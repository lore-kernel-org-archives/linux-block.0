Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2B313527;
	Mon, 17 Aug 2026 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931699; cv=none; b=OOt8cNcCfGjtmUGMaIvuQab/VbxctgS5NXIj4v0+3EwXPv4taycbvTmqrC7aB0E0nk1IHSRVFHU2+A8Ui+IOZncthA0hcAtGFI0WaaPnVZEiIhqZGqQ+wHzjydrV7+IfEJJbY5sQMWhVJgc0TmRLlF2s+6MABxqLrZAZFzaYdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931699; c=relaxed/simple;
	bh=6osIxefW9WuJTL+x/nXswa0PPTDUDWFo8rRm7h//FJk=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=OcDVehwYYgjmROrPdcilsu7/kLW0Dv0qN5UlxMgmSGtSkQreus1ssJEmyMqMXAcGEMYGlTAhHCaF1ULgZOxalWeq65E6GuM/Ud99S9s9SgkMmtpAUNJCPH++5OD6HktE38rfSS3vp1Cn6uoWPsgxFGfKp6WmDqbyc4DpfUWHJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X3sOoUFC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X3sOoUFC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FC6014000F6;
	Sun, 16 Aug 2026 21:54:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 16 Aug 2026 21:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931696; x=
	1787018096; bh=gDu691Ym/3Wgf1jg+44n93Um7djI9WASUBUmb+nUwCo=; b=X
	3sOoUFCqBbXbJljD18Nt4h8kcZmDCyLto9zqCZt9ktsd61/4zAJpbgrWNFLJm5A0
	vnQ3o0KvXVysTtpKXrOU1qXrwQsJJzC7uJc6u9ExWn/m1y5OHuvJJbLbGnqnWr/S
	3F1c5f8+lu2SZ/0GvFj/SEgHNKsH4ptXx/LqyCV3v28FTHP61PA2KXZaAoHQ4IKe
	ruY5d0WA7uX7JQRxEmJdiv3CjvAjT8A9Iu+4FqXNmde9IDOIwznQc84XuySzQGNp
	BUF3RHGv9jjBqiYFI6Hod3tj0f14fy3F2xkADduoFQcfKupSmuPxIxnnHydtwV/j
	5OjdhOqmheqo3qQmh4sfQ==
X-ME-Sender: <xms:8GmCat0q0i8cMIiLZYEZs65gBiP5My0I7qzOfe5Hqvj9zkr_C2x5Bw>
    <xme:8GmCauItCKuXdVNhu9d1n25EMspGw9kH5T8X7wXil3AxxhLNo3SWEM4Tmp-zIlVGh
    MKE4F_ScO-m1ZpIXPfJbmwgTPv4iKomuR82j_-01_i5LlQtQOQB_L1f>
X-ME-Received: <xmr:8GmCatzw5uebvKoXScn5yxEsGyl-xPh3vinI2Ln70ewQse6lVP-aCy92z2GRAZr4l8hlCm2492oShUeN2rEXP0yYwjPlayNVTYM>
X-ME-Proxy-Cause: dmFkZTEcdm/H6lUz/GNYCURxrkCd1HPfYRd3zhai/6cdZjeenE7g5xoDzlQAxk+7iMQq6v
    xV9q7s5fsS3/JQzvNsjwyK/4cWW065gbm2GoN84iHcVNvAdCqKzmKSHTb8iEr45WtpyqeY
    cz4yU9C9Fo2z94qtPVV3dAzmSvJhNew7HqXMqftu0soscmI1GAdFoXf04kdvALh7XeUIuU
    Tuk2XE2OeIJdmWhM+PiCh0JMVi0kltBn7CwQl945VNkrHoqGgbuYhi8WoWtxLKIumeRTK5
    /WtK4yCHPyxyd9XATZrYk7BUHibsQzupfidfoh//hSLpDEkVyPVHII4Kj/fp06fOz7jSp6
    vWsM4bQ3x/w4dQc5SY81sHuPFYdV0oIiRdjMxw8VV+o3oUBazBqyFDMhbdFPrTzDea9kuJ
    3WOVcZ7m5x25Z9IpJi3KIJMwaOYUPpPtJENmcgfCmrwdBqv4VRCTSkBE6oLuNF4AcD0pxm
    sW5mSnZptCuidOFTw47xs8gEaZ361yx6pXo+B5n9NHn7inAzIQor9UF5DzfwAkR8ZzYQ/S
    s41DN1o1fqnOm/LEHzilFXR20ism9JIISz2PKSrlAFidMOgmhu2vWlVM5PdJ0eEGtUL9nJ
    LYgymdRUjbLdLz1O8UeY7gMiWzXR+SKGwP57yMDal2IlAIq3QVcWoR4+gfXA
X-ME-Proxy: <xmx:8GmCasUw85quQOLuWrUuVrMXbG0NYQiLFwUqLrnoqRlJPcMoXP3xRg>
    <xmx:8GmCath_hdahOfakpbvOvLnBX-gGQQVJgWchv_-9c6wjL-IbfUEkOA>
    <xmx:8GmCasCcvOcODQmTuEd1cC0QRiA5tvrIBUa9Mj--HxxoCtqwK23ZxA>
    <xmx:8GmCajvMYUkyP5cl8q-3g-zvWNQfx5g-8rFc98iser1ol_hKTZzQPw>
    <xmx:8GmCavJokTzrEJXvT_mAAxhJZ7scQg4YrAn2fENQRse6EYHYCryzIWVL>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:54:54 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <6e352470eb9a56b20336f94d93b4c46ee3c18afd.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 04/32] swim: Don't disable drive after every sector
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

This fixes multi-sector reads on a Sony drive. The Mitsubishi drive
doesn't seem to care either way.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 4ddb87977fe1..3f92677ad127 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -473,8 +473,6 @@ static inline int swim_read_sector(struct floppy_state *fs,
 	short i;
 
 	swim_track(fs, track);
-
-	swim_write(base, mode1, MOTON);
 	swim_head(base, side);
 	swim_write(base, mode0, side);
 
@@ -490,8 +488,6 @@ static inline int swim_read_sector(struct floppy_state *fs,
 	}
 	local_irq_restore(flags);
 
-	swim_write(base, mode0, MOTON);
-
 	if ((header.side != side)  || (header.track != track) ||
 	     (header.sector != sector))
 		return 0;
-- 
2.52.0

