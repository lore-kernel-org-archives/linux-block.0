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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F00C11F67
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 22:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCAC61410
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 22:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhGAWET (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhGAWES (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jul 2021 18:04:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE5C061762;
        Thu,  1 Jul 2021 15:01:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u8so10010040wrq.8;
        Thu, 01 Jul 2021 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Glw4MyKbfrqZ47X58GjOG7N696nHmNYjMSTqKnCauic=;
        b=pB6caxcDX3Lg9zrR/9Wpvy4LgyS9BDrZiE4/9T9z3G4fCiHz1SlAv11MADJ6i684/Q
         MmosESNPPwEBH50u/E2UdiRER4TlOq0JMDcT3Kz+FXS+8PzHdH+BluFUMmLEoAu6jC6U
         hDQQHWf4dyBcgPFZPFSqOcLFgRxmk+4J454AZnZaJV22K8WvwQ/4gBfEEN6m/asVVK2F
         Y+jzk1iAVPwUD7LZmDWMHA3krmiOc5fJ10OyQe23vqmqH0F8SMNsSBIKSX9DxJgTus0+
         D0pJG9JD0XPZ7gQH+RpFM3Ry8csp71WU7kA5dK6uwsycBJLSPvh18RGBv4UCmKnaX6SD
         FkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Glw4MyKbfrqZ47X58GjOG7N696nHmNYjMSTqKnCauic=;
        b=fcAqh0pFsF21CM0OK+rb44aHk6Ry0LlzXFWJa2pG6eWxgD86SL4Hr+DXUMJDedGV0m
         WdIHxn4GknR2zCmLCotB5qbn0p/cM8iNQphf6RC3mFWL21iWbjx2iixDT1Qm3yxrcf42
         ptsHTqMaVyi4619eA+udev7vtSPBC4+skR8s3GfIAlTjdICUAFB8UklbokyKZUJ5R3k+
         AX2C960y4gLOZO+UiAGsaU/KI0Tkhl8f3LQlxkUct99eR/P9+AWd3QZREpEsw7Xo3S7E
         /skn3Sbde8bPV43xUZIz3luB0KvIZyEc+Xy2r8a6GwM/FDrBv5IXB677io06VuZfbqAv
         exXQ==
X-Gm-Message-State: AOAM531BuszUfjndYpJL9iVUxXHhmtC+D8FkdzyoZLsVVDd/DeiK1P7W
        1PXea5hG+MUMQm5KUqm8Tng=
X-Google-Smtp-Source: ABdhPJy2CcFtSyfD468hjAaYe4xZZCtBaiI2zSCBtYBb2m2WthEMN0tv3UCP89do7iMMA5AgoYytfQ==
X-Received: by 2002:a5d:400a:: with SMTP id n10mr2056703wrp.268.1625176905351;
        Thu, 01 Jul 2021 15:01:45 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id y7sm10648005wma.22.2021.07.01.15.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:01:44 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     hch@infradead.org
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: Re: [PATCH] block: Removed a warning while compiling with a cross compiler for parisc
Date:   Fri,  2 Jul 2021 00:01:30 +0200
Message-Id: <20210701220130.226582-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thank you Christoph for your comment, you are absolutely right, my previous
solution has not actually solved the problem... I have not know about %pg,
it is a nice feature, I hope I have used correctly!! and about div_u64 I
have found out that each time div_u64 was used the stack frame increased
dramatically, so I wrapped with a wrapper function and used the noinline
attribute, and if there is any mistakes or if i have do not something not
correct I am happy to hear them.
And I am sorry for the late respond, I was at work, delivering pizza. next
time, if you have ordered a pizza and I was the deliver, it will be on me.

Thank you again!

Kind Regards,
Abd-Alrhman,

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
---
 block/genhd.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 79aa40b4c39c..c32b7716381a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1106,6 +1106,12 @@ const struct device_type disk_type = {
 };
 
 #ifdef CONFIG_PROC_FS
+
+static noinline unsigned int call_div_u64(u64 dividend, u32 divisor)
+{
+	return (unsigned int)div_u64(dividend, divisor);
+}
+
 /*
  * aggregate disk stat collector.  Uses the same stats that the sysfs
  * entries do, above, but makes them available through one seq_file.
@@ -1117,7 +1123,6 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 {
 	struct gendisk *gp = v;
 	struct block_device *hd;
-	char buf[BDEVNAME_SIZE];
 	unsigned int inflight;
 	struct disk_stats stat;
 	unsigned long idx;
@@ -1140,40 +1145,36 @@ static int diskstats_show(struct seq_file *seqf, void *v)
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
+			   call_div_u64(stat.nsecs[STAT_READ], NSEC_PER_MSEC),
 			   stat.ios[STAT_WRITE],
 			   stat.merges[STAT_WRITE],
 			   stat.sectors[STAT_WRITE],
-			   (unsigned int)div_u64(stat.nsecs[STAT_WRITE],
-							NSEC_PER_MSEC),
+			   call_div_u64(stat.nsecs[STAT_WRITE], NSEC_PER_MSEC),
 			   inflight,
 			   jiffies_to_msecs(stat.io_ticks),
-			   (unsigned int)div_u64(stat.nsecs[STAT_READ] +
-						 stat.nsecs[STAT_WRITE] +
-						 stat.nsecs[STAT_DISCARD] +
-						 stat.nsecs[STAT_FLUSH],
-							NSEC_PER_MSEC),
+			   call_div_u64(stat.nsecs[STAT_READ] +
+					stat.nsecs[STAT_WRITE] +
+					stat.nsecs[STAT_DISCARD] +
+					stat.nsecs[STAT_FLUSH],
+					NSEC_PER_MSEC),
 			   stat.ios[STAT_DISCARD],
 			   stat.merges[STAT_DISCARD],
 			   stat.sectors[STAT_DISCARD],
-			   (unsigned int)div_u64(stat.nsecs[STAT_DISCARD],
-						 NSEC_PER_MSEC),
+			   call_div_u64(stat.nsecs[STAT_DISCARD],
+					NSEC_PER_MSEC),
 			   stat.ios[STAT_FLUSH],
-			   (unsigned int)div_u64(stat.nsecs[STAT_FLUSH],
-						 NSEC_PER_MSEC)
+			   call_div_u64(stat.nsecs[STAT_FLUSH], NSEC_PER_MSEC)
 			);
 	}
 	rcu_read_unlock();
-- 
2.29.0.rc1.dirty

