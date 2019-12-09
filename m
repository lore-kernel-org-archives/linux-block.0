Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F75C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF81B2068E
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=selectel-ru.20150623.gappssmtp.com header.i=@selectel-ru.20150623.gappssmtp.com header.b="D+D+nI8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLIN6R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:58:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33685 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLIN6R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 08:58:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so10828850lfl.0
        for <linux-block@vger.kernel.org>; Mon, 09 Dec 2019 05:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selectel-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=s74rJWXw7qUN98/mKdN9hYCR+OahgaAFy6Te5TkZixw=;
        b=D+D+nI8XkzqjtOXhqENxj84e4PcVrt3cJ1ex0DxVSaWp28tbb/2sk705WItFHNWxxq
         M7Cr/ty2L3SDJnnXuWYPk6AA0stD5IDMbQG0JG51iDJfrYYD9S5xGEg8GrB8aLlfRsyP
         ZYROQwamA2Rdjah3cSlVECAqnPI4fdZLdVJUhvBqC1Ws660/Pt/n4Cy0Vj76ZK9hVlyT
         oLktTJOse9XX609jLWOkRiBgBsTdhqoWMrAoGSJ56Al+wdjEB33CmkizPtFgvK47pTHB
         bw/iFnZFYmtnFQMHqNZr2igYQEnHN/fuh0ulZChlBJ301EwQE3kJZDwkuT/YXUFu/asE
         JwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=s74rJWXw7qUN98/mKdN9hYCR+OahgaAFy6Te5TkZixw=;
        b=U+bxdGrIvjB1JjGNw4kJTgJC7cwO9hX7TWnoxCkvukljes/Bc7e3BFCCruhNcRlkIi
         oE43UdD97Tko7HECs1Cs+jd+IODeIPWpQNTbs4FlxAFmk7clDe4esT+7F+adrQJfKfvp
         jExhQ7O0DuN+gsrVs8ZADSaoN4DSc85ZC0KvhJtcKULITvbLEhXa0RG6HDBgM0Yl+Dh3
         UDox/xcLyBYx3uaVnPzGe4EcVeij7STuKmhWv2LB0gXrraRIWCVw23GL7OWQQRcZusPb
         TMYNDbo11JEid4Y2tvWf3JdFTphKt+Iajz6BT39e5CKRRMza5dToN02etxq6Az4902Vu
         jLHg==
X-Gm-Message-State: APjAAAV4WqyylYas/HJ153XKJhvX8kssQcYB+2//qha2LZj00D+/vKJQ
        9cZTnfHAgPDctAYVHoC5UhTgIIi9mGQ=
X-Google-Smtp-Source: APXvYqzD0FYpEufHRVqcY8dvQdMaRJzAzUnOkjHg02jO3YKP6JtQN9bODXF6Fymk5bTE3NAeh7QzuA==
X-Received: by 2002:a19:5013:: with SMTP id e19mr15712211lfb.8.1575899894282;
        Mon, 09 Dec 2019 05:58:14 -0800 (PST)
Received: from some-laptop.eq.selectel.org ([188.93.16.2])
        by smtp.gmail.com with ESMTPSA id g14sm11099511ljj.37.2019.12.09.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:58:13 -0800 (PST)
From:   Aleksei Zakharov <zaharov@selectel.ru>
To:     linux-block@vger.kernel.org
Cc:     Aleksei Zakharov <zaharov@selectel.ru>
Subject: [PATCH 2/2] block: add iostat counters for requests splits
Date:   Mon,  9 Dec 2019 16:58:01 +0300
Message-Id: <7baf0d9f4bf8f3110c630d56ccb5c9da40b668ac.1575899439.git.zaharov@selectel.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575899438.git.zaharov@selectel.ru>
References: <cover.1575899438.git.zaharov@selectel.ru>
In-Reply-To: <cover.1575899438.git.zaharov@selectel.ru>
References: <cover.1575899438.git.zaharov@selectel.ru>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I/O request can be splitted for two or more requests,
if it's size is greater than queue/max_sectors_kb
setting.

Knowledge of splits frequency helps to understand workload
profile better and to make decision to tune queue/max_sectors_kb.

This patch adds three counters to /sys/class/block/$dev/stat
and /proc/diskstats: number of reads, writes and discards
splitted.

There's also counter for flush requests, but it is ignored,
because flush cannot be splitted.
---
 Documentation/ABI/testing/procfs-diskstats |  3 +++
 Documentation/ABI/testing/sysfs-block      |  5 ++++-
 Documentation/admin-guide/iostats.rst      | 10 ++++++++++
 block/bio.c                                |  2 ++
 block/blk-core.c                           |  2 ++
 block/genhd.c                              |  8 ++++++--
 block/partition-generic.c                  |  8 ++++++--
 include/linux/genhd.h                      |  1 +
 8 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/procfs-diskstats b/Documentation/ABI/testing/procfs-diskstats
