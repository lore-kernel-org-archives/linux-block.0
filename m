Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614076;
	b=wYH5Hi6/s5KXSgt9kcSZNrtVsqMUWrHEPRVrMzo2t0W0rjnAGBAdeMkDkvnv2I2noZWf
	 YK0ZWqxuwToduXGTqHsNhJGOm4XiRmRsSFhIdGbhYtIr11HBQqB1pxIFbXmjM73Gh/Tzg
	 EUrFLlRTwVEBtM4NMmwPCd/ZExmk3X0+h2m87aoQkXVNHNJwNOoiGerN8XgKA9jaHN0dO
	 VkuKScHnJ1z6NDqU2Z74J9yItjUeKEe2rdIfhkBYY0BYhioYNnf+3i0nKU0KKfhNaOyQX
	 k98E1QW0MueruyLfQCSgAF5NsGBu4yYYViE8j8SrhWzKvdV+RG2742Iyzp8XIsTigIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614076;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=dFEwdDtpDZeJTI/z+1ynoDB5ez//I2WBbHAbFyyxZRA=;
	b=WTHW+lQfr8LhHpKfpNbTLDjG6cyTXATZIW3oeiJSRPy0GLYu8G/dnGfK2jrIxAAQxDxJ
	 zLza/PbqH0V/57nSyo62nX49E/64jnkZt4UARV4bH6zyLmcg5d6uRDwGpy01XOHT740YL
	 s0xrY6FVsVx55wNMTjCC3yrfFl5A5qhDdyH8A8uareTb7mkb6XRrcKIVHXiUplXKljJrO
	 m83QMxbYGb5/N2b70xwz31SjfYtQSKpiD6pADlQa2ItO7Zr8nNQ+bRyuMo5oqT2Hnb/x7
	 qDpwRTx9tND4ibMlV2NqRQDha6NjRsITQn2g9UM8FR6e41Gxp0yl/caEm7PeBYegGmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVryxUr7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374D606A319
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVryxUr7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D532A1F000C2;
	Wed, 21 Oct 2026 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614076;
	bh=dFEwdDtpDZeJTI/z+1ynoDB5ez//I2WBbHAbFyyxZRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hVryxUr7A/R93uqwnkqp+3Qxxbn8nirZBGwFdiWb1raT5y3BwcSzc+wBcmxG0Rjt1
	 z8Ka8sz3w273f2E92sTAo+umfYcG8HFqiBuyBo7YU9lWczQLoB040jMdh39EkmsISK
	 Xg2e9e++BQT8wpceHshhZNcRYXhL/Sl3QpPbMqcJwpEU+dkga3o/pCBlIve5oJo7nw
	 guSMqBplg8Z9xJRQTrKPLI2sJaApdmXo8Uz9HJ4bPDsiyU3rwVk+lLFjmLaeaNXFap
	 i1w+zaxyoySXTKIzaJyEKvf6ddG5JvxFKo7JTurTL9jIT/uEW2XkySo0FjV7f/TQUu
	 fjly8keIVK3Pg==
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/2] null_blk: fix opening closed zones at the active zone limit
Date: Wed, 21 Oct 2026 22:21:02 +0200
Message-ID: <20261021202100.2017938-5-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021202100.2017938-4-cassel@kernel.org>
References: <20261021202100.2017938-4-cassel@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368; i=cassel@kernel.org; h=from:subject; bh=KYIf0+9tQda78c+S/lQC8iOscxd/tm5zU7uZpB/EiXE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJuyq1JO+h34XHN3G3Hj5ieWu+2IG5m5dX40/MyZQ6// G0y++Yxn45SFgYxLgZZMUUW3x8u+4u73accV7xjAzOHlQlkCAMXpwBM5NBmRoa+lbN6ZpzhfDfx 6kvHiIf7z1x1Vp/SZGaUumzDcb4jQlJKjAxnXx56/6T9tlxJS2fEVKnX9wTZEveafVkWbL/gwpO bSg08AA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When the open zone limit is reached, null_check_open() closes an
implicitly open zone only if the active zone limit is not reached.

Closing an implicitly open zone does not change the number of active
zones, so this check is wrong. For an empty zone, the active zone limit
was already checked by null_check_zone_resources(). For a closed zone,
the check makes writing to, opening or finishing the zone fail with
BLK_STS_ZONE_OPEN_RESOURCE at the active zone limit, whereas ZBC-3
(4.5.3.2.7.2) and NVMe ZNS (2.1.1.4.1) require closing an implicitly
open zone instead.

Remove the check, and update the comment above
null_check_zone_resources() accordingly.

Fixes: dc4d137ee3b7 ("null_blk: add support for max open/active zone limit for zoned devices")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/block/null_blk/zoned.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 7e9b5ffb9e84..ecdc8d68ca2a 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -311,10 +311,8 @@ static blk_status_t null_check_open(struct nullb_device *dev)
 		return BLK_STS_OK;
 
 	if (dev->nr_zones_imp_open) {
-		if (null_check_active(dev) == BLK_STS_OK) {
-			null_close_imp_open_zone(dev);
-			return BLK_STS_OK;
-		}
+		null_close_imp_open_zone(dev);
+		return BLK_STS_OK;
 	}
 
 	return BLK_STS_ZONE_OPEN_RESOURCE;
@@ -330,8 +328,11 @@ static blk_status_t null_check_open(struct nullb_device *dev)
  *
  * ZBC states that an implicit open zone shall be closed only if there is not
  * room within the open limit. However, with the addition of an active limit,
- * it is not certain that closing an implicit open zone will allow a new zone
- * to be opened, since we might already be at the active limit capacity.
+ * it is not certain that closing an implicit open zone will allow an empty
+ * zone to be opened, since we might already be at the active limit capacity.
+ * Therefore, the active limit is checked first for an empty zone. A closed
+ * zone already holds an active zone resource, so only the open limit has to
+ * be checked for a closed zone.
  */
 static blk_status_t null_check_zone_resources(struct nullb_device *dev,
 					      struct nullb_zone *zone)
-- 
2.56.0

