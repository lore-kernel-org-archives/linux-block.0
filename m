Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFEAC07E9C
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 11:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA63F61FCC
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 11:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhGFLux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbhGFLfw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 07:35:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2BC025474;
        Tue,  6 Jul 2021 04:19:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j16-20020a05600c1c10b0290204b096b0caso1988246wms.1;
        Tue, 06 Jul 2021 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBpIdd3w4EmoKqEbW/BZLpVWyxmjxkVlYmKKxNmRAGs=;
        b=N+gzKC0Z+TLx4EVOYrpeodOG9kqL2O+hnJQ+5hS8ySCTWQc6nhp5Tvn3ujyDzQAHCo
         ZWHRLJ5Ik3XlTKzgigdSPOLEK9yViA53g8RIqyyWvLJ+vM9zqu/0/PBReDvkuFKVso1B
         AGTpv6yuhdPZqRrPG5RskiMwvMXxdj4uSuFp8v9LCpQ6pRutc9e+osA7Xs2qSWBEE4dh
         h4eIODblSFMTUUI25MRMw0RopkQJyyvwBoB6iCV9bJgUtgLYD02To6H27A3ZDHDQgmYQ
         6PpEoQnFaKJfygsMIpHen2X68Xs/5ncAlvYGrsnX8CQgjIqfZtoVw7pMZe0J3ePN6jQw
         G60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBpIdd3w4EmoKqEbW/BZLpVWyxmjxkVlYmKKxNmRAGs=;
        b=XHIHlKFendywTHWO8CqNQHLGMfwvYNrT8JBNV2XVXQ8AjV49pCDcXhkMOaQbe3c82X
         gCFiwke0ArK5Ntb4GXj1FqswlvQ9TWW5hz5LuE9qqp0RphSO80F+GzU+FA3fBPAV/Py+
         7b2GuH1lmuuE7/hPlX6jBbjGKgafAovundU75mZ4FJpmjc2UIbWF7qCsGd2F0L0qGvXD
         eNXhktimO0GRrCBA+bpC6tUIdIbbPi2kZhYNoaQnu+Ufwj+We+qA6DP+FADcbWrjrdS9
         YFj8UZXHSDx19t9ZS2BNj6JHk1cm0YvZ/OeeyDOFrqb5YL5inF+wKhzbBbQgiVkRGDqZ
         j1eA==
X-Gm-Message-State: AOAM532++KNV6o3+nYAjvkknsPXa7auTnExtdokslp9rEwwZSe+duMR0
        FlzvWGsgFtU4dO7DEItA9EE=
X-Google-Smtp-Source: ABdhPJwWZW6uE+qpJMpNIRo+zpfm8e6b5TBp6hQTWoVQek+iG3AtgJH7ekQHoPlpcSLjU6msHrli5w==
X-Received: by 2002:a05:600c:2292:: with SMTP id 18mr19388741wmf.179.1625570394987;
        Tue, 06 Jul 2021 04:19:54 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id p7sm5142931wrr.21.2021.07.06.04.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 04:19:54 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, kbuild@lists.01.org, lkp@intel.com,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [PATCH v3] block: Removed a warning while compiling with a cross compiler for parisc
Date:   Tue,  6 Jul 2021 13:19:12 +0200
Message-Id: <20210706111912.97611-1-abd.masalkhi@gmail.com>
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

By Reduced the stack footprint, using new printf specifier to print the
bdevname and wrapping div_u64 function with a non-inline wrapper function,
the warning was not emitted anymore.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 block/genhd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 79aa40b4c39c..0b091f572bc5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1106,6 +1106,11 @@ const struct device_type disk_type = {
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
@@ -1117,7 +1122,6 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 {
 	struct gendisk *gp = v;
 	struct block_device *hd;
-	char buf[BDEVNAME_SIZE];
 	unsigned int inflight;
 	struct disk_stats stat;
 	unsigned long idx;
@@ -1140,40 +1144,39 @@ static int diskstats_show(struct seq_file *seqf, void *v)
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
+			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev), hd,
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

