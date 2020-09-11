Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86192C433E2
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 17:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE39221E7
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 17:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dtr8rc1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgIKRMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgIKRLB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 13:11:01 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754DBC061573
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 10:11:01 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y13so11841849iow.4
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PjaHcTfFjzbLCw68IPxqcyo+o8vTrqFIU4LrLdQ6i4E=;
        b=dtr8rc1TFTdhuQX1JX6cpdjp7g5dPXot326EizN5cMg4FGGWCBF3SujtkOjH2g9AU8
         VYooSex5NOHLaQmydJQvGP2ciPTbamrxy8e63sgmRcld3qe9CBysCiE7nkIJAWTrWWzD
         5cPZyRl9Z1CgPdcCfFgCs0umR5vPyTmNsQ7ARuMaYYHRDmzXZ+nTUkdmdtXeWtLd5x6F
         HZeOjxlKX3IAgX2SHg4n37ycDB7odU4BCn88ZKZVTPuVXZ6SEHZ4H2WFRV979A/Iqjwg
         f8eUotxsYrCJSPi9GeB9lCE1tcTM+Wow6b+ZMYQyvCDgYzOgnphaaEjqYJOXrGsWBVEa
         ZVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PjaHcTfFjzbLCw68IPxqcyo+o8vTrqFIU4LrLdQ6i4E=;
        b=aE3oqCzjB0VEHbjK72q/pBvCYfuk7LyqBEoF43rqnLZc1Iuo8ML4+szsmkW3/0H47u
         354lp1xQhbEYQvavOq92zVy845TNZOPrXiITRHWAOtOsU6FXkDosKsPUHFciUGJjZvZF
         a1WjgHmW/VEgpJBIo5mtFe9uf0Yfei8gfiJcrTgNLwFHDILIYTZd7RsqWmnf7QCn53r9
         0fbHF5ntthTq/+4EOMvdQHBu58Ilv+HXMd2D3cG3GLIj1FiPxDsPzUcNxncHn5Ykj0eq
         YhlWokbsogWEjZElUwbMahg0VJRAK2/D3J3RwYsyA3i3FdW77iL3E7rjba52I2gvFMc+
         geOQ==
X-Gm-Message-State: AOAM531Nd1hNy8Q02iXDDlquA7+oukkZq4L+um8pnTeFiy/HyOPuEG70
        97WONi5Y7B+pMaAr+TiMyc73pQ==
X-Google-Smtp-Source: ABdhPJya9L0YSSJEFVGJqL4QEUVLucOzZ18qlV1aPXjITgOpcqQR+btExvD6D25jNhpGgt8ZHCc9mw==
X-Received: by 2002:a02:8805:: with SMTP id r5mr2931118jai.52.1599844260029;
        Fri, 11 Sep 2020 10:11:00 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l14sm1509002ili.84.2020.09.11.10.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:10:59 -0700 (PDT)
Subject: Re: [PATCH block/for-next] blk-iocost: fix divide-by-zero in
 transfer_surpluses()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
References: <20200911170746.GG4295@mtj.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff46ca79-433e-3279-a8eb-35156639be7b@kernel.dk>
Date:   Fri, 11 Sep 2020 11:10:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911170746.GG4295@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/20 11:07 AM, Tejun Heo wrote:
> Conceptually, root_iocg->hweight_donating must be less than WEIGHT_ONE but
> all hweight calculations round up and thus it may end up >= WEIGHT_ONE
> triggering divide-by-zero and other issues. Bound the value to avoid
> surprises.

Applied, thanks.

-- 
Jens Axboe

