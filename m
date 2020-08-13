Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B9C433E1
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9C220781
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OGO4zZY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMIMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:12:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:53201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMIMs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 04:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597306365;
        bh=+ZfYF5wH6iV2bU1406LUOwiOnEnxlYXlEbgh7Ubh++g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OGO4zZY56VV6n/5ZrRAPIOMDziskVEfqjeByNqvpJ8Bnxp8v0B+B12aKPV0gKHz1J
         0mqDOOuzCf3csytq5f9AmXg4PwsKGGawRcwI/2ydZEdWo6Xu1ky3wMOJ8lsX2d9SOX
         RJqSPfBbXyEtdJt9v8cY+j8jenWPM1Q8W2BKo71E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls00508.pb.local ([62.217.45.26]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmlXA-1kVo7P2pvS-00jof9; Thu, 13
 Aug 2020 10:12:45 +0200
From:   Guoqing Jiang <guoqing.jiang@gmx.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     jinpu.wang@cloud.ionos.com, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V3 2/4] block: add a statistic table for io sector
Date:   Thu, 13 Aug 2020 10:11:25 +0200
Message-Id: <20200813081127.4914-3-guoqing.jiang@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200813081127.4914-1-guoqing.jiang@gmx.com>
References: <20200813081127.4914-1-guoqing.jiang@gmx.com>
X-Provags-ID: V03:K1:v/sJJruaf2OodJU3df2w6Inx5ZxTlEa4F8GwBncT0qJeZom6YFA
 95t6v/fUklzJWwBqtMqYFtrHBC1G2qAhwoUfU5c0vjF8poqoeAj1wgEww9ZxsJzwC50u6Yl
 jEMTt9/XNirMI7tmu9YC0e5K/0q1H7aTk1xOYMDd3yzb4GOIGdX7xJ4q4CqFyAmm0qFXhej
 /zWFoKLie9XXvlie3TrYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G+JMFj2N+Dc=:n2Xu7z6QgDJCwY+iYTgmMJ
 0wHcnr+5bwK/t7tsBsDSw03jP8k+9Nayj0EmLCDgCdTFMCFC7rZVzr8wJTuR1EGHM37jjvjar
 Rr7D7RSYotSBydIV2zLuXyp0onLTSM//p+sho7qZ13wNQGfUhLttiOWLkJWNSUs5d8LAEobo1
 VW4sy93ew1oaaZecfTkH9KbOeBjibXdBFNqUbSsPpkpGW80g+8dGBorEg6YSKbpAiK1A6VHDP
 HfZeYSKKM6XBhQ8yMfrroO5ADQEFhTh3Umev/jADI6gn7HWpVk4VNfPrXYcXQ6aBObS+koy3M
 psNcLFAN27FtLNtFGGQ0rTiBZQ/ZMTV+1BW1HTaehy4u10LM1GgazUP/+qAeND3Lh/TQoREvf
 c799WZ5Y8cXbpfbWaHmxPPCCYvIoe/aQ5/H3Ku9OuOUUZfUg4peplNxpLF38dVoNpmlUshWGc
 ms/toExOiSWT3uRpi2Wi6YHCaKIcVyNlenKaLB8Gu6WOyYQJem2T34lgfHFDMcbseQoEjLaT8
 7y5ihCvYeGMmrqClPGjFjzm7p46P2fq65njeqPb1fnh5RmQCDPATHN/ohANjXui1EP5tHvsA2
 103R7+wnoAxHRqF4A+kk0yqzdz1R+UvS2Cw78DEgfXFSiwOJgn07WDQjVBFfLQewwoBioZfLI
 RhAMi8jtuNFMqkK20MsLVW0TmktGUsub3Cp458w420hFcYPFZp0oJSZ2mGXsmjin71TDbmiTp
 7JMLzBMutsBtIl1muHCh8aYgjHYfv14mNSCUygHU6qDuL9F7W04TN519iVT5IFVQtVdZkW+GT
 ohY2GZZWbOxrsC8RqgxnwexpeDobjSA5ipRT5TJXeZu0gzSTK9z/uwJjqBcsm79GITPk7RncK
 ZkEQris62L7XXG1P79BnWy2LfFPApqAha2g5hehFsKpz57j2fAQ4BDJnCoRX74NYTH8eEZB3b
 7Qm/LpKAZ9z/mampiWH6daMnNOkbwyvNG7q8vKJw/YyT359EKPK5Nch5cxSEsUrkRGaWae5st
 zbigjBfzWmp84akIghuD7CFPmJeHV4bZ+3/gbEG6NKKG2Llh/CON4MbMxXX9uLZ4Yk2eFCkCE
 3doXhFW5YOyucDd0Zk1JiKFgjolsxgldz9Vu1ZCPVhivOuhHhVMu55mGPMay6fWankunjXG3P
 KZU4Hncg2s4ddDMvO2tXcqDqnY3f8UBJLgbnXV0y7lubNqOYIZh87NDVJLUJpgMFHjTpHJStL
 PqcZYKTY9/v/BOI849H/GC98j+bMID9neWcc4yQ9/DYjgBIW6zfyATU43uccQwI7YDhuBXy6+
 GhYkPQiYIMdUwYjiP7wUnzEe0BQz2Tq+hFyrWIb2ZzekLAX1IogTr23KHZBOB1lEAQKLXiVk5
 9C81y04FeJ5niFKBolnSAcQ/sY7OGCG+ZTK3xBFKyu5AxvMaN4jrYhkg/DGJCNjuPZOOyBPZI
 9Yl8G8wYeVDoWT4TRolqYEeKCjnQGSjdlu3y+EpL3e/0od3DpzueQnnUpXrWX0E3x5A3cjceH
 XMZqqUhA+32q+vkbT5YjE9kLmww3XZnjy/Y3wACovq8on
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

