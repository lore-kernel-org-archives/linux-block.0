Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC1AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D66660295
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhJ2MzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhJ2MzM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 08:55:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE3C061570
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:52:43 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h2so10471980ili.11
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=uhb6XVldQ6Tqmc638dZl/EsCqLPiV0DWHYdItNojyKA=;
        b=5GN0r5l7hiNpTcfLkqhYBuNFAySG3bDs0RzGVfLozpBbOOqcW2Ol5fjMfiztfSwGR7
         ecsfF4O7pN/iQHAQtqmWUAKbmPkaoUO6QANa1l6qh0P9P+dJPK6c5vvQxdCtXkDBmqzN
         wcuzr6fHGMRM7IpqZvOq+ym0pgdpkjYalqhNslx4X8xU4LltacTcQM3T9XxlDouHOCfD
         k2dsJPduQqzjvNb+bs1y1L6g/Vb4tCTRIRw25UKqIX7xro2yvpnlJU3bf48TPfCx8RHm
         x0Q933IFlQ7nga0pwTdZcQICicL+1yG8JDbm1vO32ZDYTrXoqEH7n32/zz0XT+k84C2I
         d8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=uhb6XVldQ6Tqmc638dZl/EsCqLPiV0DWHYdItNojyKA=;
        b=iL4Brnu3BWimfy8VN1sgU63ZvBSAPjhcpHjZCR5lN8DxXOBx3xp/UdHeTW8ZMQ12A6
         E/dyjIWq5BRNSOGCN3OxNupf0IL0eqZ60pxw9uavLEwyLFeTPI8uvyOCq7S03RcKuyUT
         iih44ZPKFoh3miTIyenj/fLK+HtFfpVOuOuGEv/RpVsrBhFmiZHLwGwB9uxKxBxCQj1M
         BWAEqi2wZNciPyVrku2rrMElksy6ukId95eqLbbqSalQJrySnmnNuLBgAkU8szDpX7V7
         7BJQNt0HLR630LdVDy0scDeA7GW3L1no4ROrTxEwNFdIckIGTkwjXOCcIkn5Cwof7g1J
         cF5Q==
X-Gm-Message-State: AOAM530y058jD7rJ10oUGFKXRaeLOIdgMVAMxiShbXpk9XvQAKz/o/1n
        swC5l7QwJxnmyI3csJKWVzmt8Q==
X-Google-Smtp-Source: ABdhPJxlsx7MLgDr//casvyGS6hISvFBN0+MeYK+NGcV0Ht28rkLQLfyTGFFc8OUgybOJDEyA0wdfw==
X-Received: by 2002:a92:cda5:: with SMTP id g5mr7783563ild.36.1635511963406;
        Fri, 29 Oct 2021 05:52:43 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id c23sm560811iob.52.2021.10.29.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:52:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-block@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
In-Reply-To: <20211025070517.1548584-1-hch@lst.de>
References: <20211025070517.1548584-1-hch@lst.de>
Subject: Re: (subset) move all struct request releated code out of blk-core.c
Message-Id: <163551196149.84649.4583690575292414176.b4-ty@kernel.dk>
Date:   Fri, 29 Oct 2021 06:52:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 25 Oct 2021 09:05:05 +0200, Christoph Hellwig wrote:
> this series (against the for-5.16/passthrough-flag branch) removes the
> remaining struct request related code from blk-core.c and cleans up a
> few related bits around that.
> 
> Diffstat:
>  b/block/Makefile                     |    2
>  b/block/blk-core.c                   |  362 ----------------------
>  b/block/blk-mq.c                     |  573 +++++++++++++++++++++++++++++------
>  b/block/blk-mq.h                     |    3
>  b/block/blk.h                        |   33 --
>  b/drivers/block/paride/pd.c          |    4
>  b/drivers/block/pktcdvd.c            |    2
>  b/drivers/block/virtio_blk.c         |    4
>  b/drivers/md/dm-mpath.c              |    4
>  b/drivers/mmc/core/block.c           |   20 -
>  b/drivers/mtd/mtd_blkdevs.c          |   10
>  b/drivers/mtd/ubi/block.c            |    6
>  b/drivers/scsi/scsi_bsg.c            |    2
>  b/drivers/scsi/scsi_error.c          |    2
>  b/drivers/scsi/scsi_ioctl.c          |    4
>  b/drivers/scsi/scsi_lib.c            |   46 ++
>  b/drivers/scsi/sg.c                  |    6
>  b/drivers/scsi/sr.c                  |    2
>  b/drivers/scsi/st.c                  |    4
>  b/drivers/scsi/ufs/ufshcd.c          |   20 -
>  b/drivers/scsi/ufs/ufshpb.c          |    8
>  b/drivers/target/target_core_pscsi.c |    4
>  b/include/linux/blk-mq.h             |   16
>  block/blk-exec.c                     |  116 -------
>  24 files changed, 597 insertions(+), 656 deletions(-)
> 
> [...]

Applied, thanks!

[02/12] block: remove blk_{get,put}_request
        commit: 0bf6d96cb8294094ce1e44cbe8cf65b0899d0a3a

Best regards,
-- 
Jens Axboe


