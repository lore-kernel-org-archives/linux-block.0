Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61275E8FDBF
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 00:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbjJDA1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 20:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjJDA1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 20:27:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F5F8E
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 17:27:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c72e235debso3368365ad.0
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2023 17:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696379271; x=1696984071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHRzIDUrfbGYb47ryPlH6kljeXi3/VDOViUZIBrK5Ts=;
        b=kcwl+gXQWHZVKCs056yAv12xHlwAVOzMSDRQcnfGGZImSx7P1QrfJsGSckDPDh3jGe
         bKB1UpZCZ1Vrm7AAcGwyvdQFwRljh/2IFfMso3fNXXKxGnJTih2gO6V1uGivyDiKJxEO
         yuQ5B8EswP78ie6DA5sd0cnqJhssG8qjIplOrwyasthCtLPummqJIO/x2XwaQ1Oh1NZ5
         0nI95GUVJi11ombKntSqOoSOHwTWoppo9783nzQ0DeDP+W4s59L/h9q5mogA5uycQpPp
         zuvncYnukO0HNymnE3+FTuxF2bgYcsyk2g7OM2PoMZaTCmzGAfZ/ng/ZdRX1kEP6+mJl
         k5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696379271; x=1696984071;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHRzIDUrfbGYb47ryPlH6kljeXi3/VDOViUZIBrK5Ts=;
        b=e/H3yABLyBWcUVj6sygIC9cRtcnYsglaPpkaoVKNziOndbKxZ8pALKKzo+tPvv4eW7
         lh2Xe+UC9M6Wl8hktvE9jISWrjMCneCwh/n4DOg2M/Rkpr2D6ZKM0KAloli45cx1QHKi
         LWNZ/HtYEAC/vdVIjoZiQmtcW7+7/tb9Rmi5iuR3J9GDoG+TlxqW+3vKdtoSji0Ofl+P
         7Mh7IC5f6JR4pRyz8+DGirpN5/Fvd0JkeIIta7ILssB49V2M3D4VutA1y2L7PD2vd4dg
         FPASDOLyUicr+IzxwPRZwQ/PSB95oo6Jbpbp9G/NeFECCk/0vIC65Dh9xzInfigWbDX6
         bz9g==
X-Gm-Message-State: AOJu0YwwjlGsx9w7nbQn6mFAmfDZLyTBPTNEsHU5s6T0KEw2Xiy0CYum
        pzsIYP8lfM0vBu3RPVU81VpEQok5ZnmLfhotcyI=
X-Google-Smtp-Source: AGHT+IHupd9ildh+0sHdlF5Fmr98J5f5pg5NGbhnbO6BHNNWicx++llrSuINLPu653oocYznNl1CTg==
X-Received: by 2002:a05:6a20:8f02:b0:15c:b7bb:2bd9 with SMTP id b2-20020a056a208f0200b0015cb7bb2bd9mr850983pzk.6.1696379271422;
        Tue, 03 Oct 2023 17:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id je1-20020a170903264100b001c0a414695bsm2243499plb.43.2023.10.03.17.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 17:27:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Christoph Hellwig <hch@lst.de>
Cc:     w@uter.be, linux-block@vger.kernel.org, nbd@other.debian.org,
        Samuel Holland <samuel.holland@sifive.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20231003153106.1331363-1-hch@lst.de>
References: <20231003153106.1331363-1-hch@lst.de>
Subject: Re: [PATCH] nbd: don't call blk_mark_disk_dead
 nbd_clear_sock_ioctl
Message-Id: <169637927029.2063894.11456855560323874851.b4-ty@kernel.dk>
Date:   Tue, 03 Oct 2023 18:27:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 03 Oct 2023 17:31:06 +0200, Christoph Hellwig wrote:
> blk_mark_disk_dead is the proper interface to shut down a block
> device, but it also makes the disk unusable forever.
> 
> nbd_clear_sock_ioctl on the other hand wants to shut down the file
> system, but allow the block device to be used again when when connected
> to another socket.  Switch nbd to use disk_force_media_change and
> nbd_bdev_reset to go back to a behavior of the old __invalidate_device
> call, with the added benefit of incrementing the device generation
> as there is no guarantee the old content comes back when the device
> is reconnected.
> 
> [...]

Applied, thanks!

[1/1] nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl
      commit: 07a1141ff170ff5d4f9c4fbb0453727ab48096e5

Best regards,
-- 
Jens Axboe



