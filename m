Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5D8FA373E
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 19:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJYTmQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiJYTmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 15:42:14 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D8AA027D
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:42:13 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 63so1761910iov.8
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lGMZCl6MsHpA0l/UmVpKGZS+WaXxPljTxm08IgnT3I=;
        b=ZRuZUJXEdG6ReXlAKYLkUSjlXGQWFSHTVdJhhZ11fiPmVmAiZIC71OMK0ZYR5p84N9
         AwFeemtWcoO6ZBEFUYDhfbtXe/14YZKiBX+hJO6uQmMIZpEUmMuydJnWfPCKqJqsWvx2
         71EE0jBxceIg0YbU8xxQOGicuMkCGQa28eAvhtqdm6iiCpJpwGBgx2/1u1DDuzrTBJEH
         vu1VokKzbPqj3rJ4Z5ptdjiY7nvrPWe+JeW8OdJbJF/2Za53fj794pCaFN4RBZ0d2tgj
         7iDS9nt/DuFBzbrE1e6yLkxdm6FEFPQtyYfcZYGxJO2Fyu492g+X5+VVPX9qxzQ/AnL6
         Hv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lGMZCl6MsHpA0l/UmVpKGZS+WaXxPljTxm08IgnT3I=;
        b=BPqfuCwyyUArYeB5K2OP1yzJs5RIddX/JuBidgeYEmrpou8sfMxtryl0kh+dLXopze
         nd4MhhJ5naByh0D5bK02FmMMMHsBEPmfAlSnVNRH9xH3MDejXildkEOJxDnCgb3zNbf4
         KBZugu8Syj0vD8AaxYI96PZSgOcRwUhKObn/7RhBnbuFlj4ZxNVYKkKbkkGKglw/5sBH
         d/EuH0STXeyBwpImsV1KKv/bjxhz0p139mUV/KKbREt8AF/Mno2ro29vCIJ2qrQ4ognB
         JbQ8m2J4A/9jVa6TMLv/k4tKXfLLSCHSLFAZI+2ktl6BUgpfdeFGP4r9FVRAZg7aWHoo
         lVew==
X-Gm-Message-State: ACrzQf08B7wUXftL1Q6Lzu2mvspoOkBGfsTUcOSFqrZ5ljYeSHJ8vloE
        8dec6L4LIqawBI0jplxTXSbUaw==
X-Google-Smtp-Source: AMsMyM6geUBE38POIDQkbUnJUnIAc5V6W5uVF8wJoP8lw2LKt97+bXhx7vn4mbRsoO5XxEGESxIKcg==
X-Received: by 2002:a02:a1c5:0:b0:372:d180:fbc1 with SMTP id o5-20020a02a1c5000000b00372d180fbc1mr8247080jah.297.1666726932901;
        Tue, 25 Oct 2022 12:42:12 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n17-20020a92d9d1000000b002f9b55e7e92sm1318548ilq.0.2022.10.25.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:42:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20221025191755.1711437-1-bvanassche@acm.org>
References: <20221025191755.1711437-1-bvanassche@acm.org>
Subject: Re: [PATCH 0/3] Block layer cleanup patches
Message-Id: <166672693198.6037.1837226831730358064.b4-ty@kernel.dk>
Date:   Tue, 25 Oct 2022 13:42:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 25 Oct 2022 12:17:52 -0700, Bart Van Assche wrote:
> There are two cleanup patches in this series and one small performance
> improvement patch. Please consider these patches for the next merge window.
> 
> Changes compared to v1:
> - Extracted these patches from a larger patch series.
> - Added Mings' Reviewed-by.
> 
> [...]

Applied, thanks!

[1/3] block: Remove request.write_hint
      commit: b179c98f76978a0fae072c2b2dad8e143218afd8
[2/3] block: Constify most queue limits pointers
      commit: aa261f20589d894eb08b9a2b11c9672c548387cd
[3/3] block: Micro-optimize get_max_segment_size()
      commit: 95465318849f7525f4dce1b720e4627f48963327

Best regards,
-- 
Jens Axboe


