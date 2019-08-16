Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F885C3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F8420644
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="dI2ZRUmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfHPNV2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:21:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43478 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfHPNV2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 09:21:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id b11so6022925qtp.10
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fbkwihLXGXUfSUCVgs/bzQtXmI2e46v397aoKmwXP0=;
        b=dI2ZRUmnzm/OQ7ydksBbmdAmwdFhghyE5zxE/88riTwrPr45hrTbh9qPDArvMDYkUd
         F7TAhHC0K17hpC59Kb70l7xnuvBK1ehXOYI4hmFKzPZ5LHf+F7ck89rsxd9+xqdKGAh8
         0OBJEVFpEL1GN8Lztfoc6pNfrOTZ64wRrEuOMnk/0d4kVcCsSAyJaDpzmzvVpuhupZWC
         MNv9nij6C3ZuxZ++UeOVAPidMEH48g3PpjPtYSEiIhc8CL1Dg/ITZ/+1++XljyUZqrgE
         EdXUpC3SfjQFqHODoe6tjrvYNFaAcubmOtJ7unkDEub/FyJ3DEXgLELKkaYHnCVq9bbT
         cjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fbkwihLXGXUfSUCVgs/bzQtXmI2e46v397aoKmwXP0=;
        b=RhybA1ZRYQ+b+Uo9FTLMPdOU0T4EbMWBNIUTPD/acrlq4y1XR6dlT9rTs+eeQyaPMK
         WIPIZEAXwnF2K4gEyNdhB37lT+jQiBFjjeaTS7VOYfQtDaJIwKdOXMfhXuJK55LzDEoT
         9vpoIaxUh1HENhj600pziI8SLCcwD6/76oBYrhaOSy2yPvvSlpi08yQn4wRbqD8i9J/h
         GunfnmPqy++LG6TEdaBUsCQbEvOIhzYpi1Y6DNLgJnBZ5l7fHQ4IWJXtZ7UzM+YAPPSD
         y43T0Sj0uYi3A4aVsQ/pGHHNdVMcoNYUXCyyuW93jFdsOgZYtQL84oCphayGA+lFJJ7z
         +VnQ==
X-Gm-Message-State: APjAAAXz8RUc5gCgEQIWMlPPYEepa2gsdc9mxlgATnPZdoBHSg0Hc54z
        sxAhhNf5GkcgIC/j1CzmGvfXdA==
X-Google-Smtp-Source: APXvYqwUG3oxzHkWJiHLRirGSQ2MZcvdeSnSOLkA48d/eqFPbvANn+AgGCEMxoezPLFXYyOiwVvFFQ==
X-Received: by 2002:a0c:eec5:: with SMTP id h5mr1785518qvs.238.1565961687236;
        Fri, 16 Aug 2019 06:21:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e5ca])
        by smtp.gmail.com with ESMTPSA id 18sm2924794qkh.77.2019.08.16.06.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 06:21:26 -0700 (PDT)
Date:   Fri, 16 Aug 2019 09:21:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Tejun Heo <tj@kernel.org>
Subject: Re: io.latency controller apparently not working
Message-ID: <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
References: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 16, 2019 at 12:57:41PM +0200, Paolo Valente wrote:
> Hi,
> I happened to test the io.latency controller, to make a comparison
> between this controller and BFQ.  But io.latency seems not to work,
> i.e., not to reduce latency compared with what happens with no I/O
> control at all.  Here is a summary of the results for one of the
> workloads I tested, on three different devices (latencies in ms):
> 
>              no I/O control        io.latency         BFQ
> NVMe SSD     1.9                   1.9                0.07
> SATA SSD     39                    56                 0.7
> HDD          4500                  4500               11
> 
> I have put all details on hardware, OS, scenarios and results in the
> attached pdf.  For your convenience, I'm pasting the source file too.
> 

Do you have the fio jobs you use for this?  I just tested on Jens's most recent
tree and io.latency appears to be doing what its supposed to be doing.  We've
also started testing 5.2 in production and it's still working in production as
well.  The only thing I've touched recently was around wakeups and shouldn't
have broken everything.  I'm not sure why it's not working for you, but a fio
script will help me narrow down what's going on.  Thanks,

Josef
