Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C5BC3F2D2
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 10:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DC62187F
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 10:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Fou7TXk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCBKi0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:38:26 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:57828 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727365AbgCBKiZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Mar 2020 05:38:25 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id C00672E1651;
        Mon,  2 Mar 2020 13:38:22 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id tHZIBWq68n-cMOS9f61;
        Mon, 02 Mar 2020 13:38:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1583145502; bh=LW5J51kvtPxw0Dzn08yIOjAO/dxjrH5rfxT482plXKQ=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=Fou7TXk+Tu939Za5ehyo7U/v8yayoefsH320CZ/dnsQpGqffUir1gO+sSQRXTRAtN
         YrywOgca+k15eTpcpvmPOKFyMYwF0ObM3mHyCu9Y1NabkZHukalo8jEQYkicY26sEM
         gJQOBt0MbAmnOZq/W+RBWX5iUa0c1C3GtfaKAJZk=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:7cd4:25a8:c7e3:39e2])
        by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id FhQJDCbsHQ-cMWCiHlK;
        Mon, 02 Mar 2020 13:38:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 3/3] block/diskstats: replace time_in_queue with sum of
 request times
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Mon, 02 Mar 2020 13:38:21 +0300
Message-ID: <158314550188.1788.1914819384413096357.stgit@buzz>
In-Reply-To: <158314549775.1788.6529015932237292177.stgit@buzz>
References: <158314549775.1788.6529015932237292177.stgit@buzz>
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
index 5319bf8721b7..619cde225c60 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1795,7 +1795,6 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 
 	update_io_ticks(part, now, true);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
-	part_stat_add(part, time_in_queue, duration);
 	part_dec_in_flight(q, part, op_is_write(req_op));
 
 	part_stat_unlock();
diff --git a/block/blk-core.c b/block/blk-core.c
index caad0dc32333..b913626033f7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1342,7 +1342,6 @@ void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(part, jiffies, true);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
-		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
diff --git a/block/genhd.c b/block/genhd.c
index fcc597c243f7..ab49ce053a32 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -64,7 +64,6 @@ void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 		}
 
 		stat->io_ticks += ptr->io_ticks;
-		stat->time_in_queue += ptr->time_in_queue;
 	}
 }
 #endif /* CONFIG_SMP */
@@ -1428,7 +1427,11 @@ static int diskstats_show(struct seq_file *seqf, void *v)
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
index f1fca2c57092..e517758adaa4 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -89,7 +89,6 @@ struct disk_stats {
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
 	unsigned long io_ticks;
-	unsigned long time_in_queue;
 	local_t in_flight[2];
 };
 

