Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378E4C282D8
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F136A218A3
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="aD4YVWZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbfA3Niv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:38:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42745 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfA3Niv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 08:38:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so11416259pfr.9
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 05:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UbldZgzglEVBjotXYNAVrfgzOgX2xvDiVJz3EoKTJmw=;
        b=aD4YVWZ+KyUxtd766Gha/weYyaLK8RkVFjSNgEGr+LvHI80BQym7kiGoHOx7uXKWQo
         l9D+706/1Oc2d6n3NFNMrDQz2gfauSUdROyNtMd+Z3nowpAeSIHoPSx7Enq+lsaVoslK
         G++Q0Pv1d3pOWGs+29swvavodnf9SdjeaG3tR4sCPX8+cRBtfoYVHctxI0q7LSi3pQi+
         uAhT2UVO5yVd1fHtTQXL8EJPNXlFIayu4RqaD9em5UQPE38O22LjynmZjjLcx3a3EG+u
         ulAySC4MhhPqNre/qavCsMmdcdJqlZMF9+62pInpSf481Rm6rKJXphWfrta6iN+DNNkw
         PGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UbldZgzglEVBjotXYNAVrfgzOgX2xvDiVJz3EoKTJmw=;
        b=AyUIrLmfWkSeO6RdYT8rOfSp1fqIWbrWGAMQhTP+CNxMOg3ARME2jXWlgKXTDw3UmI
         F6zMidwtkQq53HAvB5FCYatxzE3Q2B6vJO2muS3dleY1cRJS7LUB5woqLO30YdLVolRb
         CFUkmNuyun2nscr5gKHW4ISYv9yoNZgg2IyRhr6CcDhzJNprqQHMq2WWgmKb2W+W2uac
         k9ayWJ7lPRWLG4ghdWEhQY/Wg/t3cstumKOvhdeBVZc+g/YEeML+NcFXHLcxPpXuQ6oD
         nRCgT8UnZpjzTBn6baM9iEqK3TnTC+v+CXOYYdElzEL1Q/or7cwdSsSTDnlMDgmdOAR1
         Nz/Q==
X-Gm-Message-State: AJcUukdlubKf84SMI9VCIVBwxQIjAaTa7fuTYmSThA8v5zF4qP8ALn6W
        1MxRKS+p8DneDvYHmNRESSI/1A==
X-Google-Smtp-Source: ALg8bN5+zioWIRLAha/LaqJMEUkRGGDNh+I08Z0zmSfLhS9hOarsOmQ+zkNicm7RVDTFDUUPutaEkQ==
X-Received: by 2002:a62:32c4:: with SMTP id y187mr31655189pfy.195.1548855529909;
        Wed, 30 Jan 2019 05:38:49 -0800 (PST)
Received: from [192.168.15.224] (71-6-111-190.static-ip.telepacific.net. [71.6.111.190])
        by smtp.gmail.com with ESMTPSA id d13sm2978298pfd.58.2019.01.30.05.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 05:38:48 -0800 (PST)
Subject: Re: [PATCH V2] lightnvm: pblk: prevent stall due to wb threshold
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190130102604.14496-1-javier@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <aeba3235-9f86-bab0-5d05-0790ddb8f503@lightnvm.io>
Date:   Wed, 30 Jan 2019 14:38:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130102604.14496-1-javier@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/19 11:26 AM, Javier González wrote:
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
>    Changes since V1:
>      - Fix a bad arithmetinc on the rate-limiter max_io calculation (from
>        Hans)
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
> index 76116d5f78e4..e9e0af0df165 100644
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
> +	rl->rb_max_io = budget - threshold;
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

Thanks Javier. Applied for 5.1.
