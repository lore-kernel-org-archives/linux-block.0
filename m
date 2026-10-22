Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660933;
	b=33OSgd6nVCJ/usvrAX5AjODXLBff+oZZD6BSHBqU4keVQeO/QwOwfF9Os545XndA+d5X
	 esmGClb48ygx+wQ7gNZQ8RcbeCWSv985r+OLarD9tKoAS/t+R64Wbd+xsmhGQTz4/aBya
	 KqJ+fO9eHAfq1wPh9oDLocor67o2trbFDuMN+mTq7DtmBv0GBPOYWC429nktxMhBQr0vj
	 qw+Vtx1E59F3nkbCDsp+VViDZbyOQacGvk91DZuKZ0l1SR+2vNgunYcGfxJeFNLiIaB4d
	 jDHnH8Pe6GnqS2fUqxGckL7ZE+YdOxeYkMsXPK673BrzCwxYiaGxkPcWcpUmfNfGZNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=8RLJXyRQsP19IFvWgRQc9A+9ybc7lC6z+9QDlEO3+Zg=;
	b=3Cp+nojVD3nxx354Q+4tK+nD5F092GuyjcvHi8yp/f4213LNhQjl3P9r4Vy7cMQnrTA1
	 zpdfOH5xiwZo5NEyyMNP1mbp6Z24Io/W9E/nuO8XbTGxOLAaWi8wy9wwbfiCdK7qQjPXo
	 MqOMPkiYUgiQJ2iB27CZb0SwkSY3WkT615WZxqzt8oRV+FWNjKtAlFGUk2NcDZBSeQHJ+
	 AEhSrh4VoNlpo6Okxvi8aWN1Xvp5Wagy0420d0l4g7gvLJfMfKkgezFXQhBJhrcSNoh6H
	 0Xz5a1/X//FzBAmXau2MD4AvxnJZqEeKipC+qK67i85p1dtrwuNbZbruHFCDT5/ilEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9IYLdnC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63F606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9IYLdnC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1091F000C2;
	Thu, 22 Oct 2026 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792660932;
	bh=8RLJXyRQsP19IFvWgRQc9A+9ybc7lC6z+9QDlEO3+Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N9IYLdnCEwzfv6ESvrv5Tvm1S64HOQ4rlK67lT8TbXj3SbK8APD4IoWNqb5yXDLbj
	 QBIxcfxJ//saQ/HR+A9lBYXBShJoBJmuu9b1Ph3LdS72Cwfw4sULr2RL8FitrY8aW8
	 g8V/ClSZfYqZImob1eDsqbtVQhcLESKA2SmFE8PH7f3RYa2OmGkgnLLu7ag2T0MOyE
	 IA+szThTQOc63yU99xoHWB/vr6mzxy3N1Fk+jvHpfrD99xryGyW+Va8l1R1DjwN6cH
	 1Doqsg57Xq0ByvyCUH05t3RBpjsol0S517FkLvJUFkpBHB3llu2cjzKoBYED6tQJIH
	 JJRzth7okmfFg==
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 3/3] null_blk: clean up setting zones read-only or offline
Date: Thu, 22 Oct 2026 11:22:02 +0200
Message-ID: <20261022092158.2248831-8-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022092158.2248831-5-cassel@kernel.org>
References: <20261022092158.2248831-5-cassel@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713; i=cassel@kernel.org; h=from:subject; bh=NGL/o8XOiUFeqTd3T+LBuIAKOmwolAEvQWybG/cK3/w=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJuXt1tnX72ks5Zhx0FxTvEg2feL9v1+oci87nPqor6H zZ2sizb31HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJ1N5iZJiX1iNz5WpDPW/8 7OKbk9JCl2zZYp8kq9ruzyLi775USoThr1CTWMKfrZZ5dS3BT+oiA4PYp4m/WzVLdqrnnCiL0IP 2XAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

null_set_zone_cond() takes a zone condition, even though read-only and
offline are the only zone conditions that it can set. Because of this,
it needs a WARN_ON_ONCE() to reject any other zone condition, and its
name suggests a generic helper that can set any zone condition.

Rename null_set_zone_cond() to null_set_zone_readonly_or_offline(), and
replace its zone condition argument with a bool, set_offline, which
selects between the read-only and offline conditions. Also remove the
comment above the function, as it only repeats the new function name.

zone_cond_store() keeps taking a zone condition, as it, unlike
null_set_zone_readonly_or_offline(), contains generic code, and might
be extended to support additional zone conditions in the future.

No functional change, as zone_cond_store() is only called with the
read-only or offline condition.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/block/null_blk/zoned.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 015f5d304c7ce..b271d0a88ff21 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -770,15 +770,12 @@ static void null_release_zone_resources(struct nullb_device *dev,
 	spin_unlock(&dev->zone_res_lock);
 }
 
-/*
- * Set a zone in the read-only or offline condition.
- */
-static void null_set_zone_cond(struct nullb_device *dev,
-			       struct nullb_zone *zone, enum blk_zone_cond cond)
+static void null_set_zone_readonly_or_offline(struct nullb_device *dev,
+					      struct nullb_zone *zone,
+					      bool set_offline)
 {
-	if (WARN_ON_ONCE(cond != BLK_ZONE_COND_READONLY &&
-			 cond != BLK_ZONE_COND_OFFLINE))
-		return;
+	enum blk_zone_cond cond =
+		set_offline ? BLK_ZONE_COND_OFFLINE : BLK_ZONE_COND_READONLY;
 
 	null_lock_zone(dev, zone);
 
@@ -814,6 +811,11 @@ ssize_t zone_cond_store(struct nullb_device *dev, const char *page,
 	unsigned int zone_no;
 	int ret;
 
+	/* Read-only and offline are the only conditions supported for now */
+	if (WARN_ON_ONCE(cond != BLK_ZONE_COND_READONLY &&
+			 cond != BLK_ZONE_COND_OFFLINE))
+		return -EINVAL;
+
 	if (!dev->zoned) {
 		pr_err("null_blk device is not zoned\n");
 		return -EINVAL;
@@ -839,7 +841,8 @@ ssize_t zone_cond_store(struct nullb_device *dev, const char *page,
 		return -EINVAL;
 	}
 
-	null_set_zone_cond(dev, &dev->zones[zone_no], cond);
+	null_set_zone_readonly_or_offline(dev, &dev->zones[zone_no],
+					  cond == BLK_ZONE_COND_OFFLINE);
 
 	return count;
 }
-- 
2.56.0

