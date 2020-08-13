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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD97C433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437CE20781
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="k57WF5rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMINI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:13:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:53415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMINH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 04:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597306384;
        bh=gWwz7T1CRizqG6i6Tn6PMk/3z9b3JZhEpGV1Q8KYt4M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=k57WF5rd02LjjO8hM/oS0G4s0Qze/EyFhmdbJYcIZmhM935a1mmy2j5TK9+aKFEcu
         256mdNf9RrfkLrC42xTTzaOB09teg1HaLcns9TCmBeEvNqxcOWEh7aNAjpqOuh5HQO
         6lq99CAzGgcZCXCT5yFFpogMB9qL0ZzAtJBVXoEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls00508.pb.local ([62.217.45.26]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDywo-1jwCCy3Cw0-009vgD; Thu, 13
 Aug 2020 10:13:04 +0200
From:   Guoqing Jiang <guoqing.jiang@gmx.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     jinpu.wang@cloud.ionos.com, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V3 3/4] block: add io_extra_stats node
Date:   Thu, 13 Aug 2020 10:11:26 +0200
Message-Id: <20200813081127.4914-4-guoqing.jiang@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200813081127.4914-1-guoqing.jiang@gmx.com>
References: <20200813081127.4914-1-guoqing.jiang@gmx.com>
X-Provags-ID: V03:K1:tFpmsdkGFdO5MhuFT4wRnrAtqwTZRu49ugn4kkkh2mgyleLBDBE
 qX+/clVW1WJGXrhD8v2+Sp/U7/yKu9ZHiglAFP2GOprIh0j0bA0OrNLO1jqLjqSBT4FkoK7
 /8xX22eYlgDTB69jDBtm8GlcCN/ExwiYqaJ2JB3RHDaLS/ghNGw8NFsjiW3olK/YtpC85VR
 K4keQnJB8FVxS4YJyVSbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OE1M2yu36qc=:bKpY8hF2S1ZRwcjZfWXRCu
 oG8xmimf+1c9X2D9vYOCoy8EoY2vE9tozq0IvoMsKpleouY8n8HKxLbcKK5VVVsQN+yBgp2zB
 GO+0RXZF9OvTnB/9QCg8WcCbqezh9iXZTOzLbMZYGcIikKnc8aPurN/x3TpcC8BSQieqWDYoG
 ME+3m67odnVqmZEctIr2C36Akp+33RFY+NhWIqR47yocugq3WVpnsCZCWoosGFTaDih5yRVwK
 aurjDcd0X1sWAqVSFNWkilh1B1bv2eWg0EAYIFQSK0eZysUp4djzEc8SNQXuE/iLMZ3vqHf45
 4mqpdQu8Koog1R2WBfbxUftEX0HHM1pcMf+Qj5cRPBzzOrxNnmYGdtnFcG2uZABIrL0vvAtjo
 fJowxPYQr+H2jj5Ys3Z+7Dih1lbReWNq2nvq3KCWzFyGdotgbsD1vVTS+BeKWZMnzggTJZDMM
 uJwaH0KG+h/ofdkhLooXG5nLxlePVemJqi2shr+0H5k+ZZSi13+R9lMGhgOMGCpmIWW8DEjSS
 TrEYGsfMKNNSvDdNkxDAuzbPT9O3M52MrVndFvaXeeiHXxkoI3H3vvnTlfKFXpq28HWqM0sD6
 yZujRqKPckS2S54twbVw7JH3ZQBFkYqtU5FWlJywxrveeZzA4baj1ysSRvfumJSK44S2pfVqe
 vvpFTv1NqrNfIsUbc1jDEjr3ksrDB1JwY58RUhu2zwFvI+H1XJVXjp2bHQcp60XzQhn63P4hz
 +JDEHeowk1VSs8s/G5mkrivE5eVu8JR96QIPX9hxY2LQeImMZTG/vTzmSlKiUtfpOQIOtM6Al
 qiaSE83kC5peRpdaTGxw53hPlkPQe8cdKakkZGm7IXufQ0KfXDJele0EbbdxWszygKeNYQlw3
 +sDTVWD97POZhCaaubvUZXli0EAeCGDI+wGgGgPIPngiWEK4mQxcN3XyFyNA80q/TMC2R2RdU
 FDm6jzhOpEgzi+Yoi4JdPmBpf60aqsi4ekLJYaboylaNTkBhBMzvkFQuxh4MKCuQ9bKdUvU5m
 8PVFt0bCbio2Cz/aocrQlqvTYEu6CUkHnKhjY555XffO8sl/6pcGHsib9DZz+EfmSHrZZaTsf
 p1ijyvsbxv637EQn8EMTBbhavBKlUZZYlrC5R9zlPxi2yI9JRd8/oq3IjyHuY3sFr3nduBI3D
 iYY2gQmFy+6tucheoOj7K5ymGPYgoUryzdB/Oz3V7ZQ3835O1WAkhRXEWJ6zObwfkL7Y/kNbP
 kz/qCjiuIZCehwIjR+AWXoVcGc2jUQAoDdaiGhQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Even we have introduced a Kconfig option (default N) to control the
