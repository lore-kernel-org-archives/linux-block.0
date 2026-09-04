Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF144238C;
	Fri,  4 Sep 2026 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514389; cv=none; b=mMnWrsaXg/hzKU0glRruEsNInVxmtC2ibYvkriL5Ba2kF6YfXOjg8uJZRz9NJY+MmMcq5AFKvbGyJzplYiXZJ10nQajfXSPFVNFBi5/t2Slr6Uhg+byuogdc0/aq/FkDBiI3+r1uTdIhomZvfoDO2ljb9J19ZfF1gz2QT8wxLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514389; c=relaxed/simple;
	bh=2Uzu//XUNnh+b9k8CRpdbpw9MLPBTH5AazZ9f6Wg14w=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=JWw5jYhRLSip+7U3OVS01I24FQLYQXYQyA4zXAFkZzW1/A5olLGX3zVR8oRYfU/Yoqj1mtfJPDMq+u8TGFb0I9hTAKpL+6646ikLwFIVVUXUihKnzV2q8JYcAOGGBucKQqsVT9i1A0uFZLOHWEHqy+E7a/zo2uXHnggC/7eFpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n59QkZtZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n59QkZtZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F14BEC009D;
	Fri,  4 Sep 2026 05:33:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 05:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514387; x=
	1788600787; bh=eYtGit5qYI8E6j+PcO1ZDRQ+9PgxfxVmav+LBUHcTGw=; b=n
	59QkZtZ4sLBlcmO4dpgbsSYZre/UNh9rBo7eEfOYiQZJKXkiSxamQZzJHCpM0Qpy
	L6oo+0wCy9U0cNdFZyYIcIJmOO8KGPgK/MXRFk5w6tcxth0ozabYlZrrGxhGO5fG
	fxWdblQ2BK04Acf9/t6rcQpwOIZfl2Lq55q7naB+ltwd5FBROzy5FcBifkgSe3eP
	4fCE/dCuo/fCL/LXjoFsoRW4l+sqzxg9S27OSsZHGVs03oPgtoLfkr96C0CGt0fo
	SCycWixe1AA7SAoFoeKYKzxHrNem5ZCAvHzXF6aZ+k1Em8i6FKh4APz++gKBl8Bc
	0pa3ZlozfE3UZR+7A7Uvw==
X-ME-Sender: <xms:U5CaanpLCe3csXTjcgSfn1Zj5KZantrb3jiBnDaQ1PQjRtrO6g_Y_Q>
    <xme:U5CaarseivkgnORR6O21Eu3YyzZP5CATtGRG_Y9pWD5GD4ViWacM7kW88Pp7fCcgi
    CT8zkmW0slNW_3Rsbel0GTTduFsws2ydRbYZXmqFfGgU7UZnELeXLxU>
X-ME-Received: <xmr:U5CaakFzqUlKu9efszlJ_s1SZlesed4c9yoNefTjIDgO3rnwHiBhD4nstGLqxSiBu9You81f89Mi8pQ0Gdfg1bDRDhWqdHTUGpw>
X-ME-Proxy-Cause: dmFkZTFwU+S4kdAMlQ0v/k0AIIWH8NEZGASJORdIHxKTKTXUZu4/+TuTqA94nuiEUMaRxS
    Gofh+bL92h8RMpG66xVFwu0W+p9wbh5ZRd08LqtVKnsUP/9Qrp2soVjzNROQy1equ47t7H
    GqReSb441wEtgq6NIY2eQSaFWVAevL8uK2VrYQsRbjCnFUu9sctSvc8HbwNcOZhBWEvrxc
    v4dU6ftgbUqTDUj8aqtOMM9o2mrrjTYuxdDT/c0DbswJjHoKR/5ejCxg8Y/5mjJMzYLbmT
    GHbOCAcx+v5nQg51GRLb73A1+7BY5hn9tVP95J29cL5TZcJG84qND/yu/wkLW77nvFWlq8
    qJxKAmG8i1t8IBzPGAvhuSi9XzJ/z92etVKa0+MLuNwvj0BPT3esku4h/1lghd1stAJsx3
    oeO3m6ZROqowDl3uYXY/PDPil6u8mkPPDt0S+ylJK1hzDexZ389juuCze11Ujm2T0brsl4
    EFhjpp18+o0WwAJaHYSyZ3h7kiwEti+nzXeMrs/oNidCkeKGHkOLpUKu9giQhJw9SdXuW6
    +dgw6WakK2rn42eoLzbMhKrR810jNFycA2wIl2HrCp9SV934NBHmPZHFB2i8dmpa6tfOze
    DHqFrd628L3ni+wR0jzWOqv+HTNx8m1HfoQ8/6pxwlPtPT8hxhewsF+jS4ew
X-ME-Proxy: <xmx:U5CaasZzB8dTSekY5pHfso8cpFovN6s4933T3xH4_XRGrsSsOKXd7Q>
    <xmx:U5CaakXtRHIzsulAget5bgzQUfbSzVivLaSmSSHEDgcvPOz7XFQu9A>
    <xmx:U5CaaikiCpuN9s4DHnyQak5JuKkQAcySWyhh0XBZGRKVBZaMp6mzPw>
    <xmx:U5CaavDvC1KkDTayog-qxiO3V7v_-sfU1UPHYpcTqT320a7AkZNlKA>
    <xmx:U5CaakZVLcMOa2PsEgS82z7EQyOdcIa1pVST73TMdAYUGsfG-b_0py0f>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:33:05 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <6d17ca20a7286c1d74833b29510c506a66d96e6f.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 11/33] swim: Add track zero recalibration delay
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The UPD72070 spec indicates that the track zero sensor can take 3 ms
to stabilize following a STEP command so add a call to msleep().
Remove the duplicate swim_readbit() call as there's no need for that
once the sensor signal has stabilized.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 5daa60938505..cf5470cfd775 100644
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

