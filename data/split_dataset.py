import pandas as pd

# Lire le fichier CSV
print("Lecture du fichier...")
df = pd.read_csv('raw/ecommerce_dataset_10000.csv')

print(f"Total de lignes : {len(df)}")
print(f"Colonnes : {df.columns.tolist()}")

# Vérifier les valeurs uniques dans gender
print(f"\nValeurs dans 'gender' : {df['gender'].unique()}")

# Séparer par genre
df_femme = df[df['gender'].str.lower().isin(['female', 'f', 'woman'])]
df_homme = df[df['gender'].str.lower().isin(['male', 'm', 'man'])]

# Sauvegarder
df_femme.to_csv('processed/products_femme.csv', index=False)
df_homme.to_csv('processed/products_homme.csv', index=False)

print(f"\n✅ Séparation terminée !")
print(f"Produits Femme : {len(df_femme)} lignes")
print(f"Produits Homme : {len(df_homme)} lignes")