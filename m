Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48286AEE
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939708; cv=none; b=V1E5vAl40n/GQE4nCORDVB34zB18i3ZS+fTg/cqPuPLEtU6NWRAG/qWL8uux9teaDr9tHVTt2+Q74yCdKjySImrFZ+ab0JNVCnqtky1FLcI446XE6j92OPgQGBM9VAZXwzAQvjkOW/hcY7ZgwrOm/kSF8wDkJFYa+8YQY0KZP2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939708; c=relaxed/simple;
	bh=gWCcBHRP9xuXXFoCVET9UdGuxhCqH/vZNBSd9ErS+1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeaOHAIH7dJHzIoD5d3q1kq5ECnPHbApQyujsX4Ppd6zUCApqv5Me3k27OBQbcYkKGjyXv6NvBOuVcLko9PFkItynW1p6rKvJMsULwhE4XLNctkLaKkuvA9NPbcIKwO5Wadui0dmgtLgaO9+2m2kHsXxBi7gZaGmczK/QiLY0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5B+RM5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5B+RM5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9084C32786;
	Fri, 21 Jun 2024 03:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718939708;
	bh=gWCcBHRP9xuXXFoCVET9UdGuxhCqH/vZNBSd9ErS+1Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I5B+RM5CtH3VRrs6qzgp+TjPKg/F3cy/uCqwzf6eh6bPwzMDxHz1+s8ZejXlj1cIX
	 k5IlKzpCF5D9GYNaZeIwdWr52xD6/EWaBbCv54C9eSw8PiAlqDBwA9B4LWt16TH+0V
	 7dIlpWYVAK210To9h7X0G6hn1tr6g66m7AiFcocleWljdik2eD81eVb9u60ctjwOOV
	 xKpilcCendo9MW5z4c8ZoZehoTbARktBJgHetkd55S0R0DDYMqiYvBiJn84WtgcTpc
	 /OaM/co7C8wCwRgRv09cjugsu/odf9pxkqaKFV+5boofVUHyjLaVNbt+f4EvyF++m8
	 Eev8XkrkAKROA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/3] null_blk: Do not set disk->nr_zones
Date: Fri, 21 Jun 2024 12:15:04 +0900
Message-ID: <20240621031506.759397-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621031506.759397-1-dlemoal@kernel.org>
References: <20240621031506.759397-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In null_register_zoned_dev(), there is no need to set disk->nr_zones as
the now uncoditional call to blk_revalidate_disk_zones() will do that.
So remove the assignment using bdev_nr_zones().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/zoned.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index b42c00f13132..9f7151ad93cf 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -171,8 +171,6 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 	struct gendisk *disk = nullb->disk;
 
-	disk->nr_zones = bdev_nr_zones(disk->part0);
-
 	pr_info("%s: using %s zone append\n",
 		disk->disk_name,
 		queue_emulates_zone_append(q) ? "emulated" : "native");
-- 
2.45.2

