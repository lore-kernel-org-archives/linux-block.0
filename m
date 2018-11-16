Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C963C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAB02087C
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kglCUr/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAB02087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389961AbeKQBbH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:31:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40723 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKQBbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 20:31:07 -0500
Received: by mail-io1-f66.google.com with SMTP id r7-v6so17190212iog.7
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 07:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Js3BmtMcu/8Ddx1lEHQ784GFTsGFd07w04MFcc6IQ8c=;
        b=kglCUr/WLjwZiQ0E2CZyJsgMBYZ0QG4zYdk3OkTyo71pEf4Hd7Y+BbZY4/IhjbcXxH
         HNe8y/hjNYUuSbg6a24PW8kvUhOh9UiyzaVcWxBfXgXwxe1q1A0D1YcuLsxieIUztpGF
         9fxxaRPoLMtA3cEKwaLFfAKKAXC0sNo3dDjpmN6H2PsOHzAU50DPNU7KVqzT1DuBeewl
         bU4F++jvCGj1FKL+wB4vHefcq1MgXJZK/lnMs9hvnripIdcFtqFq3YEqn5u0I+DB773q
         t/fNRFP2x1PKeSlf4yuY2Q3dZ9Pet5298Wvp7OTuRRvXAHVJpHMgIHGcOckQfpW6AGvG
         Bp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Js3BmtMcu/8Ddx1lEHQ784GFTsGFd07w04MFcc6IQ8c=;
        b=VlxY0OKh6r9NHzB9xf8XvcYfXwVZTddGUt8S6l2XBwKUH+d7yiZrCbA0T9E0D2QMGC
         uhzlgW3WgdWpi27sSrhsxftxdvhnZasDQiPKvbLBv/MCKV9lVd5m64jKWDlKpHdq7qhL
         Ed9eE5MlYCx3SLQsa3PONH4hJtcavDCO645p/oe1kjwr2vBZit86hO4p+MxjiK7R+Ygt
         1itOg1HGOjljpG81Ke7o8cg7FnwVw9QKNGxBBgkFWdlctibYeFRyyb45NBWdUvO2oPMJ
         KpWimvz4lpenVFSFuG6XCttMvAiPmntJ+x8qmrNrJDFS4YkpxwrHm44vKdetqXDaKGUs
         mR6w==
X-Gm-Message-State: AA+aEWbhCFvCGFNvDgT9kEjn3j3VqGCOQDy9nnGrxzLFdHF8m8VREU1R
        CrrkM37croj0NaYZbTFhkyH1ay5SxsQ=
X-Google-Smtp-Source: AFSGD/WpB1SGoFYMsnX8xiGKMkqlAUPFkmi+l/FvaRuHsoP/8IcEPas64hlONe1R+/EQ20LW5PBbLw==
X-Received: by 2002:a5e:c74d:: with SMTP id g13mr5210929iop.26.1542381499675;
        Fri, 16 Nov 2018 07:18:19 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 68-v6sm1489283itv.25.2018.11.16.07.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 07:18:18 -0800 (PST)
Subject: Re: [PATCH 03/11] blk-rq-qos: inline check for q->rq_qos functions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-4-axboe@kernel.dk>
 <20181116083839.GE9023@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eef6cddf-c38e-f741-7f64-43d9c55bfd0e@kernel.dk>
Date:   Fri, 16 Nov 2018 08:18:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116083839.GE9023@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/18 1:38 AM, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018 at 12:51:27PM -0700, Jens Axboe wrote:
>> Put the short code in the fast path, where we don't have any
>> functions attached to the queue. This minimizes the impact on
>> the hot path in the core code.
> 
> This looks mechanically fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But since I seem to have missed the introduction of it - why do we need
> multiple struct rq_qos per request to start with?  This sort of stacking
> seems rather odd and counter-productive, and the commit introducing
> this code doesn't explain the rationale at all.

Per request-queue, not per request. One would be iolatency, one would
be wbt, etc.

-- 
Jens Axboe

