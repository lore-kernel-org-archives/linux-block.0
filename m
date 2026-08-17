Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09A259C9C;
	Mon, 17 Aug 2026 01:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931862; cv=none; b=RDU4LgYTTC1wQPPs3qAWoCLZeXSqnge3ZO/2grI34jgRodACw+Etd6Fw/kLKsfHdR6pYPt93sFDzVNLbFU44qBxml0w82UQjKAcDZQ9N0Qel+D18UTNsr9bp+91himn1T4hzL4nPBi8vEUe/yC8KZDUapS36c734BYMpeP9BxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931862; c=relaxed/simple;
	bh=C7jS1ISjo25dgwzMQhyIC0/xW99CJACmxGISeiwnhME=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=JGYF1BV/tzWRHY6BCNG/FMKZov7WVvXjvqhpzS2Z3+ZyAEqMeEq2484WHID3GkoUFDfJqN8L2p15tA7yDhVRuEiZYi30HwE1Rt2pTggKvOnQbrWMdc/xuEHR0TAyYzQiHaRqFhz7FPe7qb7DDNzuErRgPUImzd7IeQFzxnm+Qi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrVtSRsM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrVtSRsM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45F55140007C;
	Sun, 16 Aug 2026 21:57:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 16 Aug 2026 21:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931860; x=
	1787018260; bh=cjtCiqbgtAb5vjXg/Fe6qpz4E3BMwlkdBKUib/nB9iE=; b=K
	rVtSRsMWEubpjIxSBbg09MJPtrZpl+JbC27+7PF3KApOZE25qD7cNpR1ISixBucH
	TvM4q4Zai2kfHIyYfPffr3hlJis1Lxsn6iOTRftbzyxQ3eVbt1sMddmnqYdkcl4v
	uVBUWGdHExAqrh/K1WQ9ZWf+yk0dtnmmUACkli3JImyy41jbz4XE3JbjLMHJq6Uc
	6DB/tG4nhyiEL5EgTqMYu9S/ZDA2vqy3yE6lEzSTblGM9EJzHIPscBkweqr5ZOPo
	L2vFlbx6J8AjTZajR7zjzg1qzkoyHYnvz72qeEKY/jk+65TTZrqO131POIY6JpzH
	ksnSgzcXhbhQy+QxpJpjQ==
X-ME-Sender: <xms:lGqCagn24RErzAJAq8LuY_TTT2pzZhdyCPe-WBrOQNZmGPBVpf-SBg>
    <xme:lGqCap4325BYAVNKvxm6rqMv1qTtnTsorbujKrCP1fwCH95eIBQX1TxpFLxZCkN0G
    8-zyC0DQPKFPDdASamcuaeQiXRqZ3N75R4Avw_1OSKX6b2qEXCUYsY>
X-ME-Received: <xmr:lGqCauj90F43sLutnKXM6zdtxUV38FG2vF5U7-Lp5ZBs9FeOP0pZ2YGNQhaw25XFlWdOCLFO-20GxkkYQ6NtoxlFmOs2DEnhRS8>
X-ME-Proxy-Cause: dmFkZTGGfSHbL2fI02qi3PxN23Kck6mI5WuUw/IvRcvpbY119ewffFmgrLaJZrOewmv0V9
    +yVjmNFRAF5v6NwN93pp2/ef5Xe4c3LI9irOXMRuZYHRPaDMJE6WMter/2+BypR/48/QT6
    HY5IjuzvgSjmo92SyO1FOx3Pzj+F3Bo7QzXF7kAkGOLlhjpoHeFsUQfm7dkDIAS3zbzZQZ
    kdzEEhr46dUOQtvTauSfnNDphJtrhISaD9OmmoKzjI1J4txcn9eV52lgr1VrqNf0UkcCn2
    OchZn8Fy5DmAdO0OzTlRhd5sxDSBZbWOqIe4VCopfX4yIdP6r//KsVzdicR3q2dH2I0XlK
    83e5PhH6XWR8UD22F9msG7MznTQdCpCG10bzFQWIskv6BRMBJkv3vdCwVl91u0ccsjRPYw
    D9WyJ+w6/XXDPCtWft95TwdyQJ+bC77kpUM1ze0312o1AdZBb9GuBjutuNSwuInVwulVcn
    cG2v8G9vtlMGnp0xhNhRHs+shUsetx825Lt09ysDX0cD4SpNejbM4CcHCbDA7QlR31WCrH
    QKimyDuuYw87S00+DUvk7utAmL0c7FOL7YkMgKA/Dv58iFZlu/rAGk6XzKeVY9uMYZTXkB
    1uQO/4uUoowzhlz6BkxDPZ9y43u5VpIMWHNwR9eKNNkQahmd1tNn7LpXj5fQ
