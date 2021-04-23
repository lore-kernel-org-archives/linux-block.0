Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1207C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 20:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8DD61452
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 20:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbhDWUBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:01:04 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:36520 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhDWUBC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 16:01:02 -0400
Received: by mail-pl1-f175.google.com with SMTP id g16so8891287plq.3
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 13:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96GSoPoAS6WElItgBd52a15eEHpxNMWd4HWaUvxWQvo=;
        b=TjJkZYemeXtXk6Rl4+mchnN/y2IoTNLQ9D2Wwz9Y3wwzJ2LArleNUq8VRnEx+oqnjf
         qkWUDBJRb+Kk4EPvmhrfqoBua3cTKs4SEhLsmzvLFkZ3RClBb1DsE9cEipR/E05+n2Tg
         RAuM/eodNeNth1qGiNKVBf5c091Xftqm/mNxdruHpKJRJ7Ik8GKV5xu3Wql8Ctbl7Feh
         vfXahHgco6Uy1VjOP6TYknnSM8icFCE20f9ItyvwxA6TtMcVBFIccIp65yZz34/Irdc+
         imunHfm7lEVmfATSkyf3Xxi7WiXHTVftA29hiooRiWNnzi4yqgRwUl0gAyJuvOZvdnsY
         DKHw==
X-Gm-Message-State: AOAM533T/WKpZ/HJZteF/0WWt6wZz0Y88s8GnS7hXeOhQsLAxY2Q3jNt
        MwK36sFGT78G26qJ9rXSSq7/j2u5PI0=
X-Google-Smtp-Source: ABdhPJx86qD7ZeWC91pl60zYiUg3RLSKiyPRCjqGVPuZerfjw0sEBfy+TGIwdpj9Z58zRgtrhYoBrA==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr6175899pjo.220.1619208024507;
        Fri, 23 Apr 2021 13:00:24 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:a976:f332:ee26:584f])
        by smtp.gmail.com with ESMTPSA id j123sm5427082pfg.111.2021.04.23.13.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 13:00:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] block: Fix bio_max_size()
Date:   Fri, 23 Apr 2021 13:00:17 -0700
Message-Id: <20210423200017.18308-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The SCSI core sends the REPORT LUNS and INQUIRY commands before calling
device_add_disk(). This patch prevents that bio_max_size() triggers the
following kernel crash during a SCSI LUN scan:

BUG: KASAN: null-ptr-deref in bio_add_hw_page+0xa6/0x310
Read of size 8 at addr 00000000000005a8 by task kworker/u16:0/7

CPU: 0 PID: 7 Comm: kworker/u16:0 Not tainted 5.12.0-rc8-dbg+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 show_stack+0x52/0x58
 dump_stack+0x9d/0xcf
 kasan_report.cold+0x4b/0x50
 __asan_load8+0x69/0x90
 bio_add_hw_page+0xa6/0x310
 bio_add_pc_page+0xaa/0xe0
 bio_map_kern+0xdc/0x1a0
 blk_rq_map_kern+0xcd/0x2d0
 __scsi_execute+0x9a/0x290 [scsi_mod]
 scsi_probe_lun.constprop.0+0x17c/0x660 [scsi_mod]
 scsi_probe_and_add_lun+0x178/0x750 [scsi_mod]
 __scsi_add_device+0x18c/0x1a0 [scsi_mod]
 ata_scsi_scan_host+0xe5/0x260 [libata]
 async_port_probe+0x94/0xb0 [libata]
 async_run_entry_fn+0x7d/0x2d0
 process_one_work+0x582/0xac0
 worker_thread+0x8f/0x5a0
 kthread+0x222/0x250
 ret_from_fork+0x1f/0x30

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Changheun Lee <nanich.lee@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Fixes: 15050b63567c ("bio: limit bio max size")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d718c63b3533..a8879ee6c59a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -257,9 +257,10 @@ EXPORT_SYMBOL(bio_init);
 
 unsigned int bio_max_size(struct bio *bio)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	if (!bio->bi_bdev)
+		return UINT_MAX;
 
-	return q->limits.bio_max_bytes;
+	return bio->bi_bdev->bd_disk->queue->limits.bio_max_bytes;
 }
 
 /**
