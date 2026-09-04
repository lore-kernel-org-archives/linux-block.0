Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9744A3EE;
	Fri,  4 Sep 2026 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514488; cv=none; b=pEQ3hpr2NWrJv+O1OnqYQqMUTrfWwbhx0i7DUAUbyp2s5BK3IaXOTZhLvVI256cwXUX3PH5AmfrDKextUFCMFW/9UqP3YdjKrKNoM4ajQeshq2EL1UFAhEXJxAN4JImR6GpinIRavH4iXcjCmay/Y+vT/D2gpuLW43RrLp8t7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514488; c=relaxed/simple;
	bh=3s4N1H9JRF/L4oKF87tQ0c56gXovHfXcU3/OPfUw8KY=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Wa3735jaoKa8WddInvgUcy/ArJKOSMAbENMm2biOZaqf3ycfo0nYF0yv07/qArlv2+R438O3pmH1f1puZSyalSmA7HBhHlBThf+JHofGAJuNHRPeOds6ami/yseVXscJM+zuhHKFZ0I6U/RKCudWbyXsNyi0ZvcqacUomQkR4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlPdolnV; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlPdolnV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7870FEC0166;
	Fri,  4 Sep 2026 05:34:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 05:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514485; x=
	1788600885; bh=APzsWoatxbHr6Iwsqhvao1ZWjdttyfZm+IqhZmdpUv8=; b=T
	lPdolnVnsTNKkEL4RQq5kPdyjwK3u2aSNPmTkKk0iKel4c1I7Yvpe4+AHy3hR+/y
	b2m4+q/w9h2WYO+HCjU9RaSTaaGIIwjURU/mSSaFTrrYb568ab9XGs2Yyykva5BG
	rGAuerv0B8dXOFoHDVJr66pNX6SkxxRpi4y7Rwof+suIEjOpZ9ZsyR2iTJ4mjQIA
	yiwy7KexPinIKNv1mTC9+svFNtJCpl/ioL5ZEmf9Rtj2I73av+6Uyqq2A0LS1Nj3
	x9tYomfqpvzn9LSgSQyP9mXXG65c2ab7531qx7HcY/m0aGTfzYMZLRlfZ3EeAsCF
	PR4Jgm+wy4pe29VZ/CQvw==
X-ME-Sender: <xms:tZCaar0-64geGx-0w7hKkGrmqtMKyZyQt3FlhhjHxDItruPlKk9RkA>
    <xme:tZCaakLkELXiXZ_rSmEJ07WTlrTyrTCM7L6lnskDHezAds9fiG0R4cI8WQtLmM4zq
    UBv_VOCOuxT3qiiLfYIu483VJ_p1jGpSbZO6v_VPpOE4CuMwwRE9jTIKw>
X-ME-Received: <xmr:tZCaarzX9mGUzoo3-kayokfcsvtANnsZAsgjzrrrTIIQq0SicT8XoT-VUEKyap11Zjqc6krXrzTgKLTThcH2njCbbhCjX6TtjQo>
X-ME-Proxy-Cause: dmFkZTEgSwz66V+qSU0onCxC1F8ShoiVzEkD4nv3k8arPvEJrRCttwK35Oooa03yDS3V7Z
    X24bDVU3zk97dZjGWhXiX/ncGofJJNeEuYKgl31r/eDK9q5L7nwuD3/hEQU4j57irJs8tO
    84Cp9nRkKueV+P/Zh+1MA5C3iN5rv0++YXPj7VEh4HRI8ixbdKjZUIuiKKcqpAq6/i16Ze
    PQjCFsqYVbtDn7r5YuWGcGxoEjqVvREju6nRSm6O4BMaQ0J9b6++FaFcvgP73aZ6WigYRi
    RlMdiJjw76SzlSBX2alJJ3NXs6ywRX0EZbPP0m8cGOgA5DoC4o+kLwJIiLSJDXjG4wSOEc
    ImFxTNVrXEm79NTgOjLgrPsVLNZjhBCowpXTF+kbZlSSE+tBHbBvGrA+rkYyHA90Obm2l6
    YJn2gGJ0hzltsCYopJpFf0+V0KRgIYjacCcRY1yMe2jwpo1wdQH7opCxAjk4+VC4ejuGVA
    KdzCHYt8MkPU67KH0Ql4NZqRACn4p8EfespEwP3YJspth60NEsn3iEfWxzR2J74EqJkbZb
    kLIeYrE7XPNsctWd2WE+7TQMaX69JTWODLMY23NR8GSZ7l7mIYL86EpudGbVufgKbKol+A
    ESbdS+TSFDsgT9jJGk4Zr7kYLPTZy+en5Ndw34EgspMNZmTRaWKvoRTmedlQ
