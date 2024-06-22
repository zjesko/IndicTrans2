import os
import shutil
# prepare domain data for grid search
domains = ['aut', 'edu', 'fin', 'gov', 'law', 'spo', 'tec', 'hlt', 'tou']
for i,ele in enumerate(domains):
        if os.path.exists(f"evals/{ele}/grid-search"):
            os.chmod(f"evals/{ele}/grid-search", 0o777)
            shutil.rmtree(f"evals/{ele}/grid-search") 
        os.mkdir(f"evals/{ele}/grid-search") 
        for j in range(10):
                os.mkdir(f"evals/{ele}/grid-search/en{j}_Latn-hin_Deva")
                shutil.copy2(f'evals/{ele}/en{i+1}_Latn-hin_Deva/test.en{i+1}_Latn', f'evals/{ele}/grid-search/en{j}_Latn-hin_Deva/test.en{j}_Latn')
                shutil.copy2(f'evals/{ele}/en{i+1}_Latn-hin_Deva/test.hin_Deva', f'evals/{ele}/grid-search/en{j}_Latn-hin_Deva/test.hin_Deva')
        os.mkdir(f'evals/{ele}/grid-search/eng_Latn-hin_Deva')
        shutil.copy(f'evals/{ele}/en{i+1}_Latn-hin_Deva/test.en{i+1}_Latn', f'evals/{ele}/grid-search/eng_Latn-hin_Deva/test.eng_Latn')
        shutil.copy(f'evals/{ele}/en{i+1}_Latn-hin_Deva/test.hin_Deva', f'evals/{ele}/grid-search/eng_Latn-hin_Deva/test.hin_Deva')
