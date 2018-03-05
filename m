Return-Path: <linux-block-owner@vger.kernel.org>
Received: from pv33p36im-asmtp002.me.com ([17.142.213.63]:42696 "EHLO
        pv33p36im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbeCEE1B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Mar 2018 23:27:01 -0500
Content-type: text/plain; charset=gb2312
MIME-version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] bcache: remove closure debug file when unloading module
From: Chengguang Xu <cgxu519@icloud.com>
In-reply-to: <1519972473-8826-1-git-send-email-tang.junhui@zte.com.cn>
Date: Mon, 05 Mar 2018 12:26:52 +0800
Cc: Chengguang Xu <cgxu519@icloud.com>, mlyle@lyle.org,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Message-id: <8F0BEF93-CE80-4E12-9B7F-A56172CEF93A@icloud.com>
References: <1519972473-8826-1-git-send-email-tang.junhui@zte.com.cn>
To: tang.junhui@zte.com.cn
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



> =D4=DA 2018=C4=EA3=D4=C22=C8=D5=A3=AC=CF=C2=CE=E72:34=A3=ACtang.junhui@z=
te.com.cn =D0=B4=B5=C0=A3=BA
>=20
> From: Tang Junhui <tang.junhui@zte.com.cn>
>=20
> Hello Chengguang
>=20
>> When unloading bcache module there is lack of removing
>> operation for closure debug file, so it will cause
>> creating error when trying to reload module.
>>=20
>=20
> Yes, This issue is true.=20
> Actually, the original code try to remove closure debug file
> by bch_debug_exit(), which remove all the debug file in
> bcache directory, and closure debug file is expected to be
> one debug file in bcache debug directory.
>=20
> But currently code, closure_debug_init() is called to create
> closure debug file before the bcache debug crated in=20
> bch_debug_init(), so closure debug file created outside
> the bcache directory, then when bch_debug_exit() being called,
> bcache diretory removed, but closure debug file didn't removed.
>=20
> So the best way to resolve this issue is not remove the=20
> closure debug file again, but to take the closure debug file
> under the bcache directory in debug sysfs.

Yes, that looks better, I=A1=AFll modify as your suggestion in v2. =
Thanks for your review.

>=20
>> This fix introduces closure_debug_exit to handle removing
>> operation properly.
>>=20
>> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>> ---
>> drivers/md/bcache/closure.c | 5 +++++
>> drivers/md/bcache/closure.h | 2 ++
>> drivers/md/bcache/super.c   | 2 ++
>> 3 files changed, 9 insertions(+)
>>=20
>> diff --git a/drivers/md/bcache/closure.c =
b/drivers/md/bcache/closure.c
>> index 7f12920..8fcd737 100644
>> --- a/drivers/md/bcache/closure.c
>> +++ b/drivers/md/bcache/closure.c
>> @@ -204,6 +204,11 @@ void __init closure_debug_init(void)
>>    debug =3D debugfs_create_file("closures", 0400, NULL, NULL, =
&debug_ops);
>> }
>>=20
>> +void closure_debug_exit(void)
>> +{
>> +    debugfs_remove(debug);
>> +}
>> +
>> #endif
>>=20
>> MODULE_AUTHOR("Kent Overstreet <koverstreet@google.com>");
>> diff --git a/drivers/md/bcache/closure.h =
b/drivers/md/bcache/closure.h
>> index 3b9dfc9..1aa0f7e 100644
>> --- a/drivers/md/bcache/closure.h
>> +++ b/drivers/md/bcache/closure.h
>> @@ -186,12 +186,14 @@ static inline void closure_sync(struct closure =
*cl)
>> #ifdef CONFIG_BCACHE_CLOSURES_DEBUG
>>=20
>> void closure_debug_init(void);
>> +void closure_debug_exit(void);
>> void closure_debug_create(struct closure *cl);
>> void closure_debug_destroy(struct closure *cl);
>>=20
>> #else
>>=20
>> static inline void closure_debug_init(void) {}
>> +static inline void closure_debug_exit(void) {}
>> static inline void closure_debug_create(struct closure *cl) {}
>> static inline void closure_debug_destroy(struct closure *cl) {}
>>=20
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index 1a9fdab..38e2e21 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -2118,6 +2118,7 @@ static void bcache_exit(void)
>>        destroy_workqueue(bcache_wq);
>>    if (bcache_major)
>>        unregister_blkdev(bcache_major, "bcache");
>> +    closure_debug_exit();
>>    unregister_reboot_notifier(&reboot);
>>    mutex_destroy(&bch_register_lock);
>> }
>> @@ -2137,6 +2138,7 @@ static int __init bcache_init(void)
>>=20
>>    bcache_major =3D register_blkdev(0, "bcache");
>>    if (bcache_major < 0) {
>> +        closure_debug_exit();
>>        unregister_reboot_notifier(&reboot);
>>        mutex_destroy(&bch_register_lock);
>>        return bcache_major;
>> --=20
>> 1.8.3.1
>=20
> Thanks
> Tang Junhui
