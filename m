Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B363191CA;
	Mon, 17 Aug 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931739; cv=none; b=AsYywLM7Un7KMj4ZGxaNIVAfZZMLtcL3+GMx7/Az/xuVsvNpXc3eIGUX5cJkv1EnHPscPBgClwfJpmeOWDrbFn4I4mHZh6S6DHsQ5J5JgylLTdcpoCB6Np+GGE/fvfz9yAh5jJNc6E/1kZOHR+q+EHbba1w8MFanolvT3HNqrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931739; c=relaxed/simple;
	bh=S1sf+qp2cfbd5jdyPBAYCV1TXRpG2BraGxB8OKUlyyg=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=saptAuOBpocZUVEHxPKtiX3kxcDLEYCZQwNHhZr80ebXHrew5fLMUNl1L/CXDPxSD8ZdENOKEeiYXIAWCe1fWfuFjEMlDTCn1NkMZ1nPZDF6Cg1OTOq2Vs4SB4dFMWEgYaDw2jzgWbyyF82rhQPKZU//qQeF5qK/EBUzmAf6dt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtgHaTr3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtgHaTr3"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81C091400031;
	Sun, 16 Aug 2026 21:55:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 16 Aug 2026 21:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931734; x=
	1787018134; bh=4yvBgc+qb8743FNY61Gm5FcK+guiDG29W6nQ43Sr1EI=; b=F
	tgHaTr3OMSZ+/IIBS/rEVdpkb5YnTeubJcwu7OY0XnTav8a1xYKQE4X2EVWqgLmU
	egHaMRnnFF380sNXbdLofsIh2kl8Bzy2NsMHcpI9ZE6yosQHosuJl1yGrV8IXF+L
	Ue/PcLLZmOk/GxXWK5HYNguX17j1dtq8WNc/f/gKMQFgUEXmK7fzY7LPprEfk/DR
	YpvpTy2JSSpZ6ipn5o/H5tIRj/+uLblFrbMO7w1pco8ZmAy2anoct0N/34qRwpfd
	tsbAHe0bonxtoD03wUvJin2qGORXXajAcvX+3vtsJenwWQDy0dSsHeH9lV9aUCxh
	jOL8Av4/wOOe4t7KglYJA==
X-ME-Sender: <xms:FmqCajRm_ZVV4JNKkBN7yKyOWcq8YHKJFOlxzt8jbsBGOO-id15POQ>
    <xme:FmqCau2b9Chbw4_3A62Vxn-vUAcJ90YdS1qxBcG0S2pME6ud9B5e6axROUcbxHomt
    -q3m1MNxaUIOWK0AihlmMMtFOqo1Uwvzu9AGSA9aluw3EfJZeYFk1w>
X-ME-Received: <xmr:FmqCaoutk-xSp5_KAohSwmdedjH5kdOwB175qrfOfmWUH7tC8QrmCnNhf3G4-PBDTuPQih0xgfU2vjECUwNgQfnB6MT_ecT_U2M>
X-ME-Proxy-Cause: dmFkZTF0XGH9Ku30QOcJ/py44SYsAHBZC+nZ6S/oc7Lex+CsVR7e6BZwqiO/qVaqwTWIvD
    64Izcr6es7UWc5BGbJN03fhKWWyiPBFiMkbiDvWMmr8t4+OUp9BrICuXQGnQldC1yEIjOR
    5t6EQH272qgzgNfs1q8lDoRRAh4GGxpsE7a/741qnRIR6CUIfv/BaLYhBhLAoUYq8/vFwA
    EbOOSWWe/L/sSe5PAI9n1zEJyjsLIcbPhV2+j5H/KVBpIA34MQNUJoG+EKAvosPWgPNZtG
    N2G5UmAeDmLNKm+wrqAkHHl7AWNtEHAtpP51c3XmBHXBamdFo3ht5Sj19WDQmKiKzBi/Pc
    nsQrg00QR5NVRYYL+iAmjGELmdBoEH2fS6sMkJFbNQXnsk8YEovuV7viLjWGnlFdF3C3if
    xVUhFnY1l/elWT2a4+xVkzCnSQxeQTuC5k7JdxCrkwrBpTEAc/g6p4nbAvaljP8JC/f1sx
    uYLSf0f1ZVQX+faxxeGJHLemglaxlCP/lhPTb34lOhI1Hp3T/AxyM7j+tCDAuVSHESoN5I
    n+okFgvdtgGO9XZRX8k3a5blhtAI+HfQka166Fg0LsLHo8uzGpQ3ncyrSG6dzTJNqlvwo2
    nXUdkyZvKaPSXXqrXe2FmfcvQn0ISwkVuhuL5phToknL5W3woBrOuN/zgz4A
X-ME-Proxy: <xmx:FmqCakjBWH3aNmW1DRsi3GfYAyPigcAR6JlIeUC4_BM_ck18VOMpyg>
    <xmx:FmqCap-5XU5rVYqppfRoXuMkb2zRL18gV_CvlsX8dEDRCGKcJJzFGQ>
    <xmx:FmqCansAKggl3WPdpA4nVhY5jZP8LzNaHn5v1KvvU95H9Zcv_NyQKw>
    <xmx:FmqCatpE83m19lATky47b3hvvAQxct-NysU8j3AFeyVlbw0ReGhwPQ>
    <xmx:FmqCaqcOP6skHo-g5oaugSgSbX4aMdd6SRYxdnDTUW6UnqeOIf7ASKfh>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:55:32 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <a86d8ecf6ef9bfa0fa1fb4895a4b10e03e3e4a82.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 08/32] swim: Don't start motor until medium is present
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The spindle motor should not be running when a disk is to be inserted.
Don't start the motor while the drive is empty.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 597d35b514ae..6a49fc51f5d2 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -630,8 +630,7 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 		fs->ref_count++;
 
 	swim_drive(base, fs->location);
-	swim_motor(base, ON);
-	swim_action(base, SETMFM);
+
 	if (fs->ejected)
 		setup_medium(fs);
 	if (!fs->disk_in) {
@@ -639,6 +638,9 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 		goto out;
 	}
 
+	swim_motor(base, ON);
+	swim_action(base, SETMFM);
+
 	set_capacity(fs->disk, fs->total_secs);
 
 	if (mode & BLK_OPEN_NDELAY)
-- 
2.52.0

