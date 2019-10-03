package testgk_response;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import freemarker.ext.dom.NodeModel;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.Version;

public class Start {

//	protected String transformFreemarkerXMLdatamodel(final TTemplateDetailsExt template, final Source source)
//			throws FreemarkerException {
//		try {
//			InputSource is;
//			if (source instanceof StreamSource) {
//				is = new InputSource(((StreamSource) source).getInputStream());
//			} else {
//				is = new InputSource(new ByteArrayInputStream(toByteArray(source)));
//			}
//			final NodeModel doc = NodeModel.parse(is);
//
//			// Process the template to get the message content.
//			final freemarker.template.Template freeMarkerTemplate = new freemarker.template.Template(template.getName(),
//					new StringReader(template.getContent()), getFreeMarkerConfig());
//
//			// Create data-model
//			final Map<String, Object> tree = new HashMap<>();
//			tree.put("doc", doc);
//
//			// Merging the template with the data-model
//			final Writer content = new StringWriter();
//			freeMarkerTemplate.process(tree, content);
//
//			return content.toString();
//		} catch (IOException | freemarker.template.TemplateException | SAXException | ParserConfigurationException
//				| TransformerException e) {
//			this.logger.error("could not apply freemarker transform", e);
//			throw new FreemarkerException("error while applying freemarker template " + template.getName(), e);
//		}
//	}

	public static void main(String[] args) {
		String templateftl = "template.ftl";
		String outputfile = "data/out.xml";
		String inputfile = "data/input.xml";

		Configuration cfg = new Configuration();
		try {
			cfg.setDirectoryForTemplateLoading(new File("templates"));
			cfg.setIncompatibleImprovements(new Version(2, 3, 20));
			cfg.setDefaultEncoding("UTF-8");
			cfg.setLocale(Locale.US);
			cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

			NodeModel xmlfile = freemarker.ext.dom.NodeModel.parse(new File(inputfile));
//			System.out.println(xmlfile.toString());
			
			Template template = cfg.getTemplate(templateftl);

			Map<String, Object> input = new HashMap<String, Object>();
			input.put("title", "Example");
			input.put("doc", xmlfile);

			Writer fileWriter = new OutputStreamWriter(new FileOutputStream(outputfile), StandardCharsets.UTF_8);
			System.out.println("processing with " + templateftl + " to " + outputfile);
			template.process(input, fileWriter);
		} catch (SAXException | IOException | ParserConfigurationException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}

	}

}
