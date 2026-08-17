Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A4313527;
	Mon, 17 Aug 2026 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931670; cv=none; b=LLpYOGPWOE6PLTT9AflTaDQS5ZgjE6tc/zw8uN3ACDo4/wrmXMsKrM5U21DYloeX92xRtMGWjSxsQP4cbL6FYkzlZPdJbMm8UXkuhxNCiOzFJOihJ0qt9DC6vvmG9f/nH+KXs6oLwkOyUzYIsdpge9crZlHYe5+IeyZ1vYUyl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931670; c=relaxed/simple;
	bh=tXFn8F8LVGqgpNLonD0OOhm9gs3a6YN4YPKy8g6+3J0=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=NfRQZmXr7l/Io8qHGIOnvuoRd7RELqk2FjvbPI72UhkMJMDVIbywZIiE8oX4kvYae1EzrKACa6/J7yCMiuVsdpWuREhIjNYr9HcXqgyKR5JTDUFb67p9g124AfkxZSLAJmAftN62HZ2RuyjdWvjq6fbRZCIkxOEuGLVdeZT/esE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KjUI27ll; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KjUI27ll"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E1EDEC0217;
	Sun, 16 Aug 2026 21:54:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 16 Aug 2026 21:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931667; x=
	1787018067; bh=W8zpEopenm7bVgbagy9g5sl1DsTzkKmIH9uGQuORmV4=; b=K
	jUI27llvCdmw3/SJYPFRULKKP9BtDtSE2igLlYifvhifkhSfnVMXVXANIoU18VKu
	ech68/WiyP45qNgFZBJfyMzx0+JyrU2a7s+EFqZpvgNpoVZGaq/fiUgv9fEfcbWx
	9v3DLftlbzx2xdnZgYwmbPOhClDnQ6s6jyeLDeRMPP86b7l7/sWO57iEsRZ7uw/y
	wGE3MISeApRCwXu2r9kGX2FoURXhPB6PVS/cMPZy7ja2TKkGtzruMJLo8UWB3tfD
	CxjVB0AbeC/LJDnxeDm8agQABWn8FLa+I+keAuDFq3hfMIY9jq0eM8DNBpmHCbWf
	mH/4PikTJzofM71eCSMTw==
X-ME-Sender: <xms:02mCaqRPgUzfOoWMpSU_-0tFAAHRwCWorls-LvQmR7-6P-TSLL3eww>
    <xme:02mCap2gGbY1-tBnXM2Vm19ncTjph-I2_TFTMGo-niD8D6kHyzUVPaWi1ze849BRL
    Aar8oYMpYj3q9X8KayEHOt7sOXMlMeMKPHL7dHOf87JpI_bMkYZd_Q>
X-ME-Received: <xmr:02mCanvMzDkSNi2k7mDlgNXb8U2cN5RJai4Pp5uguji2-IMvPXTAa4buD__NTqeHK_f6XIVna7V7TgE1G0dayptNlM5lI3Ig4G8>
X-ME-Proxy-Cause: dmFkZTGGfSHbL2fI02qi3PxN23Kck6mI5WuUw/IvRcvpbY119ewffFmgrLaJZrOewmv0V9
    +yVjmNFRAF5v6NwN93pp2/ef5Xe4c3LI9irOXMRuZYHRPaDMJE6WMter/2+BypR/48/QT6
    HY5IjuzvgSjmo92SyO1FOx3Pzj+F3Bo7QzXF7kAkGOLlhjpoHeFsUQfm7dkDIAS3zbzZQZ
    kdzEEhr46dUOQtvTauSfnNDphJtrhISaD9OmmoKzjI1J4txcn9eV52lgr1VrqNf0UkcCn2
    OchZn8Fy5DmAdO0OzTlRhd5sxDSBZbWOqIe4VCopfX4yIdP6r//KsVzdicR3q2dH2I0Xi5
    q3/qQZdfOneFiIckB+DZiaPsW4BOSnww1gPUoEN8pIqClIpEEnRf1GAXzuEfh+JBumMv3X
    aXaoihteaAJRgN2+XaYZJdIu0mgnxjChT9R199ntjfkUlkoWdOCLvABlwJc/1n1s4oBXFR
    DYmG9viTEIcoCXYzRtCJTGr30F5muyoXdsBHFFH71fMoDZ7roS+LYHDdsE5a1BhU97V75o
    +dkR2SrbyqriNW2xlaioAR0s3wv+aDcuGq/Q2JIP4KSOUDC4tsvx4FQMmzkUxXQsvhAuFW
    rHXDIRYGwjX582fPCv0lXfiUSQtQEDRh/mxXyhCBio4O4B+vBjpjT2gaYGVQ
