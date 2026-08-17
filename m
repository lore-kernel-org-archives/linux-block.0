Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515C18DB35;
	Mon, 17 Aug 2026 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931833; cv=none; b=u6xciFqPCu/NBDBFjbiYS6ZGIjITQQLM8r7+yGC+qDDFbmx3rkLb7r1ZUSjOowqb9ogCRZ5VgtPQjRZJgByeflICU9vhSCjjizp5vdhRcf3o+HG+pXjwK1fff7htChgMxbB9FFOKeR6AUsivjYoWeAgqmf7xrEC2Zaz9pnnwnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931833; c=relaxed/simple;
	bh=l/qF4glc5PoZL52mcooNohJpMSiRF7vh9YBAUblwifk=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Yv2VPBplVVx/IlbOyDbX1dGqbmiHaRpHzv0ByeJ6U6Km0UuNqkvJcXD0KcACxBAo+KBM1RY5YPfiLOR9msC/0sShqGnAnbzDkHX5rdGSjYc2OT/XheSbOpbd9giHJsfGlogZvZscMNxEtv/eIptyE8oLWTRbu2Lf6zrX5F0ThIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YF3aX+5t; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YF3aX+5t"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72BC9140003D;
	Sun, 16 Aug 2026 21:57:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 16 Aug 2026 21:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931831; x=
	1787018231; bh=TkP38yZucR67TzySuCJiwBsl1Gd3dIOVglZIr0Jkeag=; b=Y
	F3aX+5tSnvPJQNwaZFY0MQgGJL6w4ng2KzZ0HfCoyGtRO5jStzShRnm3RTCV7joU
	pDPZwMhvEqqCDHcNytubJfqlFGPwb2n0bCXhdyFUiGIsVqfuk63R6+E3tTNtAMYO
	88JCZqOUxyvAsuw/nsW0KXs9uFzNYd1Zw4NdexKjzw57lxfX+AT5twXAe2C5l4VG
	2u20K85liFzNlKndVc39PCOPFtirGid7JJfPyi8Qc/DPYFa8H4aY4g/Ko5NFr/Ah
	xrec+LeG/ZXU5MjtuezfqMBFL2mvEWjWY3EUP8TIIhMieK1oYMgQGedtwBg1d8JU
	hMEav3W34pn6olELKaadA==
X-ME-Sender: <xms:d2qCauchnBf7SHHwsvJON2L3N1yBlzRCFEQw3af8-r-4FIWmtKFmjA>
    <xme:d2qCaiRZMTm56IvWRb4xb7YCSqMNIA-sAgJ1Dhw0k_LWHqwyorJLN6OUOgUJAFsHN
    Lfj2nB-8JKUcU6dTVGzt4hf3PmerlhO9R5l-S1J2Yp1ci9cxcUpeHr_>
X-ME-Received: <xmr:d2qCavanI4nACX0qYnBtYELbUqWhxstHYBbLup5DRO6HSlSOQE1BldyU_oM5nhshHOSdQkki1s-ROE2mTt-idWNT7ziixZzBYcA>
X-ME-Proxy-Cause: dmFkZTGGfSHbL2fI02qi3PxN23Kck6mI5WuUw/IvRcvpbY119ewffFmgrLaJZrOewmv0V9
    +yVjmNFRAF5v6NwN93pp2/ef5Xe4c3LI9irOXMRuZYHRPaDMJE6WMter/2+BypR/48/QT6
    HY5IjuzvgSjmo92SyO1FOx3Pzj+F3Bo7QzXF7kAkGOLlhjpoHeFsUQfm7dkDIAS3zbzZQZ
    kdzEEhr46dUOQtvTauSfnNDphJtrhISaD9OmmoKzjI1J4txcn9eV52lgr1VrqNf0UkcCn2
    OchZn8Fy5DmAdO0OzTlRhd5sxDSBZbWOqIe4VCopfX4yIdP6r//KsVzdicR3q2dH2I0XRq
    aF44g2C8oNTPcsNGczlwTTQcs+MxL5x/UGA3BfMT0RkBWRKz19sqaOamdCFqs7Ja/J4zQk
    ZhKzVBv0VsNY8w6prT0SI1NlAZnaIt4UCwoMpy5n+go4Uv+5NnegWtGErSaDaug+mMCLIy
    Cmq2913LdRiC5cZio+RuhxwBdQqNTrMDmfGAYKRImTyYiGNRLiXMSZ9y0tmdvPih7Bp4tW
    uFRE1IR8YEAZLCBD+VFlQnyf8jxhDKbVuYJwJHFYZsJeBFnC6Vvp2kPrP5f5BFRoM5H9O9
    x27sXi5BmRrxbcPFrYTU+n+9Zq9/0zxOO+cVMEbKgOQpEW1oJiljHSgbd/sg
