Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FEBC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C8E2087C
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="0B63n1XU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfCYLch (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:32:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34434 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbfCYLch (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:32:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so4541038eds.1
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 04:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=//IzQnz/evXctd1WQTW/oNrgBolJ2zlm/U5m7FAAYvY=;
        b=0B63n1XUAevtCaard+1GsxukYZ3w6MFG+wKG8cF7YvGHSGt2SnyaQQL4Pm19n1fYOC
         zREFPdzi3ETyeBTQwK+QPZB8e7tnuTvMUSqeIjU8+PnSThy5xR0BJ/nEEk5BvOgHhjW+
         04X5tLt3AN6z84E9tmAZ/e2k+ql6eKxMMgmfhhfPsIXNZCrzhIwddY1X357ko2Vf0wwR
         nHPr/OxlujLYZpUqYMDDwX35UeblcGu3a9s0LQGhpFYeKNu4a+YpFybSs4XOeOGZ6mbJ
         etB1qh/RoD6j0t+AF9cT9sZJGLPLw4ilZi8C7lwSHDSjWllb46tOlzElZdNNouhIAd7/
         svWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//IzQnz/evXctd1WQTW/oNrgBolJ2zlm/U5m7FAAYvY=;
        b=AErFFZ10XNCeVEf1bdWr8F0PCMYwiEN6rhTZ6gWGsPnx0jEVUkp8lWHDSawtgNCTvE
         WWxPVJBIcTu+YP63NJ5Jctg9dTzikHf0L1cQpzfmibuSY6vkOxpLmpBhCfTRcpK3Q1a5
         PHQQgHpuqrtUZtu0ozEXWeGsaKcNVTuPmCVhm+NgC4Ycx6JAbPgEOFXXDx0F3WUF8i7A
         09r2IfMfJDAIqgRi0FDKl17QId66ulc5vP2xG+hSbf7f+a4H9p7jITtUj0dhZj3BxYqw
         1gAz8LuLYH7aXdF1YdL4XMI7KeD7rteHqKLNdNboUTxZl9ZtfJsq3CMuZE2oPxZtasa5
         JrOQ==
X-Gm-Message-State: APjAAAWwwdjaF8+a4LWixI5yQVweVGmpIw8wkzwMGa1V49vWONlu/Bl2
        32C48CBH0UrdO8tPY7XvW2Bcl+oCtho=
X-Google-Smtp-Source: APXvYqx7+h6uU3vSJKxIi0tE5LlI7wqSOX/yvumQrpiZlAG3NC21t/8258ukBhbf6TJ/L7gU++ueGQ==
X-Received: by 2002:a17:906:7621:: with SMTP id c1mr13939581ejn.47.1553513554556;
        Mon, 25 Mar 2019 04:32:34 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id v7sm1491497edy.45.2019.03.25.04.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:32:34 -0700 (PDT)
Subject: Re: [PATCH v2 01/16] lightnvm: pblk: warn when there are opened
 chunks
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-2-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <96e2fa6f-1a6c-8cd1-6a17-10d6bee393f7@lightnvm.io>
Date:   Mon, 25 Mar 2019 12:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190322144843.9602-2-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 3:48 PM, Igor Konopko wrote:
> In case of factory pblk init, we might have a situation when there are
> some opened chunks. Based on OCSSD spec we are not allowed to transform
> chunks from the open state directly to the free state, so such a reset
> can lead to IO error (even that most of the controller will allow for
> for such a operation anyway), so we would like to warn users about such
> a situation at least.

Let's fix up the spec to allow resets on opened chunks and omit this patch.

> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Reviewed-by: Javier González <javier@javigon.com>
> ---
>   drivers/lightnvm/pblk-init.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 1e227a0..e2e1193 100644
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
> @@ -1071,6 +1075,10 @@ static int pblk_lines_init(struct pblk *pblk)
>   		goto fail_free_lines;
>   	}
>   
> +	if (factory && nr_opened_chks)
> +		pblk_warn(pblk, "%d opened chunks during factory creation\n",
> +				nr_opened_chks);
> +
>   	ret = pblk_set_provision(pblk, nr_free_chks);
>   	if (ret)
>   		goto fail_free_lines;
> @@ -1235,7 +1243,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   		goto fail;
>   	}
>   
> -	ret = pblk_lines_init(pblk);
> +	ret = pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
>   	if (ret) {
>   		pblk_err(pblk, "could not initialize lines\n");
>   		goto fail_free_core;
> 

