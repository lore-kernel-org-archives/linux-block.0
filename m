Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4958FC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CB2206BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfDWHFh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:05:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHFh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:05:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3859CACC5;
        Tue, 23 Apr 2019 07:05:36 +0000 (UTC)
Subject: Re: [RFC PATCH v2 11/16] bcache: add comments for closure_fn to be
 called in closure_queue()
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-12-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e3fc5d96-e7a5-84c6-ae9d-cffef3e9a774@suse.de>
Date:   Tue, 23 Apr 2019 09:05:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-12-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:05 PM, Coly Li wrote:
> Add code comments to explain which call back function might be called
> for the closure_queue(). This is an effort to make code to be more
> understandable for readers.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/super.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 83a7cb0e0e45..9b41e0b62cc0 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -662,6 +662,11 @@ static const struct block_device_operations bcache_ops = {
>   void bcache_device_stop(struct bcache_device *d)
>   {
>   	if (!test_and_set_bit(BCACHE_DEV_CLOSING, &d->flags))
> +		/*
> +		 * closure_fn set to
> +		 * - cached device: cached_dev_flush()
> +		 * - flash dev: flash_dev_flush()
> +		 */
>   		closure_queue(&d->cl);
>   }
>   
> @@ -1677,6 +1682,7 @@ static void __cache_set_unregister(struct closure *cl)
>   void bch_cache_set_stop(struct cache_set *c)
>   {
>   	if (!test_and_set_bit(CACHE_SET_STOPPING, &c->flags))
> +		/* closure_fn set to __cache_set_unregister() */
>   		closure_queue(&c->caching);
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
