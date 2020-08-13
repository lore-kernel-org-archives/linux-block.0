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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C38C433E1
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9884320781
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SJyHIbbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgHMIMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:12:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:38603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMIMa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 04:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597306347;
        bh=J2QczXJPuXb4+wChFwco8R2gPPHCo2yeIsRYKxjN2Q4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SJyHIbbgF9sYB4lnYbG6nObywLbRYaeTgTHlQujTpahDZ6EFBmeGCTvoVB0jZFtn/
         qQJGgahic8r3wF9QjzjAx1pp8C2pDwUKQ/QQGPSP6ZR2g+mVoKvhxTKj71aYz9ExPK
         5iBI+haf+XqmbZgAtyzmExa67U1Eqwpd2irQOeNw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls00508.pb.local ([62.217.45.26]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2mFi-1kozep11zg-0137fR; Thu, 13
 Aug 2020 10:12:27 +0200
From:   Guoqing Jiang <guoqing.jiang@gmx.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     jinpu.wang@cloud.ionos.com, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V3 1/4] block: add a statistic table for io latency
Date:   Thu, 13 Aug 2020 10:11:24 +0200
Message-Id: <20200813081127.4914-2-guoqing.jiang@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200813081127.4914-1-guoqing.jiang@gmx.com>
References: <20200813081127.4914-1-guoqing.jiang@gmx.com>
X-Provags-ID: V03:K1:cP1Am5f5M1UPj02h1fbtVJzX3eTG0nWJY58xEtwG6bFdiEY3eeA
 kuIA4js5+saY5awmZuhrc8FPgP1G3fVmhe/WECvG5L2TnyC/fdfrYg0dVsjkzcoBHQHbQjH
 fPLDEbfHmKNxOWf38LmAtzg7icQKahl9rkhRvc+7jk7LzewRAo8C3dJXKisEh+ARCT/EIMR
 2E++5UyaYkDDpQQzlINgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iGpdR71/n+Y=:njMfI17a3fkIhAkLlA9oah
 WK6pc23n9gIg0iTccreQeQZWwK6ahYl/aRoQSF8dAWP8waU8QzKyDlrxUPlt5CllqVvHCQbbT
 ULysLaYwAR/eCMHgN2143uBGZDzq3rfiQ4ONmThIGl7QVYHraDaYMnqOHZecSzXUyMbqhX6ni
 JU1ospMGRieVDEyRKrvRhlg7YprEm1/3/KSwP2loGibh/sgvQ75VCiy7Tl6s1kDVJ3+w32ckL
 tPlwxgcAj2xiAyo4ydJgTPYcniTPNNUtLZy2IAKWTRnQVl24MJbhmftDzcDPJ9RrZiRb6a0Qe
 IwUpleXlA4/yfCrHnNJvAS28N7E7IA6iEpK9pElCjq1jjLV6cKpZZPAhKGTJvOf9tSE4hhWC2
 I8bHNgl+1iRfrnJ8fEm7p9Na5KHFU957iFO91NnkiHPhkrdtufVzDyaqZudm3jcQ22Wpj6ypg
 Lm3R+vdarSefI4LW95+0BlUWLRci/0Thkk/dX7oLIWuXiStZWaSg1ZddDsJguwCzYXSUs/R5l
 6+u3ShU8PBiI3IoP7SeNddOlzdFW+zWis+VDpgAsAngfmSf9JbZyo9ia4xP1pVf2dgUm4cCNS
 vyiJdDLw2xpcwRbOBuL10MrOKqqcMfjp/3CaziZI/Ajm+CNAUXgd5m6nQcFOX6w8D9M6h+n+l
 WI3BSr2sloa86NEUkBCosO651pNkl1FcuisApQHzfILPZO2ZtCFBV5KF0D43vphDSxzoTM9/i
 N+IS2HoIOKx5Z0DlNg0GhNqsIg/N0O00erObebXPrV1/L6i4gn0VB3PTIlucMIGMM9sQK0TzQ
 cODYlVdgBc5AxfxD1Ct/QQSCnkNu+GSnlGpEIUlv/pViXvk9esGhz043brKw7idA8+wEVByDW
 PaRqi+K7HCi8Zs+a3qpdXAWFaqoYHexDwkZvcJkIebwYE4acyNnOM1vwbFzkOxqzhC27/O8oD
 dI9yQ6srj4BLqYBT9Ci957lDuUcmSrQCcD0Fsb+iQsWfDQHFAKxSoVpdaH7H9KN32aTh8g+aE
 5CSb4lwRe/qh1DCLfomlMAdvtKyW1cPNHFyOfG3qMkn+fZQoeYN3IHkGC+1wJytGM50KpZqfk
 v9yJCaWwihG+MUUQNLtOlDo+kGUtASoNhiMxqhyhKvPhY8GD2l89SmAEoz2IXRtzD+aaVPwfQ
 jsP0vu7UKippt5TY+EpWrynOkTBHBJBRzSbqYZXFZZeMbLUkaETafBqa1ATJ466qPWpDRZnyQ
 s198xKBRlS3d0crz6fpdvNSHRdplEVB3HFFNmjg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Usually, we get the status of block device by cat stat file, but we can
