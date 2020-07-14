Return-Path: <SRS0=uy3D=AZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1034BC433DF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jul 2020 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD774212CC
	for <linux-block@archiver.kernel.org>; Tue, 14 Jul 2020 20:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W35J3FGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgGNUMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgGNUM3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jul 2020 16:12:29 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F92C061755
        for <linux-block@vger.kernel.org>; Tue, 14 Jul 2020 13:12:29 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so18646788iom.10
        for <linux-block@vger.kernel.org>; Tue, 14 Jul 2020 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UOX8399h0mZZNRUdm40q4oW+3enpCIEzfSYybRJxWdc=;
        b=W35J3FGel87rvzHbryaZVxtOm38w8W78AWz5yEfZDKO5DnRhEYIbZecPuvmsjmoyYu
         fUuDo5YX9J4FBalu27vgFPgkMpAvPzqOs9vN+OxKQIQSpzLqma/hy5T7nuTOVyld5k86
         dgaHp/ED3qUSJLdcwVQ7Zn0lLe3sIvNU6HD2ofW+s/RxXGMGUWSZ7c6J3tFeuBS5lnEn
         4gmeZJ3EheL35j3Zavr7AGZ65+nhirn10x+ABBmlIv1bcU0vKuS3jjls3lNcQMEMhnbK
         x4F8IIqSehFZXHkyjyl1A2fE9X/UH6pakH7FDyCPJL6ZIDeZzIO3KzVEU45VLSf97H7E
         5wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UOX8399h0mZZNRUdm40q4oW+3enpCIEzfSYybRJxWdc=;
        b=D6l+RArskavZLfqox2LgzfpLJB2gJGLBpVdFmF+++p6x8GviGpgzh78a73wLX/dPoo
         /8Jhus1MFYyWgXjF80okggQ3JHGDGP/hPyQZlDyH3teXJ6n2IrpY8L7g8a7BG5/6PmGw
         o431yy1D8kKL7fKoFTWf0YWscJDQaCAYBi1hUNeTICXGGxHuECtKPYXCZj3WK/5y6JJL
         JVc22+s+BYaLscnWL0HKNFPha0GW7WzjXgjp7BoL40sbNCMe6gLaXEsNQIkAYeQMwg7c
         wzpnHrOO3gT+tB5jhG3xSiOxh/X4rralgtxiqQql7axadtpdQebuCluw8oAiZWErHirv
         xQMg==
X-Gm-Message-State: AOAM532PDsXxmILJI86fOIvUYtqNCz0WfKJPen8rIj/FWJPhfcv5Ipp+
        QQ0cCRv4PmYGth3Tag16I/pPcQ==
X-Google-Smtp-Source: ABdhPJzOuLWMOpR0c+My6l3ZClJCoKHR0SX+rDLyA01YGspLWRs9j702CD9L1ELKk35XLO+2DCPhxg==
X-Received: by 2002:a6b:8e56:: with SMTP id q83mr6733681iod.61.1594757548794;
        Tue, 14 Jul 2020 13:12:28 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w82sm10769268ili.42.2020.07.14.13.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 13:12:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200714200327.40927-1-sth@linux.ibm.com>
 <20200714200327.40927-2-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
Date:   Tue, 14 Jul 2020 14:12:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714200327.40927-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/20 2:03 PM, Stefan Haberland wrote:
> During initialization of the DASD DIAG driver a request is issued
> that has a bio structure that resides on the stack. With virtually
> mapped kernel stacks this bio address might be in virtual storage
> which is unsuitable for usage with the diag250 call.
> In this case the device can not be set online using the DIAG
> discipline and fails with -EOPNOTSUP.
> In the system journal the following error message is presented:
> 
> dasd: X.X.XXXX Setting the DASD online with discipline DIAG failed
> with rc=-95
> 
> Fix by allocating the bio structure instead of having it on the stack.
> 
> Fixes: ce3dc447493f ("s390: add support for virtually mapped kernel stacks")
> Cc: stable@vger.kernel.org #4.20
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_diag.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
> index facb588d09e4..069d6b39cacf 100644
> --- a/drivers/s390/block/dasd_diag.c
> +++ b/drivers/s390/block/dasd_diag.c
> @@ -319,7 +319,7 @@ dasd_diag_check_device(struct dasd_device *device)
>  	struct dasd_diag_characteristics *rdc_data;
>  	struct vtoc_cms_label *label;
>  	struct dasd_block *block;
> -	struct dasd_diag_bio bio;
> +	struct dasd_diag_bio *bio;
>  	unsigned int sb, bsize;
>  	blocknum_t end_block;
>  	int rc;
> @@ -395,29 +395,36 @@ dasd_diag_check_device(struct dasd_device *device)
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> +	bio = kzalloc(sizeof(*bio), GFP_KERNEL);
> +	if (bio == NULL)  {
> +		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
> +			      "No memory to allocate initialization bio");
> +		rc = -ENOMEM;
> +		goto out_label;
> +	}

Just curious, any reason this isn't just using bio_alloc()?

-- 
Jens Axboe

