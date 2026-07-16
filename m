Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0940A920;
	Thu, 16 Jul 2026 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197240; cv=none; b=cD9F9MtfTguoPyetb1m6KrcK1wO2K39BBgr7Y9YRuBsNYVCS59qB74yVDUfKrV8fZV/hcOaeR4P5oQ468XoWi6vpfvBicNRLfuFndWUPyfAGsaTLBI922qCdtS7BUHBTHcVIFdM0rC2e5/BN9EaKfhpBGDIG7LM2K31BE2cac5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197240; c=relaxed/simple;
	bh=RJ1V2xUccvW5CYWRI2UM0//jzTMk8vyyFomEitrS97M=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Rxji+pzm8XFhBOBZW79DVBOezTOen4c2eIqK12YnZpZ1gShDrNdPJz4gQgAMBk4yc58OM2J1frmn8uz40SXLtKvGmmWskyZqJ2Xigv6vRy06PybjVFNlm6cuigCfqAWfYAGjeZKoyx5iORkQNNYNABI+wwlKL96+RT+LPFY6oQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8XX0Wz0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8XX0Wz0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F17CAEC018B;
	Thu, 16 Jul 2026 06:20:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197237; x=
	1784283637; bh=WFQ8jtK9WHkzvJ97JkkqO1mNZ8y/kyT+W0cq/o3dxEs=; b=R
	8XX0Wz0bA52RAzyZyXh8Tuo7lMIQgyjuALiZ8HJSMdrvnm7JoCBMaclizvVNMPuY
	gCy3Ct7YWZHZTSdMM/pp311/KeTL91r5ejyBTr8EPYx+egRERviKviItG6yDR6Om
	+srAiok9iV6O1iyJeMwP8w4ssF4CNkI+Dw0XUfhvWiu//5VAQ6DtqDmzk5x50TBF
	1jgpYq1uXer1nBNvR9J+9fFkoNmMhktTSaHr7Yf08K1nzF1V4OgAzeSJYv7IyRkc
	vjhUzNxwYi34YfudmZTDm6+wj74j18pNr0NbrQMMSzed4r5X3ZiMrQWBMjCXYt/4
	zb2ZAl2Bpdjyh6u7PBL7g==
X-ME-Sender: <xms:dbBYamoohNl3tQXkraTFeYgibYAzhB3LFIfJ6bMzBAqlqVUy-imghw>
    <xme:dbBYauvQmdloWaxxSdVvNL-hwgK38-0rvyiNAjeyVwti3pQ_KoHrWoWJnXnrlkI3a
    xISjFztsDuJVorzaE94P53ernp5sbNn8zraAL8Y98QbaPmFJ7JVmmo>
X-ME-Received: <xmr:dbBYarFxr64TP5kSXhBk4yxzyWvY_svd0zrcm6VhVJGMbkc6JTHgvFHm33QfPf3T1MqF7IdfGth7nr2XT5_SX7Dxm__O3n4XKAU>
X-ME-Proxy-Cause: dmFkZTGhRsBonxyKtiOaby1xr0UoZp+PemcpBA8+ii02WeuKwBNQpAt4R7XVVnawYJCU0s
    COpArKMbGUrOL41Y3Xw7xYGtyiIv4yyaio3bQC42/B4dus3ckYdNyvvL4q+zhY6kpRjyLJ
    NkWr8qliVgDHyy+3Ld738Hh8VW6S/mUua10dIYeS5ugc63FfIDZn5v+NSAmKcDNOuyUiRA
    EieS3LUhllNalPXyhirbeIALlp831+0JdkZhT+ILxBNswM7C8WlcLmBZno5J4Urzi1QoKV
    0GM23GhopugnSym313Be1tdhAAMtxxxfnnAbLytPVYBuSoWVysy9ivR7EeYVs1S4eJH6mJ
    ZUQVqZPAoxwhmRj7L4fJd1EUZ8IPmWA7r/n/mDe/JEYErnll+X7Zgfwt4S8JA0WSbVJuaf
    Sshi1H/435CsyyLXInkOFoKkufqjp0tpQVRRdrcCDxF4qbF52qtHJ0B1Y+0OMyOswpVFKS
    leVOOPS5gx8059sFB/YOFLDvQOFCSpocNZiwDfPJXCBzprxSFzI7CK1cnyKGZ9X/46cjEo
    FSj7k5/nEC+XnrwguJiAPSVrIscsKigq1rpQfgzUk69w6bhPe/kCfumFxir2zRlSl9OcM7
    MLJ5NG9kr3bOd8xaokFsSnvq16g36aOgClQDx13XTdoD3U0P4rezaA55r2Ww
X-ME-Proxy: <xmx:dbBYanZpbdzCuG41cPMAXWYyhnhP9FK4tHJyvZINt_vBBka4ACP9ow>
    <xmx:dbBYajWpqkfQSInd1Rb2eKV05_g7f4RFXnoZHb8ZkOLB3bMZeUUMww>
    <xmx:dbBYalnHdD8BCn70tzLcAHoLxc8tX6XNZSlN02sWzsdgEdpHce9ZWw>
    <xmx:dbBYamBlHQwyMu5ljDaC3JVl5AIHXNKKxax5LcGF9FFbyGb2recaEQ>
    <xmx:dbBYajaI0YyUhjuAL1JS3GC5yR_VQng7ZGpc9jLNkkIdERTv6YtDgUKS>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:20:36 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <627247b3983941eef4d5a4ccf60ba7963b46e887.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 20/31] swim: Check drive ready bit
Date: Thu, 16 Jul 2026 20:02:15 +1000
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
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index c10ad1266c3b..77d7ac3765ae 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -117,7 +117,7 @@ struct iwm {
 #define TACHO		0x1F3
 #define READ_DATA_1	0x1F4
 #define GCR_MODE	0x1F5
-#define SEEK_COMPLETE	0x1F6
+#define READY		0x1F6
 #define TWOMEG_MEDIA	0x1F7
 
 /* Bits in handshake register */
@@ -316,6 +316,14 @@ static inline bool swim_readbit(struct swim __iomem *base, int bit)
 #define swim_readbit_timeout_atomic(base, bit, val, timeout_us) \
 	poll_timeout_us_atomic(, swim_readbit(base, bit) == val, 1, timeout_us, false)
 
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
@@ -354,8 +362,6 @@ static inline void swim_eject(struct swim __iomem *base)
 
 static inline void swim_head(struct swim __iomem *base, enum head head)
 {
-	/* wait drive is ready */
-
 	if (head == UPPER_HEAD)
 		swim_select(base, READ_DATA_1);
 	else if (head == LOWER_HEAD)
@@ -390,20 +396,25 @@ static inline int swim_track00(struct swim __iomem *base)
 
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
 
@@ -485,6 +496,8 @@ static blk_status_t floppy_read_sectors(struct floppy_state *fs,
 
 
 	swim_drive(base, fs->location);
+	swim_READY_timeout(base);
+
 	for (i = req_sector; i < req_sector + sectors_nb; i++) {
 		int x;
 		track = i / fs->secpercyl;
@@ -605,6 +618,8 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 
 	swim_motor(base, ON);
 	swim_action(base, SETMFM);
+	msleep(30);
+	swim_READY_timeout(base);
 
 	set_capacity(fs->disk, fs->total_secs);
 
-- 
2.52.0

