Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410985;
	b=F+O2eDSgl2vw2AibEROdfjN81WTQVVnvcwySstFMU37vfaSBXqDUTZ5wzYwddfdZoJ/+
	 BFOVK/lkNwCz8qSTc6OsdfA4/Ovji6iunzI/jvhvb5C3/pCI1C7HaR1+bl1RJfLT92N1e
	 w/xTPqEWfWE9k3MnLiMg9rbZX97SKzUy/A54mFTR2v31aHyJa+moXtAKMvmQ0AKzIDZ6p
	 oWOc4pUFqi9YfXIM8SQAT4iJvCA6+F+88JbpNOzgrGNMtk2V8USgca8x9jsvytr4SP4Ms
	 pAY3Cq1jzoqGw6KNWswZ1fjaJx+MVbalT90HFq3VqyT6g2UOw48e0Bdf1u+j1qYh4mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410985;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:In-Reply-To:X-CPGS-Detection:X-Drm-Type:
	 X-Msg-Generator:X-Msg-Type:X-Reply-Demand:Message-ID:Date:
	 X-CMS-MailID:Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:
	 CMS-TYPE:X-CPGSPASS:X-CPGSPASS:cpgsPolicy:X-CFilter-Loop:
	 X-CMS-RootMailID:References;
	bh=r5Z6BlcBuMGN6YcRZqc0PnW/X18q5FAHDnfGNUaecNY=;
	b=suhgBl1/EdGnSL3R1kcQJlnfl4zDpeUiyZgmDi57I4zGRE+Jyc5PZJG5TubwI/Ryv0Bj
	 axkY64Z+fmvkjCMsUsnpX8H+8EU2vHKM/+oUZrxP2V9HjMTZKLPTYLvj6AdjAl8QlmZF0
	 V0spfdh94c2BoON9LUrva7tecwTrjgDNZGdH55MiA/s+APWD1MIepW/Xi+oS7IafmnvSi
	 P11FTADdrEHLI/QGYwemrHMa8UBU8K7Z0Qy1k9rUR8e6fiSKkqkGG5yufh1DpCA6aS7YV
	 co53KKsELxri6TBv59lcz8hkgTgKQk0Q55Rj7M6NvUg4CYC+xKzDGzBHwRrv3fBKyYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="rKiR/444";
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1C606A31F
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 05:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF1C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rKiR/444
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261123051622epoutp04d67a969aa3ed5a99d207e4060a89577b~qlMa5rjTI2003320033epoutp04M
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 05:16:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261123051622epoutp04d67a969aa3ed5a99d207e4060a89577b~qlMa5rjTI2003320033epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795410982;
	bh=r5Z6BlcBuMGN6YcRZqc0PnW/X18q5FAHDnfGNUaecNY=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=rKiR/444DeEpMhCliz9Wt9Zd3MNFpL9TbmEbYsKvQ1nTg2ai/Itxa0jE3eBx/qpbm
	 0tRFzvRlv5e+EYBqfBAYeFb/vCXnV4n9p9b3Vn7JqBOvJNQe53HiSe8ITj+ykMpm36
	 OT9mv4P4Fx34IQKgkdQ41AONK4IuZz4mmVhnNXaQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20261123051622epcas2p28ce34ddbddc2dd758bfdeb29de21e853~qlMaUwYtd1102411024epcas2p2T;
	Mon, 23 Nov 2026 05:16:22 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.205]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jXvLF42jKz6B9mH; Mon, 23 Nov
	2026 05:16:21 +0000 (GMT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: [RFC PATCH RESEND 1/3] block: distinguish unspecified and explicit
 device-default write streams
Reply-To: suho.son@samsung.com
Sender: Suho Son <suho.son@samsung.com>
From: Suho Son <suho.son@samsung.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "tj@kernel.org" <tj@kernel.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "io-uring@vger.kernel.org"
	<io-uring@vger.kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ngeol564@gmail.com" <ngeol564@gmail.com>,
	KiYoung Lee <kiyoung77.lee@samsung.com>, JinHeon Kim
	<jinheon09.kim@samsung.com>, Suho Son <suho.son@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261123051521epcms2p2445107f926f3acaa2d51c5e12abea90e@epcms2p2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261123051620epcms2p77535b9a42e657932e12f3367f98344a3@epcms2p7>
Date: Mon, 23 Nov 2026 14:16:20 +0900
X-CMS-MailID: 20261123051620epcms2p77535b9a42e657932e12f3367f98344a3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261123051521epcms2p2445107f926f3acaa2d51c5e12abea90e
References: <20261123051521epcms2p2445107f926f3acaa2d51c5e12abea90e@epcms2p2>
	<CGME20261123051521epcms2p2445107f926f3acaa2d51c5e12abea90e@epcms2p7>

From: Suho Son <suho.son@samsung.com>

bio->bi_write_stream uses zero to mean two different things: "the
issuer did not express a stream" and "place this write in the
device-default stream".  With the io_uring per-I/O attribute and the
inode write hint as the only producers this conflation is harmless,
but it prevents a later, lower-precedence producer from telling
whether a stream was requested at all.

Introduce WRITE_STREAM_NONE ((u8)-1) as the "unset" sentinel and
initialize bios with it in bio_init()/bio_reset().  Resolve any
residual sentinel to the device default (0) in
submit_bio_noacct_nocheck(), before the bio can be turned into a
request or merged, so drivers never observe the sentinel regardless
of kernel configuration.

In blkdev_direct_IO(), keep the existing precedence and add the
missing distinction: a concrete stream is validated against the
device limit; otherwise the inode write hint is used if it was
actually set (WRITE_LIFE_NOT_SET no longer maps to stream 0);
otherwise the sentinel is left for later resolution.

Also carry ki_write_stream through kiocb_clone(), which is used by
forwarded direct I/O (fs/backing-file.c, fs/erofs/ishare.c), so a
clone does not silently drop the issuer's stream selection.

No driver changes: NVMe converts bi_write_stream to FDP placement
identifiers as before.

Signed-off-by: Suho Son <suho.son@samsung.com>
---
 block/bio.c               |  3 ++-
 block/blk-core.c          | 12 ++++++++++++
 block/fops.c              | 25 +++++++++++++++++++------
 include/linux/blk_types.h | 13 +++++++++++++
 include/linux/fs.h        | 11 ++++++++++-
 5 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b0fcc69de6535..0fbf0dfefe85c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -223,7 +223,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_flags = 0;
 	bio->bi_ioprio = 0;
 	bio->bi_write_hint = 0;
-	bio->bi_write_stream = 0;
+	bio->bi_write_stream = WRITE_STREAM_NONE;
 	bio->bi_status = 0;
 	bio->bi_bvec_gap_bit = 0;
 	bio->bi_iter.bi_sector = 0;
@@ -278,6 +278,7 @@ void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf)
 	bio_uninit(bio);
 	memset(bio, 0, BIO_RESET_BYTES);
 	atomic_set(&bio->__bi_remaining, 1);
