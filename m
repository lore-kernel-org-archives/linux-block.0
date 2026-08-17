Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA27155A5D;
	Mon, 17 Aug 2026 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931927; cv=none; b=aHR736iKBgkcQxgYKQC5KxWawgTHU50EJRqYQ1wt2oy7PYpPK8x6DbpCEcF49sTYDOSRuyMdIY7uuzIhdoYjTZDc9ccXAs9WZ2d/Jgt3AjEKKFfnAKdAgRwSt9c8EGuE03D3iitohlV3M2twAh0wdowzIfO5nafz/KKtrDZN1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931927; c=relaxed/simple;
	bh=HWkyZHRyWrtpf7FWd6YnGFTMjfjQtzKT9uRvwHZoCQQ=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=th/phc+JxQVN0rGUdaLp9AT0F+SoIL3qP6isVyWgUbgLYMFl+S6wO2fw4jfQb8h5NTJ132b9HFrZGSiuO683LX5uAIjeGX/febMOsX1WnreesrTjQA084H7N1nbcTAmdjK0xnlLKD9rDiVpwkhli/+PR1Sn+oABaLoRbLMee94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gxr09Ao+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gxr09Ao+"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E803EC0203;
	Sun, 16 Aug 2026 21:58:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 16 Aug 2026 21:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931915; x=
	1787018315; bh=8eo/+n4lyCg/6TAXGck/31U5uUVgWUR3kI+EQkD9Tdw=; b=G
	xr09Ao+jPeH/UlQGGzzP2ngbhy0woJVjzBt+aeMnPCAsZPVrJxOIDNbKvrFY/pNh
	zywwJP5cVGQEcF2G5n/pPJHOy7+zgMXtjnq6L/nNHVA6SyDilUD9w3VD7UZGsFtb
	s4Gjcsps7zweazd64BNiIJ8GppBwY54bYgS88AKnBF3/sJ8X7d1wMBOPAGoD3Z8K
	hFL/IJDkwiVkG1ly8d9l27re6xsUMNFXwo/QvricJR9d4Q9QK+F4QbmsykZFDo0/
	w7t4LY5S4Xp0RVG4bdGQJD/kax2d12MBRAXd152msKEkzYHIhDbUc3CkFmO28DBh
	E4NQ2P9SjKxrkNAsR0hwQ==
X-ME-Sender: <xms:y2qCaskf8kRAb47cBIyP7EAR2yiiN_FseyP-z5zAgb1M8SYqDAwVOQ>
    <xme:y2qCal5-P9E7OfOPXP5TLOLMiEMb80-udCY_xJjb3r2IBp6HNmqcvVozxv6xcmM9u
    AeEpIf7hV_1ssdkMr4IRD18toYEWjcbr6Sl2jLvQLJ1g4pacqr5XTg>
X-ME-Received: <xmr:y2qCaqidE5ojnTBgawiBGpAIbbSDH0B67tckKPo2dMMYsQr6XfX3w3JcwHkSWKBYX-GFXc15APDEQB3zIeYipyf6QkMYLsuuSKI>
X-ME-Proxy-Cause: dmFkZTFZjhdRphDnLxi+EiC+UjlbVLklrWdi+UybHaosTezjB2ZKWMGxBbpbKJYI8cz0VH
    CGJ0X/MYpe0L34T/rx8Izbv4joS66ns4i0E3ZQJBDO62LB9tEs5vYMuKUhO64naQDl8Th4
    QxG9JsCNTPWdAqIV21+NY4iXot0J8pyq5i3cIKh2KcvISy2fhdyxm0Nwb66hFUncaGsllW
    nddZux2ajhUpbLVK9IvIalEPPIts6Zn4VZmUl9ZRmcgSxO7UZxviA5px3hYEyHasA5LPXQ
    Z7JUOZBuH6yi+nnvLJHjm2ZEkIGw7YB6gJlCGB7eojPkjz177huLlOppXLolj6IGdkT6kp
    zkSLQDEf49QsykJltzP6ZqFEK6k2USCUG3mnVK4uAsfJ0WsXUT06pSMjDBjoPjhjp84/6F
    apmJQD0tLtX3xkbI/9ASGBQs/3H3A+6lnOj03WsIhAGTieKyI2oReaKu8gixXOVNVY/ZK+
    pLiDb9DQL8eRMmnseV8d0U3pvLiEgs/MIZ/lEcMFh5J03Z4u+BQCrLeCTKuvVK1me8cRdO
    hldlQEoJsxiSi4VxpOzhzTIqlMU77OmTYiTxnaDGMvRgENxuMLRr0sdagyTCRSpJm9nbYc
    InYd28DiQf89WReZ34qNN0zZaekz1E3MIazsrHkt7HdPDDmVtrtJno7Tm8dw
X-ME-Proxy: <xmx:y2qCaqELSM9LpXJdHQAPUv0AB_Zxs7todFz_Kb_xvCAiW5W74fu8wA>
    <xmx:y2qCaoRXGOam0czbZyuvBJS-BjYCUgFbGWtJBrfmSoyevuDvLFfF9w>
    <xmx:y2qCavz4lnFQrVep8RdPoH3IxJo-l7sSsjveKkvSMkXEmVSvukhlTA>
    <xmx:y2qCasf5iDmJzLsmmmEEyj05sEJOpBt4RIPSo_ZkWi2SUKrLFsFiLA>
    <xmx:y2qCavXOzq-l4jvR1U_T4_K9APAECoKMEEJKuu07F6x4zb9gLigd9JWv>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:58:33 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <3a8f6f7252e44358bd366ccc28d837a5cf7b5080.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 27/32] swim: Add some helpful references
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

These documents relate to the IWM, ISM, SWIM 1, 2, 3 and associated
disk drives. No functional change.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index c204108c50f0..d7182f95c21d 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -8,6 +8,14 @@
  * based on SWIM3 driver (c) Paul Mackerras, 1996
  * based on netBSD IWM driver (c) 1997, 1998 Hauke Fath.
  *
+ * See also:
+ * Inside Macintosh, vol. III, ch. 2
+ * https://archive.org/details/SWIMDesignDocs
+ * NEC uPD72070 FDC datasheet
+ * mkLinux source file swimiiicommonhal.c
+ * http://www.mac.linux-m68k.org/devel/iwm.php.html
+ * MAME source file sonydriv.cpp
+ *
  * 2004-08-21 (lv) - Initial implementation
  * 2008-10-30 (lv) - Port to 2.6
  */
-- 
2.52.0

