Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A44BC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1071F20674
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfDWHNQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:13:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:32924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHNQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:13:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DAE0AC4F;
        Tue, 23 Apr 2019 07:13:15 +0000 (UTC)
Subject: Re: [RFC PATCH v2 15/16] bcache: improve bcache_reboot()
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-16-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2ae959a2-bb2a-34cf-1dd4-dd7c6f06a0d2@suse.de>
Date:   Tue, 23 Apr 2019 09:13:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-16-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:05 PM, Coly Li wrote:
> This patch tries to release mutex bch_register_lock early, to give
> chance to stop cache set and bcache device early.
> 
> This patch also expends time out of stopping all bcache device from
> 2 seconds to 10 seconds, because stopping writeback rate update worker
> may delay for 5 seconds, 2 seconds is not enough.
> 
> After this patch applied, stopping bcache devices during system reboot
> or shutdown is very hard to be observed any more.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/super.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index e988e46a6479..2d377a4a182f 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2453,10 +2453,13 @@ static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
>   		list_for_each_entry_safe(dc, tdc, &uncached_devices, list)
>   			bcache_device_stop(&dc->disk);
>   
> +		mutex_unlock(&bch_register_lock);
> +
>   		/* What's a condition variable? */
>   		while (1) {
> -			long timeout = start + 2 * HZ - jiffies;
> +			long timeout = start + 10 * HZ - jiffies;
>   
> +			mutex_lock(&bch_register_lock);
>   			stopped = list_empty(&bch_cache_sets) &&
>   				list_empty(&uncached_devices);
>   
> @@ -2468,7 +2471,6 @@ static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
>   
>   			mutex_unlock(&bch_register_lock);
>   			schedule_timeout(timeout);
> -			mutex_lock(&bch_register_lock);
>   		}
>   
>   		finish_wait(&unregister_wait, &wait);
> Maybe you should even call 'schedule()' after the first mutex_unlock() 
to force execution of other tasks.
But anyway:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
