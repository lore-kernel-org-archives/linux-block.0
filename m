Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569D37A829;
	Fri,  4 Sep 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514361; cv=none; b=lTJRveynXJAuxo7dvoQ06m3oEL7fOvsclcZIDZ2ZujgoXq+NQpoQ4CxcONkFPM0JbRRHzz+vA05EBf8UwHhKLbT/ODEoTqhuHD6yAnRhidowzkWUfBQaZ07Va37byIDdBSv9cMpHU/szcT4COxBVdwRw0nkQQ/1V3pZyF6GKZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514361; c=relaxed/simple;
	bh=gjAFfbgXquirRMg/FEuOcy8jtQ7XXsL92yMGScg18ao=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=b8CnToHZr7jxnXuGUKEbTA5g8XQzno8r2LM1ci85dJvDZz9/o9Tt5DU7a5LnvMKXDIaYr7X6WuYogXxHS49pBq5V1h/SkbEEOBG6Ez3KwVSBRd9L1sqy0Es778aHJpHcPUk5LVvsXDnaKiiMkbPxWEO0Qc9VU5jevWUCpTHnAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QB9rHKxA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QB9rHKxA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B219414000BA;
	Fri,  4 Sep 2026 05:32:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 05:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514358; x=
	1788600758; bh=vI95rHJq6hFCrnTGLxzjtCgat4bxYxSiGX3ThWsps3A=; b=Q
	B9rHKxAIzsbv6yqqno5N7T7tCPkoeRgwS5xQRQY0rZwAJMjiphEKDpPTjCRdWxF0
	Fr40LaSkqsqfc8qNVpK0oWv/YOxgGY7dG8nheZsHT7DCxK/wwATcIom9MlP6pKE2
	Yp0fDPBPh6N8dSdbdWtPATLxPT80ODZNPRnPvVkcQH/tbjZE8JWUukXZI+IyAqPZ
	hGavK+/e+HXZwmN+2s9nQVb2ALPRGepJGfjjXdJVFZvTXY1ZVx8TqhzGxGKyU3HJ
	b4k5ptaAMShsEK4Q4JwcLYRxfW0UjycUuKy8JCN/VUvhm5rWcjDywKl5PpUZtDyK
	Hp7VaexsjEZ2aoAnyxZyQ==
X-ME-Sender: <xms:NpCaaoih3uARgheldG5OdA7wDMd2LqH0lmV2q-dg2GbtixnqsRQ18A>
    <xme:NpCaarFWmO-atse-awaaPmLXZ4lKA5jEPoyeHeI3tMlEfwqY0TaBDpRHvjVvmkOVo
    fviKMoNoMCud25mqbMoslHeLzH-1SmR29Of3F9_ts1KphC7i6Dr0F5e>
X-ME-Received: <xmr:NpCaav9Kxr7-7okLvZPPI-9YpVm8kovBgd4t4GWCs7-Hm1Xc1ZpC1MrPRH_-lGuThgtulTRKXpo3ixCqNYm4qcoUfxgiwpoTaiM>
X-ME-Proxy-Cause: dmFkZTFwU+S4kdAMlQ0v/k0AIIWH8NEZGASJORdIHxKTKTXUZu4/+TuTqA94nuiEUMaRxS
    Gofh+bL92h8RMpG66xVFwu0W+p9wbh5ZRd08LqtVKnsUP/9Qrp2soVjzNROQy1equ47t7H
    GqReSb441wEtgq6NIY2eQSaFWVAevL8uK2VrYQsRbjCnFUu9sctSvc8HbwNcOZhBWEvrxc
    v4dU6ftgbUqTDUj8aqtOMM9o2mrrjTYuxdDT/c0DbswJjHoKR/5ejCxg8Y/5mjJMzYLbmT
    GHbOCAcx+v5nQg51GRLb73A1+7BY5hn9tVP95J29cL5TZcJG84qND/yu/wkLW77nvFWlFc
    Zq9Y320IajawGuEAzRcsWsgD2Bh1Q81t7Oe8GZfmWdoQgYxhsImRYXDYF9RRMCoSq2jqXc
    XWiDqEwCczHxRZgEsWSkOIqVye6m8YeucUzr/uI9ni4CYb0wjk9BKVntSx5f8mGTDBi9aV
    RBRlAgbq3e41FJC0pgXbmYbQK1AG7E6mgOpjapQp3dkwiw9TrdiDma2iV0JcF053BVjmrA
    SqIdEsjA+fp7+UZyBwPgAJJpyq0TbcD5quyZRhqV979m4DL6CtrWd67Rnzn+s6UFUytO1K
    4ZvHpb0gQVACWlLtJbTXoJYhtYMZCvnN29xNea7il/UGjRUMn7pYQg/1n1/A
