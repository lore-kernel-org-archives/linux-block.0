Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660929;
	b=YjfsW96p6L0yOjNmXMJC7uxU5mcsinMwaDvr1BjaxjPF3YbnpqDRXrJyp+GJ4wm99Y7j
	 MhS+oS2lINeYlNaWXfuzC8szZzBchlDVF/rlvfaVE9jIs7lnkKg8WtQZ6ZW1wQf1FQCM1
	 z3YnNa1LM0onqCRrKCbWLRihYtokllwiJKeWXQ8mxTmTkkZA4EcHSWIqZTraMcJTnztUo
	 KncWTGusG4hIgKq2Wrp/zNEbi8bfhQv7rNLnXWBJile1DkrozDQU74bxxzl0+T95469iZ
	 YH0nv11hZK9c6udVel3V2D3Xyt58Jms5MpElUYwMBT00cKlaadez/7g7BMgFdfqalsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660929;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=LujKtb6ohCjzpebnrfNhU+JDBnTGq9+UQVNKsGjG+ok=;
	b=t3dnHODP0uL3QJRW7Fj0atIVeTGojrgywT2JcsgrZ1eTNUM9iyszsGhyIaLnJ1f2xZsX
	 QfbxgJ4M8W4KJwQ7orDP99nPYnA6mv6czJgZW7+cmZCKphf6wSs6fXlzOcFcgxCZJgOOU
	 0oTPz6lpQPwa+sDJXtvXIJIjOdaX4GIpvNVt8Z4UH12ux8w/LeghvGT4y356iZefGVXJ7
	 TIh0gCnY+9VxDq4gC3mbRCxUc5x1c93uKI0M38W3hgJnGD64a4DFhFiydLdEUYOwGLuS/
	 3nisbQbbn5Qeam9lnl/8+iRMnRIXIPCfUuABocX7nWExsT1nlmKv5JIBOZj5xOaVSQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFooD3hJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71972606A319
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFooD3hJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54321F000C2;
	Thu, 22 Oct 2026 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792660929;
	bh=LujKtb6ohCjzpebnrfNhU+JDBnTGq9+UQVNKsGjG+ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TFooD3hJ3kDHA5W9lOPlwy1BR03olIriSD3aXnJZTsMi76DI2h5VXyKPkNJZwypcR
	 JfCdPtTXHAipX3vTO55pIaeUK9WBRPAnVpPexmDJ5KP2kHoQ+GTiZWNI/F6AgquNW1
	 7UPRmqffgvV+W17443jJ59GmzrCLDJ/09MTzpCsRFFQFYUhUI8oQdnEqWI5aE/eiaB
	 LNrcvOMQp3Wua9WozvprsSkP3h7KTTyTbb+HVY1Esa/nUYZZ7mI2CjFWvM/d5OywGe
	 sojwoJ1JsuvLSgs/2IeaNR+N4O/OG1dZ7ovGHFmKurhl5YtaSJQCQ7FMoZOp5vxVdZ
	 P+jOn61UtHQMA==
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/3] null_blk: fix opening closed zones at the active zone limit
Date: Thu, 22 Oct 2026 11:22:00 +0200
Message-ID: <20261022092158.2248831-6-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=cassel@kernel.org; h=from:subject; bh=dI1NmOFbvSeNBTQYcWrZgE1u9PJnE1fV9BvdSSQUc1I=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJuXt29J9HHrl0j+a7aPa9anW1n2hKna3HtMZxwte/vj z62z8u7O0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjAR5nKGf6ZfL8yd4fvrY8eC Y1LzTs3cULC0a3HFtzuK7Z58ypfKJv1nZHgXE+a9X1/xBsPjrcmb/51pkd7wov/Nr0OzYvVOxDq U6DAAAA==
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/block/null_blk/zoned.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 7e9b5ffb9e841..ecdc8d68ca2a9 100644
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

