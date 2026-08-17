Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978F31AAA8;
	Mon, 17 Aug 2026 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931746; cv=none; b=jWIrCJCWRwX83/UcmtffFZBQhHBZsfnRJKntHEb/dQHzyYLSDhpJaGpv3s9OK4nIXdkP70hrFCxpEA5/T9iW2vVxiejjJojWzjyn1DVlEzBQxE5evze3lICvntg2Ud9m5n7adlNmoyYJB80000LqpI7TejeZgpzRHJxtTwmov78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931746; c=relaxed/simple;
	bh=6OIg2we+7lKJqkBVapsxecJj3Lz2kM88cqfMZOpsVEg=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=HpJLRRXl974/pZRFozl4PZX+yZZ0HwVNUnzF3qdcacRceXn2lKcWh3fGY6Fa07GzDhIPW4vo8zcJ3od0Sbfdj/jRyymuuVPqu7v7ed0dRbSfODLvl94gbF4uidqqPEar3dMje2w1dQdDYNhC5jsl0qsNfnOqBjsF8COn87a0UFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WNN7yHwL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WNN7yHwL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AFA4EC0218;
	Sun, 16 Aug 2026 21:55:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 16 Aug 2026 21:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931744; x=
	1787018144; bh=SF+A/wb3PlxLZDkRZuIKi4U0HF4yLL97AjmCOZNTp1w=; b=W
	NN7yHwLmTlQJ4Z4gbJsSdmBGktRSXtTJ2K7Tb5HINLOuzNeETeN4UulUZpmzYQXo
	uD0rTUOr1j9g4wiSTOooT9ClyOqcPpYRrKMzEDfAFZcElDJy77w6OTo5hVUpUa5T
	T6jz9v7GFLyyz4wwzmDc7w3miVUeyqjp838u97Ip72e0CoybyGJ2dUovLxEQvUBU
	mdDUm4WJ1oM4JlbPK73MjxhfX6Ae6cTFlcZ3+pb2qXeOrmOpnfvYMfGeS2aD18Zh
	1DkhEs/txvck5ySHWlH0TpMxy0C1PQr7VClsrHXq9nJFZZ1k4RhHTHGqFrRgwSJC
	ogyqlET1Dq7HSPUZISjRg==
X-ME-Sender: <xms:IGqCaphyMBrhSwlqBUUtMMTpqfioJMHvnjqKjsZ9A02B7DI5drapXg>
    <xme:IGqCaoG6AnSYFwCAYJL3YzgC4Bqsdm0BR2cmZtYYOuJunfMO7ye9rqsQ4LJdMofRf
    7XKXbbHNdZBm-kGc0CDyqyuj6LHcRpabAPMi10oZcokDQTw-vdV-n9B>
X-ME-Received: <xmr:IGqCao-qfxka4Pc8XFd2YccCJdHUAnalArh-h3NhCKcKUgmjwq09Fsn5S5mSYfyJuX-IkkR8O2e06ysjP3AzVMKPH_kDxp2jq_k>
X-ME-Proxy-Cause: dmFkZTEcdm/H6lUz/GNYCURxrkCd1HPfYRd3zhai/6cdZjeenE7g5xoDzlQAxk+7iMQq6v
    xV9q7s5fsS3/JQzvNsjwyK/4cWW065gbm2GoN84iHcVNvAdCqKzmKSHTb8iEr45WtpyqeY
    cz4yU9C9Fo2z94qtPVV3dAzmSvJhNew7HqXMqftu0soscmI1GAdFoXf04kdvALh7XeUIuU
    Tuk2XE2OeIJdmWhM+PiCh0JMVi0kltBn7CwQl945VNkrHoqGgbuYhi8WoWtxLKIumeRTK5
    /WtK4yCHPyxyd9XATZrYk7BUHibsQzupfidfoh//hSLpDEkVyPVHII4Kj/fp06fOz7jSth
    ERRoE5f7rgKuP0wwxDH3VDZM1S7mpaMxr2VenMxf2cgdyLtKymr0qrikWWYvX1kmGsE9LJ
    klSw1hIXcOm28cjnDqaggQmmDkh7/aIkNgdCm+SU3kgGeU6U7KMdYZo4xcORMtuIcOP2yM
    uk9fHUhSV7rhW5W/9CXvKOVRt2FM+x9Cr10lFHuBSrvMcSvEMbgt4c63Wx9Q2M2XaIbiZv
    F+xwlpfjidsDeTRIVeit6G+ebci7+V7WS42VlOXikrJiaOdAybIrT5bl97SwTl2hJadI+l
    ILjy6i8bB1RGj5BPneYaP+EjKjH2g4V880kW9jbX3eVuRtBOyrbTjwoMrnqQ
X-ME-Proxy: <xmx:IGqCavwT1Vpg_oGCROqvCXl8yuI9SCGn8A7vSAR0Jq0_04mDDdoqTg>
    <xmx:IGqCakOoiqTtkYtlU3HDzJ4xRwqzHeYUxO2-HkNWnQ8nbBcIbDpMzw>
    <xmx:IGqCak_04k5Ag7lImTupPOPv6qqZ54Msjr7gv5jjAF2167Ut3wMxDQ>
    <xmx:IGqCah6OM2FeVnQsly5678rOhXc-4Kc-ZDT92clIPHks8XtJ1nIVQg>
    <xmx:IGqCars5WuNozW6n7vDEkqaS_ezSFgsYm8eXwdryPkYuGVBlq47FKmGY>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:55:41 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <cf607cb27c521316ad0e77c3c4778a35e5f94ad7.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 09/32] swim: Recalibrate when drive is probed
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Track zero recalibration can be slow and is normally done only once i.e.
during system POST or boot-up. Recalibrate once after the drive is probed
rather than every time the device is opened. Don't register the drive if
recalibration fails. Park the heads before ejecting.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Refactor swim_add_floppy() slightly. Start spindle motor before
   recalibration if a disk is loaded.
 - Change return type of swim_add_floppy() to void.
 - Park heads at track 40 because that's what MacOS does.
---
 drivers/block/swim.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 6a49fc51f5d2..9abf93bc0980 100644
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
@@ -825,14 +828,8 @@ static int swim_floppy_init(struct platform_device *pdev)
 
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

