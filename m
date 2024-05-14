Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926F181337
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708368; cv=none; b=c3qQ2/ukkRdQIm0xre56g5LwF9abBv3GyAtmIDUHdnU/fbK3x+QDn2WX4yuh3NRfanj/uKaaN5vnBXCeOOro4aCqjhaIDuXsWHGBlp0/JVkTxz9Zm6Rx18OvCKUda8d0WYq/qxzhd+MXMkWNKUuWzV7SAdXqFdRgj4ntCJBwFQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708368; c=relaxed/simple;
	bh=DovLNH0jWI5RgqORRkqm9l+XJ5AhX39zkvbiQ0Futvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hXWIvubGZClF4oaZS3bsAV5GIjVl5teA5X40RKwy9diRdwWKF++VMdBXn38z0kBsiYWWG48V/8D+AMzsl0hw8jzFPHmqJOtSA6Y3aP2O+xWTg6Onk9+SmXTE5dLPYQLEEr4BRhywjqGPNsryFspYY0x77Sv49SV2RyV25OTBlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlIQnAwc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlIQnAwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462C5C32782;
	Tue, 14 May 2024 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708367;
	bh=DovLNH0jWI5RgqORRkqm9l+XJ5AhX39zkvbiQ0Futvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlIQnAwcsHIjT3vGrkL2MlHhLWPBsGvCvVPdf6YEH0DurwDMzPZyTREBMAnohIoP8
	 MZSoLqMRqgEssNu+YSn/1n7lIxcjuMsNnBL0yvywsDlRye3O/VdiPXt4qXLXVsqsHN
	 Eq81/ab+itMx9Hc6sz9gas+Sn27iOmTGNHqwEVcUBwbJJb2W4DKiK467ozO+aVHs+z
	 FWQQ8IgOr9Fvb2Z2ssAuWhx1DLNw9stxLrNLxBSQd1vOpu1ELd1whGrnENf0DI+wDD
	 e0DL7xodgbMjwHDoD4p+TRYtNAkbjMcvNAAi4FIH/634i08v8lLwvqIE+WJCSdOirJ
	 h63mxYXobFr2A==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/6] nvme: enable logical block size > PAGE_SIZE
Date: Tue, 14 May 2024 19:39:00 +0200
Message-Id: <20240514173900.62207-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Don't set the capacity to zero for when logical block size > PAGE_SIZE
as the block device with iomap aops support allocating block cache with
a minimum folio order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 828c77fa13b7..111bf4197052 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1963,11 +1963,11 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	bool valid = true;
 
 	/*
-	 * The block layer can't support LBA sizes larger than the page size
-	 * or smaller than a sector size yet, so catch this early and don't
-	 * allow block I/O.
+	 * The block layer can't support LBA sizes larger than
+	 * MAX_PAGECACHE_ORDER or smaller than a sector size, so catch this
+	 * early and don't allow block I/O.
 	 */
-	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
+	if (get_order(bs) > MAX_PAGECACHE_ORDER || head->lba_shift < SECTOR_SHIFT) {
 		bs = (1 << 9);
 		valid = false;
 	}
-- 
2.35.3

