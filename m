Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDBBC3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 22:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDD22468A
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 22:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4SbinEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1Whj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:37:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40716 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1Whj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 17:37:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id d138so3439738wmd.5
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 14:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m/L2CFNFEJ5Ff3RcD+2vg+RFDRxj9z+ompwtLPqfUIQ=;
        b=l4SbinEZFJqXMj7e39tvulvCuyM0M2J9c9l0qDdIC/6MtByij6kUnBgiAbQDSno5cv
         qGWwOsqpSZdoeQUuOhorPzs7Rn7PylcT77/K74fvYGt3Kcq5ACxeVGTB7uaZHMpUaEUZ
         2fn/yq0EEQ0bLBaPt7fNrn3IMXnKsud+7a7BrYu6Oz8WTTm9bFRx5weVcruD7wX+qLus
         4Os6e75kSSj8xlzM3jQLFCcMV7q8hbiJajcJC3nZue2fnRT5ZYq2fdX3Lr/MkAeJZ/RN
         G+ryLZHceaouWykUbsXhoRfZvvlw1Fv6vOC2ui/nSeQOhNdQpr5M5XVlLzEjEVeLF2P+
         7COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m/L2CFNFEJ5Ff3RcD+2vg+RFDRxj9z+ompwtLPqfUIQ=;
        b=Pwdk1sqanoEvOKJDajVTnjnS+Jm47qUMpsyL8ZXJUkWj5Jfb+/WCm4qNHxdRX9zQGp
         rKzMnMOAWGg1SrSWxRpno+ghXNQQICBITjEVSnWqSDcirLqykcQ75r1Swzp/wAhFaAga
         OjtVYzpuHvgilIqb1IpgcZKJXzvLdK4/IA9TXLph0pzjPJJiPK8s33KsiBweUQUrjs6R
         UpCKWwXlPw6wDinZumyXEfldIE1gNc9LdnDBvTFzxYYn1S3GDt8YN73K9K7wIlWc211n
         wdAUv9Ki0bYJGuQyvoR2RcIIQihadqQistYLWEYlGPtcmJq8g+8MX1iSz6915TZZiE8I
         Xubg==
X-Gm-Message-State: APjAAAU5V1L3OXSYOGhwAVoEamUKrhYoCCcb+6mN028olUzX9xKBa4PM
        lo41776EZ/PmsesIoNtvrYjgNo/f
X-Google-Smtp-Source: APXvYqxm4rmaN8LmhzToPK+8zLx2qkxauslE07eUH1wExyDLz/0IYrTQWNnSsKbmhVipiQBvpK2/5A==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr6637290wmc.119.1582929456557;
        Fri, 28 Feb 2020 14:37:36 -0800 (PST)
Received: from [10.20.1.199] (ivokamhome.ddns.nbis.net. [87.120.136.31])
        by smtp.gmail.com with ESMTPSA id c11sm13876125wrp.51.2020.02.28.14.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 14:37:35 -0800 (PST)
Subject: Re: [PATCH 2/6] block: use bio_{wouldblock,io}_error in
 direct_make_request
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-3-guoqing.jiang@cloud.ionos.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <b826cad5-a9fc-3490-1782-0073a92fc815@gmail.com>
Date:   Sat, 29 Feb 2020 00:37:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228150518.10496-3-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 28.02.20 г. 17:05 ч., Guoqing Jiang wrote:
> Use the two functions to simplify code.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  block/blk-core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fd43266029be..6d36c2ad40ba 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1121,10 +1121,9 @@ blk_qc_t direct_make_request(struct bio *bio)
>  
>  	if (unlikely(blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0))) {
>  		if (nowait && !blk_queue_dying(q))
> -			bio->bi_status = BLK_STS_AGAIN;
> +			bio_wouldblock_error(bio);
>  		else
> -			bio->bi_status = BLK_STS_IOERR;
> -		bio_endio(bio);
> +			bio_io_error(bio);
>  		return BLK_QC_T_NONE;
>  	}
>  
> 

The code is functionally identical so:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
