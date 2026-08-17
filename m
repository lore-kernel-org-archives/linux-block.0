Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE32771B;
	Mon, 17 Aug 2026 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931899; cv=none; b=QsEskLZQy+9ZXWQwv0bHKnlg17YRbWXeqJU5zxXcCDz1GgNpzVOhIVWIuHeq/NTMz3CqhiCz/buAXsq6tMUq8QNSrO1GDQ9p+CJJMty/YdxmHyIGyJSydhhDI44Y329yRfpWzchIzYNNsCfhJwsLi150TI9UMi6DlfRpf8fKnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931899; c=relaxed/simple;
	bh=wiieWZUd6nL8zoSX6OyQBNOzWFQYOm/YPhAbtKr6bVA=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=sytGzV1DXAtQ/rVgqCGb44wLeARllHY4TDN+JtIdgTtqVtwZmkf71Y6aJzgq++zkZ4c365XgDtjX4l69+Sjbn8BqlAKK7i442HEFuv0t6YzWrx+0yusrPUBvRmf1AOqj8mZGxAeqTO7Xc08d+CDLNuC8Wq6weik3UP2uzdzqE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uej4lA9f; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uej4lA9f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 307D8140007C;
	Sun, 16 Aug 2026 21:58:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 21:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931897; x=
	1787018297; bh=R3E+V0l2jmPNw2Z9ewJfuW5dZQD28UZ3evvLYZpCmz4=; b=U
	ej4lA9f98e6Xtodo0hbDLhTCXhk+QKoWNHDtMX+84gEX8ic2hh6hBAeUTAmqkjvX
	eo1aLRsK9zrEo7dfLagZfjtT4jL6BGG3wkBiXypbifmJW77IG0uZzhcB62oAJbpV
	dgYKJhF0PhRgHT6hyR9Wiz5ZXSZd9w9dnOEC5jM0SxOobI32cEWYMjTton6LxV1D
	FchK5YSRT+nU5cMVecFeEs3otJsu4yE2RXyN4NZs1CAVKEQscuMWDSfAwoWGde6L
	D5fFVFBVIbPgQdHZUlqZqS8qy+AiTZWf9UguM4LmF644jacAw7Dr9c0glbDzDElr
	5H7luvXyU9qsT5NpWWOow==
X-ME-Sender: <xms:uWqCakPCbU5YC0ls0Ks7-fAAPADWXtsWoujsq1Unyl2H5TCJEFLU4g>
    <xme:uWqCalBIVYNOv2nLOlKui1WSoKdwc1sjEQxFq6TgWL1rvGrpEDKw4YVX0K3mLxVqj
    o1kRwvAf4sqmun8Cr5fDP_PkNLhcs9o0sOMU8YHNQQ2osVoZ3pA2fea>
X-ME-Received: <xmr:uWqCarIF4gdm5nEJO6T-MrRfvGrCHJYZmplgcnblLwYSNhFTKGFkwJ8juA-hNYIe2fJI0-0chBijT01YCVkwYoC2gDZRrHpJieY>
X-ME-Proxy-Cause: dmFkZTGGfSHbL2fI02qi3PxN23Kck6mI5WuUw/IvRcvpbY119ewffFmgrLaJZrOewmv0V9
    +yVjmNFRAF5v6NwN93pp2/ef5Xe4c3LI9irOXMRuZYHRPaDMJE6WMter/2+BypR/48/QT6
    HY5IjuzvgSjmo92SyO1FOx3Pzj+F3Bo7QzXF7kAkGOLlhjpoHeFsUQfm7dkDIAS3zbzZQZ
    kdzEEhr46dUOQtvTauSfnNDphJtrhISaD9OmmoKzjI1J4txcn9eV52lgr1VrqNf0UkcCn2
    OchZn8Fy5DmAdO0OzTlRhd5sxDSBZbWOqIe4VCopfX4yIdP6r//KsVzdicR3q2dH2I0XFW
    ZVVWrzRLL4oU9B11oA0enZoePPc8c90Y6aEDIxdEbWncEHGIk27oaCXabyRMVJ4Apw8S+T
    3w1YhQmsD7ztfuEqrFWJykaJ6Ocvqm4cUBqz1cKxXKR/hzXkqSc2R1LOkw6h8+Tu8CFjda
    McXddxMgijMuipCioqqarX/GFikyxLBsSU0sgjgeCAEk3ngXl/5+XFM6CKQgmrvUy0HLGF
    a8v1cvr1Pg/LdnYF6OMhvSAF9vSw1XwKfy/QZzsjvgSOb3LcHZVztlclQS4UGN/DiuRb83
    ZlqLK+sKBvhpOYRnJP59jiXXo1ubkKq1o0QwYWJMFokTMJP6k/1fQP0AQvhg
