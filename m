Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B903BC10DCE
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 06:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926E22076A
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 06:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="QDLKKBD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgCXGjt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:39:49 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:45114 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgCXGjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 02:39:48 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D440B2E132A;
        Tue, 24 Mar 2020 09:39:46 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 8vnLE5EXoi-dkj88Mop;
        Tue, 24 Mar 2020 09:39:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585031986; bh=jyRnU+Asd2uxc7+0qAY2dN85ocWc8XFT/wVXuXTWsBE=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=QDLKKBD8Ec4XEAfztaT7qJTJzEani+im95myqbfF5QUF3ZWR4kgoIx7vojWZqduHI
         /VgRiaD5XWx+lo/D8l4TPDdFANxWU6VyxNsiAY6segjOM4+X/S0Do36/ufhHPEjOme
         IKRsrQw7aF4BSsP2yieT5Aot3TFEkYA/VIFBPR4E=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6410::1:2])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id XsUON6R6Im-dkbaHA5k;
        Tue, 24 Mar 2020 09:39:46 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v3 3/3] block/diskstats: replace time_in_queue with sum of
 request times
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Date:   Tue, 24 Mar 2020 09:39:46 +0300
Message-ID: <158503198613.1955.12660218488410753545.stgit@buzz>
In-Reply-To: <158503038812.1955.7827988255138056389.stgit@buzz>
References: <158503038812.1955.7827988255138056389.stgit@buzz>
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
 block/bio.c               |    1 -
 block/blk-core.c          |    1 -
 block/genhd.c             |    7 +++++--
 block/partition-generic.c |    6 +++++-
 include/linux/genhd.h     |    1 -
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b1053eb7af37..a353d5cdf589 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1805,7 +1805,6 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 
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
index 606e8755f6ed..2b49d997ac72 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -87,7 +87,6 @@ void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 		}
 
 		stat->io_ticks += ptr->io_ticks;
-		stat->time_in_queue += ptr->time_in_queue;
 	}
 }
 #endif /* CONFIG_SMP */
@@ -1487,7 +1486,11 @@ static int diskstats_show(struct seq_file *seqf, void *v)
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
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 6d3fcb5187cb..2a9bc78a116f 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -143,7 +143,11 @@ ssize_t part_stat_show(struct device *dev,
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
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ead3ffb7f327..019ede22ebd2 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -89,7 +89,6 @@ struct disk_stats {
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
 	unsigned long io_ticks;
-	unsigned long time_in_queue;
 	local_t in_flight[2];
 };
 

