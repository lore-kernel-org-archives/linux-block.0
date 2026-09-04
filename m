Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B70441623;
	Fri,  4 Sep 2026 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514297; cv=none; b=B8Ln3NUnSEbzAxXrolFo/nbvJqSYzehKJoYTxyxOTH54s4Fx2RwubWNsVZPji5kkoj+wSPoXU7dZCp3DmkR2WXy9eRUPju/jp9xlBJn2Dri/3ThhCue56yyzQ/0oVVd3Y21jGHTHog/vK+ebHhdN5ZtZxngkXvEtK3+DwLKENsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514297; c=relaxed/simple;
	bh=2s5056F3M1H1eGUdCR6jg3p7BkSWaD1ETpRDdlPRR3g=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=sxXEQb3RUonjUAfHVIF24IcM2ErG6cPiSy44EEOG/aIRKeDl2zaqFAErRUayBn+p08uN9tsT8X8Bm49o51EhdX0YeJlB7IMJoGvOnzcbs/DdUJ2Mjm0nDOiJH6nTEjPKPcnJInt81a4vTvAeMkKSizw6rtGb5464dpwOBPaUX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxUroyJj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxUroyJj"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BE2B1400141;
	Fri,  4 Sep 2026 05:31:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 04 Sep 2026 05:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514294; x=
	1788600694; bh=Jw4vsO0mgrk87gDApGL8bszTo0NjZbd8pbAFWOFBC2c=; b=R
	xUroyJj/18vTdGO/B+GHMHekHqld3EpcvsO8e8oCOE48PXegQKG5/TYM9Ikh9y/4
	xFm0fukr13mAK0vUgDAJa3EueIlCsOZp92yRddpMc2KHUjpEMRhqMWwros5TSTPE
	yMrR2j4vvjrx33hVLbi8Yd+rMu2wulMZE8MbG33aq48AO0f4S94Ngx/3MnFLL+8i
	+xPnlu88VSrs6U+FKKqvPSvVKmfNAMxWnBCWy5uOCON7n/rLwsxvT9dy9cQjPprQ
	BiwEWNHOCgIL21ehahf06nzMmBjJD8hXCvZgdf+wnlvAFaaffk5UvSp0MMiWUbtu
	FfQTJMyk48zPATHwA0Ifg==
X-ME-Sender: <xms:9o-aamyjbMVvjsVkOtY7aku0FPB40mSkIvJus-yiwgY5-sDSVYI41w>
    <xme:9o-aasX88Uv1iDcz9BOkUaZ4iwOOOezY8YNwd-8VxZSNM1TnjlHI3yAoXBrlAwuGZ
    2YdPwa-WjuChkQrzEraLF46SkgrQivUc0h6FgQwf5E_VxqcwaSW-Pk>
X-ME-Received: <xmr:9o-aaoP5lw7tIXVoxufI2M91xiztiPyuZIbVC4qhPUxUNz29koyaVGrxDW2T81T6OXf7lv5zE8uaaBghd4zcoHfvSUxeVw-EcwM>
X-ME-Proxy-Cause: dmFkZTEAKPWJVEMqJ16jAjOL9FB/rBffUzJbSVLQHlq9+RC52fsBvb13o/7yjvGYTuY3IH
    ZNCMm3A3s3Wzl4RLMlWp0jCSYNVS7BZQKRPO2yqi1PfebCSoLOeHqK6FATWT8bd3IKpoKZ
    CEwyBEjTXEy3FLlbxSNZDKwf3xO9EeiRAKVkzcAluKXcPMqMkrDpp1BPxnn7TPE8fvHu4l
    eJtWE0FI2UehL/YEbD5REmldbzGnWmAWgAUgfm0dSu3fH37RyKRhvYbjCw4HLJaLhP6501
    B+Avisf8hlO2cQGDcAA1USTZdkjGliJjHtwHNkdXiWoCX0/+3sglem9KJOr2WDslSbN9Tk
    oaz6+XA7rykO29e6MB36RTFMNZLu1+r3NdU+EBC1l0HH/oxqcciuLWp0aJuMPMiCrODbO+
    9WqPwKorht9QVxKQkBnlD+Z1qLJEmWkGQCppFHS2YJ4Gq49lSCCKKRzIJb3ci3OZxBQVNQ
    rW2gEStcfzSv5K4noXlUuirbI3lOOsMk2G+5/b42IGJ7EfLkM0d+dPTNnGn7KsZDHbUrhB
    N2GsSYoYCeTFWXCVpE7Ot6Dc4vhxc3q8C5CBaWiCXkKRdt/6NDOmbM1WI1dC0TYM2ZJqul
    Dgfwef1KfH34zxHbTR6GaBgFh3DtqlKZgUYAAyj28e+ONRzfAVYfuMVz6F9A
X-ME-Proxy: <xmx:9o-aauDpDe4Y9DezPPyGpaCTYlC12QpmFaWkLjv4TLN5N78_cSl5Rw>
    <xmx:9o-aaleSGEqn_-Uab6v8m8NINymkBJpZvk965K0lTQBaqNCfdCGmsA>
    <xmx:9o-aatOWDW_qe_nUsCpOhROeaZ3eUlRYXd-9iISiedP0Vb_xe5R3ZA>
    <xmx:9o-aalJYDat0Vd6lkU9DFH4qy91HmcqGB0s-BENbPB4DdNrNU8DmtA>
    <xmx:9o-aanh84rto3F5z7U_44e5_Wq8GTfUDBj0qtnK7A6wu2t06kGh5bN6X>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:31:32 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <6da86b9bfd1335fac3ebc8c435fb613d5de4a70c.1788513996.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 01/33] swim: Assert strobe with stable outputs
Date: Fri, 04 Sep 2026 19:26:36 +1000
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

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Added the PHASE_PIN_DIRECTION macro to improve readability.
 - Re-arranged macro definition groups so as to agree with their
 descriptions.

Changed since v2:
 - Dropped reviewed-by tag due to unreviewed changes made since v1.
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

