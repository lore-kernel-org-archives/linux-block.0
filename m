Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDAFC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 03:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA7821738
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 03:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Uza10n/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbeLWDfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:35:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34410 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbeLWDfZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Dec 2018 22:35:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so4433683pfg.1
        for <linux-block@vger.kernel.org>; Sat, 22 Dec 2018 19:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+MnGlzO4Y2S1FJ/ZJQuVnGIaBuOVrspmTHpDek6kMb4=;
        b=Uza10n/yfxwKY8idKaxmsp9mGDpYVHjI/m+4PhjHA+5vXSiNyYaGdqEkVtmU5tWaGI
         Orffvm/Xi238e7YKS8ELc3lP1OJsqYXvl1gnBO8vPcLsSMuSib+OIwIldyjLs9oIW+pY
         dlbmbvmDWBBb0FCk+CM9x1IIojne/wUa3lz9pNaKWt7j1is8ymIrYtzB9RJZ05RhQmhh
         E6cVfIKTNcvlRSo462aszEt3P0yrLAwIeKuXB7mLSKup1lBdcSklnAs6xgJIUZ9I45+N
         KvNWtLWx/5JsG39kI2vWRvWbJR/k+xA0XSbCq+Tkj2XVkvS78g00H0uozuKl9GwWvBxQ
         LeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+MnGlzO4Y2S1FJ/ZJQuVnGIaBuOVrspmTHpDek6kMb4=;
        b=iwSbKwi92AXSsyqHGVXw/gq7q9o92ma2WCHlrJEhbBWhrZcC7vDP8FX4cwSH6bNSAg
         OI7qHmyuyifLDmkfVSpcFT97X8sY5Jzc77arITzaV9IIhPLBoBFHWE68Vv/L86leO2+z
         G+2zbGU4o67CX7dY0sNhGI9ui/5osTohZ66fSfKMziBD18ns+3cvRorYJJdEfHL+UbJU
         bKfnALvZ8PoNcoETuxkkzRoCfqjmLEuphD2rn/TgIfPPkUVZHQoY4pgB+jqsT8r135FN
         nIUgauzASkdmF3sEn6gZz+c7DJHQ5ZMEYJ/O2K3T1lKi3I674HZ9yATgimFV3FQGeytK
         XvHQ==
X-Gm-Message-State: AJcUukd91aOprABtAmhBoh6hh9/GhRXLI/IsCsHa2LAUbmYiYfptaf7+
        vr1S2GWF11Fxbl6J56tNwrVPXBRZ/NFwYw==
X-Google-Smtp-Source: AFSGD/WUOdiXMYdsP/+SS+vWX75xhoXYe695ogctO3PemFuAYPu725WI11BN7JmCR/6NhxNIg8wbgA==
X-Received: by 2002:a62:13c3:: with SMTP id 64mr8514743pft.93.1545536123948;
        Sat, 22 Dec 2018 19:35:23 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v62sm45349369pfd.163.2018.12.22.19.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 19:35:22 -0800 (PST)
Subject: Re: [GIT PULL] Block changes for 4.21-rc
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk>
Message-ID: <d0300ef5-a4d7-22cf-bde0-a673bccab671@kernel.dk>
Date:   Sat, 22 Dec 2018 20:35:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 9:04 PM, Jens Axboe wrote:
> Hi Linus,
> 
> Sending this out a bit early to get this sorted for the holiday break.
> This is the main pull request for block/storage for 4.21. Larger than
> usual, it was a busy round with lots of goodies queued up. Most notable
> is the removal of the old IO stack, which has been a long time coming.
> No new features for a while, everything coming in this week has all
> been fixes for things that were previously merged.
> 
> Note that I've pulled in 4.20-rc a few times to both resolve a few
> conflicts, but mostly to get the important fixes that went into mainline
> late in this series.

The SD discard fix [1] you just merged causes a conflict, just for
reference, the below is the straight forward way to resolve it.

[1] 61cce6f6eeced5ddd9cac55e807fe28b4f18c1ba


diff --cc drivers/scsi/sd.c
index bd0a5c694a97,4a6ed2fc8c71..a1a44f52e0e8
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@@ -760,10 -759,9 +760,10 @@@ static blk_status_t sd_setup_unmap_cmnd
  	unsigned int data_len = 24;
  	char *buf;
  
 -	rq->special_vec.bv_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 +	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
  	if (!rq->special_vec.bv_page)
- 		return BLKPREP_DEFER;
+ 		return BLK_STS_RESOURCE;
 +	clear_highpage(rq->special_vec.bv_page);
  	rq->special_vec.bv_offset = 0;
  	rq->special_vec.bv_len = data_len;
  	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
@@@ -794,10 -793,9 +795,10 @@@ static blk_status_t sd_setup_write_same
  	u32 nr_sectors = blk_rq_sectors(rq) >> (ilog2(sdp->sector_size) - 9);
  	u32 data_len = sdp->sector_size;
  
 -	rq->special_vec.bv_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 +	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
  	if (!rq->special_vec.bv_page)
- 		return BLKPREP_DEFER;
+ 		return BLK_STS_RESOURCE;
 +	clear_highpage(rq->special_vec.bv_page);
  	rq->special_vec.bv_offset = 0;
  	rq->special_vec.bv_len = data_len;
  	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
@@@ -825,10 -824,9 +827,10 @@@ static blk_status_t sd_setup_write_same
  	u32 nr_sectors = blk_rq_sectors(rq) >> (ilog2(sdp->sector_size) - 9);
  	u32 data_len = sdp->sector_size;
  
 -	rq->special_vec.bv_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 +	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
  	if (!rq->special_vec.bv_page)
- 		return BLKPREP_DEFER;
+ 		return BLK_STS_RESOURCE;
 +	clear_highpage(rq->special_vec.bv_page);
  	rq->special_vec.bv_offset = 0;
  	rq->special_vec.bv_len = data_len;
  	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;

-- 
Jens Axboe

