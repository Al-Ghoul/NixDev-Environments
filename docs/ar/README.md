For English refer to [Docs](../../)

# مُقدمة

هذه مجموعة لبيئات التطوير الخاصة بي، بإمكانك إستخدام أياً منهم؛
إن كان لديك أي سئلة أو مشاكل فأنا أقترح أن تقرأ الوثائق الخاصة بكل بيئة، عدا ذلك يمكنك مراسلتي علي الدسكورد (يُفضل) أو بأي مكانٍ آخر. إن كانت لديك أي مشاكل خاصة بالقوالب و/أو البيئات المتوفرة فبإمكانك [فتح مشكلة](https://github.com/Al-Ghoul/NixDev-Environments/issues/new/choose),
نحن لم نحدد أي قوالب للمشاكل (حتي الآن) و لكن الرجاء أن تبقي الأمر بسيطاً و أن تسأل سؤالك كاملاً بسجل رسائل الأخطاء مرفقاً.

## البيئات و القوالب المتاحة

الجدول التالي يلخص ما يقدمه هذا المخزون:

| الإسم                                         | بيئة               | قالب               | الوصف                               |
| --------------------------------------------- | ------------------ | ------------------ | ----------------------------------- |
| [react-native](/docs/ar/ReactNativeDev_AR.md) | :white_check_mark: | :white_check_mark: | بيئة عمل لمشاريع إكسبو و ريأكت نيتف |
| cpp-dev                                       | :white_check_mark: | :white_check_mark: | (C و C++) لـ 'clang' بيئة عمل       |
| nextjs-dev                                    | :white_check_mark: | :white_check_mark: | بيئة عمل لمشاريع نيكست.             |
| laravel-dev                                   | :white_check_mark: | :x:                | بيئة عمل لمشاريع لارافيل.           |
| django-dev                                    | :white_check_mark: | :white_check_mark: | بيئة عمل لمشاريع جانجو.             |

## دليل الإستخدام

[رقائق نيكس](https://nixos.wiki/wiki/Flakes) جعلت الأمر أسهل من ذي قبل لتخزين و الوصول لبيئات و قوالب التطوير و وضعهم
تحت نظام التحكم في الإصدار.

### القوالب

علي سبيل المثال للحصول علي قالب من نظام تحكم في المصدر كــGithub قم بإجراء الآتي:

```bash
nix flake init --template "github:<إسم القالب>#<إسم المخزون>/<إسم المستخدم>"
```

بتبديل `إسم المستخدم`, `إسم المخزون` و `إسم القالب` بشكلٍ صحيح؛ علي سبيل المثال للحصول علي قالب لبيئة عمل مماثلة , قابلة لإعادة الإنتاج مثل بيئتي لــC و C++ قم بإجراء الآتي:

```bash
nix flake init --template "github:Al-Ghoul/NixDev-Environments#cpp-dev"
```

هذا سيقوم بنسخ القالب بأكمله في ملف عملك الحالي.

### البيئات

لحصولك علي بيئة عمل بلا أي إضافات أو حتي رقاقات منسوخة في ملفك, يمكنك إجراء الآتي:

```bash
nix develop "github:<إسم البيئة>#<إسم المخزون>/<إسم المستخدم>"
```

بتبديل `إسم المستخدم`, `إسم المخزون` و `إسم البيئة` بشكلٍ صحيح؛ علي سبيل المثال للحصول علي بيئة عمل مماثلة و قابلة لإعادة الإنتاج لــC و C++ قم بإجراء الآتي:

```bash
nix develop "github:Al-Ghoul/NixDev-Environments#cpp-dev"
```

هذا سيقوم بجلب جميع الحزم اللازمة لتنصيب بيئة العمل تلقائياً.

يمكنك أيضاً أن تطلب من نكس أن تعرض لك جميع مخرجات الرقيقة, علي سبيل المثال عند أجراء الآتي:

```bash
nix flake show github:Al-Ghoul/NixDev-Environments
```

سيقرض لك قائمة مقاربة من الآتي:

```
github:Al-Ghoul/NixDev-Environments/95b24b13fb4594817d1c747c418f055aa1c34daa
├───cpp-dev: unknown
├───django-dev: unknown
├───laravel-dev: unknown
├───nextjs-dev: unknown
├───reactnative-dev: unknown
└───templates
    ├───cpp-dev: template: A Cpp development environment with boost libraries included
    ├───django-dev: template: A Django development environment with python3.11 and other dependencies
    ├───nextjs-dev: template: A NextJS development environment
    └───react-native: template: A React Native development environment with emulator included
```
