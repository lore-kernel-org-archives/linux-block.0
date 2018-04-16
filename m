Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754581AbeDPJPd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 05:15:33 -0400
Subject: Re: [PATCH] bcache: not access dc->bdev when backing device is
 offline
To: tang.junhui@zte.com.cn
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1523869019-2109-1-git-send-email-tang.junhui@zte.com.cn>
From: Coly Li <colyli@suse.de>
Message-ID: <ca4bb84e-262e-3554-295b-28980e0bbf32@suse.de>
Date: Mon, 16 Apr 2018 17:15:23 +0800
MIME-Version: 1.0
In-Reply-To: <1523869019-2109-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/4/16 4:56 PM, tang.junhui@zte.com.cn wrote:
> Hi Coly,
> 
>> When backing device is offline, memory object pointed by dc->bdev might be
>> released in some condititions. I have bug report that bdevname() triggers
>> a NULL pointer deference panic inside bch_cached_dev_error(), where
>> dc->bdev is NULL.
>>
>> This patch adds char backing_dev_name[BDEVNAME_SIZE] in struct cached_dev,
>> and stored backing device name in backing_dev_nmae during backing device
>> registration. Then when backing device is offline, pr_err() can still
>> print message with backing device name without calling bdevname(). And
>> backing_dev_name is also helpful when debugging crash code.
>>
>> Fixes: c7b7bd07404c ("bcache: add io_disable to struct cached_dev")
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>> drivers/md/bcache/bcache.h |  2 ++
>> drivers/md/bcache/super.c  | 10 ++++------
>> 2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
>> index d338b7086013..9af0ad7f6243 100644
>> --- a/drivers/md/bcache/bcache.h
>> +++ b/drivers/md/bcache/bcache.h
>> @@ -392,6 +392,8 @@ struct cached_dev {
>> #define DEFAULT_CACHED_DEV_ERROR_LIMIT    64
>>     atomic_t        io_errors;
>>     unsigned        error_limit;
>> +
>> +    char            backing_dev_name[BDEVNAME_SIZE];
>> };
>>
>> enum alloc_reserve {
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index d90d9e59ca00..f2512e3e67e6 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -1225,13 +1225,13 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
>>                  struct block_device *bdev,
>>                  struct cached_dev *dc)
>> {
>> -    char name[BDEVNAME_SIZE];
>>     const char *err = "cannot allocate memory";
>>     struct cache_set *c;
>>
>>     memcpy(&dc->sb, sb, sizeof(struct cache_sb));
>>     dc->bdev = bdev;
>>     dc->bdev->bd_holder = dc;
>> +    bdevname(bdev, dc->backing_dev_name);
>>
>>     bio_init(&dc->sb_bio, dc->sb_bio.bi_inline_vecs, 1);
>>     bio_first_bvec_all(&dc->sb_bio)->bv_page = sb_page;
>> @@ -1247,7 +1247,7 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
>>     if (bch_cache_accounting_add_kobjs(&dc->accounting, &dc->disk.kobj))
>>         goto err;
>>
>> -    pr_info("registered backing device %s", bdevname(bdev, name));
>> +    pr_info("registered backing device %s", dc->backing_dev_name);
>>
>>     list_add(&dc->list, &uncached_devices);
>>     list_for_each_entry(c, &bch_cache_sets, list)
>> @@ -1259,7 +1259,7 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
>>
>>     return;
>> err:
>> -    pr_notice("error %s: %s", bdevname(bdev, name), err);
>> +    pr_notice("error %s: %s", dc->backing_dev_name, err);
>>     bcache_device_stop(&dc->disk);
>> }
>>
>> @@ -1367,8 +1367,6 @@ int bch_flash_dev_create(struct cache_set *c, uint64_t size)
>>
>> bool bch_cached_dev_error(struct cached_dev *dc)
>> {
>> -    char name[BDEVNAME_SIZE];
>> -
>>     if (!dc || test_bit(BCACHE_DEV_CLOSING, &dc->disk.flags))
>>         return false;
>>
>> @@ -1377,7 +1375,7 @@ bool bch_cached_dev_error(struct cached_dev *dc)
>>     smp_mb();
>>
>>     pr_err("stop %s: too many IO errors on backing device %s\n",
>> -        dc->disk.disk->disk_name, bdevname(dc->bdev, name));
>> +        dc->disk.disk->disk_name, dc->backing_dev_name);
>>
>>     bcache_device_stop(&dc->disk);
>>     return true;
>> -- 
>> 2.16.2
> 
> Since you have wrote it in dc->backing_dev_name, could you change all
> bdevname(dc->bdev, buf) into dc->backing_dev_name in bcache?

Hi Junhui,

Yes, this is on my pipeline. So far I just want to make a minimal
change, since the problematic patch is in 4.17 pre-rc1 already. Now this
patch is under our internal testing already, once the fix is verified, I
will ask Michael and Jens to pick it as a minor fix.

The changes as you suggested will be a bit larger and not in emergent
pipe for this moment.

Coly Li