index 70dcaf2481f4..e1473e93d901 100644
--- a/Documentation/ABI/testing/procfs-diskstats
+++ b/Documentation/ABI/testing/procfs-diskstats
@@ -33,5 +33,8 @@ Description:
 
 		19 - flush requests completed successfully
 		20 - time spent flushing
+		21 - reads splitted
+		22 - writes splitted
+		23 - discards splitted
 
 		For more details refer to Documentation/admin-guide/iostats.rst
diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index ed8c14f161ee..ffbac0e72508 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -3,7 +3,7 @@ Date:		February 2008
 Contact:	Jerome Marchand <jmarchan@redhat.com>
 Description:
 		The /sys/block/<disk>/stat files displays the I/O
-		statistics of disk <disk>. They contain 11 fields:
+		statistics of disk <disk>. They contain 20 fields:
 		 1 - reads completed successfully
 		 2 - reads merged
 		 3 - sectors read
@@ -21,6 +21,9 @@ Description:
 		15 - time spent discarding (ms)
 		16 - flush requests completed
 		17 - time spent flushing (ms)
+		18 - reads splitted
+		19 - writes splitted
+		20 - discrads splitted
 		For more details refer Documentation/admin-guide/iostats.rst
 
 
diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index 4f0462af3ca7..7f3f374b82b7 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -130,6 +130,16 @@ Field 16 -- # of flush requests completed
 Field 17 -- # of milliseconds spent flushing
     This is the total number of milliseconds spent by all flush requests.
 
+Field 18 -- # of reads splitted, field 19 -- # of writes splitted
+    This is the total number of requests splitted before queue.
+
+    The maximum size of I/O is limited by queue/max_sectors_kb.
+    If size of I/O is greater than this limit, it will be splitted
+    as many times as needed to keep I/O size withing the limit.
+
+Field 20 -- # of discrads Splitted
+    See description of fileds 18 and 19.
+
 To avoid introducing performance bottlenecks, no locks are held while
 modifying these counters.  This implies that minor inaccuracies may be
 introduced when changes collide, so (for instance) adding up all the
diff --git a/block/bio.c b/block/bio.c
index 8f0ed6228fc5..c8a051e128f8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1855,6 +1855,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);
 
+	bio_set_flag(split, BIO_SPLITTED);
+
 	return split;
 }
 EXPORT_SYMBOL(bio_split);
diff --git a/block/blk-core.c b/block/blk-core.c
index f0d82227a2fc..776d28b9a5bf 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1379,6 +1379,8 @@ void blk_account_io_start(struct request *rq, bool new_io)
 		}
 		part_inc_in_flight(rq->q, part, rw);
 		rq->part = part;
+		if (bio_flagged(rq->bio, BIO_SPLITTED))
+			part_stat_inc(part, splits[rw]);
 	}
 
 	update_io_ticks(part, jiffies);
diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..adb38baa24dc 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1386,7 +1386,8 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   "%lu %lu %lu %u "
 			   "%u %u %u "
 			   "%lu %lu %lu %u "
-			   "%lu %u"
+			   "%lu %u "
+			   "%lu %lu %lu"
 			   "\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
@@ -1406,7 +1407,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   part_stat_read(hd, sectors[STAT_DISCARD]),
 			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD),
 			   part_stat_read(hd, ios[STAT_FLUSH]),
-			   (unsigned int)part_stat_read_msecs(hd, STAT_FLUSH)
+			   (unsigned int)part_stat_read_msecs(hd, STAT_FLUSH),
+			   part_stat_read(hd, splits[STAT_READ]),
+			   part_stat_read(hd, splits[STAT_WRITE]),
+			   part_stat_read(hd, splits[STAT_DISCARD])
 			);
 	}
 	disk_part_iter_exit(&piter);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 3db8b73a96b1..61e26ec21256 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -128,7 +128,8 @@ ssize_t part_stat_show(struct device *dev,
 		"%8lu %8lu %8llu %8u "
 		"%8u %8u %8u "
 		"%8lu %8lu %8llu %8u "
-		"%8lu %8u"
+		"%8lu %8u "
+		"%8lu %8lu %8lu"
 		"\n",
 		part_stat_read(p, ios[STAT_READ]),
 		part_stat_read(p, merges[STAT_READ]),
@@ -146,7 +147,10 @@ ssize_t part_stat_show(struct device *dev,
 		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
 		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
 		part_stat_read(p, ios[STAT_FLUSH]),
-		(unsigned int)part_stat_read_msecs(p, STAT_FLUSH));
+		(unsigned int)part_stat_read_msecs(p, STAT_FLUSH),
+		part_stat_read(p, splits[STAT_READ]),
+		part_stat_read(p, splits[STAT_WRITE]),
+		part_stat_read(p, splits[STAT_DISCARD]));
 }
 
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8b5330dd5ac0..ea502e7b12b6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -88,6 +88,7 @@ struct disk_stats {
 	unsigned long sectors[NR_STAT_GROUPS];
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
+	unsigned long splits[NR_STAT_GROUPS];
 	unsigned long io_ticks;
 	unsigned long time_in_queue;
 	local_t in_flight[2];
-- 
2.17.1

