Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A25382299;
	Fri,  4 Sep 2026 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514379; cv=none; b=f01p1LLMoIbhtWLQVPeOeP66gQGwcfqSTpoiuSJmrFOqeP3Ma8hqJcWxS3O3uT9J2pH467nXFSKJWWLCIZzgADLP+Wm4X+UgasotHDZ9JUaroavJIcMGlbsCwl09FLdPRqq07pE9HcL5C8pQpR1R4yf8qpZqCwEZAXlNVzv6mEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514379; c=relaxed/simple;
	bh=2pyPVKp38UMdwJMmglsearybtZGlT08TQCtnZBASEPc=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=kCxbF0Mtmg8h1i1ByxZfIWPOvP2InuNczPshjehgJVNB3DaAOYOz4s1pjPOhkPU/nxhHqcFWJvYd1DPkxeS29Xvam99vt4JgIprAhWmRrsoxAwCOsIKX2BR43CYjE2FacjGfjCB/wB916TrbJ0u/3m6dEHw42mZe6oEYeF9kROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O9xwlKPh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9xwlKPh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 46334EC008F;
	Fri,  4 Sep 2026 05:32:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 04 Sep 2026 05:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514377; x=
	1788600777; bh=5vdrbn+T43CZpZXYEaWsMOzKdGDNT+c/uB7d2c8BDu4=; b=O
	9xwlKPhda2y9ql+m395qSIakgBLkyLnv+l459r1PRyAhgbao4bvFzQJQu4C2kwW8
	b113CDBLseg/bWlaKiG/qSsSS+yJTVwB66hpNiQcvM23Ky8/ZnXfPHixAZk49uo/
	1OKCkkVUYaIzFrHgZGzH44b+Eok6k+vHqbEZeqD8Msr7aFMjLqaTCXf2zdya259z
	2yvR97IvWwuN9dsniwEwPKc3NJPf+koh30T22vXZkuKCxKrZ283IhL/ineFxBmj5
	BKlXXJEfGxBkzf8A8URmpiloNNVYolyTPUTYLmPNu+BoPy9/Wi4cUsQSLZ1QRjFF
	B4NqxmUuFtuPRFS4FfGaA==
X-ME-Sender: <xms:SZCaahHgNwzM_z1sgh9QLO7qHmhr22yBAUId0p3cl-535D6TB4Y9vQ>
    <xme:SZCaagYNEwckN3MtcHiWC7vC-wWOgr6Y2mbAMZJhbjHDw55KQ_kFoHlDdms7k1CDu
    hl-KFUkYimPstiYMNHjNEiYvxVBVCEa_cjI4u10GOqAVKE3mA_oAjEX>
X-ME-Received: <xmr:SZCaajBLMspcUm5i46aey7y3W6uEEB4k-1t374FnTX05sqdA1KpG66dH1SUgih7LN_TBQOphjYce0AlMQZ0JPcEh7F9pAxE03xw>
X-ME-Proxy-Cause: dmFkZTF3auZDjEg8eBmaXoTiNUJDm36RpkU4OxNFVDzQbhXoFzPOd3Tywmiq9TcLhKbpyz
    RtcGsroltMWANqUKCBzA6jAZ/q6gwveBRqnbifBxBFmnUcKWRgTVt+8JgUfvW63RYwPFMX
    rQCMFgYat6SS5wSRSSuueIm+gtTMdXWEQ9JvjvwnVdqT7PvvrwtNrG6ptAh1E18JsFlUOU
    FY+OqaHaH+nKcgRcnMziwPz9yDlE96QQVIMo7+0M2GINxA5LefOsEBPICH+QVll4DUoBax
    jPX+GU5ty42mRSGbQYM10LF3CaX+omFSKyOeAaAbIoNGHhwVd91Wfn6+YFLGNdELAmbsZU
    FpNB2ppgyUFZD92QKOymv6jrHe9BBMzUzrzTpn473sL+yhlxNHHlWfLREpq8Np41dGqMRS
    4JCE6HR+GY/j0946JTWanXu0+5C0/nGjuTIdCqG5Tr5eGxdKTJtK+PEPLzYatCstNHpxqJ
    e1NnUK+wIVm2++mi8cmfqvCQdrdklu203/hoIVQORYfyBM8OwleIiC4zPTEISZJNnnB2sk
    dwrXUlJu2tt2ChBgkqfIMBpzL/xV4BJ7eNP/wY6vVqWwAij5fpnNm/1BC60WTEUbABq3A5
    cC8KrmMEKXXGd7Umj7KxUH8zX+ZZtsenHtMgVIAkIeAPitW4H6N0Cs2T3aCw
