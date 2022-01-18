package JDBC_test.com.JDBC_test;

import java.awt.Color;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

import JDBC_test.com.JDBC_test.models.Product;
import JDBC_test.com.JDBC_test.services.ProductCategoryService;

public class ShopResources extends JPanel{
	
	private JTextField searchInput;
	private JButton searchButton = new JButton("Wyszukaj");
	private JButton closeButton = new JButton("Zamknij");
	private JScrollPane products;
	private JComboBox<String> productCategories;
	
	private Product[] productsData;
	private String[] productCategoriesData;
	
	private void events(final Shop shop) {
		
		closeButton.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				
				shop.setPanel(new HomeAfterLogin(shop));
			}
		});
	}
	
	private void initProducts() {
		
		productsData = new Product[] {new Product("komputer", 2000.0), 
								 new Product("mysz komputerowa", 100.0), 
								 new Product("karta graficzna", 600.0),
								 new Product("karta graficzna", 700.0),
								 new Product("karta graficzna", 800.0),
								 new Product("karta graficzna", 900.0),
								 new Product("karta graficzna", 300.0)};
	}
	
	private void initProductCategories() {
		
		ArrayList<String> returnedProductCategories;
		
		try {
			returnedProductCategories = ProductCategoryService.getAll();
		} 
		catch (SQLException e2) {

			e2.printStackTrace();
			JOptionPane.showMessageDialog(this, "Nie udało się wczytać kategorii produktów", "Błąd", JOptionPane.ERROR_MESSAGE);
			
			return;
		}
		
		productCategoriesData = new String[returnedProductCategories.size()];
		
		productCategoriesData = returnedProductCategories.toArray(productCategoriesData);

	}

	public ShopResources(final Shop shop) {
		
		initProducts();
		initProductCategories();
		
		setSize(992, 488);
		
		GridBagLayout gridBagLayout = new GridBagLayout();
		gridBagLayout.columnWidths = new int[]{145, 59, 173, 110, 362, 103, 153, 0};
		gridBagLayout.rowHeights = new int[]{63, 27, 35, 273, 0, 0};
		gridBagLayout.columnWeights = new double[]{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Double.MIN_VALUE};
		gridBagLayout.rowWeights = new double[]{0.0, 0.0, 0.0, 0.0, 0.0, Double.MIN_VALUE};
		setLayout(gridBagLayout);
		
		events(shop);
		
		JLabel title = new JLabel("Zasoby sklepu");
		
		title.setBackground(Color.WHITE);
		title.setHorizontalAlignment(SwingConstants.CENTER);
		title.setFont(new Font("Tahoma", Font.PLAIN, 22));
		GridBagConstraints gbc_title = new GridBagConstraints();
		gbc_title.gridwidth = 7;
		gbc_title.fill = GridBagConstraints.HORIZONTAL;
		gbc_title.insets = new Insets(0, 0, 5, 0);
		gbc_title.gridx = 0;
		gbc_title.gridy = 0;
		add(title, gbc_title);
		
		productCategories = new JComboBox<>(productCategoriesData);
		GridBagConstraints gbc_productCategories = new GridBagConstraints();
		gbc_productCategories.insets = new Insets(0, 0, 5, 5);
		gbc_productCategories.fill = GridBagConstraints.HORIZONTAL;
		gbc_productCategories.gridx = 1;
		gbc_productCategories.gridy = 1;
		add(productCategories, gbc_productCategories);
		
		searchInput = new PlaceholderJTextField("Wyszukiwarka produktów");
		GridBagConstraints gbc_searchInput = new GridBagConstraints();
		gbc_searchInput.gridx = 2;
		gbc_searchInput.gridy = 1;
		gbc_searchInput.fill = GridBagConstraints.BOTH;
		gbc_searchInput.insets = new Insets(0, 0, 5, 5);
		add(searchInput, gbc_searchInput);
		searchInput.setColumns(10);
		
		GridBagConstraints gbc_searchButton = new GridBagConstraints();
		gbc_searchButton.anchor = GridBagConstraints.NORTH;
		gbc_searchButton.fill = GridBagConstraints.HORIZONTAL;
		gbc_searchButton.insets = new Insets(0, 0, 5, 5);
		gbc_searchButton.gridx = 3;
		gbc_searchButton.gridy = 1;
		add(searchButton, gbc_searchButton);
		GridBagConstraints gbc_closeButton = new GridBagConstraints();
		gbc_closeButton.insets = new Insets(0, 0, 5, 5);
		gbc_closeButton.fill = GridBagConstraints.HORIZONTAL;
		gbc_closeButton.gridx = 5;
		gbc_closeButton.gridy = 1;
		add(closeButton, gbc_closeButton);
		
		products = new JScrollPane(new ProductsPanel(shop, productsData));
		GridBagConstraints gbc_products = new GridBagConstraints();
		gbc_products.fill = GridBagConstraints.BOTH;
		gbc_products.gridwidth = 3;
		gbc_products.insets = new Insets(0, 0, 5, 5);
		gbc_products.gridx = 2;
		gbc_products.gridy = 3;
		products.setSize(products.getWidth(), this.getHeight());
		add(products, gbc_products);
	}

}