+	bio->bi_write_stream = WRITE_STREAM_NONE;
 	bio->bi_io_vec = bv;
 	bio->bi_bdev = bdev;
 	if (bio->bi_bdev)
diff --git a/block/blk-core.c b/block/blk-core.c
index 2ee079c1ce150..5054a6e21020c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -765,6 +765,18 @@ void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 
 	blk_cgroup_bio_start(bio);
 
+	/*
+	 * Resolve the write-stream sentinel before the bio can be turned into
+	 * a request or merged. By now every higher-precedence producer has had
+	 * its chance (an io_uring per-I/O attribute at init time, io.stream via
+	 * bio_set_ioprio()); a field still holding WRITE_STREAM_NONE expressed
+	 * no stream, so it falls back to the device default (0). This is the
+	 * single point that guarantees the sentinel never reaches the driver,
+	 * independent of CONFIG_BLK_CGROUP_IOSTREAM.
+	 */
+	if (bio->bi_write_stream == WRITE_STREAM_NONE)
+		bio->bi_write_stream = 0;
+
 	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
 		trace_block_bio_queue(bio);
 		/*
diff --git a/block/fops.c b/block/fops.c
index a0ccadaa9c79d..4dab46da49032 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -417,20 +417,33 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (iov_iter_rw(iter) == WRITE) {
 		u16 max_write_streams = bdev_max_write_streams(bdev);
 
-		if (iocb->ki_write_stream) {
+		if (iocb->ki_write_stream &&
+		    iocb->ki_write_stream != WRITE_STREAM_NONE) {
 			if (iocb->ki_write_stream > max_write_streams)
 				return -EINVAL;
-		} else if (max_write_streams) {
+		} else if (max_write_streams &&
+			   !(iocb->ki_flags & IOCB_WRITE_STREAM_EXPLICIT)) {
 			enum rw_hint write_hint =
 				file_inode(iocb->ki_filp)->i_write_hint;
 
 			/*
-			 * Just use the write hint as write stream for block
-			 * device writes.  This assumes no file system is
-			 * mounted that would use the streams differently.
+			 * No concrete stream was expressed on this I/O and
+			 * the issuer did not request the device default
+			 * explicitly either (in which case the concrete
+			 * stream 0 is kept so neither the inode write hint
+			 * nor a cgroup io.stream value applies). Use the
+			 * inode write hint as the write stream for block
+			 * device writes (this assumes no file system is
+			 * mounted that would use the streams differently);
+			 * otherwise leave the field as WRITE_STREAM_NONE so a
+			 * lower-precedence producer (io.stream) can fill it
+			 * in at submit time.
 			 */
