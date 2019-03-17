Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AEEC43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB1B2086A
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="gUA5opXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfCQTjw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:39:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40312 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfCQTjw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 15:39:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so9840808pgo.7
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2019 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5+jmI4JkVGLS2kOQA3TZubVstZC3BdtKglFkSjsKgkQ=;
        b=gUA5opXgvrHNjit+01zp7MV6sQ16n6XQQD7hDN1Fporcb4QUfY25Yxjca5iD3ydjPj
         5Bn84PzaqDSReJ46ZXA/sfrIy0+vEn3E8B+TjvMCKwKD+M5U8mBisvY7QWXCg+ZrUx7w
         yv7/SHOcUjck8e6e1DwXYmddGDxZ/PTS88//KNsDivBy6VZ9MlR7G3zhLBQYaEBY7lu/
         sPPEAglA+12NNH2Yhvy10T30zPTRisZPoUPhHBIVzlSteDWmVQW+bm8mRUokhs/o6ciH
         dH4YS6wYteMEPrjJi+DJ8eXzHYApv9YLEr/bzktPoYettgBO9ozfg5Jdbn1RqkgQ24Nl
         IIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5+jmI4JkVGLS2kOQA3TZubVstZC3BdtKglFkSjsKgkQ=;
        b=q3bngU0Lcd0ooMqTVwnD2ewgYV/3OAwFb4nccNtk8Fiv9C7XBl8wlPRwHoSunzP2cu
         WIqxrcLZgBbzg9oJWTBPEx0iV+TEuxs6ZZr1uDTGk/Epyd5laEb8BHF6fx13pAWUtjR4
         PYgFKk5bDqE/UHtoRTgLEw0OZG/u2iA4QLBKReY0P7uuXaeFvn26Szgxw5KqKrBYU6K7
         akp9xmGlEpoaov9/AQu0aFo6EeEoT3ZZL62pYDRkVQPxnwEMBq7diZFQGuxHT4fYDzXP
         P3oPtIxNWpXVHu7+veIzZ/Fx2wZGn5ZfvrnGnIW0b8wr64ZAViVV5KLRe2fKTFykkwxC
         5IsQ==
X-Gm-Message-State: APjAAAXMM4TwYObkengq5d6L+HiJ++RSear5T71aQtuar+3VQFHb/fIu
        ezZFicmlL0jOKO8434ouklFt9mYu0snpnA==
X-Google-Smtp-Source: APXvYqzRfZx+QNO9d1rc33fP1tO4B0lhsByXaLHVdDxOVG3YhMBxR4prH3pS32RVpy59qACfBA4Kww==
X-Received: by 2002:a63:df4d:: with SMTP id h13mr6334277pgj.220.1552851590605;
        Sun, 17 Mar 2019 12:39:50 -0700 (PDT)
Received: from [10.111.76.104] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id z67sm18943862pfi.152.2019.03.17.12.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:39:49 -0700 (PDT)
Subject: Re: [PATCH 02/18] lightnvm: pblk: warn when there are opened chunks
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-3-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <572b1126-eb1f-0281-90f3-7b49a1ac66e1@lightnvm.io>
Date:   Sun, 17 Mar 2019 12:39:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314160428.3559-3-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 9:04 AM, Igor Konopko wrote:
> In case of factory pblk init, we might have a situation when there are
> some opened chunks. Based on OCSSD spec we are not allowed to transform
> chunks from the open state directly to the free state, so such a reset
> can lead to IO error (even that most of the controller will allow for
> for such a operation anyway), so we would like to warn users about such
> a situation at least.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-init.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 1e227a0..b7845f6 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -712,7 +712,7 @@ static int pblk_set_provision(struct pblk *pblk, int nr_free_chks)
>   }
>   
>   static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
> -				   struct nvm_chk_meta *meta)
> +				   struct nvm_chk_meta *meta, int *opened)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> @@ -748,6 +748,9 @@ static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
>   			continue;
>   		}
>   
> +		if (chunk->state & NVM_CHK_ST_OPEN)
> +			(*opened)++;
> +
>   		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
>   			continue;
>   
> @@ -759,7 +762,7 @@ static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
>   }
>   
>   static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
> -				 void *chunk_meta, int line_id)
> +				 void *chunk_meta, int line_id, int *opened)
>   {
>   	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>   	struct pblk_line_meta *lm = &pblk->lm;
> @@ -773,7 +776,7 @@ static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
>   	line->vsc = &l_mg->vsc_list[line_id];
>   	spin_lock_init(&line->lock);
>   
> -	nr_bad_chks = pblk_setup_line_meta_chk(pblk, line, chunk_meta);
> +	nr_bad_chks = pblk_setup_line_meta_chk(pblk, line, chunk_meta, opened);
>   
>   	chk_in_line = lm->blk_per_line - nr_bad_chks;
>   	if (nr_bad_chks < 0 || nr_bad_chks > lm->blk_per_line ||
> @@ -1019,12 +1022,12 @@ static int pblk_line_meta_init(struct pblk *pblk)
>   	return 0;
>   }
>   
> -static int pblk_lines_init(struct pblk *pblk)
> +static int pblk_lines_init(struct pblk *pblk, bool factory)
>   {
>   	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>   	struct pblk_line *line;
>   	void *chunk_meta;
> -	int nr_free_chks = 0;
> +	int nr_free_chks = 0, nr_opened_chks = 0;
>   	int i, ret;
>   
>   	ret = pblk_line_meta_init(pblk);
> @@ -1059,7 +1062,8 @@ static int pblk_lines_init(struct pblk *pblk)
>   		if (ret)
>   			goto fail_free_lines;
>   
> -		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
> +		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i,
> +							&nr_opened_chks);
>   
>   		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
>   								line->state);
> @@ -1071,6 +1075,11 @@ static int pblk_lines_init(struct pblk *pblk)
>   		goto fail_free_lines;
>   	}
>   
> +	if (factory && nr_opened_chks) {
> +		pblk_warn(pblk, "%d opened chunks during factory creation\n",
> +				nr_opened_chks);
> +	}
> +
>   	ret = pblk_set_provision(pblk, nr_free_chks);
>   	if (ret)
>   		goto fail_free_lines;
> @@ -1235,7 +1244,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   		goto fail;
>   	}
>   
> -	ret = pblk_lines_init(pblk);
> +	ret = pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
>   	if (ret) {
>   		pblk_err(pblk, "could not initialize lines\n");
>   		goto fail_free_core;
> 

I've going both ways on this one. I think I rather just do an ECN of the 
spec to say that this always have been allowed, and then add a feature 
bit for those that like the reset protection.
