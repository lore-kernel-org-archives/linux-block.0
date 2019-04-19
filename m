Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9437C282DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA708204FD
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LcKh5vtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfDSS3h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37480 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbfDSS3g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:36 -0400
Received: by mail-io1-f68.google.com with SMTP id a23so1267509iot.4
        for <linux-block@vger.kernel.org>; Fri, 19 Apr 2019 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w6SCNzvdEDsSzOeJ01+rJcS4jyKcld2PmSC2Ub2aHRc=;
        b=LcKh5vtn+WTIYHOOLGAyE9oIAnP+JWCufQY4KOAfsyBZ27JaVx7WGwUEk+yFvPWHCO
         p2qbDfuvqwiZ21dU4HAsX4cAmMxZhm2/hMyeYJw8BNpSdQ79eKQyoe18hFF0aiNKIyRa
         WTlaB7KgMPj2HUSAq+2ZD8BXDNk5uNauVC4IqRrK0ZDjLDjXZcOQqXqh3tnrsyFuAAO+
         F1XiL/yiO4SJewLdNHN7Ar4BHzyC0QUSWz4B0Ab6SOHOBz2jcrOMJ2Q/4fc5yVuA9G4J
         /19RiBDw+JDyOWZ1gTbzwAa1O5hYjQ1/Bo9Zlaj06p0hS3al8lM2EVqHDHDtcx+XcntS
         rFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w6SCNzvdEDsSzOeJ01+rJcS4jyKcld2PmSC2Ub2aHRc=;
        b=V1q1VeDxubC6vPihR3nbvmqVE/ygIPDw2BPMzu0biEonLHPqnTkR16cB3N255qKOsV
         cGJ7jtY2qLgvfv0VhszEkJB59F6gsh47TPYsLw17Hgo87o0GfBKRS7H0v1h+ZH4d4k1m
         hfhmKFdVqsJSO17GAApvu+7quccptd4n4u8hCIe+aEt4NFEvkSuz7SzaufbT9tIpNFSf
         e+/TiXgF9JcP01AxTJPDp9mSE2wqbG+xCwKUMV7NoPYXc9m81Fjvf4rXwMLRj/bpXUmS
         vn1/cy8KKG3q0PI2AmcyDK/pGLjurHgKwuKOkC64SZ4FioF5QxVGx+hwhnT0m6eXYQIN
         rEPg==
X-Gm-Message-State: APjAAAW0hURM3GI+KQzNW/v+DL2gGZH3/WrFgIyiZm5pr6ydY2l+wrcC
        8hdaV3Hy4+emhKSBh2VWcz4KAz7TtghO7w==
X-Google-Smtp-Source: APXvYqzgg+pTJPn56X1Rjf9So2QiWDKrBMF6RAMY3bqS3BusdyqssGdFdkGaQ+3EJvdsTFKfhRjYLA==
X-Received: by 2002:a5e:c24b:: with SMTP id w11mr3389115iop.264.1555695150563;
        Fri, 19 Apr 2019 10:32:30 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x68sm2620352ita.40.2019.04.19.10.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 10:32:29 -0700 (PDT)
Subject: Re: [PATCH V2] block: make sure that bvec length can't be overflow
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20190417011126.20430-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <454b9ed8-d35f-cc19-ec88-855fed00631d@kernel.dk>
Date:   Fri, 19 Apr 2019 11:32:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417011126.20430-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/19 7:11 PM, Ming Lei wrote:
> bvec->bv_offset may be bigger than PAGE_SIZE sometimes, such as,
> when one bio is splitted in the middle of one bvec via bio_split(),
> and bi_iter.bi_bvec_done is used to build offset of the 1st bvec of
> remained bio. And the remained bio's bvec may be re-submitted to fs
> layer via ITER_IBVEC, such as loop and nvme-loop.
> 
> So we have to make sure that every bvec's offset is less than
> PAGE_SIZE from bio_for_each_segment_all() because some drivers(loop,
> nvme-loop) passes the splitted bvec to fs layer via ITER_BVEC.
> 
> This patch fixes this issue reported by Zhang Yi When running nvme/011.

Applied, thanks.

-- 
Jens Axboe

