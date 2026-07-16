Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51D400976;
	Thu, 16 Jul 2026 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197329; cv=none; b=hp0vy8OeF3DVa6xP2EFEWGuvXecw98WoGKolpyAZCSLa7S1LW2ceJL1sQTXv4kG7eBnADFV2cSOs7mmu85LjQCjkS4AOAAgjkmKofEXH9uTGBokeL8FDkSDlKUma5l/tIkB5xV8dkgstYHtRg+1dJdxCGE1A/akhJOeOMrV9JUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197329; c=relaxed/simple;
	bh=WT49LXyvqMdZoh15kQAPAsvR6PZg+bfLv07GGJrc2cI=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=qOlj7hcicjxZEN3NBe2XvxYo8eVPWmzLYeMn2dGRIe1nC1cfRfnOgD8wW8uEYxzJuPkGeeYbKuDr4OrgdlFL3X+gSMBUCzzhO+BunxHp9cW2pt8F2Y0SRUQcEVoC3t5FNm+2Tp54vfef8HwyaHvEDCQSOxVDVFlx6ol/tLkThU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9/CUE/N; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9/CUE/N"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 74B98EC009B;
	Thu, 16 Jul 2026 06:22:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197327; x=
	1784283727; bh=IWJP/RspGAdwImgJI7j0JI0GmhW0AcnLpqkqxEcmMbE=; b=n
	9/CUE/N1itBbdddgndjNJ2YzlbaY78UHqGYurxOewtAxV+c8h6MG/k6734CuyDNe
	aHFedDQanyWPQyYrfeX9mSpag5i5zy34FWU4iXD+PxUH07jKk9sc0eEVm5ZKPhXR
	aMM7UcGb4zHQguBe8mtcVDidYwpr/TrwqWb43VjlTkxBLINYBEZaHO9l0UAqpV4Q
	/jmfm0Ayr+eCpPs9WSbZfJMESeSqkvarY5E2x5hbnlbvGLd2hnYSzY+s4JMwo3EF
	s/l6k7Q3LHUd58WX2lcLKjOq5KpfgXBld5kjhI93Q9kuwnBZ0FPhdEKU5AnI1Yvc
	FBscsH8KC1Aaqhabwm77g==
X-ME-Sender: <xms:z7BYanyGzoVfZdW6VpjgTI--cb5SYAXmU4Dl0hxx5MHPZeGY8nNe_A>
    <xme:z7BYapUKYFo6AtFlCS09YoeXXx00QfOmQwe-UlaW1MMrDKBJVaEkLATL4WZRg9epQ
    ghq0szlh79ApYhenrxNl1fy8dHS6K5NjY_nUoanKj7TTtw5sLAVyrY8>
X-ME-Received: <xmr:z7BYahO7nC_q8lWCd5-Qy1pAz15pX1W7zXjcjUJ25aAhDSuMgOcbFt_Z9fUzthd_fBBniah20CKW2cWqgVsc6PYyFvqRWz9SPek>
X-ME-Proxy-Cause: dmFkZTF1Ntob9XONPC72IOdiGhFQoGneaS1pCFQc3kifRw4FXtPoKmZ8XvhBd0koBBJu+5
    eq3h7TwdwHqBoDoUxVCJ1uwhv/3+pT8JqwBdDKpcoT8Nl/2iRLX3jbPDdS0OCHpqtiVmhh
    3GFmtn9V9URFoD0SFK7WTxQ6Heg9GfELjyw7bbUtQUuPjTc1+i2ZqE7oH4gDHso+H1tT2e
    kqeUoUWJPJwzRV+N7bI25jIEkNbLUvyUTFb0NiZbxldPMKHhkE6dv03TiAMu9n4Zl+aCaS
    WxSfYOiBBrklPLq0GTbIDvDUIywD0ghlMyZNB4UZE8hNy4wvimfR5Eq98SMdhft+5AqRBj
    jkK257Qt6tb65n86iHWfxk+NczuhRn1bFxLao2qQet25snPdEIg1qfcSy92U7maw1KFDm8
    ePBxhQSwXEsbUqOAIg+VwuDXGquJmBfsJ5kTW+lE/ohJC1hRtvRKvjaYYhyUKQZzpO26OZ
    3QNuJoxIx++CtX2ReLNcJ1uSlPMngGcU1oZegLpMU4Qsi4VDkFSexyLKN8Htsb9kttgI8x
    53iyPIsCZMq1l9cryIOdSK/Ey4yhWKfE9XeMtXasEEhJPoUeUMcCHvBVyhcVL7Qb2ZA0XU
    us3nO+VVy1cSI8gfSpU5bO7vhmcAuAG8Bf2RMpPHwCrM0Bz6E4QOrf4AJ2qQ
X-ME-Proxy: <xmx:z7BYajC0u5OxlQZe5teAzoYu0sw35Vy9TKFveBuxEzbUp6RUUGZHEg>
    <xmx:z7BYameWm9ovHvYNZqRLna_vPKVwA1qiw6tqU6k-4knuGF2RmlEvqA>
    <xmx:z7BYaqOxPEsxE3sJm9mQXV7V0V3Uiy-JS-PW9clLuufIc8F9mLQ5uA>
    <xmx:z7BYauKi8tT2fsLnNb75rvqdyVtI2eS7PlwhoSl7X6dW5t2WN3Rp2g>
    <xmx:z7BYaogJE9LRbqOiRVJVHVepAjqmL-gpuYgv8stoDshi2fZH8tN3fEue>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:22:05 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <960a50d4c5b3b23f7198f4a3dae03bdeddbf098a.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 29/31] swim: Define macros for constants
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Define a SEL_MASK macro to name the anonymous constant. Define STEPPING
rather than re-use STEP because the latter is a command bit macro (see also
GCR_MODE vs. SETGCR). No functional change, just better readability.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 406792952e7f..460f74c19cfd 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -112,9 +112,11 @@ struct iwm {
 #define LSTRB		0x0F8
 
 #define CA_MASK		0x0F7
+#define SEL_MASK	0x100
 
 /* Select values for swim_select and swim_readbit */
 
+#define STEPPING	0x0F1
 #define READ_DATA_0	0x0F4
 #define ONEMEG_DRIVE	0x0F5
 #define SINGLE_SIDED	0x0F6
@@ -271,7 +273,7 @@ static inline void swim_select(struct swim __iomem *base, int sel)
 {
 	swim_write(base, phase, RELAX);
 
-	via1_set_head(sel & 0x100);
+	via1_set_head(sel & SEL_MASK);
 
 	swim_write(base, phase, sel & CA_MASK);
 }
@@ -369,7 +371,7 @@ static int swim_step(struct swim __iomem *base)
 {
 	swim_action(base, STEP);
 	udelay(150);
-	return swim_readbit_timeout_atomic(base, STEP, false, 20 * 1000);
+	return swim_readbit_timeout_atomic(base, STEPPING, false, 20 * 1000);
 }
 
 static int swim_track00(struct swim __iomem *base)
-- 
2.52.0

