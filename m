Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF116D4EC
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336982; cv=none; b=WV64Ji4h6/lUrnXdexAZwSHuMOmKaALq70U4zlA9I3GVQdYTopM940vGZJwYprdrY1bq9bY25unyRNCU4nnQoI+M4MVrGwIdPD/MOC1Nz3v/V86JtosTl/etiTHhIymZDyvbH70RWo2Dch0pxgaLHcn7knEkxQFl+6jhKIojcVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336982; c=relaxed/simple;
	bh=fd+9PKpzde5Dk2onVoIgU5jMVRisFeNkKmSBmUuDNaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sl8Q67k5BslWTKzeQppvcaZjWTOz6mS8h6mTaLvSKo9Y2CAE7O8JCqZNFEEV46TyeKPPuUs/uwsE5mgV8sGnPLZMpcVF3vpXuNafQkJCcLcP8v5UB00MAf0yqCKV8z1PUhGbSDD1ugG6rS+MA0F1rWetTmbhmV9QEXDQh6TIFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doqzV8AO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doqzV8AO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42A1C113CC;
	Fri, 10 May 2024 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336981;
	bh=fd+9PKpzde5Dk2onVoIgU5jMVRisFeNkKmSBmUuDNaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doqzV8AOo3DUDX1k35UihgmWnqMHMO+4othTCsffGxit/c79LZuwvLbXKsCWe2CQ8
	 x231WUp8yIViuZFZWUgu206Y6HmXbPvXZybUsb7Lh7zaTJOoZubUNxSeiuFqfUMCaF
	 5wxbcgsdgAVhz5xkZKlKhmrmuLFm4yuM696HrWqSq1Ltz8ORJ72DRaRPWTMhkuGdY2
	 KN2G6isaVJRGRsIoy0VjsNvSbZ7BL2IrwjUZk0rRYygpikFm2RwsDwaxITKhK5kMnd
	 oP9/vDQinCfWG4FRDw9zNOo4mFI3Xn00OqcJHgYnXEqnZ5Z5XF4PXRyCYfKOCVyX+Q
	 E9GiCQWcFoG1w==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Date: Fri, 10 May 2024 12:29:06 +0200
Message-Id: <20240510102906.51844-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
References: <20240510102906.51844-1-hare@kernel.org>
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
 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 828c77fa13b7..5f1308daa74f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1963,11 +1963,10 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	bool valid = true;
 
 	/*
-	 * The block layer can't support LBA sizes larger than the page size
-	 * or smaller than a sector size yet, so catch this early and don't
-	 * allow block I/O.
+	 * The block layer can't support LBA sizes smaller than a sector size,
+	 * so catch this early and don't allow block I/O.
 	 */
-	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
+	if (head->lba_shift < SECTOR_SHIFT) {
 		bs = (1 << 9);
 		valid = false;
 	}
-- 
2.35.3

