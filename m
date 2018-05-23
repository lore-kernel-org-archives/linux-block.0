Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45021 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750988AbeEWEVf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 May 2018 00:21:35 -0400
Subject: Re: [PATCH] bcache: do not check return value of debugfs_create_dir()
To: Kai Krakow <kai@kaishome.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20180522071011.8950-1-colyli@suse.de>
 <CAC2ZOYv1DvaaqEioWq1R13Vy2EtxSGhvCY33uSn3Sp6qJDhvbA@mail.gmail.com>
From: Coly Li <colyli@suse.de>
Message-ID: <523d8f63-55b1-dcee-fe1d-4651cf24ca7e@suse.de>
Date: Wed, 23 May 2018 12:21:24 +0800
MIME-Version: 1.0
In-Reply-To: <CAC2ZOYv1DvaaqEioWq1R13Vy2EtxSGhvCY33uSn3Sp6qJDhvbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/5/23 3:56 AM, Kai Krakow wrote:
> Hello Coly!
> 
> 2018-05-22 9:10 GMT+02:00 Coly Li <colyli@suse.de>:
>> Greg KH suggests that normal code should not care about debugfs. Therefore
>> no matter successful or failed of debugfs_create_dir() execution, it is
>> unncessary to check its return value.
>>
>> There are two functions called debugfs_create_dir() and check the return
>> value, which are bch_debug_init() and closure_debug_init(). This patch
>> changes these two functions from int to void type, and ignore return values
>> of debugfs_create_dir().
>>
>> This patch does not fix exact bug, just makes things work as they should.
> 
> I applied the patch to master and cherry-picked to my 4.16 branch
> (cleaning up the conflicts).
> 
> I'm not sure if I did the conflict in closure_debug right but as I
> compiled with CONFIG_DEBUG_FS=n, I think it doesn't matter for my
> configuration.
> 
> The resulting patch works, currently running it while writing this message.
> 
> So you can add my tested-by if it makes sense.

Hi Kai,

Thank you for the effort, very helpful!

I will add a Tested-by: in next version post.

Coly Li


>> Signed-off-by: Coly Li <colyli@suse.de>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Kai Krakow <kai@kaishome.de>
>> Cc: Kent Overstreet <kent.overstreet@gmail.com>
>> ---
>>  drivers/md/bcache/bcache.h  |  2 +-
>>  drivers/md/bcache/closure.c | 13 +++++++++----
>>  drivers/md/bcache/closure.h |  4 ++--
>>  drivers/md/bcache/debug.c   | 11 ++++++-----
>>  drivers/md/bcache/super.c   |  4 +++-
>>  5 files changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
>> index 3a0cfb237af9..bee6251d2d40 100644
>> --- a/drivers/md/bcache/bcache.h
>> +++ b/drivers/md/bcache/bcache.h
>> @@ -995,7 +995,7 @@ void bch_open_buckets_free(struct cache_set *);
>>  int bch_cache_allocator_start(struct cache *ca);
>>
>>  void bch_debug_exit(void);
>> -int bch_debug_init(struct kobject *);
>> +void bch_debug_init(struct kobject *);
>>  void bch_request_exit(void);
>>  int bch_request_init(void);
>>
>> diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
>> index 0e14969182c6..618253683d40 100644
>> --- a/drivers/md/bcache/closure.c
>> +++ b/drivers/md/bcache/closure.c
>> @@ -199,11 +199,16 @@ static const struct file_operations debug_ops = {
>>         .release        = single_release
>>  };
>>
>> -int __init closure_debug_init(void)
>> +void  __init closure_debug_init(void)
>>  {
>> -       closure_debug = debugfs_create_file("closures",
>> -                               0400, bcache_debug, NULL, &debug_ops);
>> -       return IS_ERR_OR_NULL(closure_debug);
>> +       if (!IS_ERR_OR_NULL(bcache_debug))
>> +               /*
>> +                * it is unnecessary to check return value of
>> +                * debugfs_create_file(), we should not care
>> +                * about this.
>> +                */
>> +               closure_debug = debugfs_create_file(
>> +                       "closures", 0400, bcache_debug, NULL, &debug_ops);
>>  }
>>  #endif
>>
>> diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
>> index 71427eb5fdae..7c2c5bc7c88b 100644
>> --- a/drivers/md/bcache/closure.h
>> +++ b/drivers/md/bcache/closure.h
>> @@ -186,13 +186,13 @@ static inline void closure_sync(struct closure *cl)
>>
>>  #ifdef CONFIG_BCACHE_CLOSURES_DEBUG
>>
>> -int closure_debug_init(void);
>> +void closure_debug_init(void);
>>  void closure_debug_create(struct closure *cl);
>>  void closure_debug_destroy(struct closure *cl);
>>
>>  #else
>>
>> -static inline int closure_debug_init(void) { return 0; }
>> +static inline void closure_debug_init(void) {}
>>  static inline void closure_debug_create(struct closure *cl) {}
>>  static inline void closure_debug_destroy(struct closure *cl) {}
>>
>> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
>> index d030ce3025a6..57f8f5aeee55 100644
>> --- a/drivers/md/bcache/debug.c
>> +++ b/drivers/md/bcache/debug.c
>> @@ -248,11 +248,12 @@ void bch_debug_exit(void)
>>                 debugfs_remove_recursive(bcache_debug);
>>  }
>>
>> -int __init bch_debug_init(struct kobject *kobj)
>> +void __init bch_debug_init(struct kobject *kobj)
>>  {
>> -       if (!IS_ENABLED(CONFIG_DEBUG_FS))
>> -               return 0;
>> -
>> +       /*
>> +        * it is unnecessary to check return value of
>> +        * debugfs_create_file(), we should not care
>> +        * about this.
>> +        */
>>         bcache_debug = debugfs_create_dir("bcache", NULL);
>> -       return IS_ERR_OR_NULL(bcache_debug);
>>  }
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index 3dea06b41d43..2b62671e4d83 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -2301,10 +2301,12 @@ static int __init bcache_init(void)
>>         if (!(bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0)) ||
>>             !(bcache_kobj = kobject_create_and_add("bcache", fs_kobj)) ||
>>             bch_request_init() ||
>> -           bch_debug_init(bcache_kobj) || closure_debug_init() ||
>>             sysfs_create_files(bcache_kobj, files))
>>                 goto err;
>>
>> +       bch_debug_init(bcache_kobj);
>> +       closure_debug_init();
>> +
>>         return 0;
>>  err:
>>         bcache_exit();
>> --
>> 2.16.3
>>
