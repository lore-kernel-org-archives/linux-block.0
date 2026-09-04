Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22442443E2E;
	Fri,  4 Sep 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514336; cv=none; b=XGYPTb+s5AYtQkRNCvJygLshKUpuUAFlW/6fIkF+V+kUD2qkZ+bRPtLeYfb7POK/M1dkWSt5nO/JKnaRUxd+ACLf7IkPDGrcBMaweo9plXjUWXML+89n86gMmsKIG9sPFKrCIDEnikSDzfuHLYFjHzVotXAyUS8AyBBbQzP4u/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514336; c=relaxed/simple;
	bh=y2aq5s8D/L5khZxRe/cFjwbxbHS1B0FaloGAs2bTUlw=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=nGoHSPgB04LcEL+vacw/t2h1xUz4g9BRDbJsfbmUmRarR+QTEMWnyYvcw6y0WRqNfA7J81w4TDfh/7VrQYVTEXQeG6UI3VpqfJEIWk4by6rtlj1MMp060IfcYTq2XwR251UFTA0Km0XPalzfOh1pOHY0jAJEDvcJdzKNLk40Tig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlRzhjBU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlRzhjBU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EEAD8EC008D;
	Fri,  4 Sep 2026 05:32:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 05:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514331; x=
	1788600731; bh=0HLz2220nu44BKt2ov/hAQqSq0Y4djEeSPVWO+Yzb0M=; b=T
	lRzhjBUMAC1bHpF6dH/sd8jjvIQsd4e33jEjCFggEVzjaLfhnkC7m0IgneV/SzRM
	RC/ZlID9ijoiWjpmOk9XXXFBZoQe0MOgnKqSSFEEj5SkRaQkRfXuQn5XBA5MDMf+
	RF9tuWekQ8t1LEfmWeyXJilMd2kwBKSt5h/Trn2KwOrmJve8LL8qqBSTo99TLWr0
	SNjBEJqbpMmCct28JDtQB3wyWmqu/GXcVls1fDN0KGblq0y2KT0yW6+D9Kvfk+25
	F963lUZ4baarsvyEQh//9atwA6rR3ARTksTswAwxBRbG3fOyLGvSE+IM3EPiJqb1
	ZcqNVyOhWFu530tsdLUvg==
X-ME-Sender: <xms:G5CaavlDBpChlLRGXoebS6vnluxvRupOH-mkXHHhz4hs8qHX5Ik7ig>
    <xme:G5Caas4Glt12QRDOBFf5wAATtzOZoABi3fTQdHf25KK-DgZ09MURk40TYnySuvD1o
    m51d_RjFPkjNZcYCziEXiJegxfBhy50ahJLxbsV_7ukf_k-s8iOPSG7sw>
X-ME-Received: <xmr:G5CaalhVwIBtJl5cmXf74trROogxXF3gUJ1z-9MXF-ghRsLlcDUHlkRFhhKKS1TnqCrD2zFjoDbioex-Vsb2WkyLaFHwmWdslgI>
X-ME-Proxy-Cause: dmFkZTFwU+S4kdAMlQ0v/k0AIIWH8NEZGASJORdIHxKTKTXUZu4/+TuTqA94nuiEUMaRxS
    Gofh+bL92h8RMpG66xVFwu0W+p9wbh5ZRd08LqtVKnsUP/9Qrp2soVjzNROQy1equ47t7H
    GqReSb441wEtgq6NIY2eQSaFWVAevL8uK2VrYQsRbjCnFUu9sctSvc8HbwNcOZhBWEvrxc
    v4dU6ftgbUqTDUj8aqtOMM9o2mrrjTYuxdDT/c0DbswJjHoKR/5ejCxg8Y/5mjJMzYLbmT
    GHbOCAcx+v5nQg51GRLb73A1+7BY5hn9tVP95J29cL5TZcJG84qND/yu/wkLW77nvFWlPz
    xzjxeqeHHSA0S3wteHlGlMMoWHfHpxu+Hhg/1ZMx56Cel/vnF63CJihimOWQG7EMklLMVy
    LKmKGb9TdONSTqptOsRCaW8lTFowx+BDlNHgB7qlLu0MetrjCaJcepNNXDJUi55KTUQoQp
    dEVLCjAH2pyHRiNq5mdtvhJ7AE49SPH7hoR7biGcHVogTXsPNv6lVFHiGIRf0xOwClT8sZ
    cd2KHV05t5j/gG1NIt9nI3q/oQB3n21pD3TstOimzUWaWxwjnTlRzKWrdwshKgAq81jTHL
    RpnyrN/Yg8jHQa6XK764YXcoqksPospXPVhmTs06OnlgEVQPwTLn/yrlj41A
X-ME-Proxy: <xmx:G5CaapFhGirno3FdFZvUs7No96huCmA2-vDu7slMHa7ey9RMQES3rQ>
    <xmx:G5CaarSOHOQYovLGb0Ft72sOlH2C7qIZa_cyI74uLMsVmt-l2_rnHg>
    <xmx:G5CaamyYN-NMPPufXLTNS0W6JjQxoxSMfUgRKe4uiklPRWY6IXKKVA>
    <xmx:G5Caand8awUOtiiox69GLAnzQqaiV3BTi_PTDIKp1HQexwotTgHDdg>
    <xmx:G5CaaiXRX6R8Ljf4WZZOClZWce5zPbxKxhAiAuZaolAiWW9YfFBX3yHZ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:32:10 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <75714ecc9a12d59511967dc9e24163dc8f3bbdd8.1788513996.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 05/33] swim: Perform ISM/IWM mode switching according to
 specs
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The SWIM spec says, "MOTOREN must be low to switch modes" and "after
switching from ISM to IWM, the very first command must be a clear L7".

The ISM spec says, MOTOREN "must not be cleared until after the Action
bit is cleared". Perform those operations in the correct sequence.

When switching to ISM mode, the Mode register has to be selected with a
particular sequence of bit flips. Set q7 low then q6 low then mtrOff.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 3f92677ad127..190b2e1b5b0e 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -149,6 +149,7 @@ struct iwm {
 #define ACTION		0x08
 #define WRITE_MODE	0x10
 #define HEDSEL		0x20
+#define ISM_SELECT	0x40
 #define MOTON		0x80
 
 /*----------------------------------------------------------------------------*/
@@ -223,18 +224,21 @@ extern int swim_read_sector_data(struct swim __iomem *base,
 static DEFINE_MUTEX(swim_mutex);
 static inline void set_swim_mode(struct swim __iomem *base, int enable)
 {
-	struct iwm __iomem *iwm_base;
+	struct iwm __iomem *iwm_base = (struct iwm __iomem *)base;
 	unsigned long flags;
 
 	if (!enable) {
-		swim_write(base, mode0, 0xf8);
+		swim_write(base, mode0, ACTION);
+		swim_write(base, mode0, ENBL1 | ENBL2 | MOTON);
+		swim_write(base, mode0, ISM_SELECT);
+		iwm_read(iwm_base, q7L);
 		return;
 	}
 
-	iwm_base = (struct iwm __iomem *)base;
 	local_irq_save(flags);
 
 	iwm_read(iwm_base, q7L);
+	iwm_read(iwm_base, q6L);
 	iwm_read(iwm_base, mtrOff);
 	iwm_read(iwm_base, q6H);
 
-- 
2.52.0

