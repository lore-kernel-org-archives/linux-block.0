Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD543B6C4;
	Fri,  4 Sep 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514351; cv=none; b=juWEmjKw3qUiBlairMQUTx0DQqwdAJaVZLaGoQL9fm2BDDW8ZrxVi4qlJ39OPGaXIrQ3QHRjYEsxXViYGgWdxfppf9XFNNUCncXaT3gMwY6sH7jTBCUQNo9DXtBxAFq1xaxd724uz1zjW2hmpvHnfSm+K6ZyQi8WJW/7XFpna50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514351; c=relaxed/simple;
	bh=TqaVQEtCJF/WR5rdcXCAI6HgPi0OGeO6YWmATyUDaXU=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=JVCYp/iT2eG717b4p6e9hENcZ5o7EcF5HcFFYyAXlB6nuAwWQg7viSWKBGAmdfVWrQ5t46uH/AqgxDvxX9Y3d63xdbcaPJDGayCZbjYA4glCw1f68Nt8KHTg+Gii9ST8fAvFloMi51uWSJvPXSG2TnhpR1/03ABQK1b1MKUwcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FDrQodt4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FDrQodt4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7302AEC0015;
	Fri,  4 Sep 2026 05:32:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 05:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514349; x=
	1788600749; bh=wcin6JPbkBoF/AQVPzdONl9kW11XqTpdguPq57kuevY=; b=F
	DrQodt4H3aQvOIBjbvdxrgitRFrGmrhlYXTf/A9aDt8m9TvosvRG7oVSBFbEBulU
	w8u/Y1k6/H5+XMPFIGBJPJv1iqG9/Fslry27i2ltmlgdH0VdioeDAGqshz6y0VqD
	FmCSpMyWP+0zoSgvTGxxFi6j+lVl2M698B47UELjqyVcRUUF71or+X4DKInVUvbu
	s/DA2kU+uQ87Uc119zlDmYH4N12GokT3e9igd5HCyZn7EbzFabpgqk3iI0xWIyDT
	9K9biYLvODFplnbzx5fOK7Ng9rWHvV8ZBASW+HoV+u8I43KkgGbUatmOqCp5AjXt
	1v80AYL5CBTpD6+Qm4rCw==
X-ME-Sender: <xms:LZCaapZS1imPouGjPfLvDwn1F7-3blFBNiD17G9t6-WW6lRVLhBa4Q>
    <xme:LZCaaqdNCee2EIo0XPKOdP6GYZD_BYRKkqJsDazjeoeeAeVucO4PBUfw01zbo40Xz
    YJOVwY-6_J8GAxKjra9kcInGGmFES7G4LJ7fgCEPxpYLusSoBNks9Go>
X-ME-Received: <xmr:LZCaar11iJb_rgG7gSVXvd_9nXb0Gtyc3Z8HX2pRrpPcTU5Sd3SGipwjtwo9OBav7Uxfu-t9tJhBTMkKxLH6mSOBneqK1kMuYCY>
X-ME-Proxy-Cause: dmFkZTFZ/TtYWX7QRSPqbWdhFvGKPdYLqSrS0kW5tw/ccCSeQwGXLU8z8+n4MTGG5Fz3xO
    fBhPKm+HgWFmiq+gJDvSVIfRvZvgV672b0RABACnDdhJF/iW3opz+U3/SP3bVUvVx8Q287
    Ap1gWmRx+bP8FRnMF0HKeE0yfsMRD8AYBXtaUsZs5aI7BW+fV7e9Q0YJu0hP5K8l60oxGK
    XrcuXNo1hSmleRjGCb9wMFpOFKoRGwYOR+2UyWTZOvcSmWg9D5Za0czKtKfTDaJ7RbQZgm
    lIJH+OOpA0D60VJW1h483ZeutJ4e8G1K0sL6VJD12jwsAudayvIunnWKGaY8cBa7nccFlF
    3vWb+n1kTewjAuLKbTmHoam2Grwkcj7+e6PXX3ACssWgh4LDa9ziRz6myZFfJYipTBK3zP
    5lDzKAEyusid/TjN1ddEQ+7OeHIkzWz9T9PyKOyaBwNUYPfIFzkuZzFbiNT08Y68WAu1dj
    sjcbB0XSCt+lpStP5uUmswPEqENWG85Zh3yY4pjM4hqmhteSAi0diNbFj0ggoLFmwxKobM
    uvXS0b3hqbr/+lKs85B5gkyHthTxXfQNv+yhJES2Fkw8vkKWZuHRuIMU0QYymcIeTaXdRS
    5qz/C0Zmw/P5V0WvM8gpFYucgC7R2/OX4WOU4Xay44qoyemESweZJ2cr0QAw
X-ME-Proxy: <xmx:LZCaapLqhrBwmYFC6_QaWTVAIovatnajtsatXo9ts4dK8rr0NFgnqA>
    <xmx:LZCaaiHKVc5SOhhPv6MhEE6O0mzkHT6Nj_sBfEkROwc6y0cWjgW7Mg>
    <xmx:LZCaatXTdVc0qonG04C482E2BLQMlucLI9LPM_EB2FYzQ6g4y8anVw>
    <xmx:LZCaaiweF0AQmrWpS0aR96DIlbEPMoHI-DbzQlWjgUAt6WnpTy7SdQ>
    <xmx:LZCaauIdfW6nkBHwbEL6SvMXvHww2rW2taFZJzmDZyYR3VNxCzZo0Wb->
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:32:27 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <e9facb07b20436a6941ec067288e84d8dd9311c0.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 07/33] swim: Refactor SWIM setup
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The write to the setup register is really chip initialization, so do it in
swim_floppy_init() rather than floppy_open(). Drop the udelay(), which was
apparently copied and pasted from swim3.c where it presumably relates to
interrupts, of which this chip has none. (See also mkLinux SWIM 3 driver.)

Cc: Joshua Thompson <funaho@jurai.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index c2d7ad3f065c..b8384525fc9a 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -628,8 +628,7 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 		fs->ref_count = -1;
 	else
 		fs->ref_count++;
-	swim_write(base, setup, S_IBM_DRIVE  | S_FCLK_DIV2);
-	udelay(10);
+
 	swim_drive(base, fs->location);
 	swim_motor(base, ON);
 	swim_action(base, SETMFM);
@@ -816,6 +815,8 @@ static int swim_floppy_init(struct swim_priv *swd)
 	int drive;
 	struct swim __iomem *base = swd->base;
 
+	swim_write(base, setup, S_IBM_DRIVE | S_FCLK_DIV2);
+
 	swim_set_parameters(base);
 
 	/* scan floppy drives */
-- 
2.52.0

