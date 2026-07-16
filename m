Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8D409624;
	Thu, 16 Jul 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197259; cv=none; b=NVNvyw1Olz63vPiLKJqhVCELsdqAfITrTtL0rSPKQ7RyY19lDxK1nYVYUrv3Xqrh2TME7weesg8gFqkWPE2cmRpT0+4Ig/tosB2/l47YZct+ecAstANVXgQZZCJ7HdC+pMgugL0CHpjnBhyRV6LlqROTFQTAQGwSXWYCZS514fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197259; c=relaxed/simple;
	bh=m0mDjqaWt27iUz5Eb4Of5HDz4pjjHopyqtEzRzIP+L8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=eInD2Q52nsf38mHtqScTMHvHjA+yVSWp90ZMB0/aa1eYRIrZSdavpOSdDqiqW+h2nFSz8qn4y8N/qXr3XQUPVQjuKZ+17Ai73Recv8Os06ti9MCCFTxtNP24Ikk/nMJ5BMUpFdpDQEzTF17/Pk4VdCKSqIhTLL214TMVEFjAoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UY0NsO/X; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UY0NsO/X"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1D89140010F;
	Thu, 16 Jul 2026 06:20:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jul 2026 06:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197257; x=
	1784283657; bh=ca8YBXSborRNk6Vch91+WO9RcLb4Kuyr4hJiHrzbBJs=; b=U
	Y0NsO/XwY9JCRZrDK+pDkFEmxr4WUUY+8BQVF3qoRpc6IC0TgrVbgjBTbG09lveo
	2EHwc42wcjO/Wdnoh2QIu9GIRGS3cdfGDB2ka6B0B+LttGl4emJ7akJukltyjFAa
	X+RDvAIZGZKe7cLa01b4GhHVVunrC1Aljx7DbpejovsO/4SiDzUX8NBeTgvqu28E
	wH9qN18JmfpAizpdGAR4W/FqyxreDL65I/kb3vlXzb2LCEK5x4ItpfsD3Db97zJd
	awv661iVDhWMq37CnDfHp/z1DxQbxlDn0+HkWVCxlSMjlbIHJ5JGEcXQRyRLO/9T
	36MsE1CDqSfUhYXNSGoHg==
X-ME-Sender: <xms:ibBYakaZo_4tne3LdsdCxtEBmhfNXcVA8KNbi1zsdi-V3Fp3hNV2hQ>
    <xme:ibBYapeGMrpUMa4ZySZMIAxxAd7a01KFMJIeJ3K7IS0Puk6Zt0vgFlD7Mcq3JOcvL
    -Z2rTWPk2Bl1tK8V98bedmTYmSIppHLk88-Sz9aoS856kBh1-wfyqpJ>
X-ME-Received: <xmr:ibBYau1TfSWfqfuYRcug-0hGT2qfv_ZgSLBD2BYSPrFSfPhLwMtg3AG9I9bX8ouOYhz7qfZZZ-SnLownU-riRMqMno_HirjSsuY>
X-ME-Proxy-Cause: dmFkZTFNd6IbQ8H02rx08ZoP12RP2Y9vRARhgJlB0wIR6PSDfpSKBP1U3vWtu8R6W2Elci
    mTbDQY7i3QnNpByXjBC06gze8kG+fvg+RzUwEsui3pN/l00MK5NihMyimabiULXhdRmgUZ
    Fp2vyfOvyCSMxk3LYLdS15NBRAbETzMbMczO1MNe+QWWvbcZSFDUzJDvejX4jDXHbMarlU
    f3AD73FJWuDyz9b43nqa4DbZUGiQLP2V73l6cRGQdOXraCcCk51WiPnNJeqlwif8p1Liiw
    vB3zT16g7f63egnFS0GX1I3OcL8mp+5HlRupkBt+q953qX1G11NJ8jDFlunH7Bs/fVh7YN
    DpdiqDoMsvITvtRkZwfXCfXKZhzxZfoA57bw8kM6iIlE78imZ6HT3nQ1uecrjpv4rCT6BO
    0O6pTUZJjibphZDvL4kyUmV/8qSAZrGtksiQ3wwNZTg4SQ56Rx9O69HwDJqfk39QXOUAfz
    fcqw7b6OKSOkwc3KC4217J5tvn5pr2tb6H5Tmhy1Vu4cmmhx6s6jypwxKy6mJAGig1nK4o
    CQ9+HjTPGOpT5U+h5z6JbbzmoCLU+cYw7djCdLU9JEHzQXsTTIhQIKAZY0m+Hw7bEO+ZpG
    IKcZ+MuQzYq5/hQh4iQRe2hZLLMG7MtIKQE1nIUuwK87yE3xVCjLgiag0xkQ
X-ME-Proxy: <xmx:ibBYagKlqAJC_53I9X7vttiFoMg6ad4TWdrjxPCUEiQ47vIXT-Aszw>
    <xmx:ibBYatHLchP3wXB_ljNN1q1uTC9XkHTRpm9rMf71oG-vJUGLf0Jt3Q>
    <xmx:ibBYasWrkwIO9hUZdkJl6q4iCcHanigJ8cCxmaJ6DjpICWGYBQ8-QQ>
    <xmx:ibBYalyvDR0aX-UqNjenEibDUJmKsSUUgsqrkmcJMI1w35D5ki9CFQ>
    <xmx:ibBYapEbPQ04jbw-wDz08nIdWgKX8LjhGdY-QhJ_T_TgavmeOfgcFLhn>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:20:56 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <328f4893de7dbee26841757bd32eda7d7f3793d7.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 22/31] swim: Remove pointless mode0 register write
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

This write has no effect so remove it. (If side == 0 then no mode bit gets
cleared. If side == 1 then mode bit 0 gets cleared but that's pointless
because that bit is already clear here.)

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 44fe7a79059c..0bab7ed3daa8 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -467,7 +467,6 @@ static inline int swim_read_sector(struct floppy_state *fs,
 
 	swim_track(fs, track);
 	swim_head(base, side);
-	swim_write(base, mode0, side);
 
 	local_irq_save(flags);
 	for (i = 0; i < 36; i++) {
-- 
2.52.0