X-ME-Proxy: <xmx:tZCaaiW-pfNYN62N1m6iMNgPxxiuGw6wUrVG7gzfOcq8Jqd9ldGwpw>
    <xmx:tZCaarjxD5qG8nON8ju0tBlyvzdFu_QNL9nVh0ou_Ok63n39MkhLiQ>
    <xmx:tZCaaiBZfsZhYbJvlOVLaEliao3vsYjEmOuXBgnfsnhWG7JzqVojVQ>
    <xmx:tZCaahtBnRkdJ7rNYaNJGBbe355-FQ7IQry9YJGL8JVgyAqDvG0Hhw>
    <xmx:tZCaamm2IQCvOm0eh4WTrFAF5OsJd-MuNFmB0OvDklo0Co0KE-5Mj0lg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:34:43 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <8d6fc833c719de2248b64ee521418b1032b1e509.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 21/33] swim: Check drive ready bit
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The drive provides a readiness signal that has to be tested before
certain commands are issued to the drive. Rename the SEEK_COMPLETE flag
as READY because that's how it's known in the documentation as well as
the mkLinux source code.

Poll for that signal after stepping the heads and also after switching
to MFM mode, as that's what mkLinux does. Check for readiness when
stepping because testing shows that some drives require this.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 59e00fb2bff5..601ce79c96b2 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -117,7 +117,7 @@ struct iwm {
 #define TACHO		0x103
 #define READ_DATA_1	0x104
 #define GCR_MODE	0x105
-#define SEEK_COMPLETE	0x106
+#define READY		0x106
 #define TWOMEG_MEDIA	0x107
 
 /* Bits in handshake register */
@@ -313,6 +313,14 @@ static inline bool swim_readbit(struct swim __iomem *base, int bit)
 #define swim_readbit_timeout(base, bit, val, timeout_us) \
 	poll_timeout_us(, swim_readbit(base, bit) == val, 1000, timeout_us, false)
 
+#define swim_READY_timeout(base) \
+({ \
+	int ret = swim_readbit_timeout(base, READY, true, 1000 * 1000); \
+	if (ret) \
+		printk(KERN_DEBUG "%s: drive not ready\n", __func__); \
+	ret; \
+})
+
 static inline void swim_drive(struct swim __iomem *base,
 			      enum drive_location location)
 {
@@ -351,8 +359,6 @@ static inline void swim_eject(struct swim __iomem *base)
 
 static inline void swim_head(struct swim __iomem *base, enum head head)
 {
-	/* wait drive is ready */
-
 	if (head == UPPER_HEAD)
 		swim_select(base, READ_DATA_1);
 	else if (head == LOWER_HEAD)
@@ -387,20 +393,25 @@ static inline int swim_track00(struct swim __iomem *base)
 
 static inline int swim_seek(struct swim __iomem *base, int step)
 {
-	if (step == 0)
-		return 0;
-
 	if (step < 0) {
 		swim_action(base, SEEK_NEGATIVE);
 		step = -step;
-	} else
+	} else if (step > 0)
 		swim_action(base, SEEK_POSITIVE);
 
+	swim_READY_timeout(base);
+
+	if (step == 0)
+		return 0;
+
 	for ( ; step > 0; step--) {
 		if (swim_step(base))
 			return -1;
 	}
 
+	msleep(30);
+	swim_READY_timeout(base);
+
 	return 0;
 }
 
@@ -482,6 +493,8 @@ static blk_status_t floppy_read_sectors(struct floppy_state *fs,
 
 
 	swim_drive(base, fs->location);
+	swim_READY_timeout(base);
+
 	for (i = req_sector; i < req_sector + sectors_nb; i++) {
 		int x;
 		track = i / fs->secpercyl;
@@ -602,6 +615,8 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 
 	swim_motor(base, ON);
 	swim_action(base, SETMFM);
+	msleep(30);
+	swim_READY_timeout(base);
 
 	set_capacity(fs->disk, fs->total_secs);
 
-- 
2.52.0

