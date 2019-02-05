Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A39C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 09:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CDB2080D
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 09:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="VajTarby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBEJL7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:11:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36575 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfBEJL7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 04:11:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so2072628lfg.3
        for <linux-block@vger.kernel.org>; Tue, 05 Feb 2019 01:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z1JgTEEX5XoAeSHjfPmW6u+UEcCYbfCzYYB/6C9iOEY=;
        b=VajTarby4e/NNtmzhuclMZzqHS2zpXH/j16UMlKVA8LYebAc/kS1BX3jOgPn97fG65
         iGaWDaEWytcK+lAaa2yG0zASL9fv9sII8RzvnitKG+l7vqMZOIIAvISN6+ex4juxjCmS
         3XZCWo3oSZCv04S7S5itNl+wgPq2HTZqZt8nflKY291lvGDWpx0IiQp49qhnvsxXqM0I
         6a+V7/FW5HcfgT1DOTT0ITw/AjF+OG2br/63dfj+9eCCxAohiqCQInXHMtmnCAMpmMTa
         dWK2xa7cvCIrJyCY48rwwzMQlYZ19Jm/xW8ncBXC+b/5OYgXMBTVYRzQh6mV1ey3ZwkA
         ZeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z1JgTEEX5XoAeSHjfPmW6u+UEcCYbfCzYYB/6C9iOEY=;
        b=qDD11cmSl3IEw0B5Egwa+CzgRjHFkjCHqB+WVkYN4rxMrMZBu+siTNzRfVHXm5d5LE
         SxJeD//0mPblyTASq6FwitPketgNGlR7gBgZhTGCLeMCI05CCoI/F8B1LgSeCHJWCtju
         5AceZbQ+9paIarCxghiiIa359bio2/tWpAUSegdSwI7rDhBwlCn00UtHqgu0l8hCmx3b
         Grc/zv3R3t6ry3MsS4TtUqby7u0eDNbYRqXNRB+LCTZkE6tgs6PbtNfYYikKbzKGLMZN
         oiggq/rT9qW6dkW+AKBre2OFEPBpFuTv+qWjC9EmDUwqfLHYbsk4Zg1lM4c2j9P51Xz4
         Yq8w==
X-Gm-Message-State: AHQUAuZssAxpC0iQOnsq9v4ieCv1xDk5mlIYt8k8A/9GMmEx47yXJcUQ
        yywO8Lp7ixcqQCeQv3HO/Ttg+2tf3s4=
X-Google-Smtp-Source: AHgI3IawivOz2Nfnnd86Rm1QwWng8RJLK7JWyHpCy+6/U+4JgTYK7DSpaILQ7DaOMhZtAWRIhJvoQg==
X-Received: by 2002:a19:2906:: with SMTP id p6mr2373197lfp.17.1549357916177;
        Tue, 05 Feb 2019 01:11:56 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id v19sm3636792lfe.69.2019.02.05.01.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:11:55 -0800 (PST)
