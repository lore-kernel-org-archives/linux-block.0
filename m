Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BEBC54FD0
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4E8207FC
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="iZCKC2wE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCYNHN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:07:13 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:38526 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727452AbgCYNHM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 09:07:12 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 5A3242E15E0;
        Wed, 25 Mar 2020 16:07:09 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id TAJ5DXKdPW-78D4Dagk;
        Wed, 25 Mar 2020 16:07:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585141629; bh=ybaDEAArqwziUQoA9o9Ff35aWMFz8no2o0b8HSSN56E=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=iZCKC2wEPnzVMpLw+9xocptjvtdBr4ZfgteD+kbaLP80QhdfLnnztAnXRXjSm9RXb
         Cg7CMQB2DweUn9mGuFfJXQRMYE7NFOjBXZ7/qhP6j4/yrKrCQNfGEkMqKSLJ9zVKeq
         dWgiCWn4UhkU4y4sLtSbKwQf16ncAw7vnqTR8HjA=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8204::1:e])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id DXfNTlVL5P-78b4c7Se;
        Wed, 25 Mar 2020 16:07:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v4 3/3] block/diskstats: replace time_in_queue with sum of
 request times
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Date:   Wed, 25 Mar 2020 16:07:08 +0300
Message-ID: <158514162821.7009.15679343074448512619.stgit@buzz>
In-Reply-To: <158514148436.7009.1234367408038809210.stgit@buzz>
References: <158514148436.7009.1234367408038809210.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Column "time_in_queue" in diskstats is supposed to show total waiting time
of all requests. I.e. value should be equal to the sum of times from other
columns. But this is not true, because column "time_in_queue" is counted
separately in jiffies rather than in nanoseconds as other times.

This patch removes redundant counter for "time_in_queue" and shows total
time of read, write, discard and flush requests.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/bio.c           |    1 -
 block/blk-core.c      |    1 -
 block/genhd.c         |   13 ++++++++++---
 include/linux/genhd.h |    1 -
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 68f65ef2ceba..bc9152977bf0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1811,7 +1811,6 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 
 	update_io_ticks(part, now, true);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
-	part_stat_add(part, time_in_queue, duration);
 	part_dec_in_flight(q, part, op_is_write(req_op));
 
 	part_stat_unlock();
diff --git a/block/blk-core.c b/block/blk-core.c
index 4401b30a1751..eaf6cb3887e6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1340,7 +1340,6 @@ void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(part, jiffies, true);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
-		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
diff --git a/block/genhd.c b/block/genhd.c
index 9eb981f7e5a4..792356e922a1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -110,7 +110,6 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 		}
 
 		stat->io_ticks += ptr->io_ticks;
-		stat->time_in_queue += ptr->time_in_queue;
 	}
 }
 #else /* CONFIG_SMP */
@@ -1265,7 +1264,11 @@ ssize_t part_stat_show(struct device *dev,
 		(unsigned int)div_u64(stat.nsecs[STAT_WRITE], NSEC_PER_MSEC),
 		inflight,
 		jiffies_to_msecs(stat.io_ticks),
-		jiffies_to_msecs(stat.time_in_queue),
+		(unsigned int)div_u64(stat.nsecs[STAT_READ] +
+				      stat.nsecs[STAT_WRITE] +
+				      stat.nsecs[STAT_DISCARD] +
+				      stat.nsecs[STAT_FLUSH],
+						NSEC_PER_MSEC),
 		stat.ios[STAT_DISCARD],
 		stat.merges[STAT_DISCARD],
 		(unsigned long long)stat.sectors[STAT_DISCARD],
@@ -1559,7 +1562,11 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 							NSEC_PER_MSEC),
 			   inflight,
 			   jiffies_to_msecs(stat.io_ticks),
-			   jiffies_to_msecs(stat.time_in_queue),
+			   (unsigned int)div_u64(stat.nsecs[STAT_READ] +
+						 stat.nsecs[STAT_WRITE] +
+						 stat.nsecs[STAT_DISCARD] +
+						 stat.nsecs[STAT_FLUSH],
+							NSEC_PER_MSEC),
 			   stat.ios[STAT_DISCARD],
 			   stat.merges[STAT_DISCARD],
 			   stat.sectors[STAT_DISCARD],
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index b0c588d1aa29..790fdc3e0b3d 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -46,7 +46,6 @@ struct disk_stats {
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
 	unsigned long io_ticks;
-	unsigned long time_in_queue;
 	local_t in_flight[2];
 };
 

