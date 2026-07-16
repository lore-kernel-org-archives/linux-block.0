Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46F3FF8A7;
	Thu, 16 Jul 2026 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197050; cv=none; b=ZQ1AObzLY3i/4lnw+t7A3a+j6MMXZ6udfrHenpTlvLOEA8zKarEeaEzUSmx+qhkygxHKUNv3te9jIKQF0ssIktpV1swnEGYHEEbpKkeeC5n0Tcj0FErILau0Q20Zb5ePRajt/snOqaUAls+0rSLQMqybDAX94SAdsau17lyrFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197050; c=relaxed/simple;
	bh=53cSgaI40k9oYdGOrgyNR585oXsZNtU2cYIO//J4+64=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Yer5HQw+f50btaHs/BmzCSaZ10S7LddFAgUokp4lClK6c4Cj8NrNGM0rY5QRWBCNJ/4BkVIPN0yicKN/1WI0bZMO1RLB49Ueu+4AZgBYHAlRBZ1pNOItfGih2mxUJcVdAig9KrlwAEDOfMRbCKL4SxOaq+USDFBD1GMBGQVb53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMLKvodV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMLKvodV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 600AE14000F3;
	Thu, 16 Jul 2026 06:17:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 06:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197044; x=
	1784283444; bh=GZ+Y9HHwl+n/BGQRE116ewYffqbxZd/kucdg61aQyf8=; b=A
	MLKvodVwboPuBecBOMoa8ueMIVSSyTE87eo6FtQqeznUNsf2mLnuhb04FQkRqr0f
	MMQX2BDZZOaxcWzRL8iIAnRwViKNEw0IfsQihfgpOkgh9jSGvvJ0B7dUwrhavj9H
	bUR+Ubh07eQS7cf4wH8Gj+YaazmyBL8HILOiZNVflAkoqD0W9USagdZfCASBY+9a
	IP9i0+3C7ysyfWEPdMWWINn/BsgyhXjNPcFtm602OMnlTqvCVNxtSB/ODNkfV3ZT
	q1R/chfJq8iFsEQcEvLUVDFCn7qXBvgK6fkuYLqO5gkm/Ig/qwjkqo2mc1r5xDaC
	Fl5svkwz/ykB7AuLDT+AQ==
X-ME-Sender: <xms:tK9YapVtJJ6598d-7HfKq59Rqu3T3LAT9ZzbviggKYbP_bJUUtBL0Q>
    <xme:tK9Yajrmn51tjzsjL8DklIdyLlXUEd3A7FVaE-PCcxGcR83-IJGpYz2tTow3q7WBY
    5jSk3Gwf7PnOCkm_buYg2FefzBWktyxjG71MCGp_2iTs4qzEseTvX8>
X-ME-Received: <xmr:tK9YalR-P8N1Gq9_fPz0Bk_zZ6VrczgtsBRsEp-6ssnnQI6NWCHV4bt09CM5v3AU8EYmDRDHbSVcfRijt6SQ1s4ahSsw2TxF5Us>
X-ME-Proxy-Cause: dmFkZTGS6ZY5pWCItkgy9Xukn2zcuewFxo8ZHHN4pRvLqTF9Ej/jkXu4Mnxg+8SVH62C9Z
    NdfHOTAcoQsik7u3NMaqdaj/Sb4GyhvEyXqxfPz1ORC+VOfUwL7xO6EixFaof20XPTjQoT
    w0gMCsjiGcBL5Sc/2+7W28zCMKgBMJ8o0m6Z5UnNj8t2Ub59pnmCGLWOBXXFwHGukKnjg9
    oPwii2VoGp9LyZNtBuP22Qc33o2tx6mCHkKvSggiUEwKtN1s+YoPNk4J+4iDvPQupo41VS
    yjh7oZu4qBQRwkQZnPNtC4Habjb6Lk5fCXqzalnvP7SEl72bFlt1OaIxxzE5VmPVNQezVC
    uw4UKGDWG4JcB/UAREVW8ri2RDGBCNG1dW6Vk/BWToggr8iVVUFArrYCNscBOcv1kEVle4
    WesT3AYzG1Kzazk2F0NgK56uuG/Wm7VuveJiQluI+Flm6paI22kZLuUSdN/jly8EksBQU1
    j5ZnVQZPLrIPSqYNy1mWIHEZniKCNBR6PJecpllos6SYOJ4qJWWjX4n1l4lCCy58xjFjig
    dAUAmvZSF7Szam6NJm9ZJhCXbE0VfUK8bLKo0L8qyLIqQg/8oylKUrTXmIW/l/+qguKoHF
    pobp04kagngQn3feJVdJuiaWPPWZJZdYdsrbccfjWV6iGEZCmHyPngeyTkfA