With the sector table, so we can know the distribution of different IO
size from upper layer, which means we could have the opportunity to tune
the performance based on the mostly issued IOs.

This change is based on our internal patch from Florian-Ewald Mueller
(florian-ewald.mueller@cloud.ionos.com).

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
=2D--
 Documentation/ABI/testing/sysfs-block |  9 +++++++
 block/Kconfig                         |  3 ++-
 block/blk-core.c                      | 18 +++++++++++++
 block/genhd.c                         | 37 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  3 ++-
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/tes=
ting/sysfs-block
index 1bae82238a79..d00d940e4e1b 100644
=2D-- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -32,6 +32,15 @@ Description:
 		the statistics of I/O latency for each type (read, write,
 		discard and flush)which have happened to the disk.

+What:		/sys/block/<disk>/io_size
+Date:		August 2020
+Contact:	Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+Description:
+		The /sys/block/<disk>/io_size files displays the I/O
+		size of disk <disk>. With it, it is convenient to know
+		the statistics of I/O size for each type (read, write,
+		discard and flush) which have happened to the disk.
+
 What:		/sys/block/<disk>/<part>/stat
 Date:		February 2008
 Contact:	Jerome Marchand <jmarchan@redhat.com>
diff --git a/block/Kconfig b/block/Kconfig
index 360f63111e2d..c9b9f99152d8 100644
=2D-- a/block/Kconfig
+++ b/block/Kconfig
@@ -180,7 +180,8 @@ config BLK_ADDITIONAL_DISKSTAT
 	bool "Block layer additional diskstat"
 	default n
 	help
-	Enabling this option adds io latency statistics for each block device.
+	Enabling this option adds io latency and io size statistics for each
+	block device.

 	If unsure, say N.

diff --git a/block/blk-core.c b/block/blk-core.c
index fa339e0cc38a..1a8e508516c9 100644
=2D-- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1438,6 +1438,22 @@ static void blk_additional_latency(struct hd_struct=
 *part, const int sgrp,
 #endif
 }

