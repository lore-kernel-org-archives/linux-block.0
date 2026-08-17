Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F395C613;
	Mon, 17 Aug 2026 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931870; cv=none; b=CPblKJ3Aba8cIXgFfq0UTtmyTV8IeyHrNB0tGL9rnH3XJHpZHKTQNKgnvSFW8clRcm78ubMw0q14s/zh3c9YBwD88aiRV+6PS93NukIKNrPiZ6YgNevT6Qff8WAU7BTO0Kr2r0GW3BDvWVbT62obJhg+RXsw5ALAAYYBsRqXv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931870; c=relaxed/simple;
	bh=jzKLTm19RCaGkfXCBInjCEoLx+MBJhbVBlThs3oLyXM=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=RgY4b6D5qFOhBeVYGSK4bO1eDoQfYZrKbLUOnV2SaByGT2l5f5xakuVGeAftTbFB87xvb2l45w7DxSJjaNLkZEKgJlcGEMxAeAwyy+BZipT84ZG2krbW1BHydVsdJayANUTO4s8chyn/l2+rwix0pGhtxoGNCUSQxgTja1y4vcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SIQR0e4C; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SIQR0e4C"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D7C2EC021D;
	Sun, 16 Aug 2026 21:57:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 16 Aug 2026 21:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931868; x=
	1787018268; bh=G7l5/nBMQo0OOGWLzh/TqcSTK2o84+C8Y2b51Z+n7KA=; b=S
	IQR0e4CQC2oLrDs916pDEvsFqUh10xsqWlemaZQ7IK9/ZI2DSDx0cr3dO1XMkzzw
	syi3SC1fQbkIU16Kwn3x8DqjN0SpYCMsyJNkI6SfQx9ew0lXX4aVuA/oYi+Wzjn2
	ubYJvm3Qrte9MFEtwH6gx3qTNIgovxneySd4GbUKocQKcqdH5oF60OrSxf0Ql7+g
	wTIbma8rcYgr1KvzMhp1cQEmPW3MTBhvpTTEtqzRt2WivCPoR1XVfG7yJie1bbDw
	y0vJBJBgncgFh2XxAvytbRZ9l3wAL5Y7CLfQytDyy+R1D8D2+WQ5LeGqtiRnpAWt
	8+6fb5W1aLZUMOeEsSBBw==
X-ME-Sender: <xms:nGqCareL5GNaz3EyYmECdZP-QkYrBjuXdzm9Ww07HnoDSZa87K58Tg>
    <xme:nGqCarRG164w_ryyKaxStW7NJwNnqWN4a-yyhqDHw6NXQKz9rSJvH8uk0L_Yqpkrw
    HnfaifyAxaKCkhhcKYC28Qc7dM7t-3231EQC2voeBDtDEFzk-neoQIx>
X-ME-Received: <xmr:nGqCakYu-ZRz8eGDv6DVaUAxMICs9BEPzRsqyDxjJmw4P_8wyqsCI5K2TJJQbzlGwDOYcjaKn003N25riH5JjlmiSQJAs7eeu9Y>
X-ME-Proxy-Cause: dmFkZTGNmzENqalxDTfCkkFc7mFU+8/8u51l4usXC2H+kPVL/IH2s2NYJxgIYjtBYtArJA
    YWtyuDuajqQPlQd9d39HppQGgAciKWsN5vaSeS8TTvkVHVx1RLPosXGbRFJQPSd5BLLYVy
    eC1VIy4/prdxHqOKz9F9XzgS4LWYfaliKe2CMViR9dDdyGPbLM90F38TD9YW2MkJ0tIv5F
    Ml4DBCJ2CjSI2ieswFMFy7Ro4IzVcMw8i8Or1S6KLLExG4iRUFFS7PoCzWwG3m0EJF7GAr
    uN2VwdTVv1tA6XFTaF1EIrNDccscfKI9P6vDWUSZluIhB0JYi7lhYJmYYZKiGnpyDh4kkO
    +PWXsJPme0aRe7jer4Xtcg0DwtNzhV9uy9Fe5NxvMFzuavJglvRkHK0lyXgyvdICaIpAbt
    Z2hjbi8AxZgMlLGJDtqVGqX8R0X/zl394CPOX64lTUdACujPJO/Ig5l6IfRyBzRWQyST3H
    JJZLjdfxNXlR5gI1uKcqM82Xh6YcTFoeUUadoMRfCqFFMWT3SZ+Qzi/ySRfUgBWKjGls8y
    9BMomsnxDmCEmY0ShwuQkgFVuG44x4ALOEpcADv2yrrZrJunSEK1BiNEhPlICQKkxYx5xY
    KYiEbVuOcCYthEcclFdScyBTMF5idebAcY+XZu3iy5zfOTVWRMNZLSKkKFQQ
X-ME-Proxy: <xmx:nGqCaueSnDicuHfGq3yHnfUmSgC14vKv9NNCgY0GhN9bqE-I0F49eA>
    <xmx:nGqCalLUJhk1XsKvwxjnTwaiEHm-YmTtEk3AmHYgaJHcj0SIWfbgBQ>
    <xmx:nGqCarIwy-QMO5wjqDuJn0Zt-mnsc1ft7ZTBnnMxLFDoIBj7Pk5ZQg>
    <xmx:nGqCakU2mmDsFlVkqbpnNJHnZ5RC5pX_ysoWrbcoqnNG0ZpBWmEU6w>
    <xmx:nGqCaqNXwBpiOn9d7--jXdMany6ebn18RY7X0KF_imT7iPFgCwC592F0>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:57:46 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <b277731987f1d2cb6b71b650509be5c4d68c03d9.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 22/32] swim: Remove pointless mode0 register write
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

This write has no effect so remove it. (If side == 0 then no mode bit gets
cleared. If side == 1 then mode bit 0 gets cleared but that's pointless
because that bit is already clear here.)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index eb4c2b7c57e7..38b1643f3702 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -464,7 +464,6 @@ static inline int swim_read_sector(struct floppy_state *fs,
 
 	swim_track(fs, track);
 	swim_head(base, side);
-	swim_write(base, mode0, side);
 
 	local_irq_save(flags);
 	for (i = 0; i < 36; i++) {
-- 
2.52.0