X-ME-Proxy: <xmx:tK9Yat08YQmTvQzqkHl11QZbpIRJU8rahJDdigaFw78klhntyIhP6w>
    <xmx:tK9YahA2XrAs7qFcVtXC_Xc2suaGs5tVO-jdh_-1sW1d5NXEtFkbyA>
    <xmx:tK9YapiCWOjCAyT6y-fucmFnelniwzlowQq9yMQi_WcJ_WEsHw_3_Q>
    <xmx:tK9YajO5Ys_F7cxj7c9zy9yT9OZ5PrfELF_idiMd7xK3wlMNKh68Pg>
    <xmx:tK9YakFMtIY0mOfoU90WdtkZDjY30w1aL9xaMMScFE_NZd2tr8ScX69u>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:17:21 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <998aeb6ae4536503516df34ae38709835c61c8cb.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 01/31] swim: Assert strobe with stable outputs
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Inside Macintosh says, "Be sure that you don't change CA0-CA2 or SEL
while LSTRB is high". Unfortunately, those bits do change. The CA0-CA2
outputs become inputs when (LSTRB << 4) | LSTRB gets written to the
phase register. Then when LSTRB is driven low, CA0-CA2 get driven high.

This is a problem because the drive interprets a STEP command as an
EJECT command when these pins float high. This occurs intermittently,
perhaps because interrupts are disabled and the race condition happens
to end well. However, when I add code to step the heads with interrupts
enabled, the disk always ejects.

Keep the four phase pin directions set to output and hold their levels
constant during LSTRB signalling.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 0ccc12a72388..b61e92d0e3e9 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -89,35 +89,35 @@ struct iwm {
 
 /* bits in phase register */
 
-#define SEEK_POSITIVE	0x070
-#define SEEK_NEGATIVE	0x074
-#define STEP		0x071
-#define MOTOR_ON	0x072
-#define MOTOR_OFF	0x076
-#define INDEX		0x073
-#define EJECT		0x077
-#define SETMFM		0x171
-#define SETGCR		0x175
+#define SEEK_POSITIVE	0x0F0
+#define SEEK_NEGATIVE	0x0F4
+#define STEP		0x0F1
+#define MOTOR_ON	0x0F2
+#define MOTOR_OFF	0x0F6
+#define INDEX		0x0F3
+#define EJECT		0x0F7
+#define SETMFM		0x1F1
+#define SETGCR		0x1F5
 
-#define RELAX		0x033
-#define LSTRB		0x008
+#define RELAX		0x0F3
+#define LSTRB		0x0F8
 
-#define CA_MASK		0x077
+#define CA_MASK		0x0F7
 
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
+#define READ_DATA_0	0x0F4
+#define ONEMEG_DRIVE	0x0F5
+#define SINGLE_SIDED	0x0F6
+#define DRIVE_PRESENT	0x0F7
+#define DISK_IN		0x1F0
+#define WRITE_PROT	0x1F1
+#define TRACK_ZERO	0x1F2
+#define TACHO		0x1F3
+#define READ_DATA_1	0x1F4
+#define GCR_MODE	0x1F5
+#define SEEK_COMPLETE	0x1F6
+#define TWOMEG_MEDIA	0x1F7
 
 /* Bits in handshake register */
 
@@ -284,9 +284,9 @@ static inline void swim_action(struct swim __iomem *base, int action)
 
 	swim_select(base, action);
 	udelay(1);
-	swim_write(base, phase, (LSTRB<<4) | LSTRB);
+	swim_write(base, phase, action | LSTRB);
 	udelay(1);
-	swim_write(base, phase, (LSTRB<<4) | ((~LSTRB) & 0x0F));
+	swim_write(base, phase, action);
 	udelay(1);
 
 	local_irq_restore(flags);
-- 
2.52.0

