Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB8C25B0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Aug 2022 12:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiHPMTA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiHPMSU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 08:18:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A09D7F
        for <linux-block@vger.kernel.org>; Tue, 16 Aug 2022 05:16:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so9431650pjk.1
        for <linux-block@vger.kernel.org>; Tue, 16 Aug 2022 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=YjP3WNw/TJNTpsaI4Njl2DK4+CglvzwLpHBnp4oraLo=;
        b=YlJl9e4QRqwe+YedrfthkBmRF9P3CBv6Qg8g2/TxeDy7a4KrJEGK3k8OrXjSq9dY2R
         SZRARNDt+rojrIuxBlp/AIGiZ8JzrjyuwHxoccmdP4DFQBrdl55WHwemDquqt4wbpS3i
         Gummo5h/JDB1PhqgfND+7gRYL1PBN5sGYAfvZwiETdjC/1L9PRoRG7LTy9Sr3iGIXviv
         Ws+XyhrpoN+rG1TKNfFRYLWG4JpOwtw2DkWqi85jBLyX44Ty42Xp2mQfVtoy9j2AMxja
         Fug6zNG3m4ceNq/npcuLYvRiYjnghggKMLXOpFDrQbuFUYxBfPvEHWoqo0jfOEt3w09P
         8pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YjP3WNw/TJNTpsaI4Njl2DK4+CglvzwLpHBnp4oraLo=;
        b=y/eNT3NTZQMR/VBd8vEaz+fPEOloe+72R9Exgw8yRUctmiY2Ucl9mU3flBDF5ps6gC
         fCCMaDxE/wu8NErD4Cc9jeImxe2O5TOQxMgLxBppLnF70BFIIG+t5FK7NpdPspIbnuPM
         /mzsHc8dRVMt7GpyK41LGwkXYtL0XlZ0LtapZ9MNFi+Vt3QsUQ0BjSavwKW3rvEbfm6j
         m+UgOECsd3hM2QI1VT8rLvnSDaLF8mD318iPPiIQP7ExKFbphU0WpDRlhYhuVqCx4R/y
         VlitK+2qbEspwELUg0rLIzkqpwFzwUKj62NSXui+ydKYIg91C5TWb2ak5gBLXsWHPYNU
         2biA==
X-Gm-Message-State: ACgBeo2phdBLWsqJOb8VDWol4PXNl9USMluSMYeXvOpCabRFKmiX/S/1
        g5AmF/B2kExf7z5+bTWG474VBQ==
X-Google-Smtp-Source: AA6agR720neDfYhH26vGvdMpqiQXEp9IVwU70e00B9Yu2z2mCdeX3PMmLXmGeXqtnamr/ND6QVW4NQ==
X-Received: by 2002:a17:903:2286:b0:16f:8f52:c952 with SMTP id b6-20020a170903228600b0016f8f52c952mr22075618plh.126.1660652198669;
        Tue, 16 Aug 2022 05:16:38 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x5-20020a623105000000b005302cef1684sm8318735pfx.34.2022.08.16.05.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:16:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, ZiyangZhang@linux.alibaba.com
Cc:     joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
In-Reply-To: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
References: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V2 0/3] ublk_drv: cleanup and bugfix
Message-Id: <166065219672.192972.12166477403979227046.b4-ty@kernel.dk>
Date:   Tue, 16 Aug 2022 06:16:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 15 Aug 2022 10:36:30 +0800, ZiyangZhang wrote:
> The following 3 patches are cleanup and bugfix. Patch 1 and 2
> simply inline a function and update comments for ublk_drv's
> aborting machemism.
> 
> Patch 3 fix a null-deref bug reported by myself. Ming gives out a
> patch and I integrate it with more comments on this bug.
> 
> [...]

Applied, thanks!

[1/3] ublk_drv: check ubq_daemon_is_dying() in __ublk_rq_task_work()
      commit: 966120b51a245c9ff5857c5b169310c248e0ae87
[2/3] ublk_drv: update comment for __ublk_fail_req()
      commit: bb24174754afc5a7d185ca5406dcfbc608cdf157
[3/3] ublk_drv: do not add a re-issued request aborted previously to ioucmd's task_work
      commit: e6190dd0031d335c22586d34ef898301ed20f230

Best regards,
-- 
Jens Axboe


