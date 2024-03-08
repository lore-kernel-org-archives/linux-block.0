Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17F29CFB
	for <linux-block@vger.kernel.org>; Fri,  8 Mar 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887913; cv=none; b=Qm5790pIXlfJ4xEd+9U2JeTXHd+DPnEB8mDRgQD+KxyVsEqtCHVKTE+/jkq9nl1gLNt3pleM8v0YSsFz1HKmRWiSX9H5p+avj+C4Sfwg4Yly/ZmkHJbxwjpcTliYV0NsKXf3++F81f4mjWyuC1zLIhtElRetLrWzeBXOQA61FeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887913; c=relaxed/simple;
	bh=VeBEKzTQ1q29WWwwEYXhpTgOHd5ZGN4TpM2lTAVw5Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RRlhwDp1pK64eqMHacGWuaJcicBu0fURwoRNVNVPwA/zM9uIRsQZqSycz0f7YOChGob2TlgoSGbQedGsZ2VZL0XD/VO2mgXHIujcmw1DEU7S7f0vwrgphC/HKOaEk/0nTaxZPzz6DjtxXbdtPJeYoiNK7TPi5lfwzilRv+u0AFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-0006vL-AL; Fri, 08 Mar 2024 09:51:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxE-0056Mx-QE; Fri, 08 Mar 2024 09:51:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxE-00245J-2M;
	Fri, 08 Mar 2024 09:51:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] block/swim: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:04 +0100
Message-ID:  <a00aea8201ea85ae726411bb0fb015ea026ff40a.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VeBEKzTQ1q29WWwwEYXhpTgOHd5ZGN4TpM2lTAVw5Pg=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRXFyutggUq70vzVqhyP2TYflCj5PpKLzcNs0il3XK6X 99PYubuZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiAlvZ/1fx8V05yufZcLJs yr3ZyWmClQcm9cpcm3bnTMrRPcJltSKNi3qLulvjuQ8kbuNN6f3kK33+xZ39Pz/8UWCZ9tbHjXf zju8sTu4PHSJcHh4Qnvxx2pGm7ZekYnYwOSyuiFjAGKSi0hW3eVNhrN4pVxM5Ee6Vr1MrF6mu4H 9ZNoOH+eML88LGcqHtZec1md+pWVcaTp6xJ3J3ylV+4aiMj1udMkO+pxzw8n88SVRtk9HXTTptJ 1p8dE7mXnQ3SZksEM+V80+INy+/5+32kNxsd4NZs/5a/m2/s/P00cSYfZveHSzNXj6pPe3cdDsF TqNQa3ZBgz05fZyLnk1Pvtp+L3/Xd2EW5qaYdJdSBf0JAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-block@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/block/swim.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 16bdf62067d8..6731678f3a41 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -916,7 +916,7 @@ static int swim_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int swim_remove(struct platform_device *dev)
+static void swim_remove(struct platform_device *dev)
 {
 	struct swim_priv *swd = platform_get_drvdata(dev);
 	int drive;
@@ -937,13 +937,11 @@ static int swim_remove(struct platform_device *dev)
 		release_mem_region(res->start, resource_size(res));
 
 	kfree(swd);
-
-	return 0;
 }
 
 static struct platform_driver swim_driver = {
 	.probe  = swim_probe,
-	.remove = swim_remove,
+	.remove_new = swim_remove,
 	.driver   = {
 		.name	= CARDNAME,
 	},

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0