only know the total time with that file. And we would like to know more
accurate statistic, such as each latency range, which helps people to
diagnose if there is issue about the hardware.

Also a new config option is introduced to control if people want to know
the additional statistics or not, and we use the option for io sector in
next patch.

This change is based on our internal patch from Florian-Ewald Mueller
(florian-ewald.mueller@cloud.ionos.com).

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
=2D--
 Documentation/ABI/testing/sysfs-block |  8 ++++++
 block/Kconfig                         |  8 ++++++
 block/blk-core.c                      | 29 +++++++++++++++++++
 block/genhd.c                         | 41 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  7 +++++
 5 files changed, 93 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/tes=
ting/sysfs-block
index 2322eb748b38..1bae82238a79 100644
=2D-- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -23,6 +23,14 @@ Description:
 		17 - time spent flushing (ms)
 		For more details refer Documentation/admin-guide/iostats.rst

+What:		/sys/block/<disk>/io_latency
+Date:		August 2020
+Contact:	Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+Description:
+		The /sys/block/<disk>/io_latency files displays the I/O
+		latency of disk <disk>. With it, it is convenient to know
+		the statistics of I/O latency for each type (read, write,
+		discard and flush)which have happened to the disk.

 What:		/sys/block/<disk>/<part>/stat
 Date:		February 2008
diff --git a/block/Kconfig b/block/Kconfig
index bbad5e8bbffe..360f63111e2d 100644
=2D-- a/block/Kconfig
+++ b/block/Kconfig
@@ -176,6 +176,14 @@ config BLK_DEBUG_FS
 	Unless you are building a kernel for a tiny system, you should
 	say Y here.

+config BLK_ADDITIONAL_DISKSTAT
+	bool "Block layer additional diskstat"
+	default n
+	help
+	Enabling this option adds io latency statistics for each block device.
+
+	If unsure, say N.
+
 config BLK_DEBUG_FS_ZONED
        bool
        default BLK_DEBUG_FS && BLK_DEV_ZONED
diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639bd1..fa339e0cc38a 100644
=2D-- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1411,6 +1411,33 @@ static void update_io_ticks(struct hd_struct *part,=
 unsigned long now, bool end)
 	}
 }

