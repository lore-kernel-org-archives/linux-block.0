Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04DC433E2
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 01:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DCC21655
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 01:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nuIk1sCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgIOBiA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOBh5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 21:37:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671AFC06174A
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 18:37:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c196so1028728pfc.0
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 18:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=veTRf67heiIFBb4KPb8qCnP0OdQI7n5gixhte0BRym0=;
        b=nuIk1sCKUYraP3k57rU4ShNSYsyPO6TSIfbhfJGQr6XoUbfSbodkxRYwXNVW/EEBnx
         S4g4Plpz8OrOv+wOakdj/YTlGdE7xpbSoZTCgFA6cKkcQ999EbkYaI90Y/2dWERkkNZ/
         z3uPvic5mPlvmNiDl4C1QEcmUXvaJdlRCS9gFz+05Q3KennGshV4VpIpviIZsmb/AVOc
         zVzlJ+dFJ+ZST8txLF+bWxw/p4eKBSvfLb5JsmcPncRwA1w43w2seg2dbik9+EhH5cCR
         TQA/WLjUvkqQRATpdsgf4rCmTr8tRoXZEu/XvpfvhuSclBmVwXpwe2nDqKzztpaj2/1u
         Blxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=veTRf67heiIFBb4KPb8qCnP0OdQI7n5gixhte0BRym0=;
        b=P6hhbR3eJH1ELtz1cIyskGb9N1JBIs11xui6HyUQCvn+uytJgPKIfnWuxbvOYIHh8+
         i1jWRYCNa3W+BVarwij1tACtH5GMx7XLRTU10ejT0wzdsPCwqOST98/0h3vUmhX8SoxR
         /4uw2lcOYyxR9WqWZrNobQiOWZb5H8mAp6SMMjQ1AAJPnxkNqWLDhfE21isWwGwQ1qPr
         f+FYrIsbfTCQHBurjPKIQZJag1s9HS3zN78HT0wp72B91omEL51DWDOC/5hhCxk5xfni
         3AXzAfEG2QY2PfHbpnUeXpy53Qcac8g2FxJVPZgi2fJRrUDLj+V/rgERRPOvl08rYkVh
         mzqg==
X-Gm-Message-State: AOAM532ZqIe2NrAFRFc1VYEwr69YEgPDP11j+vxIm+1sJOP4xAwQkGai
        DEPZ2JdULfQ0xlSCpbuX2hc7tPnGuAL7R6Ao
X-Google-Smtp-Source: ABdhPJzgHqFLzOqTAgfUjDKvOe1d+ajMiyzwv68TI2k4WqC3aQxq3mx3jZ/CepIWy4+hbH0Ix8oyHw==
X-Received: by 2002:a62:2c8:0:b029:13e:9ee9:5b25 with SMTP id 191-20020a6202c80000b029013e9ee95b25mr16061298pfc.1.1600133875800;
        Mon, 14 Sep 2020 18:37:55 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i16sm13205719pjv.0.2020.09.14.18.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 18:37:55 -0700 (PDT)
Subject: Re: [PATCH 0/5] Some improvements for blk-throttle
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <822998a7-4cc7-88ee-8b3f-e8e7660a5b0a@kernel.dk>
Date:   Mon, 14 Sep 2020 19:37:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/20 2:10 AM, Baolin Wang wrote:
> Hi All,
> 
> This patch set did some clean-ups, as well as removing some unnecessary
> bps/iops limitation calculation when checking if can dispatch a bio or
> not for a tg. Please help to review. Thanks.
> 
> Baolin Wang (5):
>   blk-throttle: Fix some comments' typos
>   blk-throttle: Use readable READ/WRITE macros
>   blk-throttle: Define readable macros instead of static variables
>   blk-throttle: Avoid calculating bps/iops limitation repeatedly
>   blk-throttle: Avoid checking bps/iops limitation if bps or iops is    
>     unlimited
> 
>  block/blk-throttle.c | 59 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 23 deletions(-)

Looks reasonable to me, I've applied it.

Out of curiosity, are you using blk-throttle in production, or are these
just fixes/cleanups that you came across?


-- 
Jens Axboe

