Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67487C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 13:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDMNML (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDMNMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 09:12:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700A0AF10
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:11:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b5312bd34so65797b3a.0
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681391488; x=1683983488;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOZYbrXhG6vMi0K9b9D3jfmidZWcUQ/LYCnf+UuPDiw=;
        b=TzOjrKklGC46OAu0C9VeLbWm2xIbC52A8yNPKf0k61rHCZ7WepeOf7M2d6g7GGwvXe
         xQ0/kLEOU3+VwRAqvTKlQdM3PxkHCpsYQxtQb9LWxLMiRAPpNks8aq+8pZHkjM3fL2Ic
         6OGZUsaO7d7l2XZR1BxvDA9p6R4t8vFvI1DwcxaxZdCid7/kuv5dwYpeDmJ1usora1mi
         mPjcpdS4SrXMZG/uA3Ta7Phx0yvUpCvai1VkhEy4H0R06v5CrE7NpUkEDEMfMLH8pvri
         fFqruOYEsJ7ih2kjjN27SP6/i7UXNzU9NaBYJX4qDwJYtw0z+2bAVkUeo7HK8INYQryN
         SFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391488; x=1683983488;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOZYbrXhG6vMi0K9b9D3jfmidZWcUQ/LYCnf+UuPDiw=;
        b=C0Je6sc2CzwHtioiz/KtjVaQx9hTvHTYvaI+Td9FGLUUXvGrLfjgWd0ax0npMnw1Gq
         YWkfHvCr/8jnrCpOV+zZcgwWwTBTiV1h/zJPrQAmDgmmzv/3U/8cxseIdnuvakEmHjd7
         TCRMxGNnA3p20W0wAk7mcK1vb5o22TfdC59w2K2/a07oC4ZyLcQBxenfIlIsYRGcA8kB
         wZ+QxbL9FL8C/jddPuTMpGK4CK4v+ujp2Bd6s/aAFrZcRZLhAsTFekt2FVKnLFZoXsxY
         HV/s3vnJQ8uuK/euMRoZ3IIIx8m3stphPVW9Y6wJ+yZg1JOkNeyKlN8MKimQASehItB8
         Y4JA==
X-Gm-Message-State: AAQBX9dxS2i+FLGsCtCVPRy5j4MN/gw0UZ/cWKPdhSRZZ8Siq571p/Dp
        mAe1VZGFTj3mMS4Sslo1kT2hswl9GfhaC5NbpQo=
X-Google-Smtp-Source: AKy350Z6GpPZ9IFi3BB54V5iLyNnNbm4b85cWpEMlDDI2emOwDG3UcwY7GniImUw7SjcBdphaF4iPQ==
X-Received: by 2002:a05:6a21:32a2:b0:e9:843:18f3 with SMTP id yt34-20020a056a2132a200b000e9084318f3mr2483089pzb.5.1681391488545;
        Thu, 13 Apr 2023 06:11:28 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id s18-20020a62e712000000b0062dee0221b2sm1387575pfh.21.2023.04.13.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:11:28 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20230413060651.694656-1-hch@lst.de>
References: <20230413060651.694656-1-hch@lst.de>
Subject: Re: cleanup blk_mq_run_hw_queue v2
Message-Id: <168139148760.18684.10898164083476475110.b4-ty@kernel.dk>
Date:   Thu, 13 Apr 2023 07:11:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 13 Apr 2023 08:06:46 +0200, Christoph Hellwig wrote:
> this series cleans up blk_mq_run_hw_queue and related functions.
> 
> Changes since v1:
>  - drop pointless blk_mq_hctx_stopped calls
>  - additional cleanups
> 
> Diffstat:
>  blk-mq-sched.c |   31 ++++++++++------------
>  blk-mq.c       |   79 ++++++++++++++++-----------------------------------------
>  2 files changed, 37 insertions(+), 73 deletions(-)
> 
> [...]

Applied, thanks!

[1/5] blk-mq: cleanup __blk_mq_sched_dispatch_requests
      commit: 89ea5ceb53d14f52ecbad8393be47f382c47c37d
[2/5] blk-mq: remove the blk_mq_hctx_stopped check in blk_mq_run_work_fn
      commit: c20a1a2c1a9f5b1081121cd18be444e7610b0c6f
[3/5] blk-mq: move the blk_mq_hctx_stopped check in __blk_mq_delay_run_hw_queue
      commit: cd735e11130d4c84a073e1056aa019ca0f3305f9
[4/5] blk-mq: move the !async handling out of __blk_mq_delay_run_hw_queue
      commit: 1aa8d875b523d61347a6887e4a4ab65a6d799d40
[5/5] blk-mq: remove __blk_mq_run_hw_queue
      commit: 4d5bba5bee0aa002523125e51789e95d47794a06

Best regards,
-- 
Jens Axboe



