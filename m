Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5C4457A6;
	Fri,  4 Sep 2026 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514473; cv=none; b=KEsBntAJXY93jjSjlxwmf50YmZde5WLixnPDRzyAfOMnashXfhuP48gcs0wogl1xcko9S0oBpWmcVMxYqSNslBoSR43AlCP86k07uvKyGhy/WXSC7Jh/axilABB8xzcvQUpSSXfiUPRj3yJefPwXr488iKJfIOV+DyAsL9ptb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514473; c=relaxed/simple;
	bh=dO8QMILUhgA8Zfx+Xfz3sPDUvz/p9npfdmFjZGwc3Do=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=NP+E8bf1aP3Ot5ALxPaoU0A0VdZFMZdAI+zODBbT+l2RsiQ5gDVEth9AbEuua/yXrEAKyfWkrZ9DqFGRj76qatkdnmsVtlbEljDWa1jBw4m1HxxTyF8vT2mw6oWPkAFhn4Q2KbWosRUccm+FdKgZ92fEr8UUkAY3i9LBBeb5HSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QY5fWU5n; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QY5fWU5n"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EB47EC016E;
	Fri,  4 Sep 2026 05:34:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 05:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514471; x=
	1788600871; bh=rkNIHvKMgEJtfrOYGBua/B72Sum6l4yyKQbdbImuNyM=; b=Q
	Y5fWU5n6KYTqU2wc6s9Kizd7F8f0TY6Yn9ENLTrwoU7hMMtOpQXOyz6UJgcTINCv
	z/CfXjoJvctIyfRw0ee2zYolt1JH1PQQ7YxP+HShDgcwk8W37s8PMckF4heRKv8l
	Zx5PMSVfRrxUP2SZeMrMUEAEnVqMmPCaPzJTGn5PFiDWGINBLJ+1AWY8Ma1b1z0f
	5CR9GeTcivGeLESpZ3NGdvnWhRtk8ckMg2MmQBZLywEZilU1xFCCpJBvNagAv0c8
	2jgI3dfX0Nlcl9stcJaNSrLM3w+hNHvbU9ukK/bZzLbyAuBwivvKcI1aCLSzKtzA
	SU+w9I+FkhXcXme3/KIvQ==
X-ME-Sender: <xms:p5CaagLwYVqWeb4z4xyCIR69o5UJFapr0Z6OxHAIvki4d2ihZluBEw>
    <xme:p5CaanxYB-vbMtaNzUjegvsfjJf7kwdTM9ufZd39rhjh7mNN5Yp6tZB9z58r6VkhD
    Rdk0oyC6aThFdDZlVuo0hjbub2-1pR2dZqi9qhESCmdY9Gp8Hgu93xh>
X-ME-Received: <xmr:p5CaauUPWVSLFP3myzpVSFbhFRtSojoZDH5Oz_N6CcZx8OPik8Nuj3my2-bvG9Y54kfOb11kTa3g60Zt1M2WBBnkXJRTFLxYhiY>
X-ME-Proxy-Cause: dmFkZTFZ/TtYWX7QRSPqbWdhFvGKPdYLqSrS0kW5tw/ccCSeQwGXLU8z8+n4MTGG5Fz3xO
    fBhPKm+HgWFmiq+gJDvSVIfRvZvgV672b0RABACnDdhJF/iW3opz+U3/SP3bVUvVx8Q287
    Ap1gWmRx+bP8FRnMF0HKeE0yfsMRD8AYBXtaUsZs5aI7BW+fV7e9Q0YJu0hP5K8l60oxGK
    XrcuXNo1hSmleRjGCb9wMFpOFKoRGwYOR+2UyWTZOvcSmWg9D5Za0czKtKfTDaJ7RbQZgm
    lIJH+OOpA0D60VJW1h483ZeutJ4e8G1K0sL6VJD12jwsAudayvIunnWKGaY8cBa7nccFIz
    BaxXso6ACFmOH7A+7jeNeRS3VwPeCIl68212f2eVwLYW3oARrJDnfTg673wbMaO3pTWEJb
    mXq1p1XwYpfuQM2ADqW3g8XUkt3+USUbM7r6C6pGGq+Je2+l/oxv73Jv5T/wZcbCNqDAW/
    zoTc3axXRG02gVo9TPjTl1fonIUr2w2zVlE35Clygc5s7ctFFY7ACoFItbvSVbzqYRLSxJ
    ynOQDFxmmA7nThsG4ky2OvtMOIeM4TxrbxaD14wFTY4TpCftvNQntGL8ogT12eD4VhmAZl
    ZLE6swUgxEjTvqIMoubqW5hDO7lSxvINlXwxQeR3S/UxRTJ7PVT5++9/sk6g
