Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E050BC433DB
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58042332A
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 15:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgLWPCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgLWPCX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 10:02:23 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF7C0613D6
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 07:01:43 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id e2so10742271pgi.5
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 07:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NX1g0xnc/DMHEonC41vpqPTZ85/YlvXww2Bzq4Cudds=;
        b=KU86abpkdQGOgmMLQ3JMQ8jtkMAkNvzJ4Xvv1wMO0u91fYxOSeYe+ZARLFwwikOCMS
         TKCzr/AsJc2zz5O7mefNHQrVJ1GZ7l9op24KoVUYvRm9VWRX1pmJgfNmAj+IafBRhDeS
         pzv02NsbPHifgCZQ+5+/2FVKlOmmth0OIDpVIoFYtITebAd1iN75VeDxEUXkkIPgJfeE
         Rjtm+cUkkHpSm8RyLbvoDW5xk6yxaZBywtAzu8Op5HL24HCfmyPo2o92Pc8LOK69B/Je
         uUQMwwrwVB63uzWgT5oUX/ks5PTz27ZvFqLqwPt5B58BbB85LVq761X4cQucDU2ebxkI
         Hkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NX1g0xnc/DMHEonC41vpqPTZ85/YlvXww2Bzq4Cudds=;
        b=nlbw7mkCa/zVeAWwmX168ViiUDFIR9+qdtYs8cF0Xz3Ip1wJY72bGmT9+/FqShjuDE
         pBgl4cGuJKNWpr0/szBRKl+jAdx3fj4W/fCjzwWpROwpOEQZo5vqhS4p7Qh0dgAzaUlc
         tD7amfKi9KRcF+O7c3ia2i4OGjMIeGXfZDnH/r2DlGK5iKw2tS6bo0Os8vPfI2smnRxj
         CrDxfJ+jzb+Ku8r57Pj1/vtXQwiusBH+7o++EzSW0L3tHkqPCY0fYTgFAA7gGN1VeJ4M
         3Mw5DZCtAdy4KzqdjWgkBcr+nKvgdRB5sehf2B3dnHBOAAx7e9fxAuA11XUkhZPDvKPR
         J7Tw==
X-Gm-Message-State: AOAM532e2ISEbm88qRCrDzdrCLGFZZDdPURpSruz2G3RquJt4A/sPUYX
        hQHHiJyDcCYu6oPG4b/ScPU=
X-Google-Smtp-Source: ABdhPJzZn7Md/JQR10Vomq7VgpPskRvBDP5i2dxWDGv/Mtupo8m8Cgb8AgbwDhwQ+/hPHJumcnW3Jw==
X-Received: by 2002:a63:1220:: with SMTP id h32mr24692438pgl.309.1608735702465;
        Wed, 23 Dec 2020 07:01:42 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id m15sm24208763pfa.72.2020.12.23.07.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 07:01:41 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [RFC] nvme: set block size during namespace validation
Date:   Thu, 24 Dec 2020 00:01:36 +0900
Message-Id: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

  Let's say we have 2 LBA format for 4096B and 512B LBA size for a
NVMe namespace.  Assume that current LBA format is 4096B and in case
we convert namespace to 512B and 4096B back again:

  nvme format /dev/nvme0n1 --lbaf=1 --force  # 512B
  nvme format /dev/nvme0n1 --lbaf=0 --force  # 4096B

  Then we can see the following errors during the BLKRRPART ioctl from
the nvme-cli format subcommand:

  [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
  [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read
  ...

  Also, we can see the Read commands followed by the Format command due
to BLKRRPART ioctl with Number of LBAs to 0xffff which is under-flowed
because the request for the Read commands are coming with 512B.

  kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
  ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002

  Before we have commit 5ff9f19231a0 ("block: simplify
set_init_blocksize"), block size used to be bumped up to the
4K(PAGE_SIZE) in this example and we have not seen these errors.  But
with this patch, we have to make sure that bdev->bd_inode->i_blkbits to
make sure that BLKRRPART ioctl pass proper request length based on the
changed logical block size.

  Currently, nvme_setup_rw() does not consider under-flow case when it
fills the cmnd->rw.length:

  cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);

  Maybe we can have some statement to prevent under-flow case here, but
this patch set the blocksize to the block layer when validating
namespace where the logical_block_size of request_queue also is set.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..6f2e8eb78e00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2085,6 +2085,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	}
 
 	blk_queue_logical_block_size(disk->queue, bs);
+	set_blocksize(disk->part0, bs);
+
 	/*
 	 * Linux filesystems assume writing a single physical block is
 	 * an atomic operation. Hence limit the physical block size to the
-- 
2.17.1