+/*
+ * Either account additional stat for request if req is not NULL or accou=
nt for bio.
+ */
+static void blk_additional_latency(struct hd_struct *part, const int sgrp=
,
+				   struct request *req, unsigned long start_jiffies)
+{
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	unsigned int idx;
+	unsigned long duration, now =3D READ_ONCE(jiffies);
+
+	if (req)
+		duration =3D jiffies_to_nsecs(now) - req->start_time_ns;
+	else
+		duration =3D jiffies_to_nsecs(now - start_jiffies);
+
+	duration /=3D NSEC_PER_MSEC;
+	duration /=3D HZ_TO_MSEC_NUM;
+	if (likely(duration > 0)) {
+		idx =3D ilog2(duration);
+		if (idx > ADD_STAT_NUM - 1)
+			idx =3D ADD_STAT_NUM - 1;
+	} else
+		idx =3D 0;
+	part_stat_inc(part, latency_table[idx][sgrp]);
+#endif
+}
+
 static void blk_account_io_completion(struct request *req, unsigned int b=
ytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
@@ -1440,6 +1467,7 @@ void blk_account_io_done(struct request *req, u64 no=
w)
 		part =3D req->part;

 		update_io_ticks(part, jiffies, true);
+		blk_additional_latency(part, sgrp, req, 0);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1488,6 +1516,7 @@ void disk_end_io_acct(struct gendisk *disk, unsigned=
 int op,

 	part_stat_lock();
 	update_io_ticks(part, now, true);
+	blk_additional_latency(part, sgrp, NULL, start_time);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c314..21a3dae6a024 100644
=2D-- a/block/genhd.c
+++ b/block/genhd.c
@@ -1418,6 +1418,44 @@ static struct device_attribute dev_attr_fail_timeou=
t =3D
 	__ATTR(io-timeout-fail, 0644, part_timeout_show, part_timeout_store);
 #endif

+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+static ssize_t io_latency_show(struct device *dev, struct device_attribut=
e *attr, char *buf)
+{
+	struct hd_struct *p =3D dev_to_part(dev);
+	size_t count =3D 0;
+	int i, sgrp;
+
+	for (i =3D 0; i < ADD_STAT_NUM; i++) {
+		unsigned int from, to;
+
+		if (i =3D=3D ADD_STAT_NUM - 1) {
+			count +=3D scnprintf(buf + count, PAGE_SIZE - count, "      >=3D %5d  =
ms: ",
+					   (2 << (i - 2)) * HZ_TO_MSEC_NUM);
+		} else {
+			if (i < 2) {
+				from =3D i;
+				to =3D i + 1;
+			} else {
+				from =3D 2 << (i - 2);
+				to =3D 2 << (i - 1);
+			}
+			count +=3D scnprintf(buf + count, PAGE_SIZE - count, "[%5d - %-5d) ms:=
 ",
+					   from * HZ_TO_MSEC_NUM, to * HZ_TO_MSEC_NUM);
+		}
+
+		for (sgrp =3D 0; sgrp < NR_STAT_GROUPS; sgrp++)
+			count +=3D scnprintf(buf + count, PAGE_SIZE - count, "%lu ",
+					   part_stat_read(p, latency_table[i][sgrp]));
+		count +=3D scnprintf(buf + count, PAGE_SIZE - count, "\n");
+	}
+
+	return count;
+}
+
+static struct device_attribute dev_attr_io_latency =3D
+	__ATTR(io_latency, 0444, io_latency_show, NULL);
+#endif
+
 static struct attribute *disk_attrs[] =3D {
 	&dev_attr_range.attr,
 	&dev_attr_ext_range.attr,
@@ -1436,6 +1474,9 @@ static struct attribute *disk_attrs[] =3D {
 #endif
 #ifdef CONFIG_FAIL_IO_TIMEOUT
 	&dev_attr_fail_timeout.attr,
+#endif
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	&dev_attr_io_latency.attr,
 #endif
 	NULL
 };
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 24125778ef3e..fe3def8c69d7 100644
=2D-- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -9,6 +9,13 @@ struct disk_stats {
 	unsigned long sectors[NR_STAT_GROUPS];
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+/*
+ * We measure latency (ms) for 1, 2, ..., 1024 and >=3D1024.
+ */
+#define ADD_STAT_NUM	12
+	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
+#endif
 	unsigned long io_ticks;
 	local_t in_flight[2];
 };
=2D-
2.17.1

