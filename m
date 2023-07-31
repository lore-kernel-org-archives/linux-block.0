Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8017C001DF
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 22:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjGaWPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGaWPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 18:15:24 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB30CF
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:22 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so39958105ad.1
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841722; x=1691446522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Pu+YKMQwPa5aL4AVezA94nxXjD3P55gI6I95cgZ2Lk=;
        b=OXfmjGtJ2ZkdtvwlCFIGxlieO8hKrE1RDGfPJVUa/gqFK4wAoUNvGX/2iwFpRioiYW
         fGK+mwBHPmtjS55cHacClUWtEWXzX1tG8u/oWxuZFXgjeuKUtWCWbKRTalmG/iL/Xtl8
         QRBXruTvpcJ1VtZJblQ3Q+9RMtr3TdK8zSwgbz+dzZ9BOmp6SYlZ0oNhQCMfdkQSOAuJ
         LSAsdiX5Zygr3EQIqJKqqD0leIn9XPg1MGOaou1pRCMeibLFwfgEpqQk5yO9WldSvDzy
         4wHggg9nqrgHFzUSjxneHdTPOCG7oT9yYgR7inJ9/tcya5/5eUNP7LIWnWgFwbwpZnCg
         F8Dg==
X-Gm-Message-State: ABy/qLZPyDl035a4ToKaaQS2t4nqWAFo7GjX5bfVWfHrHZZQIBG/fwLA
        7BUf1Bm1kg/5XWbwZzidx08=
X-Google-Smtp-Source: APBJJlHORBGmN3um8sIgZaHFaIzlHi78xHMWJTN5eQFOt7c3WzsGcgggA/ZtopPSgcDhUdBUZjTuKg==
X-Received: by 2002:a17:902:bd4b:b0:1b8:8af0:416f with SMTP id b11-20020a170902bd4b00b001b88af0416fmr10651381plx.1.1690841722040;
        Mon, 31 Jul 2023 15:15:22 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9346:70e3:158a:281c])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm9000888plb.117.2023.07.31.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:15:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 0/7] Improve the performance for zoned UFS devices
Date:   Mon, 31 Jul 2023 15:14:36 -0700
Message-ID: <20230731221458.437440-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves small write IOPS by a factor of four (+300%) for
zoned UFS devices on my test setup with a UFSHCI 3.0 controller. Please
consider this patch series for the next merge window.

Thank you,

Bart.

Changes compared to v4:
 - Dropped the patch that introduces the REQ_NO_ZONE_WRITE_LOCK flag.
 - Dropped the null_blk patch and added two scsi_debug patches instead.
 - Dropped the f2fs patch.
 - Split the patch for the UFS driver into two patches.
 - Modified several patch descriptions and source code comments.
 - Renamed dd_use_write_locking() into dd_use_zone_write_locking().
 - Moved the list_sort() call from scsi_unjam_host() into scsi_eh_flush_done_q()
   such that sorting happens just before reinserting.
 - Removed the scsi_cmd_retry_allowed() call from scsi_check_sense() to make
   sure that the retry counter is adjusted once per retry instead of twice.

Changes compared to v3:
 - Restored the patch that introduces QUEUE_FLAG_NO_ZONE_WRITE_LOCK. That patch
   had accidentally been left out from v2.
 - In patch "block: Introduce the flag REQ_NO_ZONE_WRITE_LOCK", improved the
   patch description and added the function blk_no_zone_write_lock().
 - In patch "block/mq-deadline: Only use zone locking if necessary", moved the
   blk_queue_is_zoned() call into dd_use_write_locking().
 - In patch "fs/f2fs: Disable zone write locking", set REQ_NO_ZONE_WRITE_LOCK
   from inside __bio_alloc() instead of in f2fs_submit_write_bio().

Changes compared to v2:
 - Renamed the request queue flag for disabling zone write locking.
 - Introduced a new request flag for disabling zone write locking.
 - Modified the mq-deadline scheduler such that zone write locking is only
   disabled if both flags are set.
 - Added an F2FS patch that sets the request flag for disabling zone write
   locking.
 - Only disable zone write locking in the UFS driver if auto-hibernation is
   disabled.

Changes compared to v1:
 - Left out the patches that are already upstream.
 - Switched the approach in patch "scsi: Retry unaligned zoned writes" from
   retrying immediately to sending unaligned write commands to the SCSI error
   handler.

Bart Van Assche (7):
  scsi: scsi_debug: Support disabling zone write locking
  scsi: scsi_debug: Support injecting unaligned write errors
  scsi: ufs: Split an if-condition
  scsi: ufs: Disable zone write locking
  scsi: core: Report error list information in debugfs
  scsi: core: Add a precondition check in scsi_eh_scmd_add()
  scsi: scsi_debug: Support injecting unaligned write errors

 drivers/scsi/scsi_debug.c   | 21 +++++++++++++++--
 drivers/scsi/scsi_debugfs.c | 25 ++++++++++++++++++---
 drivers/scsi/scsi_error.c   |  1 +
 drivers/ufs/core/ufshcd.c   | 45 ++++++++++++++++++++++++++++++++++---
 4 files changed, 84 insertions(+), 8 deletions(-)