Subject: Re: [PATCH V3] lightnvm: pblk: prevent stall due to wb threshold
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190205065042.6727-1-javier@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <46459342-fa3c-f215-7dd7-6b5d3292344f@lightnvm.io>
Date:   Tue, 5 Feb 2019 10:11:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190205065042.6727-1-javier@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/19 7:50 AM, Javier González wrote:
> In order to respect mw_cuinits, pblk's write buffer maintains a
> backpointer to protect data not yet persisted; when writing to the write
> buffer, this backpointer defines a threshold that pblk's rate-limiter
> enforces.
> 
> On small PU configurations, the following scenarios might take place: (i)
> the threshold is larger than the write buffer and (ii) the threshold is
> smaller than the write buffer, but larger than the maximun allowed
> split bio - 256KB at this moment (Note that writes are not always
> split - we only do this when we the size of the buffer is smaller
> than the buffer). In both cases, pblk's rate-limiter prevents the I/O to
> be written to the buffer, thus stalling.
> 
> This patch fixes the original backpointer implementation by considering
> the threshold both on buffer creation and on the rate-limiters path,
> when bio_split is triggered (case (ii) above).
> 
> Fixes: 766c8ceb16fc ("lightnvm: pblk: guarantee that backpointer is respected on writer stall")
> Signed-off-by: Javier González <javier@javigon.com>
> ---
> 
>   Changes since V1:
>     - Fix a bad arithmetinc on the rate-limiter max_io calculation (from
>       Hans)
>   Changes since V2:
>     - Address case where mw_cunits = 0 in the new math
> 
>   drivers/lightnvm/pblk-rb.c | 25 +++++++++++++++++++------
>   drivers/lightnvm/pblk-rl.c |  5 ++---
>   drivers/lightnvm/pblk.h    |  2 +-
>   3 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index d4ca8c64ee0f..a6133b50ed9c 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -45,10 +45,23 @@ void pblk_rb_free(struct pblk_rb *rb)
>   /*
>    * pblk_rb_calculate_size -- calculate the size of the write buffer
>    */
> -static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
> +static unsigned int pblk_rb_calculate_size(unsigned int nr_entries,
> +					   unsigned int threshold)
>   {
> -	/* Alloc a write buffer that can at least fit 128 entries */
> -	return (1 << max(get_count_order(nr_entries), 7));
> +	unsigned int thr_sz = 1 << (get_count_order(threshold + NVM_MAX_VLBA));
> +	unsigned int max_sz = max(thr_sz, nr_entries);
> +	unsigned int max_io;
> +
> +	/* Alloc a write buffer that can (i) fit at least two split bios
> +	 * (considering max I/O size NVM_MAX_VLBA, and (ii) guarantee that the
> +	 * threshold will be respected
> +	 */
> +	max_io = (1 << max((int)(get_count_order(max_sz)),
> +				(int)(get_count_order(NVM_MAX_VLBA << 1))));
> +	if ((threshold + NVM_MAX_VLBA) >= max_io)
> +		max_io <<= 1;
> +
> +	return max_io;
>   }
>   
>   /*
> @@ -67,12 +80,12 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
>   	unsigned int alloc_order, order, iter;
>   	unsigned int nr_entries;
>   
> -	nr_entries = pblk_rb_calculate_size(size);
> +	nr_entries = pblk_rb_calculate_size(size, threshold);
>   	entries = vzalloc(array_size(nr_entries, sizeof(struct pblk_rb_entry)));
>   	if (!entries)
>   		return -ENOMEM;
>   
> -	power_size = get_count_order(size);
> +	power_size = get_count_order(nr_entries);
>   	power_seg_sz = get_count_order(seg_size);
>   
>   	down_write(&pblk_rb_lock);
> @@ -149,7 +162,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
>   	 * Initialize rate-limiter, which controls access to the write buffer
>   	 * by user and GC I/O
>   	 */
> -	pblk_rl_init(&pblk->rl, rb->nr_entries);
> +	pblk_rl_init(&pblk->rl, rb->nr_entries, threshold);
>   
>   	return 0;
>   }
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index 76116d5f78e4..b014957dde0b 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -207,7 +207,7 @@ void pblk_rl_free(struct pblk_rl *rl)
>   	del_timer(&rl->u_timer);
>   }
>   
> -void pblk_rl_init(struct pblk_rl *rl, int budget)
> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
>   {
>   	struct pblk *pblk = container_of(rl, struct pblk, rl);
>   	struct nvm_tgt_dev *dev = pblk->dev;
> @@ -217,7 +217,6 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
>   	int sec_meta, blk_meta;
>   	unsigned int rb_windows;
>   
> -
>   	/* Consider sectors used for metadata */
>   	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
>   	blk_meta = DIV_ROUND_UP(sec_meta, geo->clba);
> @@ -234,7 +233,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
>   	/* To start with, all buffer is available to user I/O writers */
>   	rl->rb_budget = budget;
>   	rl->rb_user_max = budget;
> -	rl->rb_max_io = budget >> 1;
> +	rl->rb_max_io = threshold ? (budget - threshold) : (budget - 1);
>   	rl->rb_gc_max = 0;
>   	rl->rb_state = PBLK_RL_HIGH;
>   
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 72ae8755764e..a6386d5acd73 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -924,7 +924,7 @@ int pblk_gc_sysfs_force(struct pblk *pblk, int force);
>   /*
>    * pblk rate limiter
>    */
> -void pblk_rl_init(struct pblk_rl *rl, int budget);
> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold);
>   void pblk_rl_free(struct pblk_rl *rl);
>   void pblk_rl_update_rates(struct pblk_rl *rl);
>   int pblk_rl_high_thrs(struct pblk_rl *rl);
> 

Thanks. Applied for 5.1.
