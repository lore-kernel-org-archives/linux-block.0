Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF13C141F;
	Thu, 16 Jul 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197109; cv=none; b=ca72ELFgzcW80YtdgekV4oSkohhqX9Gs28hcy6Day2bPTGviEeT7OoVkAC/ZS/+xUihYM3/PCvrSFFAU5O9hCLM+xhaPyRnp6blI/WnpJiNRdD0VXlDUn/f8D+t/v2k68xConZ4F7+/7uPdo1/UEVW61RfhsQ0lOnwj3AWKSAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197109; c=relaxed/simple;
	bh=WhQGZ+noZWtK/1YPdd+aYYMwhmi3YM9yrGUsdfFcTEw=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=AOk04qLVnld+vjccP3umFnJ3ZvZU1YRxPJwiycZjwZ5ntcdtVyEXp5nQHXn1WWZQ02wz7ZqKNJM8ab+VAhqncF95WdO64iGpt2MqrZfX49USYrl85Tvfl0O3Cah7SZixStJN1prYqd3OVz734o8nY15Dd7MtpR+52C+U00OYTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eweRDkJJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eweRDkJJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A955214000E7;
	Thu, 16 Jul 2026 06:18:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 06:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197107; x=
	1784283507; bh=8fPPCN0SKCePQLHp/NriLmtASq3YQVkTq+Mr1RuOTxo=; b=e
	weRDkJJW6NiPWsFSy7JCY/EPdtd5Azq3lZ3hUpdZBeNrPHzEViPwl880PmbaisdF
	1ZfZxDvDR7sbHqciVWku3P9xrU3chjD5W/Nhnu4AilksKG7IfyOQtpKq+ujEcoyU
	E72uZtTcNCtMSIoFy/EqCrKgs7YelpM/2/6qqW6fBkKNjEOfdRQJllZ3T0GPGe+E
	QQxYIpwM0JOGJtDjGM+t5T8UA2V+jJr0NLeKQOZnKmBHO3whehVGCXDi3CZ7sEao
	fzUpsRztGPPalJ7uC8Y8lAkczT4KtP+Hx8V9exy3iUuVyYdbv8DIPRLLhHY0+6LN
	N+/sR4NAJVtyFap2wvRfg==
X-ME-Sender: <xms:869YaqU2pBLy19mvKiWcwItGyu9S32ZERQN2LW2Ydg-ImPbDeZOF1Q>
    <xme:869YagribEGsvTQm_f51nldzoaYxyh4b_rfDIZDosW7HE281atVEYUsbakNKKxo-B
    iBW5gs8aPa4bfRlrdtad9g8QvWSWi8WIuwv1jrbjfGFQ4vJVUftVg_U>
X-ME-Received: <xmr:869YauSVgy_5zoEOcMO0D5RzsAsb0iKQVWS3icZ3Z5AeKmIgo155zJg34bbajIACWN0g4gTqQV8OZiv27mu-FwwapI1O6ScbG2g>
X-ME-Proxy-Cause: dmFkZTGnu0KdDU6Cnnjzjut7Ynh6tk2+ovdpnczbl4TEpYjd2xea/2V+9/ei9yK10Kdl/H
    MbnOLuulMTuh04InA34id9JiQfcRHmEvLbwyFCa5AII7mZh4DTPlhaDZ0EtjPXqANZvanI
    gKXX6FTRmvs81e/SXh3Y2RykIsd2348XDj62kawHLLsABLDnR8PY9gSZYcetb1jCVEBUF7
    NNBy9UN+k4f/mjPPJM+IIU/fCaOQ7S5w2BvgFaksakvMJ3PE6CWzUaileWz2f2pbUkMMWm
    PCQh/JnlR8kHHa5+ppdGiXm20K6ZlwccOsrQO4Yn7guYiLAWoI1ITGaZd8YRxp3Crl4rqE
    l77K8IUJwuBrnRs3Ab133qyBEQn4W4+hmVuREtgL3xbCbkMTr+UUqJDjs5WFtohFPPqLh6
    ZuHu/Br8S98x1yA9dJQOzl01M7hHRjMCbmuMzjCJDYV1d4KbG92romy2KJhLm974ARkQyM
    4tnp/E3qfgVLlLRaqYvFrHubdc99NFGEplhwX5YHuMae/PdzmfPcOnhjL0G1B7Q2OzH2k4
    UZN980EpEsCZefvj97pSV5U424ZyhOV8uKnGavB01H86+1w2fu4qcAk6m+BvfzBwm1i/Pn
    TtPwCdf2HOS1lgXvHWzvsDRBhfC5YuI3c9YokZygC6z9W3Le+nrNSyij+UIQ
X-ME-Proxy: <xmx:869Yai2lSuju19_vYriaZSc-Y7mI2dT6FPovfteXxTFrrxxbZgtBAw>
    <xmx:869YaiCAN9d7vpevY6HVoL8iLFheA1V8rmNGq3xyFqo7psULCLg1SA>
    <xmx:869YamhrJ9KmC9AwYzL5N5cE51fBkpd4-2FFpVvF-49N-f-AEJvBjg>
    <xmx:869YasO5ZkE0Ftt5SsVHTJYP0wTKuxdqi6AdXFB5Tm934ejD-kCVdg>
    <xmx:869YauRC4dtbHcY_1xY_Dh1hFCdmwhYr3sWMfk55cd5UKWQvtJufW1Cf>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:18:25 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <043de8859e96216310712deacbbf9e622e5c77cf.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 07/31] swim: Enable clock divider only where appropriate
Date: Thu, 16 Jul 2026 20:02:15 +1000
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
index 481fb1e63ac1..c49e584cd663 100644
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

