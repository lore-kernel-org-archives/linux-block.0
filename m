Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9142BC07E95
	for <linux-block@archiver.kernel.org>; Sun,  4 Jul 2021 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B95613E5
	for <linux-block@archiver.kernel.org>; Sun,  4 Jul 2021 12:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhGDMwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Jul 2021 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGDMwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Jul 2021 08:52:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38969C061574;
        Sun,  4 Jul 2021 05:50:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so12155624wms.1;
        Sun, 04 Jul 2021 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJlLed1w+/MtdkCkK1NBTk1DZy9w9lQtOOpUJt3r8eI=;
        b=R5PesJ9PXH7OoGGOd/laFCvdMWq+JgnvY0Fy03J+6u7H5P5Lv+fk9jYDV37aN8B5dr
         GdB8ZrYPf6PohbYHJ0X/zkLPSNzguCcbsCAkJLCHeQ1v3OTa3rmVgH734U1++Y/6mpX8
         GbXINKTC025A+lv2RNze6peGoAt1ZfnJFhzVdWlSRcYrVrfyHykojoXGIfoZGGbsD/lR
         hiZ/iR0ILcE8Bvqemk/JxT/aWfa/OBgLwWYwoMfZazoqaYmgDdpwgM+Z1xzhFH2VvL/J
         AgOEMK+wTtiHwyuBavJ4K9eu4+S6d1FOUs+PMS1biaKawjtHXmIebdJs/av7VyZX+G3g
         nuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJlLed1w+/MtdkCkK1NBTk1DZy9w9lQtOOpUJt3r8eI=;
        b=TaxTyZ4GBzyhirPyE2WLcQwH5woZJU+lXXQ3lhVs2AqI2F2iGf3/FY1ObvIPnQcvoi
         TjANl1q0W5cIt0qzB1kkh6gV6VkQG7CBT/Y7vAZYtsRsR8SrzD1nDd2Do2+bYEeaxeDV
         HfRfCAT7RtkLKjpBX/yVI9gUyYC5W6lk4zZyavKRWKRUzrMQI1zQ7yigRRblFDgOA8uo
         VLLeF9T4psFqxrbDxYjPEn8raC/BqjCS8Y40TnDGC+pNZwyGNsr1AWNQF2QzS25jOldr
         ySBKN7A46uiXkw9qMW6invFfFONa/nr1xR1npfmBwPazPWI99g68xsImZI5ymxEsFdXs
         ZlPg==
X-Gm-Message-State: AOAM530NYz44YpQGnOpktJikTqveKBKOp/RxerRy56mjj0lf5PCwQutG
        xSMgReL80cBg0YEOQvBaflM=
X-Google-Smtp-Source: ABdhPJwPsT80j7LM+fZzEqxdishZt102hgWLXn7n1A4QMJUo9UV/10NO5K36Q3d624QcVUXO1qtH0w==
X-Received: by 2002:a1c:1bd4:: with SMTP id b203mr9877799wmb.171.1625403017727;
        Sun, 04 Jul 2021 05:50:17 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id o3sm9731947wrw.56.2021.07.04.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 05:50:17 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [PATCH v2] block: Removed a warning while compiling with a cross compiler for parisc
Date:   Sun,  4 Jul 2021 14:48:27 +0200
Message-Id: <20210704124826.63468-1-abd.masalkhi@gmail.com>
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

by Reduced the stack footprint, using new printf specifier to print the
bdevname and wrapping div_u64 function with non-inline wrapper function,
the warning was not omitted anymore.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
---
 block/genhd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..6d22b84b182b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1151,6 +1151,11 @@ const struct device_type disk_type = {
 };
 
 #ifdef CONFIG_PROC_FS
+static noinline u64 call_div_u64(u64 dividend, u32 divisor)
+{
+	return div_u64(dividend, divisor);
+}
+
 /*
  * aggregate disk stat collector.  Uses the same stats that the sysfs
  * entries do, above, but makes them available through one seq_file.
@@ -1162,7 +1167,6 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 {
 	struct gendisk *gp = v;
 	struct block_device *hd;
-	char buf[BDEVNAME_SIZE];
 	unsigned int inflight;
 	struct disk_stats stat;
 	unsigned long idx;
@@ -1185,40 +1189,39 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		else
 			inflight = part_in_flight(hd);
 
-		seq_printf(seqf, "%4d %7d %s "
+		seq_printf(seqf, "%4d %7d %pg "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
 			   "%u %u %u "
 			   "%lu %lu %lu %u "
 			   "%lu %u"
 			   "\n",
-			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev),
-			   disk_name(gp, hd->bd_partno, buf),
+			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev), gp,
 			   stat.ios[STAT_READ],
 			   stat.merges[STAT_READ],
 			   stat.sectors[STAT_READ],
-			   (unsigned int)div_u64(stat.nsecs[STAT_READ],
-							NSEC_PER_MSEC),
+			   (unsigned int)call_div_u64(stat.nsecs[STAT_READ],
+						      NSEC_PER_MSEC),
 			   stat.ios[STAT_WRITE],
 			   stat.merges[STAT_WRITE],
 			   stat.sectors[STAT_WRITE],
-			   (unsigned int)div_u64(stat.nsecs[STAT_WRITE],
-							NSEC_PER_MSEC),
+			   (unsigned int)call_div_u64(stat.nsecs[STAT_WRITE],
+						      NSEC_PER_MSEC),
 			   inflight,
 			   jiffies_to_msecs(stat.io_ticks),
-			   (unsigned int)div_u64(stat.nsecs[STAT_READ] +
-						 stat.nsecs[STAT_WRITE] +
-						 stat.nsecs[STAT_DISCARD] +
-						 stat.nsecs[STAT_FLUSH],
-							NSEC_PER_MSEC),
+			   (unsigned int)call_div_u64(stat.nsecs[STAT_READ] +
+						      stat.nsecs[STAT_WRITE] +
+						      stat.nsecs[STAT_DISCARD] +
+						      stat.nsecs[STAT_FLUSH],
+						      NSEC_PER_MSEC),
 			   stat.ios[STAT_DISCARD],
 			   stat.merges[STAT_DISCARD],
 			   stat.sectors[STAT_DISCARD],
-			   (unsigned int)div_u64(stat.nsecs[STAT_DISCARD],
-						 NSEC_PER_MSEC),
+			   (unsigned int)call_div_u64(stat.nsecs[STAT_DISCARD],
+						      NSEC_PER_MSEC),
 			   stat.ios[STAT_FLUSH],
-			   (unsigned int)div_u64(stat.nsecs[STAT_FLUSH],
-						 NSEC_PER_MSEC)
+			   (unsigned int)call_div_u64(stat.nsecs[STAT_FLUSH],
+						      NSEC_PER_MSEC)
 			);
 	}
 	rcu_read_unlock();
-- 
2.29.0.rc1.dirty