X-ME-Proxy: <xmx:uWqCauNT25adO8Hy6ELyi_u3oRb9-QkcVbZrSxzmG4jEOGD7pl_YBw>
    <xmx:uWqCap5nkQuMckboQgl7rHBgjzk1P757z7B6MlqIR7RXgeBHFLHbog>
    <xmx:uWqCag4wko702gsMWwtWmnDzdGzFRzoj-YZE0myXySdQb1ix25U09w>
    <xmx:uWqCanGYkaQucwHvdEcL0FM5GR4ejxIcGyooQwE30-48nvtTL19FBQ>
    <xmx:uWqCaq81ByMsZ7WCaZKazPsN0DA_MJsCVj_FzLvhihe_bCWPCGIvl01z>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:58:14 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <6315efe51bde76010582edd511252d606878c096.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 25/32] swim: Remove pointless specifiers
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

If the compiler made these functions "as fast as possible" that wouldn't
actually help because they involve slow mechanical operations. Remove
pointless inline function specifiers.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index e35918bdf9d2..ae31b302dac4 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -222,7 +222,7 @@ extern int swim_read_sector_data(struct swim __iomem *base,
 				 unsigned char *data);
 
 static DEFINE_MUTEX(swim_mutex);
-static inline void set_swim_mode(struct swim __iomem *base, int enable)
+static void set_swim_mode(struct swim __iomem *base, int enable)
 {
 	struct iwm __iomem *iwm_base = (struct iwm __iomem *)base;
 	unsigned long flags;
@@ -250,7 +250,7 @@ static inline void set_swim_mode(struct swim __iomem *base, int enable)
 	local_irq_restore(flags);
 }
 
-static inline int get_swim_mode(struct swim __iomem *base)
+static int get_swim_mode(struct swim __iomem *base)
 {
 	unsigned long flags;
 
@@ -321,7 +321,7 @@ static inline bool swim_readbit(struct swim __iomem *base, int bit)
 	ret; \
 })
 
-static inline void swim_drive(struct swim __iomem *base,
+static void swim_drive(struct swim __iomem *base,
 			      enum drive_location location)
 {
 	if (location == INTERNAL_DRIVE) {
@@ -340,8 +340,8 @@ static inline void swim_drive(struct swim __iomem *base,
 	udelay(1);
 }
 
-static inline void swim_motor(struct swim __iomem *base,
-			      enum motor_action action)
+static void swim_motor(struct swim __iomem *base,
+		       enum motor_action action)
 {
 	if (action == ON) {
 		swim_action(base, MOTOR_ON);
@@ -352,7 +352,7 @@ static inline void swim_motor(struct swim __iomem *base,
 	}
 }
 
-static inline void swim_eject(struct swim __iomem *base)
+static void swim_eject(struct swim __iomem *base)
 {
 	swim_action(base, EJECT);
 	swim_readbit_timeout(base, DISK_IN, false, 2000 * 1000);
@@ -367,14 +367,14 @@ static inline void swim_head(struct swim __iomem *base, enum head head)
 		swim_select(base, READ_DATA_0);
 }
 
-static inline int swim_step(struct swim __iomem *base)
+static int swim_step(struct swim __iomem *base)
 {
 	swim_action(base, STEP);
 	udelay(150);
 	return swim_readbit_timeout(base, STEP, false, 20 * 1000);
 }
 
-static inline int swim_track00(struct swim __iomem *base)
+static int swim_track00(struct swim __iomem *base)
 {
 	int try;
 
@@ -394,7 +394,7 @@ static inline int swim_track00(struct swim __iomem *base)
 	return -1;
 }
 
-static inline int swim_seek(struct swim __iomem *base, int step)
+static int swim_seek(struct swim __iomem *base, int step)
 {
 	if (step < 0) {
 		swim_action(base, SEEK_NEGATIVE);
@@ -419,7 +419,7 @@ static inline int swim_seek(struct swim __iomem *base, int step)
 	return 0;
 }
 
-static inline int swim_track(struct floppy_state *fs,  int track)
+static int swim_track(struct floppy_state *fs,  int track)
 {
 	struct swim __iomem *base = fs->swd->base;
 	int ret;
-- 
2.52.0

