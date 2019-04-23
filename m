Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A12C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EEA206BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDWHFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:05:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHFQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:05:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF2C4AC4F;
        Tue, 23 Apr 2019 07:05:15 +0000 (UTC)
Subject: Re: [RFC PATCH v2 10/16] bcache: Add comments for blkdev_put() in
 registration code path
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-11-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <39d46bc4-f7c9-c346-5145-22320ea97a36@suse.de>
Date:   Tue, 23 Apr 2019 09:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-11-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:05 PM, Coly Li wrote:
> Add comments to explain why in register_bcache() blkdev_put() won't
> be called in two location. Add comments to explain why blkdev_put()
> must be called in register_cache() when cache_alloc() failed.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/super.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index a435c506edba..83a7cb0e0e45 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2191,6 +2191,12 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
>   
>   	ret = cache_alloc(ca);
>   	if (ret != 0) {
> +		/*
> +		 * If we failed here, it means ca->kobj is not initialzed yet,
> +		 * kobject_put() won't be called and there is no chance to
> +		 * call blkdev_put() to bdev in bch_cache_release(). So we
> +		 * explictly call blkdev_put() here.
> +		 */
>   		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
>   		if (ret == -ENOMEM)
>   			err = "cache_alloc(): -ENOMEM";
> @@ -2331,6 +2337,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>   		mutex_lock(&bch_register_lock);
>   		ret = register_bdev(sb, sb_page, bdev, dc);
>   		mutex_unlock(&bch_register_lock);
> +		/* blkdev_put() will be called in cached_dev_free() */
>   		if (ret < 0)
>   			goto err;
>   	} else {
> @@ -2339,6 +2346,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>   		if (!ca)
>   			goto err_close;
>   
> +		/* blkdev_put() will be called in bch_cache_release() */
>   		if (register_cache(sb, sb_page, bdev, ca) != 0)
>   			goto err;
>   	}
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
