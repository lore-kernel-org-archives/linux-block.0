Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97A1C47254
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 13:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AAA2075E
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 13:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="rAwrIjR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgEDN3j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 09:29:39 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:60982 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgEDN3i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 09:29:38 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6E0612E0DF0;
        Mon,  4 May 2020 16:29:31 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id ONPkaKCySh-TUW0g9np;
        Mon, 04 May 2020 16:29:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588598971; bh=ACX3+Kjv5E3oD5vNgDl+54nvwQYFB1P5GSJhJZbV9OY=;
        h=Message-ID:Date:To:From:Subject;
        b=rAwrIjR//k3mW9rEBXzWcDKsqOJIpjQyCffU1ukvAQVJtsFti82vcvHBslQUGyoEO
         LXZXh2j2HiAnetq814e7vgjngYFcmyl4vRyVGq02eAqRz7xC2/KiD1uwOQ3QC08imG
         CmsMI/OpSbKCvdOyRNl8d7/UNKhtoG/tNKLRVcCo=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id XuQMN8HZVe-TTW88Pdb;
        Mon, 04 May 2020 16:29:30 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH 1/4] block/part_stat: remove rcu_read_lock() from
 part_stat_lock()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Date:   Mon, 04 May 2020 16:29:29 +0300
Message-ID: <158859896942.19836.15240144203131230746.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RCU lock is required only in blk_account_io_start() to lookup partition.
After that request holds reference to related hd_struct.

Replace get_cpu() with preempt_disable() - returned cpu index is unused.

Non-SMP case also needs preempt_disable, otherwise statistics update could
be non-atomic. Previously that was provided by rcu_read_lock().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-core.c          |    3 +++
 include/linux/part_stat.h |    7 +++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7f11560bfddb..45ddf7238c06 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1362,6 +1362,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
 		part = rq->part;
 		part_stat_inc(part, merges[rw]);
 	} else {
+		rcu_read_lock();
 		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
 		if (!hd_struct_try_get(part)) {
 			/*
@@ -1375,6 +1376,8 @@ void blk_account_io_start(struct request *rq, bool new_io)
 			part = &rq->rq_disk->part0;
 			hd_struct_get(part);
 		}
+		rcu_read_unlock();
+
 		part_inc_in_flight(rq->q, part, rw);
 		rq->part = part;
 	}
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index ece607607a86..755a01f0fd61 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -16,9 +16,10 @@
  * part_stat_{add|set_all}() and {init|free}_part_stats are for
  * internal use only.
  */
+#define part_stat_lock()	preempt_disable()
+#define part_stat_unlock()	preempt_enable()
+
 #ifdef	CONFIG_SMP
-#define part_stat_lock()	({ rcu_read_lock(); get_cpu(); })
-#define part_stat_unlock()	do { put_cpu(); rcu_read_unlock(); } while (0)
 
 #define part_stat_get_cpu(part, field, cpu)				\
 	(per_cpu_ptr((part)->dkstats, (cpu))->field)
@@ -58,8 +59,6 @@ static inline void free_part_stats(struct hd_struct *part)
 }
 
 #else /* !CONFIG_SMP */
-#define part_stat_lock()	({ rcu_read_lock(); 0; })
-#define part_stat_unlock()	rcu_read_unlock()
 
 #define part_stat_get(part, field)		((part)->dkstats.field)
 #define part_stat_get_cpu(part, field, cpu)	part_stat_get(part, field)

