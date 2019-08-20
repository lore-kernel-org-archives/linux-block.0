Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751EFC3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D6522DD3
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 21:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJijRmSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfHTVYw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:24:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56179 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVYw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 17:24:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so36630wmf.5
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=b2TuYTxQsEDPdRP3TSBh+KQF+kODG99MX+qEFuk4Xf4=;
        b=gJijRmSBmy4fDLDbGLtaolU7mY6JdiL/uY5fAdlnxSeXpr+E9ezxVPCwxEmjkZOU++
         X5nAncj0h3F07xPmhzNNbPLMUFKm4pdRh8wNE9HvbvEGBqPxyB1x1i0DnkOY5gGYTBMI
         Wst8bckMM6pB8hjWfOOX3ENynSCkNLulxzvzl8XgoRbx8qAa4G65uVB99DH+ghSmygPR
         X8K2hWRhEoVamTNmyv0ayvSwxt90++E0I4vnd5V9e4aDUjK42F1gWaW5r1HHn74rwoXS
         hdbIr2wkDT3WK/s1RKbYT11BENwj7ydaEkKYh8mq0PGMlg7s9418lZOrWRbZYN0jSNje
         Pc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=b2TuYTxQsEDPdRP3TSBh+KQF+kODG99MX+qEFuk4Xf4=;
        b=X+04Gm4BKH1o+lRDvksXByFc9FRvJXD60MiPUCwzKSQSpV+bfbo154Hke87EKcMcuv
         2aX9LDJ7X1/F4VWnmjTnoKSHvVtLoTthHWFPS4umTxHEodhZlpxGSXP0Fh28MXV6lib7
         EFbuQShac4D1ykIgXckxEGwMhtOgPFzKGtzKFYwwSiTEsoQAkhpZnlVCjq3MLoG56Vkn
         ttZjjKkXEF49YHh1fX+0OD26ItVaFqoVeb2ueu7NlQTfTYq8L5HUkpx9RDmwrqfVO4oE
         Pr+c78tgr0BtDOrbsuk7CkbQG2Fx70IqZwge9ecQ6gn61KmkWAU8drBlQ1tblDaLMcGo
         d6vQ==
X-Gm-Message-State: APjAAAUqE6ILH7frakmIhwAv0e5bBB5/dEaD3pdlND8AejA3Lu/cXjGL
        Zx001yxSMm0AmdyS3ojCIigPALVMK5Q=
X-Google-Smtp-Source: APXvYqz9w/cFoSMcOER1yO0njj3lw1rsgKNfPHsCvnFBuvLhXSsPhRziwhCpJbd4QP2mOdabZYGIMw==
X-Received: by 2002:a1c:f50c:: with SMTP id t12mr2034861wmh.49.1566336290170;
        Tue, 20 Aug 2019 14:24:50 -0700 (PDT)
Received: from gmail.com (39.30.137.88.rev.sfr.net. [88.137.30.39])
        by smtp.gmail.com with ESMTPSA id c187sm2235691wmd.39.2019.08.20.14.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 14:24:49 -0700 (PDT)
