Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0EC77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 02:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjETCEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 22:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjETCEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 22:04:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C36E19F
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 19:04:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1af90acbd6bso723185ad.1
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 19:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684548271; x=1687140271;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oW93QGXpXYcAM43Cknmvd22XuvJlklxf2kIYGjaMu0=;
        b=JWLPdJkl1f/K+GnpE1maGkjE3+yYadXxYgh0VJ/H6fRfbCUs2Vy19vLjOSvNihaWJ3
         ta/KAQH1xamPyGCs3G4icu6nt1OHIM1MaQ4lREwi0wWK5/cDvvV/rh8fajCUNMU83tZi
         OdS27xuCZ3K7i9/oQxQ0fdXpBhc3ZWdEgtALTxVVgs/qxBO6K1OPAc6wOfrISZbiG5RX
         82q7BA/zgQV3DUkUDHGJhWQ9IoAbeKrSHOTAGpHk2X2B5h0uxjOni5xkp827y/JDbRln
         M+81F4aLfn/2RboB+qSaWloDMYGt7T55pya25FvFmvvzIlp1M26Aov7/iefF3BgCapB0
         jQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684548271; x=1687140271;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oW93QGXpXYcAM43Cknmvd22XuvJlklxf2kIYGjaMu0=;
        b=N6U2S3OunZHzb4GuPC47rYBRAPrq7Ja8TOezrZl8IVd5KhMDMR9BE6BNSp+NeJOTGe
         E5ahPSUTydeY0HhbqTbw933WeNeQqIJiJfKZ0mqW7/Y+3QmMM/D8KO7WyYEnmZDi4k8B
         YBZpoc5ToF5Zkjg2RKhVXatII52ZPbYRzhRRHIwWSRW06me9bUShDEpQKNhIXgH3KPWZ
         7uWz9Ai5y3CXaEWnqcGPklOaxfa3wtm1VbMcOPirIiSu31E9ebURljAmXwz1bDVRLN25
         U5tQ2W/Ch+BaqJ0zHvHx5jwwBIb37ww8XYgDDccpnYepXebV0Ixlj3lWP33/zA31/LaY
         1SaA==
X-Gm-Message-State: AC+VfDz1k6HBe+HE36A3Ib5871nfmIIRtD9mhkBDLgJq3uGOSes3+174
        Le1PTXw4DSVTBvsmPY/Zpxbltg==
X-Google-Smtp-Source: ACHHUZ7yN853lNpZImNiCnnBQ6QM2vNsP370sNIEGZRq6fr6k+NGCCKqF43Cfq5OubGrJuN7M4iv0w==
X-Received: by 2002:a17:902:dac3:b0:1ac:775b:3e0a with SMTP id q3-20020a170902dac300b001ac775b3e0amr4611526plx.5.1684548271471;
        Fri, 19 May 2023 19:04:31 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001ac706dd98bsm298922plg.35.2023.05.19.19.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 19:04:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>
In-Reply-To: <20230519065030.351216-1-ming.lei@redhat.com>
References: <20230519065030.351216-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3 0/7] ublk: cleanup and support user copy
Message-Id: <168454827040.386102.10179038640056644063.b4-ty@kernel.dk>
Date:   Fri, 19 May 2023 20:04:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 19 May 2023 14:50:23 +0800, Ming Lei wrote:
> The 1st 3 patch are cleanup.
> 
> The other patches support to move data copy between io request pages and
> userspace buffer into ublk server(userspace). This way avoids one round trip
> of uring command(UBLK_F_NEED_GET_DATA), and solve buffer release issue for
> READ[1]. Meantime both sides becomes cleaner. Also it can be thought as
> prep patch for supporting zero copy.
> 
> [...]

Applied, thanks!

[1/7] ublk: kill queuing request by task_work_add
      (no commit info)
[2/7] ublk: cleanup io cmd code path by adding ublk_fill_io_cmd()
      (no commit info)
[3/7] ublk: cleanup ublk_copy_user_pages
      (no commit info)
[4/7] ublk: grab request reference when the request is handled by userspace
      (no commit info)
[5/7] ublk: support to copy any part of request pages
      (no commit info)
[6/7] ublk: add read()/write() support for ublk char device
      (no commit info)
[7/7] ublk: support user copy
      (no commit info)

Best regards,
-- 
Jens Axboe



