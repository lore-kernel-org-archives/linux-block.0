Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F6BC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 21:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763F0613CE
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 21:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhF3VqX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 17:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhF3VqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 17:46:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1FDC061756;
        Wed, 30 Jun 2021 14:43:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o35-20020a05600c5123b02901e6a7a3266cso2648917wms.1;
        Wed, 30 Jun 2021 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tathPutVfQKcoiCFXb2rQuhW+brQlwkKxBaNJj1Iod0=;
        b=L59yqG9EQpd4QPOTkkH8dNMy56xQXEd0mZGpGaTexbG8EIZiRdnmJbFEq3Bus67en7
         n3/vx4afpRYIu9J6KXshERpUUzCUvbDRc5cKCh6ZW+Rh6/GRq/B1A2C5dXiHDFNnn1T5
         u6QzU72zf3QpvTRIA/pVMSvGBbL12A4rjim4RDqR7PvIfffl2MgyAL39k/Y61/+MJYGP
         UZ2aSohGDwJGSoIi5EHz9MPVvKEykrLS5jo2vtfSyFwUs/NfXrbSuw/vYvXfbviBNNnf
         ndWvcI5kLu5h8PTzO94XLB1ekejTkbtf8mAu0aWDoh+w+qPBpsqlc7HyGlhyYTl+XxOp
         4M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tathPutVfQKcoiCFXb2rQuhW+brQlwkKxBaNJj1Iod0=;
        b=DPoANHjc46zQBXVp3a5c6wq4qQoNrNRISufK2Z9qPFys17QfTYG4UjCVZz6Zv8OWV3
         sJGaejeW+CKCshmR89L3NlFWI193nrOXgDFSRQVaqTm3ASmXDfKuwM33VC9VYvQTtsqu
         ip7dAprVbRqpwO+Q5cQDdW4WtISQ+ukOvOOTCkPZWTdPcims25/WKdClR58LTXzW+rlg
         pVvUzA9wiSjjaQmRVNArB6azs/V1voQs1w/C7msxGfcz2ILs8Iq/ek2q2CZEEdUeHCvT
         oILksI+YLMsBas2SJL6pyeduBQ/2Ip4VbR4MVKEcJkYw+0sta9uF4XBtSLEpyWKKuZsu
         QSfw==
X-Gm-Message-State: AOAM5316I1Kkc65FTo+/xHgiceSPpN96/AGLJpH7c//G5PJgbwv0xqjT
        1OgR01zzA4K7CyqIqP3ul6KXehlfCyao/Q==
X-Google-Smtp-Source: ABdhPJzxKo7tnWCFSI1BoI/0COduHAGFzDvjXWfEePvlL5EgVJbnCbsALiWzCMOmcYskO/fuCicqEw==
X-Received: by 2002:a05:600c:4f56:: with SMTP id m22mr6979973wmq.16.1625089430817;
        Wed, 30 Jun 2021 14:43:50 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id o2sm23557738wrp.53.2021.06.30.14.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 14:43:50 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [PATCH] block: Removed a warning while compiling with a cross compiler for parisc
Date:   Wed, 30 Jun 2021 23:42:33 +0200
Message-Id: <20210630214233.235942-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I have compiled the kernel with a cross compiler "hppa-linux-gnu-" v9.3.0
on x86-64 host machine. I got the following warning:

block/genhd.c: In function ‘diskstats_show’:
block/genhd.c:1227:1: warning: the frame size of 1688 bytes is larger
than 1280 bytes [-Wframe-larger-than=]
 1227  |  }

The problem was calling seq_printf function with too long argumnets list.
Therefore, I cut it into two halves. For the second half I have defined
a function called "print_disk_stats" to print the states of the disk.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
---
 block/genhd.c | 74 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..64846aec76c0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1151,6 +1151,43 @@ const struct device_type disk_type = {
 };
 
 #ifdef CONFIG_PROC_FS
