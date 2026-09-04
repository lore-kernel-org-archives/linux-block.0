Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1EB45562F;
	Fri,  4 Sep 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514498; cv=none; b=EIzsWtp3uSu9zB/AYdjvXYbl1lr4rtP7Hipc1Mr5ZUZLBxsodamywd13+dUB3YBGTcROSzEzNfFnwWZP28hVKZHNnw0mz1BO6gPw5VzZwd0i7eKs5ATGRXCmpHlCMVWJBozoDyZNN6Km5RzmMb7N4n/b8ZRU59EmkkJ62pHE4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514498; c=relaxed/simple;
	bh=5LKoyyv+B3JUSwHovTPFmmeF1GOl7dse2jfvawYntd8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=lUGNAsvkF2+8Bs0KLT2nu6D12j606/5OcjLQnNmuh/M1lB6+GdQb0l+QbnWpnOJXeK7wce2OBB79eiTJMqUZcce4Ua5zMdWG+nOofiM8WE+Zb3+PNv4uIBLI5E/96XR9Y6kxYrItDtS4NwdZtWsTi27ulBRde1jfsa5DqBFVdes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DzMJLOjm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzMJLOjm"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A03A1140009E;
	Fri,  4 Sep 2026 05:34:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 04 Sep 2026 05:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514495; x=
	1788600895; bh=RtsvlZUtERDJAcOg3qjdo4GY091HGFBTrei0xS7NPEk=; b=D
	zMJLOjmwhY89wnp0EUOXlIBhmGoCdezPlSYyO2XF/oUV9hBhtThmNnMWgr4ILCVW
	2JPoUT55xshqG1BHF8WQ+mX+GZQHthojBkONbUZ0oIwx2Q3yvXPJV/KHuOJD8J4z
	pRG4QDcHlswe3YEyQ11rPfwuw83GW88lJHvmZ/mJRTlF+ABbBODFNjLvbjDlallM
	qhyWmlX/OeSqQzqGLe8+DqYuzO/mFhb9hHtoF+DRefI9iXMcn+wVJfByaSzHb312
	/MkwzGq/8yVbOZDbRYU/pIwvIuC43wdNtePl7zkEa9yMaSk3s/bWmNqL2VCBLwIV
	3bP60l9YUJhElrDeOhyiQ==
X-ME-Sender: <xms:v5Caag3M6UPW7KrXzinyxO4qy7wUMN8AHtVVAQLedhZJxas8SI7p3Q>
    <xme:v5CaalLvKKyzWmBr61m7MzD_uuOHwyt5gfy1NTl1slizLcDzAGII599mFXqhwvxJf
    aEqg_j0CLfyUNlVxzLXOskwDcXofsXc36yjE0OYfb5PKPROlTEzyrFV>
X-ME-Received: <xmr:v5Caaozt40NS7xCHAhtEA9nChZWGP_sm6h53GMqbZ8QFBREMz6gxRa5X-OMTYP0KeShrddxqDdO4E_iKlgoIXOabjTWffCMXy-4>
X-ME-Proxy-Cause: dmFkZTFwU+S4kdAMlQ0v/k0AIIWH8NEZGASJORdIHxKTKTXUZu4/+TuTqA94nuiEUMaRxS
    Gofh+bL92h8RMpG66xVFwu0W+p9wbh5ZRd08LqtVKnsUP/9Qrp2soVjzNROQy1equ47t7H
    GqReSb441wEtgq6NIY2eQSaFWVAevL8uK2VrYQsRbjCnFUu9sctSvc8HbwNcOZhBWEvrxc
    v4dU6ftgbUqTDUj8aqtOMM9o2mrrjTYuxdDT/c0DbswJjHoKR/5ejCxg8Y/5mjJMzYLbmT
    GHbOCAcx+v5nQg51GRLb73A1+7BY5hn9tVP95J29cL5TZcJG84qND/yu/wkLW77nvFWlln
    /yrDcq9sUVKrVReZ+mDfwadZxXbVsPisJ/byk1uJqDc1N1rAnoNUFszaMUIsmu1PvawqZb
    y7nZ11jAVGzgXodvt0Dg0OWp73jiwwiavcPYgmAjuQDti/00q0sxzvsBXde78Rp9e2e9sm
    kvIMayH45L35tV4ydiRFP/Bs+63wi05kdlXxT8T6vdUIRb17g3TQERQ+Uxv/OHbaCIjMpU
    PyIQlIsYe8mjicQKe/3XxYtj1p9AZZcr5Ul0I5gdGIS4i34vLyAJTHacm7o457hCW4U2uY
    LjPCyRZe26G20OExD5uKKIfKyLQZfl74gHEYb3zuPEFElTNSsi27w4McKmgA
X-ME-Proxy: <xmx:v5CaarXn8KJ6L8ps5k634M5QMJCgAU59n1b2gcbM0axjG1JxeDXWLA>
    <xmx:v5CaaggEKPUBmPHL7L9KjOjFAxSRcZI-5G92vrh-XbuE-XXouppMsA>
    <xmx:v5CaajAF8nHtxmsvMDo3e12o7akya4ylh1tiQWoet56C35p2ovkm4g>
    <xmx:v5CaauvjM4VyV7k8qdN5LwQJw9MKns0t7giIuXQVa-sjJbe6XwTGFQ>
    <xmx:v5CaarlVRHPoo--8mYKTbqmmmYUCAmYn5rlXPqDxFlM6CKMd4dFSE2ks>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:34:53 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <af356248a1e6a4fd956f71acf17feead27ba4918.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 22/33] swim: Revisit delays
Date: Fri, 04 Sep 2026 19:26:36 +1000
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
index 601ce79c96b2..a67ccd4504b7 100644
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

