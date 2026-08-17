Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF20319601;
	Mon, 17 Aug 2026 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931733; cv=none; b=fxqRoI/itfxCM+h/gD7UxYPC9Cg6eiF6h4/Rnm+6lG48bBu4LS7riuTzUFEU4vb1NfArPU4quZl4d4e1sEPyp71zZCrjWcX0Z73G6ZusdkPjNImpfzwVqgPZ9feZag+mZEArNZx2eSQJnB/8N4Ypvukfst83pja20LbKP9P3su0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931733; c=relaxed/simple;
	bh=OGJprNUbnOVm7FXYJuR/t71hmh8wpnE5/IGNNpjmDqU=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=fLEvrerSRLAO45WgtF+iohB2fLLbMvGOUkoccziO4NP6rVL08q0lkQBYnvBnZ2+Mt+8Ousrnua+MNZN69XHWn2bJsGXncQbJc/LzM3OmeUVh1wBIaV9yQtPoGYCu0XJoEgS4PJw2FzuA+p/Vymql5FqvsOPrgJ1qC8gT2ldnaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dz3RIM7e; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dz3RIM7e"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCB1E14000FB;
	Sun, 16 Aug 2026 21:55:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 16 Aug 2026 21:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931726; x=
	1787018126; bh=j/FDfXXuUbpthgBP/bWV0xdeiffmbGuM3aGx/1Q1gEQ=; b=d
	z3RIM7efpe+iW2FFtBmicZo3ceMKZkpeDLuHpYxwJNejGawU1FOXsbslzV6paKP9
	CqabtPuSRxwymbtpsItVpgMaSwaJqsEwj9PKrD48uaAtUHq5fRWzOSV916Mcy1Ct
	QnkQ0SGiS4Fam99cnH5R9Yrw6JcuwozQRVxrtOJt1GyNEoFO5F64GcX0Ey6bmr7o
	VHG/Y0JIy8MvBlSQXevFWObqprl88ryx3hj1KvZ3Jf40w/13UOUE4Mu2338auhKR
	rTjzbuJEMiW6YpzJj8PQFFl6ciNTvooVQ5Hsv1I1qb/camPfWTj47ro7neIu4lWE
	HpbKNH03oJyBnBPcvt65w==
X-ME-Sender: <xms:DmqCaobzwvd2q0ZtVTCkw-B2unpX38gGRadZqrHuGyvxnkvYV1QhOw>
    <xme:DmqCarBvLsy2UtZYm-1x1eHKj3YLjenojH4Z1-mTqvBLLvcChi1o7lbSXvA2UwutP
    L0G00P_ZmLm_nD8qAayzmnqyazcvVPXEjMwZSiuL4YPGwCpKHdQryU>
X-ME-Received: <xmr:DmqCagmpxsyCyEXOigzJYdsulSiXxQBzyPcxYZ5Zj3mi0x68nGEut6w5goM2cAoil05uhPuY6BF4VSZsAIdtOAAOe_3tseLarz0>
X-ME-Proxy-Cause: dmFkZTGGfSHbL2fI02qi3PxN23Kck6mI5WuUw/IvRcvpbY119ewffFmgrLaJZrOewmv0V9
    +yVjmNFRAF5v6NwN93pp2/ef5Xe4c3LI9irOXMRuZYHRPaDMJE6WMter/2+BypR/48/QT6
    HY5IjuzvgSjmo92SyO1FOx3Pzj+F3Bo7QzXF7kAkGOLlhjpoHeFsUQfm7dkDIAS3zbzZQZ
    kdzEEhr46dUOQtvTauSfnNDphJtrhISaD9OmmoKzjI1J4txcn9eV52lgr1VrqNf0UkcCn2
    OchZn8Fy5DmAdO0OzTlRhd5sxDSBZbWOqIe4VCopfX4yIdP6r//KsVzdicR3q2dH2I0XFc
    2AIk5MgcQih3StdVHrsCyxPvCofzkcyWqZXh7o3REXgnakbHxKyNt9puAD/TLNkkJkcgDl
    9tPKNPr4498ClPIipqW+17nukpnW0tnZE0PSklFa2qiFsMEn9vHfRNLZIqMKJzN4iAud3p
    fRV1P+FAEN2yPZGsCVbSyH2m1HCObIQPYW7fjrXIycs4szTj0fqoDu7mekjXoG/OfO9ONV
    pfzzbRcbi8i5zKQI3pyEHrIjcmjCXOlR+JSPqN3tQk3BxRAwa5z6IbDUirSgQ/JwddqHZC
    7RwjWOKisw9eHetC84ZOkAXZLpeNxZck1mZH5LBocXYTYEdkhXQbueTpDjkA
