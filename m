Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAF7C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D28A2077B
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mHbUqoxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbfAQBXU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:23:20 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38548 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfAQBXU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 20:23:20 -0500
Received: by mail-pf1-f182.google.com with SMTP id q1so3955991pfi.5
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SzOcom6a1OgqobL1zWGYDxGgYJyhMeFJKiJyS8sgSRU=;
        b=mHbUqoxV2FuYRmMnZL9yQdex5lGcMa0yQQtMZvcYlx9gWHnuj/MJRUMs43AiKOimrn
         b1+3zRqo6XDJbw4Xm+c57GRnKF7wgPHF3ZfszMfcgLsdRJo+QlH7hCP6t9HqA+lCxwxa
         UYbHGjx23HVtPVTaHm4Hf2ngeUrLLgqb7oXqbnUlZeAoBk8QYnSnGjhorEOO7DDa4P10
         KbbQehJZOg52LeZdhevjSP1vQxg3UpJo7Obe9COi/Z3mPLxJ7pc/IG/sRT5//aH7lrTB
         LlVy0pApPYs1DEZcynSZmKr1fHwCkb+5mhhRB2HRSTknKXK0SWQky2mabL7RoFjJDqwJ
         0Ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SzOcom6a1OgqobL1zWGYDxGgYJyhMeFJKiJyS8sgSRU=;
        b=Up+Iy8FvydnIKrt5MquCml8C31K/+Q0vQaTRF+xJpozYwcwm2iTehGqVfYg1gqS88d
         MOcQoEqs64z/bugpevjZp1dyOn7hwpltcHRUmwkwM5uLaRUV97hR7wVAX4LVSDC7n66s
         g/P5IAa/n/x5ueJ2nuAXzRwlURQ7k2qtSpLoh1MYBKh3QN1TyyDbpRXpmnGByY+6mBTi
         6JEEjZH+2pjBvShXQpvw9D1Xjok/2W31ez91mOs5pU5pi7ayqZ7JS9gDkkyfe5N8LmKW
         3evqyP8XQXFG2Ao7GI3Dr9YjUOwebqzXEvjN2TMfy4J2Eik01yhrwPLozRhfmEt7CWrz
         Mjkg==
X-Gm-Message-State: AJcUukcaAq5PviGHtQZctjnPXmNypPBXplihwNLBSqejhyhWrcHsUB94
        v8nmvEBCegL22+ozdZnPH7w3njetg8ID9A==
X-Google-Smtp-Source: ALg8bN6+Ch0Tkqr05zAxsmw5GQGsV7byKYBoRWd5vaX3c4xHmUrGO0lKJfOHq9RixrQ7/31hqWmg/Q==
X-Received: by 2002:a62:160d:: with SMTP id 13mr12752046pfw.203.1547688199122;
        Wed, 16 Jan 2019 17:23:19 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d3sm35569pgl.64.2019.01.16.17.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 17:23:18 -0800 (PST)
Subject: Re: [patch] io_uring: don't allow duplicate registrations
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
References: <x497ef4hzuj.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9965e26b-1490-7a18-e112-0d2318b8b23f@kernel.dk>
Date:   Wed, 16 Jan 2019 18:23:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x497ef4hzuj.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 5:50 PM, Jeff Moyer wrote:
> Hi, Jens,
> 
> It looks to me like calling io_uring_register more than once (for either
> IORING_REGISTER_BUFFERS or IORING_REGISTER_FILES) will leak the
> references taken in previous calls.

Oops, thanks for that. Let's make it -EBUSY though, everything ends up
being -EINVAL and that sometimes makes it hard for an application to
figure out wtf is going on.

I also added -EINVAL for unregister when not already setup.

-- 
Jens Axboe

