Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7EFC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Dec 2021 13:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhLNN6Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhLNN6X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 08:58:23 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1337C061748
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 05:58:22 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id l5so17508671ilv.7
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=IeJEDuwrHuRaa+Ik/SvG/4JB6lqbm2wKrnNt11uuG4A=;
        b=wMb1zuONQwHdeid8S1mJv4yX2A2Yx3Z/jQ3x4ORQDBB7GS1EzW2Fmb33wZTbX8v2H7
         vlHWBrKTa1fuyiHpwFLEwGL4ByT9HaNvQNinFzQlphTwm/GTRuFGTP0nZEtPedwOJC4s
         AlTZTc01fPcj+twJQ5FmKV0qBKTeGPyCVEg46rJ3Whua4tLY2av7mihgHt/8RyrQ5C4Z
         nGeM3Pqadn4UvSal3UTyBkY+8qXs4RVhEnku3LPJfF52pbvKyzkPKLTYmTMnauD+asfC
         vzeOe7HKQJIacSFtyKrCc9WWAzxumDw5Ad4/u9iklppC9Fv5nJ398Igz/W1wjr8iUdbT
         5joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=IeJEDuwrHuRaa+Ik/SvG/4JB6lqbm2wKrnNt11uuG4A=;
        b=gYIT2CEsTI7QXxeZP4Fu4t7+uz03acxR9DwqYTIu9GmMkEwZ3+jJQVGs2HkaJ8rUNn
         eakKfxJN/C2uOYibzjUJF8gE6SBiVKnU09GMU9mQJZ+bZbaHUW5ex7qgufQ8HsmabE/P
         HPDXDbCFZR25SoWccgqIwTy+zO7ExoUUZsZm3yo1vU2c2fe61Pr5IR4WF4f9aj8rYkEl
         dOgi+sLx8zyypwhmrNmSp6uCVUMfRAcwVYyVA1BRhhhPGBEAQ7Rl4R0kJrtR3j5ifR+d
         tRO97e1psbp1PLfXPT8aqYjF2BHd0DHPeSbs1kvfJtNi+SccGeApwPBFKqkznkwghhiE
         OajA==
X-Gm-Message-State: AOAM531O+yRob4lhG0f3gJ90491MC0iArTPaVhIbvV9TZTt6AAjy+mqd
        ElAzNnr13dbsKHKcBv0sF46f/UDsXUdshA==
X-Google-Smtp-Source: ABdhPJzS0xykloyo4HnzZbLCGjWJWacfLqAlkteSfczA+XZFmqRhXAa8qf2/F3kXzIhTSCgWu/URgQ==
X-Received: by 2002:a05:6e02:1789:: with SMTP id y9mr3400069ilu.321.1639490302145;
        Tue, 14 Dec 2021 05:58:22 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q8sm9533638iow.47.2021.12.14.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 05:58:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
In-Reply-To: <Ybfh86iSvpWKxhVM@slm.duckdns.org>
References: <Ybfh86iSvpWKxhVM@slm.duckdns.org>
Subject: Re: [PATCH for-5.16/block] iocost: Fix divide-by-zero on donation from low hweight cgroup
Message-Id: <163949030003.173863.14081933851643062205.b4-ty@kernel.dk>
Date:   Tue, 14 Dec 2021 06:58:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 13 Dec 2021 14:14:43 -1000, Tejun Heo wrote:
> The donation calculation logic assumes that the donor has non-zero
> after-donation hweight, so the lowest active hweight a donating cgroup can
> have is 2 so that it can donate 1 while keeping the other 1 for itself.
> Earlier, we only donated from cgroups with sizable surpluses so this
> condition was always true. However, with the precise donation algorithm
> implemented, f1de2439ec43 ("blk-iocost: revamp donation amount
> determination") made the donation amount calculation exact enabling even low
> hweight cgroups to donate.
> 
> [...]

Applied, thanks!

[1/1] iocost: Fix divide-by-zero on donation from low hweight cgroup
      commit: edaa26334c117a584add6053f48d63a988d25a6e

Best regards,
-- 
Jens Axboe


