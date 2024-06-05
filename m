Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9F1A2560;
	Wed,  5 Jun 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588987; cv=none; b=OR71m4sLSWbZk+JETQ1BMxRHLz99gm4tTrszsIAdx3FHv2zL93UnLBNtv9Ue4axIuprgJncZ6XQr0xebkAXVbn1vgOhIdHjSuBRYgxKRUx1znMZxgbqWt7Jn4ylcpKDVQRF5JFOohrwMwlGxpQoMAmhW/0rRNLQ7XGJYM0T8z1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588987; c=relaxed/simple;
	bh=+W6S6xQ9Mr5ysKrm4VyCT5dvvfoqp7FzldkgEf13SbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkeYL2kLkH1khoNcLTL815xlWM4wXFKwFmaILYvWxWdVO8ovBI7/Qf8Xcov8DmH1h0hg40iDwUiDOvxWi/IS4dHiaraxnPH8MAYC+dK7necBSq2as+X/Eg2fo7JrviriICP1ZIdao1jfz/rHGiYoMh/AHhdAdQjjUt9xEWsp1b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGGPvpxQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGGPvpxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC49C3277B;
	Wed,  5 Jun 2024 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588987;
	bh=+W6S6xQ9Mr5ysKrm4VyCT5dvvfoqp7FzldkgEf13SbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGGPvpxQvls/iN3TSXFBQYWKOvxHyL7UIRGCZ46It6PPEFuvsFIk3Jz5h0F6+32Bq
	 82Gou7oQ+uE4e18uakPLP27UQ4AiGFr+5+UWi4UTSiG6ZS5L9I2Ezy9hboxcCQ6UwB
	 iqt8SllWwlhuWXmEiorQyTZ+4Q1S30D7Qx5KPmcC97VdtvBxhNGI1LNOV06Sexu1r7
	 10yoXDLkCVopnlsZYdUSI0pbUK6ES067uPn1fYn+6NQMW++TcH+MuRvIH2+MKU+C6o
	 P5Gd8wu6BdRdiASKEgl2d0CvtJeDzJisO7BD/pnWWXphmBhrBlZynXB0zg34A6H306
	 LX3g+pQExSLQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	martin.petersen@oracle.com,
	hare@suse.de,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 23/23] null_blk: Do not allow runt zone with zone capacity smaller then zone size
Date: Wed,  5 Jun 2024 08:02:06 -0400
Message-ID: <20240605120220.2966127-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit b164316808ec5de391c3e7b0148ec937d32d280d ]

A zoned device with a smaller last zone together with a zone capacity
smaller than the zone size does make any sense as that does not
correspond to any possible setup for a real device:
1) For ZNS and zoned UFS devices, all zones are always the same size.
2) For SMR HDDs, all zones always have the same capacity.
In other words, if we have a smaller last runt zone, then this zone
capacity should always be equal to the zone size.

Add a check in null_init_zoned_dev() to prevent a configuration to have
both a smaller zone size and a zone capacity smaller than the zone size.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20240530054035.491497-2-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/zoned.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 1689e25841048..b638b7f7b4f80 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -84,6 +84,17 @@ int null_init_zoned_dev(struct nullb_device *dev,
 		return -EINVAL;
 	}
 
+	/*
+	 * If a smaller zone capacity was requested, do not allow a smaller last
+	 * zone at the same time as such zone configuration does not correspond
+	 * to any real zoned device.
+	 */
+	if (dev->zone_capacity != dev->zone_size &&
+	    dev->size & (dev->zone_size - 1)) {
+		pr_err("A smaller last zone is not allowed with zone capacity smaller than zone size.\n");
+		return -EINVAL;
+	}
+
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-- 
2.43.0

