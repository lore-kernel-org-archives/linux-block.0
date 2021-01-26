Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E4CC433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 15:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5542100A
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 15:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392015AbhAZPvC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 10:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391967AbhAZPuw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 10:50:52 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25CC061A29
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 07:50:12 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p18so11663369pgm.11
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 07:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SsOHsp4CNkFxjdTZshpM5g+g+qO3mJ0CLTnLDYGv8F8=;
        b=Q/fVoQh5K93yJcNdbudRk4luINyrwHUURtqGAC6/JqYcOPosFilLAg+2J9JqCAyANZ
         EnsGBpNvfjgopsphz2sovbPJTKzmrCA4ASTUfBXE6n5cw0t3FfMmYTlyc1xvJ3u4wQkQ
         Y0g4X+JIUu0F+4XBCTzkbegxLAe6uGJ9kLMY+tHukHRybvSz+0BFvNicJpql+rcTOst4
         R+9elAJWLiLOLRWZkaX9ONwxX4kAU4kEKAJNJ7ldWH9kdI13qMOMw3Tw4lgEoMSa2iix
         gpvu7RWlVeK3KO+3PC7yJ38PHoTMygY6TEZX80x/gMEorKUHLXX4Y1vfo2A9Qe3S+DTK
         3pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SsOHsp4CNkFxjdTZshpM5g+g+qO3mJ0CLTnLDYGv8F8=;
        b=becdVwqk/T9+PHt6/d4BLd9jiouoacpcaikAf+tSq6hoKL6rM8YG7Nq/OXd2SkKA+W
         ckBCKtICqLSKNKmpXypc91F+4SmuXJm/0+a47xeREYZhp7QFwNRqwMeFlWroEzYuu+WW
         Nzf7MR64zKqL2hIJq9T0UU/jnM9UydYPw1uO3NxBsWp40hBSWQ4MifSjBr1b/HGZlE5r
         U1gGzYwWQ8qyDKrRhbx7Wukz4qjESRdR6RV4hO6qvd+L92mWSHtNmC74UNQW1L4V12ub
         H/AUJ/FS7qf/YFqtgppgKjMOyIaklqGYoaL+IBQBhhoxKOrqkNtizAkMIa5nMTwIMHKS
         X2aA==
X-Gm-Message-State: AOAM531pbuD5CI5qRoJwb5fptwI95yCIwmI0L3jQgDW3oBgUzG1iSTwq
        n6HDhaiHWPa0c7S9Q5RLQdvAhF5SyD6KoQ==
X-Google-Smtp-Source: ABdhPJxFgCpz0Tr3yR3J/h+CulR4O67CYepxBdICoMBSME41Ibjc9P2FhWI9Jz3iszjTH1K/mjzkMA==
X-Received: by 2002:a65:5241:: with SMTP id q1mr6163039pgp.143.1611676212261;
        Tue, 26 Jan 2021 07:50:12 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id y16sm19967027pfb.83.2021.01.26.07.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 07:50:11 -0800 (PST)
Subject: Re: additional ->bi_bdev fixups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-bcache@vger.kernel.org
References: <20210126143308.1960860-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b33aeb19-094e-c32a-2da0-33cff6f9e418@kernel.dk>
Date:   Tue, 26 Jan 2021 08:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126143308.1960860-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/21 7:33 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> more fixes for the (so far theoretical) fallout from the ->bi_bdev
> conversion.

Applied, thanks.

-- 
Jens Axboe

