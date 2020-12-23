Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3CBC433E0
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 16:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF5D207A2
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgLWQRd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 11:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLWQRd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 11:17:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E407C061794
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 08:16:53 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id be12so9361285plb.4
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R/XI3HACitxNNKdDGgHb+kOn5zfn0Owx8twC0nO/Nto=;
        b=cHBpe0rmEcvFesYRG+RYgq5Ek8r6gHYu+8GOChXrJ0L4IehMh/gk0CXI5fRzTlgwwz
         kGl6W6VAwAZgNAsnjqgT4j8CFE+NIQOHd4Cjl6U93RptnVVt8jJf8EUQNObUMj4Xaq/x
         Kiwj/ehm5DEEqq6hoCxcBFhu9XRhI1jxWpH4weolyQGkBTqEEprWAzq0I7qUuuyM5v5E
         rbJwRyvh5srP0ozWwsMd9nS0MOT/uib6hAAUgvQkQ48j40cgj0ZM464B92MCgLoxuMHP
         05fQOCL5f4NxpwUuCf3RVA8FEd5Mz6Q6BL9DuSeRedz/UQ3jd5NTPXxUIDqkcW6CC2Q7
         0e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/XI3HACitxNNKdDGgHb+kOn5zfn0Owx8twC0nO/Nto=;
        b=aCRq//pr/KVTTLVXuDqJjpx3nJoVBsQGVvObGU4M5Q/pa4jl0tiG/NeVg4Vfj15lqO
         wPh6b5Mkh5Bj/ZcBJnzo8FZNMr+UXinAUOBmdvLgbBlludAUKvrdNFtd1j3fd61q7edU
         0MINRcHCUg2qX3NrayNmIFncE+yddtq4anv46mZY1SqoePT2gAAQtYvCZo/8yHTtF1cc
         SdEn+g1xOgfg/YbMjlFP0XyvGItLVCLXCjU1YZ6p66AjrfBqd9SycoB+458gcIiouj8T
         H1BIAzhZaPLG96pHFg87A2D7X04mNpJJMkV7VviFshnNhWiZj+OdgSa8q2U/nvLTUpfY
         T3PA==
X-Gm-Message-State: AOAM533dzYE93soqarDuasfhpd0ecRwPVVrjF6FG5oX7jCEqgf5WLzxI
        0E4HxXLVtay18aLs1R8B3tg=
X-Google-Smtp-Source: ABdhPJzoiDr5W0ttuQgdEQzzISkxPt+rKaUM7wFPX0tNJy4ZBpORqyyZr0uMruqZcxGaDcIRdDdoJA==
X-Received: by 2002:a17:90a:a2e:: with SMTP id o43mr382325pjo.59.1608740212687;
        Wed, 23 Dec 2020 08:16:52 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id z23sm15869038pfj.143.2020.12.23.08.16.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Dec 2020 08:16:52 -0800 (PST)
Date:   Thu, 24 Dec 2020 01:16:50 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC] nvme: set block size during namespace validation
Message-ID: <20201223161650.GA13354@localhost.localdomain>
References: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
 <20201223154904.GA5967@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223154904.GA5967@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 20-12-23 16:49:04, Christoph Hellwig wrote:
> set_blocksize just sets the block sise used for buffer heads and should
> not be called by the driver.  blkdev_get updates the block size, so
> you must already have the fd re-reading the partition table open?
> I'm not entirely sure how we can work around this except by avoiding
> buffer head I/O in the partition reread code.  Note that this affects
> all block drivers where the block size could change at runtime.

Thank you Christoph for your comment on this.

Agreed.  BLKRRPART leads us to block_read_full_page which takes buffer
heads for I/O.

Yes, __blkdev_get() sets i_blkbits of block device inode via
set_init_blocksize.  And Yes again as nvme-cli already opened the block
device fd and requests the BLKRRPART with that fd.  Also, __bdev_get()
only updates the i_blkbits(blocksize) in case bdev->bd_openers == 0 which
is the first time to open this block device.

Then, how about having NVMe driver prevent underflow case for the
request->__data_len is smaller than the logical block size like:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..030353d203bf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -803,7 +803,11 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
        cmnd->rw.opcode = op;
        cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
        cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
-       cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+
+       if (unlikely(blk_rq_bytes(req) < (1 << ns->lba_shift)))
+               cmnd->rw.length = 0;
+       else
+               cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
        if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
                nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);

Thanks,