X-ME-Proxy: <xmx:NpCaaqwDTDXT5A5kN8588Krkr03lV7cgbxG6zVLx0X8KHtbK0jsZSg>
    <xmx:NpCaajPWxhqbtnfYlDKyrbR2NMd3ufM6sVs_c2yogWFyf1WR8gPFyg>
    <xmx:NpCaan8jCDFXXItmFEJxtUyxOsaBdDL_kRH6yQyhx_ZYDLxIcTlpwg>
    <xmx:NpCaao7FrTPRby84f7w5yOfY-agGnLdQAeCl9pQOjM9d64hzKbbOHA>
    <xmx:NpCaauuz96y2XHk6YEgW67EnHVfcyAkRCwJpaAlaX7i5ySyCtwNriWzz>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:32:36 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <483efa2f8ac6beb2a2d4fa2d8b431cb1a8b560c7.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 08/33] swim: Enable clock divider only where appropriate
Date: Fri, 04 Sep 2026 19:26:36 +1000
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

Cc: Joshua Thompson <funaho@jurai.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v2:
 - Code motion was split off into a separate patch.
 - Use 'bool fast_fclk' instead of 'unsigned int data'.
---
 arch/m68k/mac/config.c | 31 ++++++++++++++++++++++++++++++-
 drivers/block/swim.c   |  9 ++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index c0033f885ed4..b745cf20a71f 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -984,8 +984,37 @@ static int __init mac_platform_init(void)
 			.start = swim_base,
 			.end   = swim_base + 0x1FFF,
 		};
+		bool fast_fclk = false;
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
+			fast_fclk = true;
+			break;
+		}
 
-		platform_device_register_simple("swim", -1, &swim_rsrc, 1);
+		platform_device_register_resndata(NULL, "swim", -1, &swim_rsrc, 1,
+						  &fast_fclk, sizeof(fast_fclk));
 	}
 
 	/*
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index b8384525fc9a..1ade5c497e10 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -806,8 +806,11 @@ static void swim_set_parameters(struct swim __iomem *base)
 		swim_write(base, parameter, mem[i]);
 }
 
-static int swim_floppy_init(struct swim_priv *swd)
+static int swim_floppy_init(struct platform_device *pdev)
 {
+	struct swim_priv *swd = platform_get_drvdata(pdev);
+	bool *data = pdev->dev.platform_data;
+	bool fast_fclk = data && *data;
 	struct queue_limits lim = {
 		.features		= BLK_FEAT_ROTATIONAL,
 	};
@@ -815,7 +818,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 	int drive;
 	struct swim __iomem *base = swd->base;
 
-	swim_write(base, setup, S_IBM_DRIVE | S_FCLK_DIV2);
+	swim_write(base, setup, S_IBM_DRIVE | (fast_fclk ? S_FCLK_DIV2 : 0));
 
 	swim_set_parameters(base);
 
@@ -931,7 +934,7 @@ static int swim_probe(struct platform_device *dev)
 
 	swd->base = swim_base;
 
-	ret = swim_floppy_init(swd);
+	ret = swim_floppy_init(dev);
 	if (ret)
 		goto out_kfree;
 
-- 
2.52.0