Date:   Tue, 20 Aug 2019 23:24:47 +0200
From:   Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ps3disk: use the default segment boundary
Message-ID: <20190820212447.GA13087@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
since commit dcebd755926b ("block: use bio_for_each_bvec() to compute
multi-page bvec count"), the kernel will bug_on on the PS3 because
bio_split() is called with sectors == 0:

kernel BUG at block/bio.c:1853!
Oops: Exception in kernel mode, sig: 5 [#1]
BE PAGE_SIZE=4K MMU=Hash PREEMPT SMP NR_CPUS=8 NUMA PS3
Modules linked in: firewire_sbp2 rtc_ps3(+) soundcore ps3_gelic(+) \
ps3rom(+) firewire_core ps3vram(+) usb_common crc_itu_t
CPU: 0 PID: 97 Comm: blkid Not tainted 5.3.0-rc4 #1
NIP:  c00000000027d0d0 LR: c00000000027d0b0 CTR: 0000000000000000
REGS: c00000000135ae90 TRAP: 0700   Not tainted  (5.3.0-rc4)
MSR:  8000000000028032 <SF,EE,IR,DR,RI>  CR: 44008240  XER: 20000000
IRQMASK: 0 
GPR00: c000000000289368 c00000000135b120 c00000000084a500 c000000004ff8300 
GPR04: 0000000000000c00 c000000004c905e0 c000000004c905e0 000000000000ffff 
GPR08: 0000000000000000 0000000000000001 0000000000000000 000000000000ffff 
GPR12: 0000000000000000 c0000000008ef000 000000000000003e 0000000000080001 
GPR16: 0000000000000100 000000000000ffff 0000000000000000 0000000000000004 
GPR20: c00000000062fd7e 0000000000000001 000000000000ffff 0000000000000080 
GPR24: c000000000781788 c00000000135b350 0000000000000080 c000000004c905e0 
GPR28: c00000000135b348 c000000004ff8300 0000000000000000 c000000004c90000 
NIP [c00000000027d0d0] .bio_split+0x28/0xac
LR [c00000000027d0b0] .bio_split+0x8/0xac
Call Trace:
[c00000000135b120] [c00000000027d130] .bio_split+0x88/0xac (unreliable)
[c00000000135b1b0] [c000000000289368] .__blk_queue_split+0x11c/0x53c
[c00000000135b2d0] [c00000000028f614] .blk_mq_make_request+0x80/0x7d4
[c00000000135b3d0] [c000000000283a8c] .generic_make_request+0x118/0x294
[c00000000135b4b0] [c000000000283d34] .submit_bio+0x12c/0x174
[c00000000135b580] [c000000000205a44] .mpage_bio_submit+0x3c/0x4c
[c00000000135b600] [c000000000206184] .mpage_readpages+0xa4/0x184
[c00000000135b750] [c0000000001ff8fc] .blkdev_readpages+0x24/0x38
[c00000000135b7c0] [c0000000001589f0] .read_pages+0x6c/0x1a8
[c00000000135b8b0] [c000000000158c74] .__do_page_cache_readahead+0x118/0x184
[c00000000135b9b0] [c0000000001591a8] .force_page_cache_readahead+0xe4/0xe8
[c00000000135ba50] [c00000000014fc24] .generic_file_read_iter+0x1d8/0x830
[c00000000135bb50] [c0000000001ffadc] .blkdev_read_iter+0x40/0x5c
[c00000000135bbc0] [c0000000001b9e00] .new_sync_read+0x144/0x1a0
[c00000000135bcd0] [c0000000001bc454] .vfs_read+0xa0/0x124
[c00000000135bd70] [c0000000001bc7a4] .ksys_read+0x70/0xd8
[c00000000135be20] [c00000000000a524] system_call+0x5c/0x70
Instruction dump:
7fe3fb78 482e30dc 7c0802a6 482e3085 7c9e2378 f821ff71 7ca42b78 7d3e00d0 
7c7d1b78 79290fe0 7cc53378 69290001 <0b090000> 81230028 7bca0020 7929ba62 
[ end trace 313fec760f30aa1f ]---

The problem originates from setting the segment boundary of the request
queue to -1UL. This makes get_max_segment_size() return zero when offset
is zero, whatever the max segment size. The test with BLK_SEG_BOUNDARY_MASK
fails and 'mask - (mask & offset) + 1' overflows to zero in the return
statement.

Not setting the segment boundary and using the default value
(BLK_SEG_BOUNDARY_MASK) fixes the problem.
Maybe BLK_SEG_BOUNDARY_MASK should be set to -1UL? It's currently set to
only 0xFFFFFFFFUL. I don't know if that would break anything.

Signed-off-by: Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
---
 drivers/block/ps3disk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index c5c6487a19d5..7b55811c2a81 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -454,7 +454,6 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 	queue->queuedata = dev;
 
 	blk_queue_max_hw_sectors(queue, dev->bounce_size >> 9);
-	blk_queue_segment_boundary(queue, -1UL);
 	blk_queue_dma_alignment(queue, dev->blk_size-1);
 	blk_queue_logical_block_size(queue, dev->blk_size);
 
-- 
2.23.0