X-ME-Proxy: <xmx:02mCaniNtlXCbc7qkMWqHuvr4veCul5jCALXNCl5Gx_U1TOmVRJfVA>
    <xmx:02mCag_KAJDSOQyoPZMhBXiLbOkaxaKqEKRb6V1o-1M5QmWiuR4uuw>
    <xmx:02mCaiugnMJvtOEW9JXn_vPQ6a93EMkPmTXhz_4zBcAyBPT_m64agg>
    <xmx:02mCaspiea7P0bEoLvAX42Xv4HWuuSHlvyvOnbKtliOsPod8SE9cWA>
    <xmx:02mCaldB0_TBmoEfWvU3MQ7qc2dsuxEjou0v1_2p2Px1y1QnSGc3i_Nt>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:54:24 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <bf9a21a704f50870adb57c0b514f2bd3e0d67c4b.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 01/32] swim: Assert strobe with stable outputs
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Inside Macintosh says, "Be sure that you don't change CA0-CA2 or SEL
while LSTRB is high". Unfortunately, those bits do change. The CA0-CA2
outputs become inputs when (LSTRB << 4) | LSTRB gets written to the
phase register. Then LSTRB is driven low (with CA0-CA2 bits set).

This is a problem because the drive interprets a STEP command as an
EJECT command when these pins float high. This occurs intermittently,
perhaps because interrupts are disabled and the race condition happens
to end well. However, when I add code to step the heads with interrupts
enabled, the disk always ejects.

Keep the four phase pin directions set to output and hold their levels
constant during LSTRB signalling. Introduce the PHASE_PIN_DIRECTION
macro to separate the pin configuration from the logic level changes.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Added the PHASE_PIN_DIRECTION macro to improve readability.
 - Re-arranged macro definition groups so as to agree with their
 descriptions.
---
 drivers/block/swim.c | 62 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 0ccc12a72388..5d89e7813049 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -87,37 +87,37 @@ struct iwm {
 #define iwm_write(base, reg, v) 	out_8(&(base)->reg, (v))
 #define iwm_read(base, reg)		in_8(&(base)->reg)
 
-/* bits in phase register */
+/* Bits in phase register */
 
-#define SEEK_POSITIVE	0x070
-#define SEEK_NEGATIVE	0x074
-#define STEP		0x071
-#define MOTOR_ON	0x072
-#define MOTOR_OFF	0x076
-#define INDEX		0x073
-#define EJECT		0x077
-#define SETMFM		0x171
-#define SETGCR		0x175
-
-#define RELAX		0x033
-#define LSTRB		0x008
-
-#define CA_MASK		0x077
+#define RELAX		0x03
+#define LSTRB		0x08
+#define CA_MASK		0x07
+#define PHASE_PIN_DIR	0xF0
 
 /* Select values for swim_select and swim_readbit */
 
-#define READ_DATA_0	0x074
-#define ONEMEG_DRIVE	0x075
-#define SINGLE_SIDED	0x076
-#define DRIVE_PRESENT	0x077
-#define DISK_IN		0x170
-#define WRITE_PROT	0x171
-#define TRACK_ZERO	0x172
-#define TACHO		0x173
-#define READ_DATA_1	0x174
-#define GCR_MODE	0x175
-#define SEEK_COMPLETE	0x176
-#define TWOMEG_MEDIA	0x177
+#define SEEK_POSITIVE	0x000
+#define SEEK_NEGATIVE	0x004
+#define STEP		0x001
+#define MOTOR_ON	0x002
+#define MOTOR_OFF	0x006
+#define INDEX		0x003
+#define EJECT		0x007
+#define SETMFM		0x101
+#define SETGCR		0x105
+
+#define READ_DATA_0	0x004
+#define ONEMEG_DRIVE	0x005
+#define SINGLE_SIDED	0x006
+#define DRIVE_PRESENT	0x007
+#define DISK_IN		0x100
+#define WRITE_PROT	0x101
+#define TRACK_ZERO	0x102
+#define TACHO		0x103
+#define READ_DATA_1	0x104
+#define GCR_MODE	0x105
+#define SEEK_COMPLETE	0x106
+#define TWOMEG_MEDIA	0x107
 
 /* Bits in handshake register */
 
@@ -269,11 +269,11 @@ static inline int get_swim_mode(struct swim __iomem *base)
 
 static inline void swim_select(struct swim __iomem *base, int sel)
 {
-	swim_write(base, phase, RELAX);
+	swim_write(base, phase, RELAX | PHASE_PIN_DIR);
 
 	via1_set_head(sel & 0x100);
 
-	swim_write(base, phase, sel & CA_MASK);
+	swim_write(base, phase, (sel & CA_MASK) | PHASE_PIN_DIR);
 }
 
 static inline void swim_action(struct swim __iomem *base, int action)
@@ -284,9 +284,9 @@ static inline void swim_action(struct swim __iomem *base, int action)
 
 	swim_select(base, action);
 	udelay(1);
-	swim_write(base, phase, (LSTRB<<4) | LSTRB);
+	swim_write(base, phase, LSTRB | action | PHASE_PIN_DIR);
 	udelay(1);
-	swim_write(base, phase, (LSTRB<<4) | ((~LSTRB) & 0x0F));
+	swim_write(base, phase, action | PHASE_PIN_DIR);
 	udelay(1);
 
 	local_irq_restore(flags);
-- 
2.52.0