accounting of additional data, but the option still could be enabled
occasionally while user doesn't care about the size and latency of io,
and they could suffer from the additional overhead. So introduce a
specific sysfs node to avoid such mistake.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
=2D--
 Documentation/ABI/testing/sysfs-block | 9 +++++++++
 Documentation/block/queue-sysfs.rst   | 6 ++++++
 block/blk-sysfs.c                     | 8 ++++++++
 include/linux/blkdev.h                | 2 ++
 4 files changed, 25 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/tes=
ting/sysfs-block
index d00d940e4e1b..0f8fe43518e5 100644
=2D-- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -329,3 +329,12 @@ Description:
 		does not complete in this time then the block driver timeout
 		handler is invoked. That timeout handler can decide to retry
 		the request, to fail it or to start a device recovery strategy.
+
+What:		/sys/block/<disk>/queue/io_extra_stats
+Date:		August 2020
+Contact:	Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+Description:
+		Indicates if people want to know the extra statistics (I/O
+		size and I/O latency) from /sys/block/<disk>/io_latency
+		and /sys/block/<disk>/io_size. The value is 0 by default,
+		set if the extra statistics are needed.
diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/que=
ue-sysfs.rst
index f261a5c84170..d1055aac4c83 100644
=2D-- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -99,6 +99,12 @@ iostats (RW)
 This file is used to control (on/off) the iostats accounting of the
 disk.

+io_extra_stats (RW)
+-------------------
+This file is used to control (on/off) the additional accounting of the
+io size and io latency of disk, and BLK_ADDITIONAL_DISKSTAT should be
+enabled if you want the additional accounting.
+
 logical_block_size (RO)
 -----------------------
 This is the logical block size of the device, in bytes.
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7dda709f3ccb..93692f59d26c 100644
=2D-- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -287,6 +287,7 @@ queue_store_##name(struct request_queue *q, const char=
 *page, size_t count) \
 QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
+QUEUE_SYSFS_BIT_FNS(io_extra_stats, IO_EXTRA_STAT, 0);
 #undef QUEUE_SYSFS_BIT_FNS

 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -706,6 +707,12 @@ static struct queue_sysfs_entry queue_iostats_entry =
=3D {
 	.store =3D queue_store_iostats,
 };

+static struct queue_sysfs_entry queue_io_extra_stats_entry =3D {
+	.attr =3D {.name =3D "io_extra_stats", .mode =3D 0644 },
+	.show =3D queue_show_io_extra_stats,
+	.store =3D queue_store_io_extra_stats,
+};
+
 static struct queue_sysfs_entry queue_random_entry =3D {
 	.attr =3D {.name =3D "add_random", .mode =3D 0644 },
 	.show =3D queue_show_random,
@@ -799,6 +806,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
 	&queue_io_timeout_entry.attr,
+	&queue_io_extra_stats_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5636cc17b9..b014ab035656 100644
=2D-- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -615,6 +615,7 @@ struct request_queue {
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
+#define QUEUE_FLAG_IO_EXTRA_STAT 28	/* extra IO accounting for latency an=
d size */

 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
@@ -657,6 +658,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, st=
ruct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->que=
ue_flags)
+#define blk_queue_extra_io_stat(q) test_bit(QUEUE_FLAG_IO_EXTRA_STAT, &(q=
)->queue_flags)

 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
=2D-
2.17.1

