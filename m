Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE4C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264D72081C
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oTZC6uqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfD3Q0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:26:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36730 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfD3Q0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 12:26:01 -0400
Received: by mail-io1-f66.google.com with SMTP id d19so12753876ioc.3
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dg+V+anpuAxbOR+5OMOKSK2lM2Hr69lijz9ORDKKZHo=;
        b=oTZC6uqhgjBg6gNR/nJb6gKZiqQmPzmUEnHF1otlRAbschfjQdWgk/0OBeRmzdKeC5
         inP4MRyZ385eGdj7xl1BTtentkSEwkjqtjltsr2ZYe3rwmWWiBwJE2AmHahCTOt4UXJu
         g84dnwF8MLqLRnoj/sFB+aJ/0Lu26SsL1VSq5OSYsuIcbmmV2C5YFqdTcx33xfj0c8NZ
         /fiywPGwbfO4NHc9n3inHMUtkwBzFlZjIkPeM7gZFC+ZzuFPmt0FtmoUGb1xlFrlqSlX
         x1MDjEErBRCh2wiZmKpStrQ9muj6mgnZJeSuGWkIat1R90jmMnu/aDNTQoGUmfu1fMyj
         1Rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dg+V+anpuAxbOR+5OMOKSK2lM2Hr69lijz9ORDKKZHo=;
        b=fy5jD5CkcwCxRD2bHsV+RKHLrrSlnmO5p+jXz/acU3QC4VU3jTvpBIfrsa7g6A5+4b
         7f0vu+TLHen9yXAkGJC+5J7obyRGsBTGosTfMPvMZB2mAhD3y2UXxpwYfGxQH4hls6iN
         Cyd+CcVuuOS5vQJDZmrxFD4J1AslwyrkR8xYZBzdzJMVHLXzGEqVGtytqbCwe07H3ggl
         RJiPq3g5GZMruS5cfNSo0XwpMAmiUHrTL5Wrwr9teM1ie2F3/e/Hmp0pVphezAQA22Bi
         Hw01p6mu/0eKSZ39Y0Vhd0Zei9hwzqdvJzSYlZprgfodIURcsGigauLzDruGaImiH2xp
         vvoQ==
X-Gm-Message-State: APjAAAW48DD4K7LSAnOUeCEHtGTtFBmoABRxLBzqHecspGST6QCv57Rb
        +jvHzhPqrVyNm4wiIVcqjlo/vnJwfAr3Lg==
X-Google-Smtp-Source: APXvYqw2WfFzy9c/sIOkLtnj/jGAZnVJH96KNES34KBHnhvr4LS75vUUAEKbu0PE3pb/gY15cClXJg==
X-Received: by 2002:a6b:c386:: with SMTP id t128mr5223266iof.167.1556641560113;
        Tue, 30 Apr 2019 09:26:00 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o199sm1640874ito.25.2019.04.30.09.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:25:59 -0700 (PDT)
Subject: Re: [PATCH] block: remove the unused blk_queue_dma_pad function
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20190430161030.23150-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e595d372-aea1-64f9-dfe6-c80a1f04be7b@kernel.dk>
Date:   Tue, 30 Apr 2019 10:25:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430161030.23150-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/19 10:10 AM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c            |  2 +-
>  block/blk-settings.c   | 16 ----------------
>  include/linux/blkdev.h |  1 -
>  3 files changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 029afb121a48..22da218fbcda 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1576,7 +1576,7 @@ static void bio_copy_kern_endio_read(struct bio *bio)
>   *	device. Returns an error pointer in case of error.
>   */
>  struct bio *bio_copy_kern(struct request_queue *q, void *data, unsigned int len,
> -			  gfp_t gfp_mask, int reading)
> +			  gfp_t gfp_mask, int reading, struct bio **biop)
>  {

??


-- 
Jens Axboe

