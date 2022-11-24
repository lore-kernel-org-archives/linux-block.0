Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE83C4321E
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 13:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKXNaI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Nov 2022 08:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXNaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 08:30:07 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3320BE0EB
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 05:30:07 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g62so1628431pfb.10
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 05:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yERCfx6hm6i3G3Npd6plnECUlMWYQ6NPvgIuF752/Sk=;
        b=X4OnYqooNw//+t8UiOYuFu1QDE7nzyGOxvio+l5YleV3ROAXycB9G/M8MpkXeNqavG
         N3UQSF3NQYOolpGgA147cmcAbfKyRac3n77bogydf0Xq/QM4hIaQjabQWRJ4Cgia9uQr
         DQBiUmr0Jb+ZBrTXTQa+7BfhLj6+jVX74EGAcosqpIMjVBQZamADIPNti8fJuERTNHgs
         ScQuMThUHgF2yUjqKdyDy1zUx/1NuzWHJm6sLmwvsj09c8FYYON7HWXzT+3CMHI3281t
         6bQ4lfbS0LVN7SWaiho6bn4Ew81Dl6soCDHK+QIzwdZOnBZgrhdaHl1Cvoa6n8nij4C7
         P2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yERCfx6hm6i3G3Npd6plnECUlMWYQ6NPvgIuF752/Sk=;
        b=otzrn6jsi5RBUf1oj5KY/6j/cPSsLA/0PaYAyCaiTywH0O/K4siyo1MGMb9WzsTP45
         6MQUvcxinNmLdQJYBoNtuCkHDnQUGWelWwi045CeMKh/O9Hwtfq0wMVgaW9yeaaHrP3m
         HEydL1/ZQBu/a+G5YpSwdZ4k/CxZFOogef7ZT+1b1JvKZzoFjaclhyNXiHcNBNu8OgfC
         LRGhCMur4YlaszoXBgEwFvvl2BM/WHRRpQD4GowzsXE/Mmk+i0oA4SK9A+siNWKYPTmO
         n3RWPFvVe7qfpl678Ldg2GtLF/ESD/ooI11qa6Hc+fGXCWnrDuQNruS98G2ZK255uUSm
         EmZg==
X-Gm-Message-State: ANoB5pmG0Ci3ynJ62qIsFGoimxLQZN4a94+uaum3y6Sz3ADZpk2VoRW9
        oyAZn6+fGWxcEhf34lSs39I1Yi/z8/ReHn9q
X-Google-Smtp-Source: AA0mqf5N9WPCg/o0CpBJDFxR9G8M4H//mkqrxAmQXafzOXR+VC94Ko6HshhBhvSw/mW4tIriGUGAyA==
X-Received: by 2002:a63:191d:0:b0:46f:1cbd:261f with SMTP id z29-20020a63191d000000b0046f1cbd261fmr12901192pgl.329.1669296606496;
        Thu, 24 Nov 2022 05:30:06 -0800 (PST)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a5e4100b00218f7c1a7d4sm1671729pji.56.2022.11.24.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 05:30:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221124021208.242541-1-damien.lemoal@opensource.wdc.com>
References: <20221124021208.242541-1-damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/2] mq-deadline fixes
Message-Id: <166929660560.51429.3700435810079299475.b4-ty@kernel.dk>
Date:   Thu, 24 Nov 2022 06:30:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 24 Nov 2022 11:12:06 +0900, Damien Le Moal wrote:
> A couple of patches to fix (1) a potential problem with mq-deadline IO
> priority handling and (2) to improve write performance with HDDs.
> While the performance improvement patch is technically not a bug fix,
> the improvement is so significant with some HDDs that I added cc-stable
> tag to get the patch added to LTS kernels.
> 
> Damien Le Moal (2):
>   block: mq-deadline: Fix dd_finish_request() for zoned devices
>   block: mq-deadline: Do not break sequential write streams to zoned
>     HDDs
> 
> [...]

Applied, thanks!

[1/2] block: mq-deadline: Fix dd_finish_request() for zoned devices
      commit: 2820e5d0820ac4daedff1272616a53d9c7682fd2
[2/2] block: mq-deadline: Do not break sequential write streams to zoned HDDs
      commit: 015d02f48537cf2d1a65eeac50717566f9db6eec

Best regards,
-- 
Jens Axboe