+static void print_disk_stats(struct seq_file *seqf,
+			     unsigned int inflight, struct disk_stats *stat)
+{
+	seq_printf(seqf, "%lu %lu %lu %u "
+		   "%lu %lu %lu %u "
+		   "%u %u %u "
+		   "%lu %lu %lu %u "
+		   "%lu %u"
+		   "\n",
+		   stat->ios[STAT_READ],
+		   stat->merges[STAT_READ],
+		   stat->sectors[STAT_READ],
+		   (unsigned int)div_u64(stat->nsecs[STAT_READ],
+					 NSEC_PER_MSEC),
+		   stat->ios[STAT_WRITE],
+		   stat->merges[STAT_WRITE],
+		   stat->sectors[STAT_WRITE],
+		   (unsigned int)div_u64(stat->nsecs[STAT_WRITE],
+					 NSEC_PER_MSEC),
+		   inflight,
+		   jiffies_to_msecs(stat->io_ticks),
+		   (unsigned int)div_u64(stat->nsecs[STAT_READ] +
+					 stat->nsecs[STAT_WRITE] +
+					 stat->nsecs[STAT_DISCARD] +
+					 stat->nsecs[STAT_FLUSH],
+					 NSEC_PER_MSEC),
+		   stat->ios[STAT_DISCARD],
+		   stat->merges[STAT_DISCARD],
+		   stat->sectors[STAT_DISCARD],
+		   (unsigned int)div_u64(stat->nsecs[STAT_DISCARD],
+					 NSEC_PER_MSEC),
+		   stat->ios[STAT_FLUSH],
+		   (unsigned int)div_u64(stat->nsecs[STAT_FLUSH],
+					 NSEC_PER_MSEC)
+		);
+}
+
 /*
  * aggregate disk stat collector.  Uses the same stats that the sysfs
  * entries do, above, but makes them available through one seq_file.
@@ -1185,41 +1222,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		else
 			inflight = part_in_flight(hd);
 
-		seq_printf(seqf, "%4d %7d %s "
-			   "%lu %lu %lu %u "
-			   "%lu %lu %lu %u "
-			   "%u %u %u "
-			   "%lu %lu %lu %u "
-			   "%lu %u"
-			   "\n",
+		seq_printf(seqf, "%4d %7d %s ",
 			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev),
-			   disk_name(gp, hd->bd_partno, buf),
-			   stat.ios[STAT_READ],
-			   stat.merges[STAT_READ],
-			   stat.sectors[STAT_READ],
-			   (unsigned int)div_u64(stat.nsecs[STAT_READ],
-							NSEC_PER_MSEC),
-			   stat.ios[STAT_WRITE],
-			   stat.merges[STAT_WRITE],
-			   stat.sectors[STAT_WRITE],
-			   (unsigned int)div_u64(stat.nsecs[STAT_WRITE],
-							NSEC_PER_MSEC),
-			   inflight,
-			   jiffies_to_msecs(stat.io_ticks),
-			   (unsigned int)div_u64(stat.nsecs[STAT_READ] +
-						 stat.nsecs[STAT_WRITE] +
-						 stat.nsecs[STAT_DISCARD] +
-						 stat.nsecs[STAT_FLUSH],
-							NSEC_PER_MSEC),
-			   stat.ios[STAT_DISCARD],
-			   stat.merges[STAT_DISCARD],
-			   stat.sectors[STAT_DISCARD],
-			   (unsigned int)div_u64(stat.nsecs[STAT_DISCARD],
-						 NSEC_PER_MSEC),
-			   stat.ios[STAT_FLUSH],
-			   (unsigned int)div_u64(stat.nsecs[STAT_FLUSH],
-						 NSEC_PER_MSEC)
-			);
+			   disk_name(gp, hd->bd_partno, buf));
+		print_disk_stats(seqf, inflight, &stat);
 	}
 	rcu_read_unlock();
 
-- 
2.29.0.rc1.dirty

