Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4240A93A;
	Thu, 16 Jul 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197232; cv=none; b=J/+553P1yqgMWasAsRXxCc0yPqPA1jBXBMjRjbVsYe5b/ugLPsQZqX0dk8al3rF4hXbFz+sOGYvBwt5bIEeCnTvcF6VHlHttoyDh8QcxD4DP8lotCvSmkBOwGjEHXxRG2b7sabXLwBpfW///OAYA11XVC1VSg3P8JYMCmTAw4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197232; c=relaxed/simple;
	bh=7PGOVL3SzYHp847hvCD5GRRs/5qRBpsz7rwupuXXxUQ=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=LSSx/WY9Cwt+v77klopa8P4iHKs0GrKfVSU1cIcw7GsUIWDExS/L2tEKDuVHqH/Mc7EJvio1JvMClvjZOLqGzlWU47J8dI292VMC2kahwZwbZZzjTJ43baneBELLPszfONWez8MSejbTvEFftncR8uurvDpc8FBPh8wLSSeV5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ik4FXBWj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ik4FXBWj"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B955EC01A3;
	Thu, 16 Jul 2026 06:20:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jul 2026 06:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197229; x=
	1784283629; bh=zVgznqNhqudCQN+U100hyApWowTL/sn2IB8gWyAVitc=; b=I
	k4FXBWjBfhc9U2/RCFEroj2yBFGsv7miJg3S4uNwU4MGdTHMfOaOeskIOpy9ugpY
	NsyEliHMDmoO+uuLZhrHp4FQZPO6JII3Vjm/uOfoKfMofhUYrbN6eWCmFfEndYI7
	T0WLA/5XRtx0/FqBcwKMAdgoRWNjvDf793CVf2YJ89j1AoAVTs88L8uwgfSiOJzY
	tt7fsjzH8st2QUWQ/FNsmbmIvf8bPC0Uc0YUT2+uMzBrdbBwPHwG8k0/tTu5Q/Rj
	cdxiT1aTRbLbs8VZseOMNh0tumYsfErznH6hUTIQAZPYiG62psrvq7r4mYBq3+gV
	PV9ov8FH3SFwkfgq656bQ==
X-ME-Sender: <xms:bbBYahLiN6Kw1BiXkij4ybmJDwMWoKx1AjLkXinOzoVQjgfzA9b11Q>
    <xme:bbBYanPNzJ2NzIimaZXwCrlcUE4t2k17EMRQ7gfxxZ_vLNFUPAIYddf0yqNxeXAro
    2TlLQiKUExWzabvGTSI61KofDpg-HFE0IDJxSozln5JPSk6qm_CkHI>
X-ME-Received: <xmr:bbBYapknp8R5bBnhjfl09lsMZze7d0XWijjHdGJE0y7yCISr4Nv9Gq6OWVmkIQp3I6Z71MknZA2jdA15KfavA7Zkb7LVG377ERg>
X-ME-Proxy-Cause: dmFkZTGS6ZY5pWCItkgy9Xukn2zcuewFxo8ZHHN4pRvLqTF9Ej/jkXu4Mnxg+8SVH62C9Z
    NdfHOTAcoQsik7u3NMaqdaj/Sb4GyhvEyXqxfPz1ORC+VOfUwL7xO6EixFaof20XPTjQoT
    w0gMCsjiGcBL5Sc/2+7W28zCMKgBMJ8o0m6Z5UnNj8t2Ub59pnmCGLWOBXXFwHGukKnjg9
    oPwii2VoGp9LyZNtBuP22Qc33o2tx6mCHkKvSggiUEwKtN1s+YoPNk4J+4iDvPQupo41VS
    yjh7oZu4qBQRwkQZnPNtC4Habjb6Lk5fCXqzalnvP7SEl72bFlt1OaIxxzE5VmPVNQezpa
    6gBz4pfVyvFJbs5Ac5rYe0U46UCKZWZkslRBQyN7Eqbrc8xkB9PUk07WNIPqwkJjurUMO6
    JgOyB2cdRzMPCQi0+aWxH/qBaAYMSwrN3rELrYdtYu26ItuUoDsP4zGgehwqhbF5iTm0LF
    RYYPIFwDrivoK28vJkcD6EItH3DxZW0QPq36FjbmEKa3YjnKhRK+Ei7PFGX7KQCI4voYCA
    fkXMgS/7VfaiH57YS0iBM/6zfKuW0DnRy9Kw+MgA0A0mUS6do9rd9kK7y5HJ0X/GPqxM3o
    NRcUEftPtQ/m0RNxKlrBmSMbQMtmb5Co+VILv4hh0e/3q+BmcVax7Ytsbs9Q
X-ME-Proxy: <xmx:bbBYaj5NNKYZUUg-uSlXi8zAo_Jn5ovSsdhwKKyQFliBu-YlwUdF2A>
    <xmx:bbBYal1VX055u5WLy-0ejaQF5NYm76ZC-BCvRLoXBFUpOQP03xsj_Q>
    <xmx:bbBYamEE7tHAkQScxSwjq6fmLq_asApDwHRt5CMA24sM74ugAt3V2Q>
    <xmx:bbBYasiR8Ym1j6DmyFo63EXUv030g5s6FBxOtdp7JCURkyRfy0PN0A>
    <xmx:bbBYat4qAw8T-UqmMlexLYtCFq-9hyQ9MbrB7Gh-QLoH9nU8l_WHLPgG>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:20:27 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <7f0be2470206f78fb64d7df72e4d6948a21ec2ab.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 19/31] swim: Deduplicate polling loops
Date: Thu, 16 Jul 2026 20:02:15 +1000
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
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index b4bf96a788db..c10ad1266c3b 100644
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
 
@@ -309,6 +310,12 @@ static inline int swim_readbit(struct swim __iomem *base, int bit)
 	return (stat & SENSE) == 0;
 }
 
+#define swim_readbit_timeout(base, bit, val, timeout_us) \
+	poll_timeout_us(, swim_readbit(base, bit) == val, 1000, timeout_us, false)
+
+#define swim_readbit_timeout_atomic(base, bit, val, timeout_us) \
+	poll_timeout_us_atomic(, swim_readbit(base, bit) == val, 1, timeout_us, false)
+
 static inline void swim_drive(struct swim __iomem *base,
 			      enum drive_location location)
 {
@@ -331,16 +338,8 @@ static inline void swim_motor(struct swim __iomem *base,
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
 		swim_write(base, phase, RELAX);
@@ -349,16 +348,8 @@ static inline void swim_motor(struct swim __iomem *base,
 
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
@@ -373,19 +364,8 @@ static inline void swim_head(struct swim __iomem *base, enum head head)
 
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
+	return swim_readbit_timeout_atomic(base, STEP, false, 20 * 1000);
 }
 
 static inline int swim_track00(struct swim __iomem *base)
-- 
2.52.0

