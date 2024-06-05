Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318351CAB73;
	Wed,  5 Jun 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589086; cv=none; b=PNhiOitAzpX0SZB/T/MT0Je2GUdWgxpil5TlpGbCF09TY9+dzSnh8PCn9mdlkDnWjqzUs76YoBgVCzeD1MqqcYGQBbT6RDS00XBuf0/iFKdioLMoZomsf8PevSo4DnSHZFbpEWmtsfz0oXaCOR1LD++h3sqmSIwtVjXAtF8b0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589086; c=relaxed/simple;
	bh=ULzyHXS0sGWALaeJqeoih3j0CMPUwjesskRuWaz8y2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ht0Ru5aA4MEJg/l9ZTCEUB1EK/AZE3Dd29GhYoMtyuerrx4UlbsEcQT5JoZO9vrJeMMDETw84D4h9NhYuGc6mslG0SHZ3GXYULW2UwWQA7DYH2N/GfWaA+jxPXj4XL+l0iWC1KGAm+eVpzS6xmjMaPQyBgSKPwdFxtGYKPgFkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfpqkaR4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfpqkaR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026B7C4AF08;
	Wed,  5 Jun 2024 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589086;
	bh=ULzyHXS0sGWALaeJqeoih3j0CMPUwjesskRuWaz8y2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfpqkaR47E3Uh+m3G/eetpQzFye4uruJ0jDgUEvjtqJkVkDV0LQHFkzhPbGV7aDKm
	 olIn+PJw2TVuSQ+HwJk4/X17nwYIxp3JjK0xdwuPfvWzS/1GKpEKZiKVCLw20xUlWm
	 UsCdLMFDpViWC1gWin9FwvIkpYkeVZsNhZZOjd6cfcEYgusRXBh2x97ghwwCYkyBlF
	 Pip9dAdFm1sWAgK2HdSmMTzI9ZBWD5xQb2HDx2ZLlVkEKyHgWUwdcWrF6xX6LYn2MX
	 PqnNn18BeG1v/xM4SLKuSGeYi2Fz+wfYvI7KnDBnzrwdd/TvukxQAEcIpHXu/Ipyxa
	 p9xq3RFlqfNig==
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
Subject: [PATCH AUTOSEL 6.6 18/18] null_blk: Do not allow runt zone with zone capacity smaller then zone size
Date: Wed,  5 Jun 2024 08:03:57 -0400
Message-ID: <20240605120409.2967044-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 55c5b48bc276f..9f6d7316b99aa 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -83,6 +83,17 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
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

