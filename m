Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20C44238A;
	Fri,  4 Sep 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514462; cv=none; b=kzMnkx03xLhnqaBqH/fxLQP+/keQnv8sdjZkpXkHcgZFCKBwQmLYfkGEMlLSdSzK2p1VjUUPSQkIEiB6vT+VvrkteyDAe57UbWlxLHd98CJW8LVnTbMQ0NJpPwebx1PPhixF5+VrYQAg7PtDbzmhH8wmGZQBNcURkytSTtPNFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514462; c=relaxed/simple;
	bh=1wZ85nY1Xb40yLRL1WgRJHMZba+zxtb61fsKP9HuagI=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=anHJ/SfmN2PIc/pPZodrM5uLGu6iRh2S/T/hw4kJQxCVHX1UvLeDKLvXNq+Omsd26VVWN+Et9HI2DMjwBthPpdqVxO0aqC5rheWgha9CKcboLLPC1EzfhyvTe/f2q9/WirPkf8ULSA/sSk6uatHw/S/aC4LzdtgrK693bRR5UQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UhGefoGx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhGefoGx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA042140009E;
	Fri,  4 Sep 2026 05:34:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 05:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514460; x=
	1788600860; bh=OgrKuJ8TfhNYprofHyiwoLzqrOniZxrU9W3RTA8FMaQ=; b=U
	hGefoGx0M7X/L/R8AwakmXLco2lYHRPlqA6sXhwGJgTESXxhyH7G1cn+x0XU3DPL
	ksCG314NbpVxch673k+44yB5TiOxmcgAnAzAo9RehXe7H45U4W9IBRBcZr3t6+Od
	bzDurWW8cidg7LGkvI2cfJWjmt2ywiS1Bd8fDvZRu2PUvfwn/+nMXeb5WKgwkZOm
	IJzkgHzcFtd99PCl+90nNxpTdXtwsZS8css86OTR2/DS/yDdJ076TFLa1zVzhgth
	5SGZ1Cn0ntol+CfRKii7y7umOilLRu76XB/Xjky3pHKoypDRw5KjMdKPuyLXHBAV
	i32S1/VCVnao7sj1lOHwQ==
X-ME-Sender: <xms:nJCaakBXHiNpZ0GkgUO9TTFkjKiBRhRiqgcuW030WTWfwtbMVs-VIA>
    <xme:nJCaagkGnHecE650xly7m7uQh33wR1s8H9UgzWCqvv2B4615k3kJL047SBSgttHe5
    xVybXmevPkhazrj-Zb2h8fXhaJhiBVcVxRhUS4xiSOGRehpHPhLbhRG>
X-ME-Received: <xmr:nJCaancDAe2qOOhYFPL7Znjo5zGVByl56kYpf5LpcSeZN4wehaD7OYCYtbCBMAi5JZ3Br9mgP57jpd6YC7kR3lHVCOfMZP3y5XA>
X-ME-Proxy-Cause: dmFkZTFZ/TtYWX7QRSPqbWdhFvGKPdYLqSrS0kW5tw/ccCSeQwGXLU8z8+n4MTGG5Fz3xO
    fBhPKm+HgWFmiq+gJDvSVIfRvZvgV672b0RABACnDdhJF/iW3opz+U3/SP3bVUvVx8Q287
    Ap1gWmRx+bP8FRnMF0HKeE0yfsMRD8AYBXtaUsZs5aI7BW+fV7e9Q0YJu0hP5K8l60oxGK
    XrcuXNo1hSmleRjGCb9wMFpOFKoRGwYOR+2UyWTZOvcSmWg9D5Za0czKtKfTDaJ7RbQZgm
    lIJH+OOpA0D60VJW1h483ZeutJ4e8G1K0sL6VJD12jwsAudayvIunnWKGaY8cBa7nccFl4
    dGRPIrPp6c/LFUbbk9AdFDSE4WRvUuWsfVOhrTdU6AJGIOPebqRLOnkqmR4ZIMSPPHRo9Y
    A9HSuXqNi2UYrB4vfY2H4WQGQSL5+AZZE4R5+1QFeqKO03uzL5bdr044STmLxGkF5kfbVC
    IVmpZ1Gf+bfqL5370CJFJ3oQULNZzANfdh62d7Lk8EKSr6xznZRgs2thtSgsCxsHUxiGB7
    m+v4V/PG+7pkDdC8EgLWFX47PdNX0Oprmzt9JudmmKothO8aeRGTH52vTQafELU3RQN8j0
    XizwNI333OiNIiWqGS1ggeb5mgd38X9p6vkKtGVaOvuhASNxi6bt6pvmIV/A
X-ME-Proxy: <xmx:nJCaasReqMRwWLH9Njicrm4d6RLdNIL-cacuFmEAmfLsh-VDbUXadA>
    <xmx:nJCaamsvEekkfVI_mF7fpQbqMrW0amb9CH-GKmsw5GL8q6jifmYuIA>
    <xmx:nJCaaldweKK1FylTkYcikwKHs-C--dZWKDc5V7dC2KI4heRL0N0NeQ>
    <xmx:nJCaaoaNqIy4Rh12ZLZ56HksB8j2f1t7LCUx6BP3LeqfOMV7XQIcsA>
    <xmx:nJCaasyEjSlKlx-kXsxoj5nw_WcGv51CMWV-scemIxMkLlEr6BQXLvj6>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:34:19 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <08ab67c2780c9107b87a1ece8b5f9cb54a8cea70.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 19/33] swim: Remove redundant RELAX actions
Date: Fri, 04 Sep 2026 19:26:36 +1000
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
index c3fbcf377d1f..ea4663945505 100644
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