X-ME-Proxy: <xmx:SZCaaokeoMXdwF345FX7iMN0-X2msVhs9azQMCXRlezG3afYOUcM1g>
    <xmx:SZCaakzUdIhmE8vW8qrQ0yLH8v83Z3r-kquBBDajmiGzjFAcGXhIAA>
    <xmx:SZCaaiTKcyNDAnk2Vt4KMp9dP9aFjfMMMX4eOnwz0H01jtzwJ3RY6Q>
    <xmx:SZCaas_3V9mbVX5wu3uPAqvxQIKkywxP0aiLN2w-WM4DzPu9c0ztZw>
    <xmx:SZCaaj0c_k0Z_kU36Ru2hUSV2DPZf6P-pz4_6AqOK01M5P4HSciwuqDM>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:32:55 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <119e799afcc00d6bd4a479c31e0c960cb1a1d71b.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 10/33] swim: Recalibrate when drive is probed
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Track zero recalibration can be slow and is normally done only once i.e.
during system POST or boot-up. Recalibrate once after the drive is probed
rather than every time the device is opened. Don't register the drive if
recalibration fails. Park the heads before ejecting.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Refactor swim_add_floppy() slightly. Start spindle motor before
   recalibration if a disk is loaded.
 - Change return type of swim_add_floppy() to void.
 - Park heads at track 40 because that's what MacOS does.

Changed since v2:
 - Dropped reviewed-by tag due to unreviewed changes made since v1.
---
 drivers/block/swim.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 64073e8f6c36..5daa60938505 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -412,6 +412,7 @@ static inline int swim_track00(struct swim __iomem *base)
 	if (swim_readbit(base, TRACK_ZERO))
 		return 0;
 
+	pr_err("swim: track zero recalibration failed\n");
 	return -1;
 }
 
@@ -456,6 +457,7 @@ static int floppy_eject(struct floppy_state *fs)
 	struct swim __iomem *base = fs->swd->base;
 
 	swim_drive(base, fs->location);
+	swim_track(fs, 40);
 	swim_motor(base, OFF);
 	swim_eject(base);
 	swim_drive(base, NO_DRIVE);
@@ -596,13 +598,6 @@ static void setup_medium(struct floppy_state *fs)
 		struct floppy_struct *g;
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
-
-		if (swim_track00(base))
-			printk(KERN_ERR
-				"SWIM: cannot move floppy head to track 0\n");
-
-		swim_track00(base);
-
 		fs->type = swim_readbit(base, TWOMEG_MEDIA) ?
 			HD_MEDIA : DD_MEDIA;
 		fs->head_number = swim_readbit(base, SINGLE_SIDED) ? 1 : 2;
@@ -610,7 +605,6 @@ static void setup_medium(struct floppy_state *fs)
 		fs->total_secs = g->size;
 		fs->secpercyl = g->head * g->sect;
 		fs->secpertrack = g->sect;
-		fs->track = 0;
 	} else {
 		fs->disk_in = 0;
 	}
@@ -759,24 +753,33 @@ static const struct block_device_operations floppy_fops = {
 	.check_events	 = floppy_check_events,
 };
 
-static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
+static void swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 {
 	struct floppy_state *fs = &swd->unit[swd->floppy_count];
 	struct swim __iomem *base = swd->base;
 
-	fs->location = location;
+	swim_drive(base, location);
+	if (!swim_readbit(base, DRIVE_PRESENT) ||
+	    swim_readbit(base, ONEMEG_DRIVE))
+		goto out;
+	if (swim_readbit(base, DISK_IN))
+		swim_motor(base, ON);
+	if (swim_track00(base))
+		goto out;
 
-	swim_motor(base, OFF);
+	fs->location = location;
 
 	fs->type = HD_MEDIA;
 	fs->head_number = 2;
 
 	fs->ref_count = 0;
 	fs->ejected = 1;
+	fs->track = 0;
 
 	swd->floppy_count++;
 
-	return 0;
+out:
+	swim_motor(base, OFF);
 }
 
 static const struct blk_mq_ops swim_mq_ops = {
@@ -826,14 +829,8 @@ static int swim_floppy_init(struct platform_device *pdev)
 
 	/* scan floppy drives */
 
-	swim_drive(base, INTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT) &&
-	    !swim_readbit(base, ONEMEG_DRIVE))
-		swim_add_floppy(swd, INTERNAL_DRIVE);
-	swim_drive(base, EXTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT) &&
-	    !swim_readbit(base, ONEMEG_DRIVE))
-		swim_add_floppy(swd, EXTERNAL_DRIVE);
+	swim_add_floppy(swd, INTERNAL_DRIVE);
+	swim_add_floppy(swd, EXTERNAL_DRIVE);
 	swim_drive(base, NO_DRIVE);
 
 	/* register floppy drives */
-- 
2.52.0

