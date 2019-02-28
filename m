Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE2BC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 12:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E1B205F4
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ixggv1Iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfB1M4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:56:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39536 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfB1M4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 07:56:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so9178408pgp.6
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 04:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kzo2A+a3ZDwHIOHPtl4HrG/jPh4Zs1QQ3qtlr0uEII0=;
        b=Ixggv1IujZhkUmMB8GKJfV1kLeGuVpqDo0nO6HLwh5c35/7BrHJAy4XJwbWAB6kOdj
         9aGMmqwcKwpZPQPuovlY/B5cxcQeAX59xhlnt/o/w0+00U1byLDAvQY2yCpkGH2catUS
         3lhzoZ0FhaDKcvf6D4vlMunRlhLcjnorHEkvCPV9r5DN8v81SL6RxgdK4V43jX6Ul3O+
         EHkMG+RlNLu5WwD2VRK0NCCMdtj9bsOAdYPPolC2D6zVR8S3gAurR2jSt+4ws0K7r5Nk
         LyT1u6k7TQzsaxCSHxjunEwMFHDoc4kIysEtHiQ1IcWRztwHfrJpRWSaF7k+nnxfs3nn
         ssbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kzo2A+a3ZDwHIOHPtl4HrG/jPh4Zs1QQ3qtlr0uEII0=;
        b=rC24Tm4IfOBj8hIVNrCj3fOlFLK99kwHOsDWeOH1WY5lpmHtEMl3ZGhP9VtHx/Qoix
         csmUuKwMEqKG3Pfy5xKUWTRUq9I2bs4dEzOUzuELhMlaeyO0Iy0ZSSJS49o2xjDg+DGx
         R2PDbdmX0K4Sgu+bQ/tIBGly3qW3RSsyXCwZre8XUZREDdFmRgKATJFabjwSoctI0Lt3
         BYOxE/KdvP7h7A/GC/lJblqB+4RGxPJRZFSkez/dKbmmUAvLWhgWfX0GdOz8kRnpf1pC
         00bU5D4I4ku4uU3A8EsSVFrKzQKkU3t6LXNtB+Fwo7+Weo+Vj2wmk6JX3caGzHZMp8w8
         95LQ==
X-Gm-Message-State: AHQUAuaaBWl+VvOtoGIMWPlFFDf/lWHks00z+olycSgBRTNDeTr9hsFp
        bsRm4x/NLBHqHzGIJrtMPskNu0yHBn2HnA==
X-Google-Smtp-Source: AHgI3IZ79aJR3f/Z75MpMz3s0Kndv9Hh4xS4ftIsj5apNj1WqjJqDNDBIZxKeM/zvdC5kQbtTIkdZA==
X-Received: by 2002:a63:4247:: with SMTP id p68mr8493845pga.30.1551358582352;
        Thu, 28 Feb 2019 04:56:22 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d16sm23996213pfo.112.2019.02.28.04.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 04:56:21 -0800 (PST)
Subject: Re: [PATCH] block: fix mp_bvec_for_each_page
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190228122927.3495-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fafa4b89-97bb-42ea-8659-1ec141b625b5@kernel.dk>
Date:   Thu, 28 Feb 2019 05:56:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228122927.3495-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/19 5:29 AM, Ming Lei wrote:
> mp_bvec_for_each_page() may miss the 1st page in case that the bvec
> ends before last byte of the 1st PAGE.
> 
> So fix it by checking against the last page.

Thanks, I just folded this in.

-- 
Jens Axboe