X-ME-Proxy: <xmx:DmqCaszMTOLi4nQkhtBUaNbV9_i2myJoBcT7mO8rxo2eb8jwIdI_Bw>
    <xmx:DmqCaqSYq4N2Yfb5exLVHryPfB8y4CiQQptyk0WUWUf1XncQVmfzNA>
    <xmx:DmqCak_koVLq8i-a1stDbpjJ6HxjO6jCzP6W5GjBu7p-UAOQa5jwNg>
    <xmx:DmqCaostmX1D85VX29qq6f-RaxQjSQJ2A-wnztVNpucq8i9U7wtdWw>
    <xmx:DmqCauARxaBdW3VdZdWQIrWaobX9g1UYU_adsa46OBMZ1x0jump1z1CA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:55:23 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <1e349506a7cc6aa574aacbd4c69c240b5a1e3eb8.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 07/32] swim: Enable clock divider only where appropriate
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Some models have a 16 MHz FCLK oscillator and others 32 MHz. Put this
information into the swim device platform_data so that the driver can
correctly enable the clock divider. When this is enabled incorrectly,
nothing can be read and failures from the Error Correction Machine are
flagged in the error register.

This is chip initialization, so do this in swim_floppy_init() rather
than floppy_open(). Drop the udelay() which was apparently copied and
pasted from swim3.c, where it relates to interrupts (of which this chip
has none).

Cc: Joshua Thompson <funaho@jurai.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/mac/config.c | 31 ++++++++++++++++++++++++++++++-
 drivers/block/swim.c   | 11 +++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index c0033f885ed4..dba3de21c3c4 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -984,8 +984,37 @@ static int __init mac_platform_init(void)
 			.start = swim_base,
 			.end   = swim_base + 0x1FFF,
 		};
+		unsigned int data = 0;
+
+		/* Models in this list are supposed to run FCLK at 32 MHz */
+		switch (macintosh_config->ident) {
+		case MAC_MODEL_CCL:
+		case MAC_MODEL_CCLII:
+		case MAC_MODEL_LCIII:
+		case MAC_MODEL_Q605:
+		case MAC_MODEL_Q605_ACC:
+		case MAC_MODEL_Q610:
+		case MAC_MODEL_Q630:
+		case MAC_MODEL_Q650:
+		case MAC_MODEL_Q800:
+		case MAC_MODEL_P460:
+		case MAC_MODEL_P475:
+		case MAC_MODEL_P475F:
+		case MAC_MODEL_P520:
+		case MAC_MODEL_P550:
+		case MAC_MODEL_P575:
+		case MAC_MODEL_P588:
+		case MAC_MODEL_TV:
+		case MAC_MODEL_C610:
+		case MAC_MODEL_C650:
+		case MAC_MODEL_PB190:
+		case MAC_MODEL_PB520:
+			data = 1;
+			break;
+		}
 
-		platform_device_register_simple("swim", -1, &swim_rsrc, 1);
+		platform_device_register_resndata(NULL, "swim", -1, &swim_rsrc, 1,
+						  &data, sizeof(data));
 	}
 
 	/*
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index c2d7ad3f065c..597d35b514ae 100644
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
@@ -807,8 +806,10 @@ static void swim_set_parameters(struct swim __iomem *base)
 		swim_write(base, parameter, mem[i]);
 }
 
-static int swim_floppy_init(struct swim_priv *swd)
+static int swim_floppy_init(struct platform_device *pdev)
 {
+	struct swim_priv *swd = platform_get_drvdata(pdev);
+	unsigned int *data = pdev->dev.platform_data;
 	struct queue_limits lim = {
 		.features		= BLK_FEAT_ROTATIONAL,
 	};
@@ -816,6 +817,8 @@ static int swim_floppy_init(struct swim_priv *swd)
 	int drive;
 	struct swim __iomem *base = swd->base;
 
+	swim_write(base, setup, S_IBM_DRIVE | (*data ? S_FCLK_DIV2 : 0));
+
 	swim_set_parameters(base);
 
 	/* scan floppy drives */
@@ -930,7 +933,7 @@ static int swim_probe(struct platform_device *dev)
 
 	swd->base = swim_base;
 
-	ret = swim_floppy_init(swd);
+	ret = swim_floppy_init(dev);
 	if (ret)
 		goto out_kfree;
 
-- 
2.52.0

