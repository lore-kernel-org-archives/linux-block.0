Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660931;
	b=HTUMHTxdXFDgQl5Gkk8ZwKVg1II8xilxIi8j4FEg/xvRLzk1uaVpdN0lRR/SMQj2XOrB
	 nqkOitgCtpwXYrwdQQXoTBEGUkM+HfOOq9y6ntKr9X4FM1ydS5A6UdsUMLx9x+hXiqtih
	 ++n9e2UzUo19UwbyJWyDD1mqYnvh7VM1xS8REALCZo7Lg1Z6G7M3T89RPDmL9vRskgTp/
	 yUkY+6xcecLOxrpU8HgmoNHRZ7Ek2J3qC+LxfJ74epsLV9TAXwmUtUcYAHEhsfP08pEY/
	 kBfmOctqAqBz5IV64GH0Os2VWIedsOMLhIrH2lsSuwSgJegGNsh2I6dVVm+Lr2A8gfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660931;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=+zDiCMC35MoELVTN7pdJ+bb1itpLkJeBSsfjWRivmpc=;
	b=fyRbWp92yuEUyrZFSSrWcU2N876NUrVljl/jDRkw+NHJhgl8+egPZUTDLQumeMAHs2KV
	 O6GOKtUAPOnx2azUr1QPZ3qfW0+G4+9ewKf7E8mlpP6XOcugOJw8RMQSTk9aIWW/nOUNi
	 AQSGeBR7Uwy5rr7J/jbX8Zc018NC+LWCSTDgGarA7ynYwl7TIK7U9OGQilCJFxR2o3O98
	 a5rJlyY0yZAYOXCM5Ashe2kxwKg+rLRPctFH7lI8Mb3pRtsWd0RIArOadgUl/SXc4SdfW
	 exPKYhyLj2mn9cg62VDcpZOiKRJvzeY5k3S8l4PULBr6AYI3d/8FOacTKtXF3h8pOlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOXQbdYm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA22606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOXQbdYm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813921F000C1;
	Thu, 22 Oct 2026 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792660930;
	bh=+zDiCMC35MoELVTN7pdJ+bb1itpLkJeBSsfjWRivmpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BOXQbdYmf6l5ENTtxm7b/2TsWH6ixgPfI7PVDMI+sO2AoYSOJWhz0Ro04XoL2k3LD
	 fR9vPH8pUIHFC8J2+S4vJic8Nzsrtyqp/kkaxejdyote2ERg/Z6UXwB5qc3iaH/6pF
	 XIHsflVSq87GWT9xjMsQ2QcWJTjhbB+anymYQYLLWSk9tvdjr38But3OI2HscrK7nr
	 yKYOQnI73CRpB6gudvVUNCozkaqguhwRTjzgM2DCtuETh9SnPOrxknoVTWkIkX6zyB
	 4o6HD1s4T8Ti68qbQuAlRkK6be5lPNB/oNil95Z773N71c1mZbIcKz5kQp3F1QKrOw
	 mQPDZJdmKHIWw==
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/3] null_blk: don't finish zones to set them read-only or offline
Date: Thu, 22 Oct 2026 11:22:01 +0200
Message-ID: <20261022092158.2248831-7-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=cassel@kernel.org; h=from:subject; bh=K6QvQfo++jWVkT02HRJ/nIO+BPHObPxOa1zZAze0dLQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJuXt3NU3ag7MHM5PXSKR7ipyuu/1kz4VG0TmB8xT+5d c1dLNerO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARu5sM/6t0/IVc3EsOLQlc N5Xvpmzhf7G0pHieJS/2qZ9Vv/+yQJqR4Zqia/rSYwb2BxVd+irvLP6SFKi4Ys0vu1Cdo/ML2M8 KsgAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

null_set_zone_cond() calls null_finish_zone() to release the zone
resources held by a zone before setting it read-only or offline.

For an empty or closed zone, null_finish_zone() first runs the zone
resource checks, which can close an unrelated implicitly open zone, or
fail. As the error is ignored, a failure for a closed zone leaks
nr_zones_closed, permanently lowering the effective active zone limit.

Setting a zone read-only or offline requires no zone resources, so
release the zone resources held by the zone directly instead, using a
new helper, null_release_zone_resources().

Fixes: d3a5738849e0 ("null_blk: support read-only and offline zone conditions")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/block/null_blk/zoned.c | 35 +++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index ecdc8d68ca2a9..015f5d304c7ce 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -743,6 +743,33 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
 	}
 }
 
+/*
+ * Release the zone resources held by a zone, before changing the condition of
+ * the zone to a condition that does not hold any zone resources.
+ */
+static void null_release_zone_resources(struct nullb_device *dev,
+					struct nullb_zone *zone)
+{
+	if (!dev->need_zone_res_mgmt)
+		return;
+
+	spin_lock(&dev->zone_res_lock);
+	switch (zone->cond) {
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
+	case BLK_ZONE_COND_EXP_OPEN:
+		dev->nr_zones_exp_open--;
+		break;
+	case BLK_ZONE_COND_CLOSED:
+		dev->nr_zones_closed--;
+		break;
+	default:
+		break;
+	}
+	spin_unlock(&dev->zone_res_lock);
+}
+
 /*
  * Set a zone in the read-only or offline condition.
  */
@@ -759,8 +786,8 @@ static void null_set_zone_cond(struct nullb_device *dev,
 	 * If the read-only condition is requested again to zones already in
 	 * read-only condition, restore back normal empty condition. Do the same
 	 * if the offline condition is requested for offline zones. Otherwise,
-	 * set the specified zone condition to the zones. Finish the zones
-	 * beforehand to free up zone resources.
+	 * set the specified zone condition to the zones. Release the zone
+	 * resources held by the zones beforehand.
 	 */
 	if (zone->cond == cond) {
 		zone->cond = BLK_ZONE_COND_EMPTY;
@@ -768,9 +795,7 @@ static void null_set_zone_cond(struct nullb_device *dev,
 		if (dev->memory_backed)
 			null_handle_discard(dev, zone->start, zone->len);
 	} else {
-		if (zone->cond != BLK_ZONE_COND_READONLY &&
-		    zone->cond != BLK_ZONE_COND_OFFLINE)
-			null_finish_zone(dev, zone);
+		null_release_zone_resources(dev, zone);
 		zone->cond = cond;
 		zone->wp = NULL_ZONE_INVALID_WP;
 	}
-- 
2.56.0