X-ME-Proxy: <xmx:p5CaanhA3L4_ORxrZGuyJy8cGR-ez1jy68rLaVq-vtxArMbkjxNz1g>
    <xmx:p5CaauBgPBlCk7nbYQ3MODjzIDjXwsFQz-dhzvwHpVl3GcE8lveWqw>
    <xmx:p5CaatsNfbRwHMf5MkEhhk1JImbW8fxBa2OgJHNR2i8pBWxGEoqVuQ>
    <xmx:p5CaaiemTcQo2sAu06ioJELL75d6rjGJRvaxFAM9YR1G-HBKTFk6fw>
    <xmx:p5CaatyryBNMqgYGHaXmnSZuRIgv6WmCsZr0aruLoI6T5VxpZSa59W8h>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:34:29 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <0ea2d3313dea26f8b4c2abc4d29055ac95aeb74b.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 20/33] swim: Deduplicate polling loops
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Replace duplicated polling loops with poll_timeout_us(). Change the
interruptible sleep to uninterruptible because signal delivery shouldn't
be allowed to shorten delays required by the drive hardware.

Change the timeout for the !STEP transition to 20 ms in accordance with
the maximum interval required by the UPD72070 spec. The existing 1 second
timeout is impractical considering the number of steps in a typical seek.

Change the return type of swim_readbit() to bool because that way the
bit names make sense i.e. the reader doesn't have to remember to invert
the active-low logic used for drive signals.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Dropped swim_readbit_timeout_atomic() as it's no longer needed.
---
 drivers/block/swim.c | 39 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index ea4663945505..59e00fb2bff5 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -19,6 +19,7 @@
 #include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/hdreg.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
@@ -296,7 +297,7 @@ static inline void swim_action(struct swim __iomem *base, int action)
 	local_irq_restore(flags);
 }
 
-static inline int swim_readbit(struct swim __iomem *base, int bit)
+static inline bool swim_readbit(struct swim __iomem *base, int bit)
 {
 	int stat;
 
@@ -309,6 +310,9 @@ static inline int swim_readbit(struct swim __iomem *base, int bit)
 	return (stat & SENSE) == 0;
 }
 
+#define swim_readbit_timeout(base, bit, val, timeout_us) \
+	poll_timeout_us(, swim_readbit(base, bit) == val, 1000, timeout_us, false)
+
 static inline void swim_drive(struct swim __iomem *base,
 			      enum drive_location location)
 {
@@ -331,16 +335,8 @@ static inline void swim_motor(struct swim __iomem *base,
 			      enum motor_action action)
 {
 	if (action == ON) {
-		int i;
-
 		swim_action(base, MOTOR_ON);
-
-		for (i = 0; i < 2*HZ; i++) {
-			if (swim_readbit(base, MOTOR_ON))
-				break;
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1);
-		}
+		swim_readbit_timeout(base, MOTOR_ON, true, 2000 * 1000);
 	} else if (action == OFF) {
 		swim_action(base, MOTOR_OFF);
 		swim_write(base, phase, RELAX | PHASE_PIN_DIR);
@@ -349,16 +345,8 @@ static inline void swim_motor(struct swim __iomem *base,
 
 static inline void swim_eject(struct swim __iomem *base)
 {
-	int i;
-
 	swim_action(base, EJECT);
-
-	for (i = 0; i < 2*HZ; i++) {
-		if (!swim_readbit(base, DISK_IN))
-			break;
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	swim_readbit_timeout(base, DISK_IN, false, 2000 * 1000);
 }
 
 static inline void swim_head(struct swim __iomem *base, enum head head)
@@ -373,19 +361,8 @@ static inline void swim_head(struct swim __iomem *base, enum head head)
 
 static inline int swim_step(struct swim __iomem *base)
 {
-	int wait;
-
 	swim_action(base, STEP);
-
-	for (wait = 0; wait < HZ; wait++) {
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-
-		if (!swim_readbit(base, STEP))
-			return 0;
-	}
-	return -1;
+	return swim_readbit_timeout(base, STEP, false, 20 * 1000);
 }
 
 static inline int swim_track00(struct swim __iomem *base)
-- 
2.52.0

