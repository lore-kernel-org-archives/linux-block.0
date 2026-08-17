Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F32771B;
	Mon, 17 Aug 2026 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931852; cv=none; b=HfBjTkJKPEUP7/uFc4rCxk2sPF4jzN8IqfGwstaq7nbxwXdKKHgpg2qV0mR8YrBUZi17i8DukDYzPlTyXmsOCSJtlV4+r9NMh5OxLvA6KvSJxzXqeoHW2kBwHJqJfq8bWiiOytFHOg2hg1NTgFLHt9C3HdLoYToF2BgKvo8g3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931852; c=relaxed/simple;
	bh=GKFD9XHNEU0GTpmCxmnybc0RYX1Oz20z3lOhHa82Vw8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=cUjZMkiyizW5YPeyN4sxPkuugI1GSBBMgFh86GiXShc92b4DJ7eCYflblcVrxyHZ4lqt0Rjyo8vBnScaU+GLX8K9jZ8iWGAC9bSMChDDivjNy5J69CVpT7ZMHKvcwETpGgFO6fKAcvW5v9xkh72ZcTj9ylRxnZWMCfuAJ7/HJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BI5TyWwh; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BI5TyWwh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DEDCEC01FD;
	Sun, 16 Aug 2026 21:57:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 16 Aug 2026 21:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931850; x=
	1787018250; bh=SPrifuD9lBBeDwG+66BL/g+bRKXuw1lymozUg35htA0=; b=B
	I5TyWwh2/ZFbOo80df7u6VhUQAhUztJ05nouPlPmQZB+UEd3Hfq2Mlbs3sy/pc/o
	7LYDaJpfPqp6jAZqCbq7nXOKajDMfQiR2W8pC1enb8NS9tSCB9OSX2+Q4JUdTn32
	RdWH15xqn4soMo0NvtYqIQHFQMsB2Pmv6VZGWMKo84eHHXEwJE9n8K38O4AW44l7
	DYwph8v4g95hAq1N99hrZNu5pTW9lXNbSv7wF7Cm9mBXaZtz2YWBveMuuQ2YuwIm
	yjCpcGjrJgHy5jxpUGNQb6xAvTl0n2LAiItRS77K1APg3I1cGUvJ15amR8+WApV7
	bScJRZEFZgqUPuYmtcRmw==
X-ME-Sender: <xms:imqCalC0kxMHQaVBN8LiNqeohqr30PUhZWMtcNgkopMq818fzNb5FA>
    <xme:imqCatkF8fWeQ-FMg0-WW7t4qhqdJmIzK7f6O-yxN0QAw5zlVE6BMmdoyveZVdPXc
    AqAbJoYAQfwwHpUBvEZr8OB73X1xc8NFLXq-4mQ9GoXiFbr8X8zZOlJ>
X-ME-Received: <xmr:imqCagfPxkgbOSCt0whDGd1USuVk9LYw7ox6fyMD9TXKxs3FMdOaikvmSzcg4XMmWxeOPaquvl6-tgWxQPm7zb65PtniyV2wmI8>
X-ME-Proxy-Cause: dmFkZTECU9zAlmyIvbcspBqHSrqOwQbTBIkgUamPgZFlNDl9b9qv2bnkkY45Pt1/8NOBTe
    Hr0+DT2CLwlGeE/9AyKiy9sFZu5yAXMPg5I48yRejhD+BZymtd0XvLQCaHPBJaxB5XYNtl
    0SZBq8er1ZYpoM7krAD5xeO6YwzL3u1djn7inOMELalBNNZ0N5ua3XMBaLCzN7uNQwtuea
    eerq5OVOvcQBjCKCI6GlI6gEz//Hx25osXV7pnqniQeMeaD/eLdkc07tl8Fndrkjm7QN8q
    6elaoEX36DYhLnZCNhlmIhVVbW9CH0eWBE5Vmhw76pCPawUzX19Yt6EyO6B5nrell3ChSe
    yPgz/pHyD8Vz6hsVCcPrTHjBH1cO6YzyXVfdpehATyyT2H6QNZo6cnAv+QtQ8X8IP+KSZV
    EeIkfCccovn9sIubNZoE0Arp1buIfEa34LxUga0nvo6Y8paXhyF5LlGqAE3CqiUycDMnBo
    FckiOwlH9J4C8JJNaVu9RnPq0C4fMUf+ego1+ihRvZuhKgiFyjNjFE0DBtbKzZJmSkruAR
    EdS4UQ/I/49gjes+8/p9aBtogIfaQjvg6wPUfmwpAas3eYRmH9nqm5RjZSGMOKcBm8W1vc
    iFZqQN44vrTUsDoYTyAcEL4NmIWe/gMz/OX+8P044CAeIzda/MrUaOW8kF+w
X-ME-Proxy: <xmx:imqCahRrgxWDetD-D_o4FKMSU41L-8sNSyFX2ooW8c7e6vBGwlTS6w>
    <xmx:imqCantNJd0BOOPOtN2TLGgKC1ImDteBzz987GhZAVciFiHjXGH7dw>
    <xmx:imqCaiedyzi9ykudo2H3rOnYlGLNti4n_o427oBEFDrStQO4uYfTHw>
    <xmx:imqCahaCFfiJvj_DjEgcVViiK8MJYjdewK6omUmbqxU9nF_ioZ0qVQ>
    <xmx:imqCatzLNf_teMgaasEOx80cP50o88ukWpvMa5b6jFcTEK1YZ0jJTTqi>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:57:28 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <e03414186ee8a51523e98fc9277ef7ea5a1cad33.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 20/32] swim: Check drive ready bit
Date: Mon, 17 Aug 2026 11:17:10 +1000
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
index 36e28a766a5a..987e43e5b4ef 100644
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