X-ME-Proxy: <xmx:d2qCateCRiYWRsZdwvIGDX8JVEZbppqp8Zb61l0WeqPFdPhSKjCUDA>
    <xmx:d2qCaoKdU0l2u-RYYIqAJ88M155KP1rgxB1FgAm3FULYiDuXj6Z32Q>
    <xmx:d2qCaiL63bwfNkOccNOGl_xFm7n176Wmbtrord5no71RJya8sQVOEQ>
    <xmx:d2qCavWa1BQA-cTsXEJ_dWDUuZUCTn_b4oR5sdAc4dyor4MHKbuqug>
    <xmx:d2qCatML9MIouQpot4t88OLl8SKQDv1RyeVFi8cVv9qwzyN-hHy4Bndn>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:57:08 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <20acc6e4cb6f7b0090b294ab39d2913b40fd2731.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 18/32] swim: Remove redundant RELAX actions
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Wherever we have a swim_select() or swim_readbit() call there is an
implicit RELAX. That means the caller doesn't have to do it. Remove the
redundant code.

BTW, Inside Macintosh says, "Be sure [...] that CA0 and CA1 are set high
before changing SEL." Hence the RELAX found in swim_select(). The SwimIII
driver in mkLinux also has that. But the swim3.c driver in Linux is odd:
it scatters RELAX actions around as though SEL was not actually under its
control... In anycase, swim.c really does control SEL so there's no need
for that here.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 8c8b157e2d74..9635f4df3fc0 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -336,7 +336,6 @@ static inline void swim_motor(struct swim __iomem *base,
 		swim_action(base, MOTOR_ON);
 
 		for (i = 0; i < 2*HZ; i++) {
-			swim_select(base, RELAX);
 			if (swim_readbit(base, MOTOR_ON))
 				break;
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -344,7 +343,7 @@ static inline void swim_motor(struct swim __iomem *base,
 		}
 	} else if (action == OFF) {
 		swim_action(base, MOTOR_OFF);
-		swim_select(base, RELAX);
+		swim_write(base, phase, RELAX | PHASE_PIN_DIR);
 	}
 }
 
@@ -355,13 +354,11 @@ static inline void swim_eject(struct swim __iomem *base)
 	swim_action(base, EJECT);
 
 	for (i = 0; i < 2*HZ; i++) {
-		swim_select(base, RELAX);
 		if (!swim_readbit(base, DISK_IN))
 			break;
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
-	swim_select(base, RELAX);
 }
 
 static inline void swim_head(struct swim __iomem *base, enum head head)
@@ -385,7 +382,6 @@ static inline int swim_step(struct swim __iomem *base)
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 
-		swim_select(base, RELAX);
 		if (!swim_readbit(base, STEP))
 			return 0;
 	}
@@ -399,8 +395,6 @@ static inline int swim_track00(struct swim __iomem *base)
 	swim_action(base, SEEK_NEGATIVE);
 
 	for (try = 0; try < 100; try++) {
-
-		swim_select(base, RELAX);
 		msleep(3);
 
 		if (swim_readbit(base, TRACK_ZERO))
-- 
2.52.0

