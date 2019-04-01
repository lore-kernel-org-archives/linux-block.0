Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B33C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 16:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25180213F2
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 16:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="DtXygTHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfDAQJh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:09:37 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:36588 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727032AbfDAQJh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 12:09:37 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Apr 2019 12:09:35 EDT
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 2A6962E142A;
        Mon,  1 Apr 2019 18:59:47 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id r5FRh28GdW-xkL8k4SL;
        Mon, 01 Apr 2019 18:59:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1554134387; bh=EGp/YoVMHmXos5JfZkrpigUbbElvE331JXf9q50kYrs=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=DtXygTHkypOuM9DFgXG6ImNX9EoHIyZSVBYTZ6iyu9CXFRuYz5IZvw3VkizJZLp7u
         Ni0dx1KHBDpSNUUxulQxDLUkGT+I41KBkVsUJFItPHvRKFi7GeSRPiDJTFR6+5lH+B
         xu85Mx7GzN7PhwzlQs4PDo976r7IaXc6Ki+RQWM4=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d4bb:795:9728:5f59])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5co1Z1xk1c-xkLOrfag;
        Mon, 01 Apr 2019 18:59:46 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/3] block/diskstats: remove redundant and inaccurate
 time_in_queue counter
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Mon, 01 Apr 2019 18:59:46 +0300
Message-ID: <155413438636.3201.8688215933219744911.stgit@buzz>
In-Reply-To: <155413438394.3201.15211440151043943989.stgit@buzz>
References: <155413438394.3201.15211440151043943989.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Diskstat's column "time_in_queue" must be equal to sum "read tisks",
"write ticks" and "discard ticks". But it is accounted separately and
in jiffies rather than nanoseconds as other times. As a result total
time is not even close to the sum, especially for fast ssd disks.

In Documentation/block/stat.txt these fields are defined as product of
time when disk had such requests and count of them. But that is equal to
sum of running time of completed requests plus running time of in-flight
requests. Latter part is small or even zero if disk is idle.

This patch removes field time_in_queue and replaces with simple sum.

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/bio.c               |    1 -
 block/blk-core.c          |    1 -
 block/genhd.c             |    6 ++++--
 block/partition-generic.c |    5 ++++-
 include/linux/genhd.h     |    1 -
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b64cedc7f87c..c0a60f3e9b7b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1772,7 +1772,6 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 
 	update_io_ticks(part, now);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
-	part_stat_add(part, time_in_queue, duration);
 	part_dec_in_flight(q, part, op_is_write(req_op));
 
 	part_stat_unlock();
diff --git a/block/blk-core.c b/block/blk-core.c
index 4673ebe42255..d89168b167e9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1337,7 +1337,6 @@ void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(part, jiffies);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
-		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
diff --git a/block/genhd.c b/block/genhd.c
index 2f986af81ba1..7e53d6af08fb 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -63,7 +63,6 @@ void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 		}
 
 		stat->io_ticks += ptr->io_ticks;
-		stat->time_in_queue += ptr->time_in_queue;
 	}
 }
 #else /* CONFIG_SMP */
@@ -1403,7 +1402,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 							NSEC_PER_MSEC),
 			   inflight,
 			   jiffies_to_msecs(stat.io_ticks),
-			   jiffies_to_msecs(stat.time_in_queue),
+			   (unsigned int)div_u64(stat.nsecs[STAT_READ] +
+						 stat.nsecs[STAT_WRITE] +
+						 stat.nsecs[STAT_DISCARD],
+							NSEC_PER_MSEC),
 			   stat.ios[STAT_DISCARD],
 			   stat.merges[STAT_DISCARD],
 			   stat.sectors[STAT_DISCARD],
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 621e0d9f3c92..935df55c0c91 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -142,7 +142,10 @@ ssize_t part_stat_show(struct device *dev,
 		(unsigned int)div_u64(stat.nsecs[STAT_WRITE], NSEC_PER_MSEC),
 		inflight,
 		jiffies_to_msecs(stat.io_ticks),
-		jiffies_to_msecs(stat.time_in_queue),
+		(unsigned int)div_u64(stat.nsecs[STAT_READ] +
+				      stat.nsecs[STAT_WRITE] +
+				      stat.nsecs[STAT_DISCARD],
+						NSEC_PER_MSEC),
 		stat.ios[STAT_DISCARD],
 		stat.merges[STAT_DISCARD],
 		(unsigned long long)stat.sectors[STAT_DISCARD],
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 7f981be190b4..2f5a9ed7e86e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -89,7 +89,6 @@ struct disk_stats {
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
 	unsigned long io_ticks;
-	unsigned long time_in_queue;
 	local_t in_flight[2];
 };
 