-			if (write_hint <= max_write_streams)
+			if (write_hint != WRITE_LIFE_NOT_SET &&
+			    write_hint <= max_write_streams)
 				iocb->ki_write_stream = write_hint;
+			else
+				iocb->ki_write_stream = WRITE_STREAM_NONE;
 		}
 	}
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1a5812fa40529..016707437702f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -203,6 +203,19 @@ typedef __u32 __bitwise blk_opf_t;
 typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE		-1U
 
+/*
+ * Sentinel value for bi_write_stream / ki_write_stream meaning "no write
+ * stream expressed". Distinguished from an explicit request for the
+ * device-default stream (0): a concrete stream set by an issuer (e.g. an
+ * io_uring per-I/O write attribute) always wins, while a field still holding
+ * WRITE_STREAM_NONE lets a lower-precedence producer (io.stream) fill it in.
+ * The submit path converts any residual WRITE_STREAM_NONE to 0 before the bio
+ * reaches the driver. Both fields are u8, so the sentinel is (u8)-1 = 255;
+ * kernel interfaces limit selectable stream identifiers to 0..254, so the
+ * sentinel never collides with a stream an issuer can request.
+ */
+#define WRITE_STREAM_NONE	((u8)-1)
+
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c4..e796a1858e187 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -357,6 +357,13 @@ struct readahead_control;
 /* kiocb is a read or write operation submitted by fs/aio.c. */
 #define IOCB_AIO_RW		(1 << 22)
 #define IOCB_HAS_METADATA	(1 << 23)
+/*
+ * The issuer explicitly requested the device-default write stream
+ * (IORING_WRITE_STREAM_DEFAULT in the io_uring SQE): ki_write_stream
+ * holds a concrete 0 and must not be overridden by the inode write hint
+ * or a cgroup io.stream value.
+ */
+#define IOCB_WRITE_STREAM_EXPLICIT	BIT(24)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
@@ -374,7 +381,8 @@ struct readahead_control;
 	{ IOCB_NOIO,		"NOIO" }, \
 	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
 	{ IOCB_AIO_RW,		"AIO_RW" }, \
-	{ IOCB_HAS_METADATA,	"AIO_HAS_METADATA" }
+	{ IOCB_HAS_METADATA,	"AIO_HAS_METADATA" }, \
+	{ IOCB_WRITE_STREAM_EXPLICIT, "WRITE_STREAM_EXPLICIT" }
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -2202,6 +2210,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 		.ki_filp = filp,
 		.ki_flags = kiocb_src->ki_flags,
 		.ki_ioprio = kiocb_src->ki_ioprio,
+		.ki_write_stream = kiocb_src->ki_write_stream,
 		.ki_pos = kiocb_src->ki_pos,
 	};
 }
-- 
2.43.0

