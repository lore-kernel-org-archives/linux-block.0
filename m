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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF0C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 08:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5390361D06
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 08:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhF3IOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbhF3IOq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 04:14:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D23C061766;
        Wed, 30 Jun 2021 01:12:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hc16so2710336ejc.12;
        Wed, 30 Jun 2021 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPRdx0QRo7nzdsh8ED97M0eRdszbBRIeqzvVm0DA5wI=;
        b=Zj/QFMaYYl8hPs4a6H8kudkxgrARZRa3aHjQ9v4gBawGr1Rk44TxYOTokjotD7W+k5
         ps6palupDfdCkxCVJL/g1XeeW+Ki2wXpumk5u+hpTw5xqrWlofhrYc8XYlk4/574tgEz
         2eu07GWcZsYGc9BSP52qwdCZ6gnK7UihpsmPRCrLqCL5C7rVEj1TRGyc7yDmOxUnrYJU
         qm4jqf++hcc+5Zs8aQTqT3BKNpG7aHjEQ3jNett1RV/0kIh5biHz7VnjC6URa1adbkY6
         5tXo0z6Ds+tI9+FSQTFOQQKl1eS1/dxR8redkVrehmLcpQ1YXQQhRY9t3Z6ncJvB5TIS
         MtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPRdx0QRo7nzdsh8ED97M0eRdszbBRIeqzvVm0DA5wI=;
        b=PEQb4UDbCV1A7SXCmmtb6GJTJ/Udr7rPvmjcbNEWv35hHrJdQGZyjDx4g6gD4eAdPj
         oMOKERwHKumt6Nz3v8vsgfzcfhahyWnAqG2YQQEeD2hnYucRgvKW5FTnEK3/4ge4uKcu
         iJ12BDTyLtWsXpAjpiadZXG6zeSbBnLVfrBW4kzn0e7tVIsLURO8w9yBQvAIPXIlBP5R
         6rEY53jRrAk3dFW0XrcpwIWn5yKcwjdTrOKFZbDsmQTAFuxStrMWfu6e+acQG8Q6uUd/
         eyPIEAJXKDcJD2Bp4YX2kknYiF0AZ1mmdArEXRQheclJLkyvge+rKjFjDUWpoEVGRZpS
         ah+g==
X-Gm-Message-State: AOAM533Aux2lVPV9BWRc3ICPmHvISN2Z7Zg08/w7AOxsEfUNgYfa8Gvf
        9+UKwtZFQwVDguj7mqbscaE=
X-Google-Smtp-Source: ABdhPJzKTmHtvvcYdXvAc3Zx13bZiN3UQt8ySxYFfBKIElMmfp1fzqt5Ji6wjKmswUBxVBveb4suFA==
X-Received: by 2002:a17:906:2985:: with SMTP id x5mr33888561eje.438.1625040733002;
        Wed, 30 Jun 2021 01:12:13 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id ml14sm9218318ejb.27.2021.06.30.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 01:12:12 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [PATCH] block: Removed a warning while compiling with a cross compiler for parisc
Date:   Wed, 30 Jun 2021 10:10:28 +0200
Message-Id: <20210630081028.161284-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I have compiled the kernel with a cross compiler "hppa-linux-gnu-" on
x86-64 host machine. I got the follwing warning:

block/genhd.c: In function ‘diskstats_show’:
block/genhd.c:1227:1: warning: the frame size of 1688 bytes is larger
than 1280 bytes [-Wframe-larger-than=]
 1227  |  }

The problem was calling seq_printf function with too long argumnets list.
Therefore, I cut it into two halves. For the second half I have defined
a function called "print_disk_stats" to print the states of the disk.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
---
 block/genhd.c | 75 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..caf5ac8b509f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1151,6 +1151,44 @@ const struct device_type disk_type = {
 };
 
 #ifdef CONFIG_PROC_FS
+
+void print_disk_stats(struct seq_file *seqf,
+		      unsigned int inflight, struct disk_stats *stat)
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
@@ -1185,41 +1223,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
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

