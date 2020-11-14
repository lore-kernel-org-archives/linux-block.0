Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E260DC61DD8
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 18:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CD02224F
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 18:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ar5yYtE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKNSRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Nov 2020 13:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKNSRu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Nov 2020 13:17:50 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B69C0613D2
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2020 10:17:48 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x15so6077814pll.2
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2020 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i0e3E64zBwid1kl9TRb62r7Kg+IomqRl8tjiUk7Bh9c=;
        b=ar5yYtE92kZ+9hKIQlmSdM6HKuoBgt3Lu8f0HxdrUrOiHZqm2UzBum26yliHtmn1+r
         mxSVE6PlJr/itb28rrNlbHsB2BZInkJuTLUUzDMap0sizj7IZ88LVD7xHv3929rOBD/0
         FRV1WZgZotmwOyHRXExpS4gz3qif6if5xK3amwypNu/hNKL98W4eW+y9hFqTcW/N345X
         lsYxw9QiHSiMZWUepK03fL8kbrAor/JLE5zyGABb127CO8UI19U9Rs/QqII7w4fvc10N
         gM4AA85DRqKlvHu06SMj9QPliMHjIS/LH13uqlsK4shI9951+5EKiIPpx2HSVWr1FxCv
         65Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i0e3E64zBwid1kl9TRb62r7Kg+IomqRl8tjiUk7Bh9c=;
        b=Hs3xXLl1pg1ipn8goxhbd9XCLmobxfIUdHsC6fnagIIsiWXL0fgo+AldhEnDPEiLPs
         kXJEjQ6kzi9Y43LUQsdEaRC15vWs+jFcvt930zOtGLiFJ/Tv6aDIc+6YF9rf1KnT0kmE
         BkheoQhTqvZnCwTYKC4V3p0jwXjQfrZkVm4VY4+o+vbOe/t09ifNNgpudE2EHT7ZKuet
         246RaSnQ4m9f0vs8yB8a9jHitKNQDWaN04SKmoBJoQPPdKJ+BqHgYJBzTGAGK+rqNUR1
         CDIP+BwtoUd+dSZvX9LNbnm8p1Q1A4N2b88PjtV5Zm0WwKZBTstBqvTu/jIg48hHP2U8
         e4ZA==
X-Gm-Message-State: AOAM53388E++aQn3a0uv4UJO7jaUXjevu04n3iEDscnQZonVLWxF+vIK
        w0rX4rV0MgloLb0T9ab5W4nob/SEyKdHeg==
X-Google-Smtp-Source: ABdhPJxdiozu1knCYASESveHYO4oSpGkq0H4nlByReLIuPAxWDkMxmBDoW1Jiylj6bOobSCuT3wbuQ==
X-Received: by 2002:a17:902:8691:b029:d7:e0f9:b1b with SMTP id g17-20020a1709028691b02900d7e0f90b1bmr6834076plo.37.1605377867947;
        Sat, 14 Nov 2020 10:17:47 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p4sm13819649pjo.6.2020.11.14.10.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 10:17:47 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: fix a hd_struct leak in
 blkcg_fill_root_iostats
To:     Christoph Hellwig <hch@lst.de>, tj@kernel.org
Cc:     boris@bur.io, cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20201114181246.107007-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3dd068d9-8dd6-ea2f-e600-f8007516cd1d@kernel.dk>
Date:   Sat, 14 Nov 2020 11:17:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201114181246.107007-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/20 11:12 AM, Christoph Hellwig wrote:
> disk_get_part needs to be paired with a disk_put_part.

Applied, thanks.

-- 
Jens Axboe

