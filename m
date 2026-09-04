Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDC447817;
	Fri,  4 Sep 2026 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514594; cv=none; b=KZAU3lqYnJ/mF0RUxnP124x3dg8MEPRWLKi+//ksJ/lXHBk8rWNPq5WdNMe45wl9F/ZFAXf9dmWoHjENZ/Dgjin7hAVOzM6GQxCmwfiy6yBOrq+p2ZNMcZvXE2x7Jrw7xidxc/hlm7+Y5NY+GJfQ2A3SpsRw/4EX2A9iccn3YS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514594; c=relaxed/simple;
	bh=W/2peY7QXmgSVaUSqR3xSWS3rJJZzZGsQ2US1ly9C70=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Gou0fL0PsZI9xvHzL+FnjNt4xk2KhNqXWdVOaB+IsLXSckhm3+EOQ8SNM90Gk6eoXiOl8vWoR9BrsBlr2sDrSW1uS+bUzpSvOG29imn0RqdyezFkB0YWjCfZ5W93UNfDvLmHB60MrIEYmdvVyK141ERnzsxkgUktPjDyjTCHG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OtNPeOJ0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OtNPeOJ0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 50862EC0212;
	Fri,  4 Sep 2026 05:36:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 04 Sep 2026 05:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514592; x=
	1788600992; bh=Z20/xYIt8naMl8dD/6e4TSmsRBPPZUUgtJg076bDEt0=; b=O
	tNPeOJ0Idr9G4JnBFhzF97dwGCxywtSgnhTCRa5P7XGY8U5QO/WI6z4sa5wCHj6p
	QaoITr3Mi/1gxE9cvaS0Vf7ldeFWH2CPkX5y9cjWDJK3Yr0DhuPPVoiJbt3aNFED
	unGZGXB4sD1c+hK3KRvUw+RTfyFx3GzEpkuD8/Y6jsT+sSRqP54KA2RpFM0qOjMJ
	Q0vrEeDwv+MAaAbnnXMkof1I7NnFk88+WbgoeM6BhhV6o+0AA+nVnPDYNEulg9g1
	GAuYiZS5lsi6XXMHQsrOrfZCp11vu7b639IhYPNkKNVMc7zFD5PsiZj8G+s3qKwi
	MGJEdn8L+tq1Pplqy6zbg==
X-ME-Sender: <xms:IJGaao_dn6ZqxyP810750exuangq3U_AK2-9VRb4BaoTk9CyblQLEQ>
    <xme:IJGaaqwvQSfXMM4_uJ6pnVhXqsheNDEH731iIUtRg3bXd8Fof-xs9EKjL_KO-Pezq
    GkokqulLYjuBqqkGh7Q-zNBi1uUoctl7d3ZCb5S1WVMD6tCHE3KdKOO>
X-ME-Received: <xmr:IJGaat4vANZ99El5jygEzfatuDjc5MKj3NnmNNCxXsiMtXmWY5igLkaKBukLx_vhF0Qjn4trSJBJ6G2hauMIklqnsS-GFOUgnzQ>
X-ME-Proxy-Cause: dmFkZTFZ/TtYWX7QRSPqbWdhFvGKPdYLqSrS0kW5tw/ccCSeQwGXLU8z8+n4MTGG5Fz3xO
    fBhPKm+HgWFmiq+gJDvSVIfRvZvgV672b0RABACnDdhJF/iW3opz+U3/SP3bVUvVx8Q287
    Ap1gWmRx+bP8FRnMF0HKeE0yfsMRD8AYBXtaUsZs5aI7BW+fV7e9Q0YJu0hP5K8l60oxGK
    XrcuXNo1hSmleRjGCb9wMFpOFKoRGwYOR+2UyWTZOvcSmWg9D5Za0czKtKfTDaJ7RbQZgm
    lIJH+OOpA0D60VJW1h483ZeutJ4e8G1K0sL6VJD12jwsAudayvIunnWKGaY8cBa7nccFWv
    heq/msEziktLWpOMZ9NXNM9QFw03T5eqezgpHov9MF9RWQ8uc4Edv/R7IuHCoFmgwVmc6D
    p7oXTf6J1Iql+X8lykrN8/QRdMhFHNDmE539dwFEenDiQq9kPEHccaXLM+oDr17kDN6mHs
    tY4FsfRtkugeqMnClXJdpN5RT+38uccuO/ShH9KSJIXKfp3o+zWYI4isIbG8Ak/FWRA+3/
    VCX8BiV0NkybeCnb6xJ8PAKnB5JToOGsrKNo4ddnIAMCZ7PT1MP3ahu0/c7CRcDLApmwyg
    dL/0CqO4NAB2J5PsehnNM9ub1z/5pzFJ6/Xt3rISIBMLWtUiO83Hq8+tHjQQ
X-ME-Proxy: <xmx:IJGaap_QJnwqSSDalQ0FhSf4MRuVtuEJ32eo5zMs-eGOkbyDWsISXA>
    <xmx:IJGaaqprFoSQZ7o63GXds8Zka5yhMVGdLhySlXkpBY5eyEHNuli2cg>
    <xmx:IJGaaiqx54PEc4GCEmHyF9OW_u1niJ3zWl9DPwsaC1BZNdne1kcNTw>
    <xmx:IJGaal25yDmTPjG-77QyyAkl9KM_fS3S3sjnrDsfKS-iVOr9dTZtfQ>
    <xmx:IJGaanvwDpVNTIuwWcQJ7QXctHh_xmUcwm978OwMofUkRw4snn73YBMp>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:36:31 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <64ee742adc48218962a989017b9dc5622e2932c7.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 31/33] swim: Define macros for constants
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Define a SEL_MASK macro to name the anonymous constant. Define STEPPING
rather than re-use STEP because the latter is a command bit macro (see also
GCR_MODE vs. SETGCR). No functional change, just better readability.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index a5be31b732b5..6f37a01219c2 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -105,6 +105,8 @@ struct iwm {
 
 /* Select values for swim_select and swim_readbit */
 
+#define SEL_MASK	0x100
+
 #define SEEK_POSITIVE	0x000
 #define SEEK_NEGATIVE	0x004
 #define STEP		0x001
@@ -115,6 +117,7 @@ struct iwm {
 #define SETMFM		0x101
 #define SETGCR		0x105
 
+#define STEPPING	0x001
 #define READ_DATA_0	0x004
 #define ONEMEG_DRIVE	0x005
 #define SINGLE_SIDED	0x006
@@ -271,7 +274,7 @@ static inline void swim_select(struct swim __iomem *base, int sel)
 {
 	swim_write(base, phase, RELAX | PHASE_PIN_DIR);
 
-	via1_set_head(sel & 0x100);
+	via1_set_head(sel & SEL_MASK);
 
 	swim_write(base, phase, (sel & CA_MASK) | PHASE_PIN_DIR);
 }
@@ -366,7 +369,7 @@ static int swim_step(struct swim __iomem *base)
 {
 	swim_action(base, STEP);
 	udelay(150);
-	return swim_readbit_timeout(base, STEP, false, 20 * 1000);
+	return swim_readbit_timeout(base, STEPPING, false, 20 * 1000);
 }
 
 static int swim_track00(struct swim __iomem *base)
-- 
2.52.0

