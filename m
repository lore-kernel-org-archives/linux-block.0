Return-Path: <SRS0=yHxa=2T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF79C2D0CE
	for <linux-block@archiver.kernel.org>; Sun, 29 Dec 2019 16:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193F620718
	for <linux-block@archiver.kernel.org>; Sun, 29 Dec 2019 16:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ollPjs0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfL2QOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:14:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35231 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfL2QOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Dec 2019 11:14:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id s7so7142575pjc.0
        for <linux-block@vger.kernel.org>; Sun, 29 Dec 2019 08:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lS5C3oE5Vb5JCHjfA6cg71mAiaSuEjKzhQnNbiEg9Zw=;
        b=ollPjs0dtwSWN+HyZdP8kgfYGppmqMb0Bq80VPdSNREPbV1D1wT2wMdIl2dNaFD/Bz
         dAaFW8Eo5U10qrt1GOxyqaSPoTBDs8bTOouUWVw2R61JxNM1JCgpo4tg4g+IBbXrHnaw
         FvBt3aHpVlbtgCFIUhNc5sidEnjNoCOtEutSQy/oV6Fr7810QKBjH60pDf6kcsypfGqk
         vkSRqKIcdEkLtTzGEEQMBky4d/8A+O5ZUlucycsEgGUsJYj9vUw/oWJrRtAiCh4iEBzB
         8P9UtbQrF5S6PAmOsj44wHamRd5nT6fXn56QSImQ+VYp9a3x7USOa7Yhc0rrUOi/sNoA
         2hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lS5C3oE5Vb5JCHjfA6cg71mAiaSuEjKzhQnNbiEg9Zw=;
        b=g44ri4SnXd32lrYqzZbpt22iiHk/tK+5P/W3bvJLCkIkJEyWMvFQxkBtfsypH0sDCc
         PxIkrcV9Hfd3YG7U/prxRxoypIYEh/pMFWmpiTMOtcWT49xpjlnBo7ihR0EvSLh0PvIf
         oNbe361nr48aG1fIwOeye27XsKQ7vNkdWw4p/+4x5iKdiR3qCZNzKjc3R9pcRdHr0Xz+
         gG9zDAZpIqF2n0l8ZTmIKE86jKGfw4ZVU02DjRIM0ocH4Cr1vyZZko9/NIIdDSrV1d3T
         v3z/X1H9suOd/IIMAC8doeU14AeHbnvefy/iCKvuw2GpaZIZiH3JuWt1YPz7bBJv8Ezr
         /1rQ==
X-Gm-Message-State: APjAAAXD9irqt5z7F6ql056btwRDstxFfwAX+61IDqLGkHeExtxhlMDK
        JweGQMoZHnY8+vQvjZLvCVhMKA8BxNR+cw==
X-Google-Smtp-Source: APXvYqwtCodKfV0a5BRs0YHAcl+IIGZfgOvi6O0sXVm/39a/1Vuc20l+GT3MH0T5pQbtwcCFumfEqQ==
X-Received: by 2002:a17:90a:9d8a:: with SMTP id k10mr27493664pjp.91.1577636058544;
        Sun, 29 Dec 2019 08:14:18 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d3sm7929305pfn.113.2019.12.29.08.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 08:14:18 -0800 (PST)
Subject: Re: [PATCH] block: fix splitting segments
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Chris Mason <clm@fb.com>
References: <20191229023230.28940-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f49d02ee-9b36-be80-9a84-d74cfb35f796@kernel.dk>
Date:   Sun, 29 Dec 2019 09:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191229023230.28940-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/28/19 7:32 PM, Ming Lei wrote:
> There are two issues in get_max_segment_size():
> 
> 1) the default segment boudary mask is bypassed, and some devices still
> require segment to not cross the default 4G boundary
> 
> 2) the segment start address isn't taken into account when checking
> segment boundary limit
> 
> Fixes the two issues.

Given the potential severity of the bug, I think it deserves a somewhat
richer explanation than just that. It should also go into stable. This
is what I queued up:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.5&id=add1fc07334260253dfa880d9c964edc8381deac

BTW, did you change your email setup recently? Your patches are coming
through mangled.

-- 
Jens Axboe

