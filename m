Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53AC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 06:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6512220643
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 06:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfDWGue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:50:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWGue (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 02:50:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1D27AE54;
        Tue, 23 Apr 2019 06:50:32 +0000 (UTC)
Subject: Re: [RFC PATCH v2 01/16] bcache: move definition of 'int ret' out of
 macro read_bucket()
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-2-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <dfc47081-e029-111f-4da2-3b033156d47e@suse.de>
Date:   Tue, 23 Apr 2019 08:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-2-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:04 PM, Coly Li wrote:
> 'int ret' is defined as a local variable inside macro read_bucket().
> Since this macro is called multiple times, and following patches will
> use a 'int ret' variable in bch_journal_read(), this patch moves
> definition of 'int ret' from macro read_bucket() to range of function
> bch_journal_read().
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/journal.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
> index b2fd412715b1..6e18057d1d82 100644
> --- a/drivers/md/bcache/journal.c
> +++ b/drivers/md/bcache/journal.c
> @@ -147,7 +147,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>   {
>   #define read_bucket(b)							\
>   	({								\
> -		int ret = journal_read_bucket(ca, list, b);		\
> +		ret = journal_read_bucket(ca, list, b);			\
>   		__set_bit(b, bitmap);					\
>   		if (ret < 0)						\
>   			return ret;					\
> @@ -156,6 +156,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>   
>   	struct cache *ca;
>   	unsigned int iter;
> +	int ret = 0;
>   
>   	for_each_cache(ca, c, iter) {
>   		struct journal_device *ja = &ca->journal;
> @@ -267,7 +268,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>   					    struct journal_replay,
>   					    list)->j.seq;
>   
> -	return 0;
> +	return ret;
>   #undef read_bucket
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
