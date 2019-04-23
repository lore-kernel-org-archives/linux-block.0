Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A77C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A894206BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfDWHEy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHEx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:04:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE455AC4F;
        Tue, 23 Apr 2019 07:04:51 +0000 (UTC)
Subject: Re: [RFC PATCH v2 09/16] bcache: add error check for calling
 register_bdev()
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-10-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a8b8029b-fc81-b56c-18ee-b0df9e195a74@suse.de>
Date:   Tue, 23 Apr 2019 09:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-10-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:05 PM, Coly Li wrote:
> This patch adds return value to register_bdev(). Then if failure happens
> inside register_bdev(), its caller register_bcache() may detect and
> handle the failure more properly.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/super.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 400af446c372..a435c506edba 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1281,7 +1281,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
>   
>   /* Cached device - bcache superblock */
>   
> -static void register_bdev(struct cache_sb *sb, struct page *sb_page,
> +static int register_bdev(struct cache_sb *sb, struct page *sb_page,
>   				 struct block_device *bdev,
>   				 struct cached_dev *dc)
>   {
> @@ -1319,10 +1319,11 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
>   	    BDEV_STATE(&dc->sb) == BDEV_STATE_STALE)
>   		bch_cached_dev_run(dc);
>   
> -	return;
> +	return 0;
>   err:
>   	pr_notice("error %s: %s", dc->backing_dev_name, err);
>   	bcache_device_stop(&dc->disk);
> +	return -EIO;
>   }
>   
>   /* Flash only volumes */
> @@ -2273,7 +2274,7 @@ static bool bch_is_open(struct block_device *bdev)
>   static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>   			       const char *buffer, size_t size)
>   {
> -	ssize_t ret = size;
> +	ssize_t ret = -EINVAL;
>   	const char *err = "cannot allocate memory";
>   	char *path = NULL;
>   	struct cache_sb *sb = NULL;
> @@ -2307,7 +2308,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>   			if (!IS_ERR(bdev))
>   				bdput(bdev);
>   			if (attr == &ksysfs_register_quiet)
> -				goto out;
> +				goto quiet_out;
>   		}
>   		goto err;
>   	}
> @@ -2328,8 +2329,10 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>   			goto err_close;
>   
>   		mutex_lock(&bch_register_lock);
> -		register_bdev(sb, sb_page, bdev, dc);
> +		ret = register_bdev(sb, sb_page, bdev, dc);
>   		mutex_unlock(&bch_register_lock);
> +		if (ret < 0)
> +			goto err;
>   	} else {
>   		struct cache *ca = kzalloc(sizeof(*ca), GFP_KERNEL);
>   
> @@ -2339,6 +2342,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>   		if (register_cache(sb, sb_page, bdev, ca) != 0)
>   			goto err;
>   	}
> +quiet_out:
> +	ret = size;
>   out:
>   	if (sb_page)
>   		put_page(sb_page);
> @@ -2351,7 +2356,6 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>   	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
>   err:
>   	pr_info("error %s: %s", path, err);
> -	ret = -EINVAL;
>   	goto out;
>   }
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
