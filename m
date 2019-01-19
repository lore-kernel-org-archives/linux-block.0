Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F5C61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1004D2084C
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9hlF8lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfASSFO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:05:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39321 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfASSFO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 13:05:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so18805392qtj.6
        for <linux-block@vger.kernel.org>; Sat, 19 Jan 2019 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HNtCxs6Hio0+5xh9aKWTwuKO3XPEcG5zRyVZxia7uUY=;
        b=c9hlF8lfiJSRMxJ4Tm1Eo2UOuH5jkJnlyqf2mrligq4kmSbvGa4KFOyodbR0jwpQkx
         uifJiwPTcvo4Bp86MARB4piTqK0CpfwIkaa+unEWSuaoHgwkSFouCGx4Zarf38frtxod
         4LMLFprcumJGhC3gyEwHsp2CTy1NTEBgGLFpMYTcjoUbY7CG4NijaMce5ZHAWQtRVrP6
         Gr6xIzeb9OJ/IOfPR/elIqq3ya/JOJ1qhHkFxdQ5l2DX5r6/wm4h6vsZd6IXkgk5VM8e
         qydm/N9l1IiINkeTfnFtuce26E3TE7LUXGsB0U9QflQ0GWHiSnNK2sU7zQctqJw07izO
         FQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=HNtCxs6Hio0+5xh9aKWTwuKO3XPEcG5zRyVZxia7uUY=;
        b=hFigAi4En7GegW/tiGMiYnEDoOZ4oj+JF3JhX2B65dwuLfn7vJKVfXnIw7G9P+LQPI
         tnERBVWhTKsw2j3bFxpNaFl5Ly1OXvnC842v+aYiY/htPa0tfPSTWLcOWcs4Kz75KTap
         Uw7GdGO8r7THZ83aXLTPrC73KOkPvJz4zeewkcyR1DOddiRs9iNkPMgGVE/kWCzZ0jeC
         zScJHvZ5fDxRTdUaKq00zUcSaFqdedIZxWro7fwqMycAVbqX0v/5ONxZCBhTNOehpOnr
         De11Bi7u7JG2xBwmfVPsldLyj4QvnueffW4iNDEgMU84BuItr2AAsk5MCJm67MQgQzew
         rHfQ==
X-Gm-Message-State: AJcUukdSm8MGDDmGMSGlAQnim8/yX3gl6yJX8SX8Ej726b+QjLl9a6JN
        55s94gXxIhyj6fuwt8p9Q0M=
X-Google-Smtp-Source: ALg8bN5HH966CVOZdkbUHXX6AsCqk+v/Fux8upPWCa8vk6IN9/ymokTGWPHFQbN+MnJR3r99a9In1Q==
X-Received: by 2002:ac8:33fc:: with SMTP id d57mr20098374qtb.82.1547921112881;
        Sat, 19 Jan 2019 10:05:12 -0800 (PST)
Received: from localhost (pool-68-160-176-113.bstnma.fios.verizon.net. [68.160.176.113])
        by smtp.gmail.com with ESMTPSA id m81sm43331864qkl.92.2019.01.19.10.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 10:05:12 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     NeilBrown <neilb@suse.com>, Ming Lei <ming.lei@redhat.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH 2/4] dm: fix redundant IO accounting for bios that need splitting
Date:   Sat, 19 Jan 2019 13:05:04 -0500
Message-Id: <20190119180506.1300-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190119180506.1300-1-snitzer@redhat.com>
References: <20190119180506.1300-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The risk of redundant IO accounting was not taken into consideration
when commit 18a25da84354 ("dm: ensure bio submission follows a
depth-first tree walk") introduced IO splitting in terms of recursion
via generic_make_request().

Fix this by subtracting the split bio's payload from the IO stats that
were already accounted for by start_io_acct() upon dm_make_request()
entry.  This repeat oscillation of the IO accounting, up then down,
isn't ideal but refactoring DM core's IO splitting to pre-split bios
_before_ they are accounted turned out to be an excessive amount of
change that will need a full development cycle to refine and verify.

Before this fix:

  /dev/mapper/stripe_dev is a 4-way stripe using a 32k chunksize, so
  bios are split on 32k boundaries.

  # fio --name=16M --filename=/dev/mapper/stripe_dev --rw=write --bs=64k --size=16M \
    	--iodepth=1 --ioengine=libaio --direct=1 --refill_buffers

  with debugging added:
  [103898.310264] device-mapper: core: start_io_acct: dm-2 WRITE bio->bi_iter.bi_sector=0 len=128
  [103898.318704] device-mapper: core: __split_and_process_bio: recursing for following split bio:
  [103898.329136] device-mapper: core: start_io_acct: dm-2 WRITE bio->bi_iter.bi_sector=64 len=64
  ...

  16M written yet 136M (278528 * 512b) accounted:
  # cat /sys/block/dm-2/stat | awk '{ print $7 }'
  278528

After this fix:

  16M written and 16M (32768 * 512b) accounted:
  # cat /sys/block/dm-2/stat | awk '{ print $7 }'
  32768

Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first tree walk")
Cc: stable@vger.kernel.org # 4.16+
Reported-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fcb97b0a5743..fbadda68e23b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1584,6 +1584,9 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 	ci->sector = bio->bi_iter.bi_sector;
 }
 
+#define __dm_part_stat_sub(part, field, subnd)	\
+	(part_stat_get(part, field) -= (subnd))
+
 /*
  * Entry point to split a bio into clones and submit them to the targets.
  */
@@ -1638,6 +1641,19 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 				struct bio *b = bio_split(bio, bio_sectors(bio) - ci.sector_count,
 							  GFP_NOIO, &md->queue->bio_split);
 				ci.io->orig_bio = b;
+
+				/*
+				 * Adjust IO stats for each split, otherwise upon queue
+				 * reentry there will be redundant IO accounting.
+				 * NOTE: this is a stop-gap fix, a proper fix involves
+				 * significant refactoring of DM core's bio splitting
+				 * (by eliminating DM's splitting and just using bio_split)
+				 */
+				part_stat_lock();
+				__dm_part_stat_sub(&dm_disk(md)->part0,
+						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
+				part_stat_unlock();
+
 				bio_chain(b, bio);
 				ret = generic_make_request(bio);
 				break;
-- 
2.15.0

