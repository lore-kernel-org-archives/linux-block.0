Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD884408629;
	Thu, 16 Jul 2026 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197140; cv=none; b=HJv7V05DLiT0kIEPYoDT6crkHr74g2OlMwoQQKqBUoh8wTHLb0wKCcAejNAWWim0GV/1+MoC83UlB1Jzm8tesHOLtys7vfbRiUrUqZw1Z8XIWkhcPRibn6P1Kckj1XWMwCint2eVUpYwWmfDQftuLkimPzFlOZUj/0AMxVFUi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197140; c=relaxed/simple;
	bh=Kv3aAZ1zYjqBUqn/oY7kWthA3Kf2wE4L1Q5T7fw9wqo=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=jKMsREiGScJgJh+f1AXTjotkyk7cxtzDwXXveSpGcMOn3T+yAb+6D6OtQgzDtWFxTSewivHhBRbMQzO0uneSeeV/WB/bclWaeiZnXjIfJ5kc96ToGKcPTBcTVc9SLPz+dwxxgGNA4qGPcalAjoeqJK/7ZGOiW2M5l//Pi2dUMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pBE22pad; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pBE22pad"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CCC81400064;
	Thu, 16 Jul 2026 06:18:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197138; x=
	1784283538; bh=iW7KpW35PDoLPpYyGw2fwro8Ku3jO+TAP8yDEs8nI4w=; b=p
	BE22padavYdTKARpF8apfP2956C5ma2aGlgznjPd8n6YWsMTm6XVuGMuXE6lM1tx
	bvU+NIY+2/mGgLXJ971Qt65eBrPXBXA1o8HacltOWDJpMA+tMdFPVwVdx7jUjzP9
	mhLYq2qEUS9OEi77VqgISwG/rMdtZT1MRtCbyKHfRyWrg0xIbcpS2P6n2CD30fA2
	0SccM84eUgcjEaOYug+oDbU8i76Nk2/x/mVa2x80VZJETy107k8cuOR8AWRypUWY
	yhz6jyQAcBO7zJ8NNg3iSDP17WYlPtA/kP5VXoIXhpavKFzi0BP8uMiEI45B7o/B
	A5QPlzZkoPCoc0QVSQshA==
X-ME-Sender: <xms:ErBYat7KWRqt1GI4-BbWwxtgqC9E5kZUWq4Gz8c01AysWrNTY7WzqQ>
    <xme:ErBYak80dL9xJuQAaIcL5zSeK4ywSYsTdljlVuGpk8X5o0HNrU22hMXlaK5RAnTeL
    -Uot_CufBDCA1A0QHte_bbvzqWgeMHXx6JP2eSunpq_E2Jx-85dH7r4>
X-ME-Received: <xmr:ErBYakWbJxoayRyTZ1R67R-aTYToNdR95w0iPpph-S2-nwvrNshKDPGPeVFYewRQu6F32-G6K1HEhlu-44ag7CZPRYg-85ZbrDU>
X-ME-Proxy-Cause: dmFkZTGnu0KdDU6Cnnjzjut7Ynh6tk2+ovdpnczbl4TEpYjd2xea/2V+9/ei9yK10Kdl/H
    MbnOLuulMTuh04InA34id9JiQfcRHmEvLbwyFCa5AII7mZh4DTPlhaDZ0EtjPXqANZvanI
    gKXX6FTRmvs81e/SXh3Y2RykIsd2348XDj62kawHLLsABLDnR8PY9gSZYcetb1jCVEBUF7
    NNBy9UN+k4f/mjPPJM+IIU/fCaOQ7S5w2BvgFaksakvMJ3PE6CWzUaileWz2f2pbUkMMWm
    PCQh/JnlR8kHHa5+ppdGiXm20K6ZlwccOsrQO4Yn7guYiLAWoI1ITGaZd8YRxp3Crl4rLc
    ZEmh64nacC6a5Yvo2Z72HDkAEp9+Hg7BgnffDWnst92EPFDElLcFQanLOS2lSgL9f44oO5
    NL6kuErACDdHSkvkH9zq2DRNv4LvQarHM/SiTqfqvhhbTl/mPte7rh/S0DbArq4tcysPEP
    guWMRdPA9xpjHcBvAaQYHg4trlG87LLyeuySlIfL8E0DeE+aPMrYPaRAMgtUPxQFFlQxim
    GJmXhNxQ5tNAhRYUNBP0aXPzTcbnkSSFfDweCNQ0M9pKsR4cxX9t7CWqcxLfIQ4l8o/HQp
    t3qnhDd8YSYtf3Mp8X7A68xNrJrxhKdfqKu85Bw9fmJ4BB5psriEt9wR36AQ
X-ME-Proxy: <xmx:ErBYanoVYkDydq1DFSzLcCWiLSmj7dBIKk27I99PxDmHHa9o1l-j9w>
    <xmx:ErBYaul-E7XIFpTKIpCV4zwv4Br9b1kJF6gxMhzhmybzwAYJQDmxng>
    <xmx:ErBYav18Bx8BldsDn2vgD6bwW6si5pCHBwPeccEz1M_K4zeGSa8iKg>
    <xmx:ErBYajQU9reN45lbTgZN31wnwS-ym3ynEORXrwk0HuBJQGruo-ZvoQ>
    <xmx:ErBYaiojHRO41tPzQUoFIMEhfqMgodTHrL8dLH4e9pyyAIpSsC2zi3cq>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:18:56 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <95b9285e4d2b77b010162e2c83e6d4f7917c4d85.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 10/31] swim: Add track zero recalibration delay
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The UPD72070 spec indicates that the track zero sensor can take 3 ms
to stabilize following a STEP command so add a call to msleep().
Remove the duplicate swim_readbit() call as there's no need for that
once the sensor signal has stabilized.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 76f6cfa68432..9755b86d4dd4 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -402,16 +402,15 @@ static inline int swim_track00(struct swim __iomem *base)
 	for (try = 0; try < 100; try++) {
 
 		swim_select(base, RELAX);
+		msleep(3);
+
 		if (swim_readbit(base, TRACK_ZERO))
-			break;
+			return 0;
 
 		if (swim_step(base))
-			return -1;
+			break;
 	}
 
-	if (swim_readbit(base, TRACK_ZERO))
-		return 0;
-
 	pr_err("swim: track zero recalibration failed\n");
 	return -1;
 }
-- 
2.52.0