+static void blk_additional_sector(struct hd_struct *part, const int sgrp,
+				  unsigned int sectors)
+{
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	unsigned int idx;
+
+	if (sectors =3D=3D 1)
+		idx =3D 0;
+	else
+		idx =3D ilog2(sectors);
+
+	idx =3D (idx > (ADD_STAT_NUM - 1)) ? (ADD_STAT_NUM - 1) : idx;
+	part_stat_inc(part, size_table[idx][sgrp]);
+#endif
+}
+
 static void blk_account_io_completion(struct request *req, unsigned int b=
ytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
@@ -1446,6 +1462,7 @@ static void blk_account_io_completion(struct request=
 *req, unsigned int bytes)

 		part_stat_lock();
 		part =3D req->part;
+		blk_additional_sector(part, sgrp, bytes >> SECTOR_SHIFT);
 		part_stat_add(part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1499,6 +1516,7 @@ unsigned long disk_start_io_acct(struct gendisk *dis=
k, unsigned int sectors,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
+	blk_additional_sector(part, sgrp, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();

diff --git a/block/genhd.c b/block/genhd.c
index 21a3dae6a024..38517b86a968 100644
=2D-- a/block/genhd.c
+++ b/block/genhd.c
@@ -1454,6 +1454,42 @@ static ssize_t io_latency_show(struct device *dev, =
struct device_attribute *attr

 static struct device_attribute dev_attr_io_latency =3D
 	__ATTR(io_latency, 0444, io_latency_show, NULL);
+
+static ssize_t io_size_show(struct device *dev, struct device_attribute *=
attr, char *buf)
+{
+	struct hd_struct *p =3D dev_to_part(dev);
+	size_t count =3D 0;
+	int i, sgrp;
+
+	for (i =3D 0; i < ADD_STAT_NUM; i++) {
+		unsigned int from, to;
+
+		if (i =3D=3D ADD_STAT_NUM - 1) {
+			from =3D 2 << (i - 2);
+			count +=3D scnprintf(buf + count, PAGE_SIZE - count,
+					   "      >=3D%5d   KB: ", from);
+		} else {
+			if (i < 2) {
+				from =3D i;
+				to =3D i + 1;
+			} else {
+				from =3D 2 << (i - 2);
+				to =3D 2 << (i - 1);
+			}
+			count +=3D scnprintf(buf + count, PAGE_SIZE - count,
+					   "[%5d - %-5d) KB: ", from, to);
+		}
+		for (sgrp =3D 0; sgrp < NR_STAT_GROUPS; sgrp++)
+			count +=3D scnprintf(buf + count, PAGE_SIZE - count, "%lu ",
+					   part_stat_read(p, size_table[i][sgrp]));
+		count +=3D scnprintf(buf + count, PAGE_SIZE - count, "\n");
+	}
+
+	return count;
+}
+
+static struct device_attribute dev_attr_io_size =3D
+	__ATTR(io_size, 0444, io_size_show, NULL);
 #endif

 static struct attribute *disk_attrs[] =3D {
@@ -1477,6 +1513,7 @@ static struct attribute *disk_attrs[] =3D {
 #endif
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
 	&dev_attr_io_latency.attr,
+	&dev_attr_io_size.attr,
 #endif
 	NULL
 };
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index fe3def8c69d7..f23c367ea646 100644
=2D-- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -11,10 +11,11 @@ struct disk_stats {
 	unsigned long merges[NR_STAT_GROUPS];
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
 /*
- * We measure latency (ms) for 1, 2, ..., 1024 and >=3D1024.
+ * We measure latency (ms) and size (KB) for 1, 2, ..., 1024 and >=3D1024=
.
  */
 #define ADD_STAT_NUM	12
 	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
+	unsigned long size_table[ADD_STAT_NUM][NR_STAT_GROUPS];
 #endif
 	unsigned long io_ticks;
 	local_t in_flight[2];
=2D-
2.17.1

