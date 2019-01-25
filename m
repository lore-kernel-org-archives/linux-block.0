Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D9BC282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 13:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A232218FC
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 13:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="zIVPHtRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAYNIo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:08:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34840 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYNIo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 08:08:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so6893233lfc.2
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XY/Z0Xdy8cX3Yc4uBc8drK+RSeNPFD02rMKaKY5NbXw=;
        b=zIVPHtRnz5J0IZob9KDP4IgzZfm8YWNMAtln9ni5KnYn90C4a/nsYIaGQ8ODUpzwbt
         NXwp1TJ/F63YFutVbRGtlYdnspG8a30e4a1BE9AyGYve3qftZqX7tE2jEI6TmKrMMydu
         qcq7lmxmGQen/gVnobodG649o5UdG8fSpfnL5AJfm2MOwAtT0oEIL7WWKuy22eXtLQm0
         iQ8BR8WgQFY6sX4dFJQSGNdTp+XdGb+b3+5eJtlfd19Lx3hnDHG9fK++aNpLJ+TmGTu7
         2cYGDRjyn6EWmDhaqYjkl8OSAIF6ByD1H5vvZ6b3jm+R/YonRhUBQj/GRfQElfMwscGu
         751w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XY/Z0Xdy8cX3Yc4uBc8drK+RSeNPFD02rMKaKY5NbXw=;
        b=nQXxX2oIfRjnekzaatrMnJmNCNA4TPIS1+OGwKYYoa4PgvxSSg8pVFTelWBOgfKazz
         ZvLIHQrdRLUPCr83QtGTcDfTK3VNxE4l6yjJQCNaAMfMYel5m9SSgymjGtJDOfyLXEgw
         xiVuvJ2ICWR0a4aSHz7JVbru2gmf4MIL0W6EGe2t0PBiiSvpJ6DUi7UcpoUtkTUcr1Bp
         ElBJorcf2hJq7K/cSR1nXTwRx+KOdOOZG9JtvKSE+uj2UHipku3Z2CH8DycfJq3nuI6J
         ivUalYO+OC17DdrC1Ym4GAYCBPievHyxWgn6SJOykMsOCepc8Ruhh5XoOr+1zm7PZ6y0
         Y+Zg==
X-Gm-Message-State: AJcUukdt4NSkP45tSyFlcie7YtiduDZKbluSNRKWcS+v7JWtSC3DY4db
        inpLxvxVsJbakNinCg8db3sViQ==
X-Google-Smtp-Source: ALg8bN6IysmLS/HIBe87xTzMqL627zRWYo+zz1HyFAeW45DNGZapMwXwldg3unkdueFxOpeD2RD4OA==
X-Received: by 2002:a19:4402:: with SMTP id r2mr8213909lfa.111.1548421721810;
        Fri, 25 Jan 2019 05:08:41 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id u12-v6sm1467577ljk.79.2019.01.25.05.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 05:08:40 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: prevent stall due to wb threshold
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20190125100943.28743-1-javier@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a712d1f5-2d82-2879-b220-4c6790fdc56a@lightnvm.io>
Date:   Fri, 25 Jan 2019 14:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125100943.28743-1-javier@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/19 11:09 AM, Javier González wrote:
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
> index 76116d5f78e4..f81d8f0570ef 100644
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
> +	rl->rb_max_io = (budget >> 1) - get_count_order(threshold);
>   	rl->rb_gc_max = 0;
>   	rl->rb_state = PBLK_RL_HIGH;
>   
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 85e38ed62f85..752cd40e4ae6 100644
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

+ Hans
