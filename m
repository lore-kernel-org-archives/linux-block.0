Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453AF442B23;
	Fri,  4 Sep 2026 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514545; cv=none; b=V4E1wTGO8L971mxB2q7RwOQ0RPPjztFhp1EegZ4A09zDt/0ZS+IswCxXGfEeFGgkzoJu7HkOdjMV9FlUFIseYUIiGlpgyTZ9iBMUD0KlYZ/54eo9HeQPTvZsbO4lKxNbebPMDOLhK9IPNbVrKS90KMJXspPQsEjIN/Wm0Le0H8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514545; c=relaxed/simple;
	bh=Sjt4m/UwSDY9zaOMplN1GOQKXrsxPrspeHxixk9NV8Y=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=jPWT7WADI4jiFxAAenm24DkgnHijdQKB0kZ/GvD8QqvwltaMK77KCEBrBQVkz3H7SITl4ri841yVLTzeZG8Nk1fiGzVS5aK1d68VISv4xiehLX99U8bUQYciNH7+tdETqVyGkCFFfqYAd41kbMiOrxMwu4a9m+Jx0gl9V4D2T1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d1Wg04Un; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d1Wg04Un"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A1AA0EC018E;
	Fri,  4 Sep 2026 05:35:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 05:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514543; x=
	1788600943; bh=vY4d4m5al/ak4Pc98Pi7L/0wx0/i3VzkrzE9scLyi+Q=; b=d
	1Wg04UnqYh8Nmu86Ew/lrJGgwUzLIhvT1khJw06aLufGNChGFtXuUvoJbRBG7kC7
	McIBHlinPRiYfJc/8U45IWrPS0zer8Mte/0qnVWvZv62rsYSrPFbTEXPx+iCnZE4
	V9lEJahL3FqIYrwe8+VGUg6iS8jHrzjFbznnUB6I0MjVJfWeCM3Pj9vZe+kMz+Nr
	vh+LZLwWwCtfzYl8Qkpru9GFAUW1CQTh6Bf8MgYy915AsHty85GrvVEjR9rFMXjQ
	XVM5VR/CyC4TXjU+9MRBSpI6zWnHsVS+zUk990yf8yQW5IZAzerV7taK+Y8Dbrlq
	kDIVJzALOI064+filtqPA==
X-ME-Sender: <xms:75Caatsqc4endqyNUASd22NRinrWXx0ICJtTbU9rm15l4HiZfuJDAQ>
    <xme:75Caaghhu-LNwKwzbTLRL6fS1_R0J8aODf9HNBNxu079aweW0OKrjl23WUCyzuLTY
    qncO9cQUd9_Wvu15v9qMS-T6YUFcGbMd_ZK9-hSBQy0fZuJ97FOL7R8KA>
X-ME-Received: <xmr:75CaagrcL7olQUD0dLhW4Qs7SgffVYKcHPQH0o2osDOeKZsDTpfuOHTqzgQx>
X-ME-Proxy-Cause: dmFkZTF1sA8Xp5SQpLKPpl7AOr0OCI6a5muovCjMEclTQyynzEcS3CRdTjaZz8PU8K7WR7
    lfQ3mDP7gXeanu8WmFTTNTNg/WI3tmXduWuLwEtqkTz5KfwhqzwioviZErMgjDZWxH58hL
    ih/8BC4Od4xW5ClBg2Setyl1uFZbuKpueRv4UkSy93ie3kcU6K9mH8wt6e98EXVurgHAvD
    MBDOw+EcwXx7T/tslfs+d2j7oiGrIytLxYYyT1iUYG4q6gimgwbZjGKP0TSVgw26FCz7SL
    lg+B/dQvzS+oOmxLOh6t9JfYFKVOoBcMAeQr36ZU0zAxhgEHVdZcTZoA90wPHeyf1527uI
    I2ZtggWjDk4YhaoaOrvoBL1NELDEVARX8hVTT8/A1S596QPsIu0M3IcHcTjTslam831nK3
    DzxiFvvzttH3AZpWn2ncnc11LLBZi0NlUchHzy6SuTLWx0oib0vvMdBQS3HiCssZGzqubU
    ejb/Nfgzl9MSu9Jl+Ipy7dd3Sd0/zFcAVvt7WPL5rIZZuxFWJiDmCashjXop45Yayt+MzV
    Ip8QWpKjC4GqQU0gPo5CNDAHgolLUN+ENnGglGrmlOwZC2tNFUl5YKgg7HdqeoIaxJUqbe
    yF/qBE3X5ieTAha/BKsglnpSnNhD3xUjdUGhA9wGthd6XHXuZ6GSZ9uXFwgw
X-ME-Proxy: <xmx:75Caalunsln0Ghwa3VJwFgKvIkxwE-ztdXclYAeLZtqS8hFA6mfjcw>
    <xmx:75CaarbB3XisWRD5gu8_oIRop2Z9u00jU4ybhUgJUZEL-E6EOPLKYw>
    <xmx:75CaakYcJo9G8We0JbD_nppy0TKNgRDngeCUqL6DIMkrHxWJD_s7sg>
    <xmx:75Caakl8Zx1dI6gS2TExMFrAS5am4RsguFONqxQ6nhS9DHR3eRxBsg>
    <xmx:75CaakcdT06tTHTDmOBofIrkVIMBl54UVfD3ftWR_nZV9DslU8rxLZvu>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:35:41 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <e48ea61df817d30b5a50d1ced91c066b13cd47ae.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 26/33] swim: Remove pointless specifiers
Date: Fri, 04 Sep 2026 19:26:36 +1000
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
index 637810d86e37..3ce73176da2e 100644
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