X-ME-Proxy: <xmx:lGqCauGGY_MYmV1uTS3enqqESs8uZEYNHS1PrpgnFZbT9bKlKIlZzA>
    <xmx:lGqCasRRhxUaLRy3ss6IFeD8wDWR1lKkqk0ar6Brmc8hAVDIl1fjjA>
    <xmx:lGqCajwGrYuHIku77nedj1Ae3IP4FH1XTqLCKupJ1aXaotbHWi5wjA>
    <xmx:lGqCagce1NuJB8ipj5IjGaWKX1dY5iYPLxqN2GcUfkKxnedtC5CJJQ>
    <xmx:lGqCajWNH_5IA8yy1Xy8FBcc-qlyxMsTJw1UP10GydjT7X1UehHANPmk>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:57:37 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <b1708f9276efd33c9f85047045b813e941f7aca0.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 21/32] swim: Revisit delays
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

AFAIK, timing requirements for the various FDHD drive mechanisms aren't
well documented. But we do have the UPD72070 spec and secondary sources
like swim3.c and mkLinux source code. This patch is needed to satisfy
the requirements in the UPD72070 spec and follows mkLinux.

Change the LSTRB pulse to 2 microseconds, because this is what mkLinux
does. Inside Macintosh says, "Hold LSTRB high for at least one usec but
not more than one msec".

When a disk is ejected, pause before de-asserting /ENBL. Wait 150 us after
the STEP command for valid signalling. Pause for 1 us after setting the
step direction before sending the STEP command.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 987e43e5b4ef..eb4c2b7c57e7 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -290,7 +290,7 @@ static inline void swim_action(struct swim __iomem *base, int action)
 	swim_select(base, action);
 	udelay(1);
 	swim_write(base, phase, LSTRB | action | PHASE_PIN_DIR);
-	udelay(1);
+	udelay(2);
 	swim_write(base, phase, action | PHASE_PIN_DIR);
 	udelay(1);
 
@@ -337,6 +337,7 @@ static inline void swim_drive(struct swim __iomem *base,
 		swim_write(base, mode0, EXTERNAL_DRIVE);
 		swim_write(base, mode0, MOTON);
 	}
+	udelay(1);
 }
 
 static inline void swim_motor(struct swim __iomem *base,
@@ -355,6 +356,7 @@ static inline void swim_eject(struct swim __iomem *base)
 {
 	swim_action(base, EJECT);
 	swim_readbit_timeout(base, DISK_IN, false, 2000 * 1000);
+	msleep(1);
 }
 
 static inline void swim_head(struct swim __iomem *base, enum head head)
@@ -368,6 +370,7 @@ static inline void swim_head(struct swim __iomem *base, enum head head)
 static inline int swim_step(struct swim __iomem *base)
 {
 	swim_action(base, STEP);
+	udelay(150);
 	return swim_readbit_timeout(base, STEP, false, 20 * 1000);
 }
 
@@ -398,6 +401,7 @@ static inline int swim_seek(struct swim __iomem *base, int step)
 		step = -step;
 	} else if (step > 0)
 		swim_action(base, SEEK_POSITIVE);
+	udelay(1);
 
 	swim_READY_timeout(base);
 
-- 
2.52.0

