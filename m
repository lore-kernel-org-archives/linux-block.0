Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DC3D6CB8
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245287; cv=none; b=UvS71QL8ezsHy3qHiNfNghQFn2pmuBQxEISqMTRqp3sxbCMVExXtPXevZHj0o8iAUOZY9S1gsHP216lzUazq10dXdYHVUxV+N/FxrRYaSmXgGRen+FTbPztTnJAg0YVw+RcIz313i9dxHGdf+xN6HYCYEOmD2YDkBHALphy1Now=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245287; c=relaxed/simple;
	bh=dXB9nsSEQr0UD6HILmUJ3dO6tL18AphRTyOEKOREPnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oECO06PqFRMXgZ7GHyjcuGE8mW8SkaGGgFL0qDes0K+30VQc2fP3bYgcL3J+RRcf63fDOivVC9sprkKwIRAWsDxiuImz+iBBQUEYEgyFFQ5SFXARzEW4DY6ZEkOK6vlfdbIN60YriNXC/Azz4UAEElquCip1EHcekXVDDNdso9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JvULn3uO; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JvULn3uO"
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-12734af2cdcso91202c88.0
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7Uy8gUL8icrsg5BG6MoYGthlOT8yOCeEWU7Db5146I=;
        b=JvULn3uOwkKUaQaHqiJT+f+UAp8ILB924uzwY7yoeg21GuaTAkNMfn7WUgSTmCkyyC
         smp36/0PpdPHWDotyaAGL/JbIpK+JlJaBVTYquHkH154ucK+3pSS95gCSapl3kKo9uf4
         CwKtYFWipRUDso/ZR6Q+7MeTxbp66XDGH5FaEwhIQQf5KAHfzO4HRx5Ch2hcidmiMls7
         wASCAkOrzJBIOCxCNniqYnNrUCX2PDkSp054MqK0XYeRm+Mhy60OSUv9gYlxEKXOSt89
         AFrDjNx/epWcUHg7nLd6JKf0zEH5JSKt8eVcdbCrM6HrP6YF+DCiIQzbi/HLtM+sOnOx
         w5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7Uy8gUL8icrsg5BG6MoYGthlOT8yOCeEWU7Db5146I=;
        b=EFYEKHnmOoT4DKoyEFAiMS0p7xa5B/RkfxuapMNAnmKL5M05a/MSeyH6jAKrM5UrZ6
         SOPFI8ZMYyrcIelVbO0xgoktxrwp4y5eOPtmVCyTspnqtKKu7KURPNOTelGTc6XDygnP
         OieGFYPjwtqzn2yD0DnAX0lGnkDIjQs41AHpIFWDIkfdk94ciH/UoDnrpaEJEFaDxLbI
         0wvp4rGBemde7P0/YTIMJ7V+UwjIilPbe9BON8vX0so0jFnyKyD2+vAVUYnKdj4PNQSu
         w2Is/NSN3QrnjsPIhWM5Ykq2BvKDdZvO5B/hq+5bVK1IDwCXN9UpGdGO9CMWoa+qqyyM
         RRVA==
X-Gm-Message-State: AOJu0YzDrugzNPJ2J5eyJVZpoEui96sI6g4+rC+QxfAgkPZu4Ks9T8G2
	nN3hGU3v8vpTuJMdpj0nDdeb4WjWyDkxFFJX4euNA6yUf32DyaW6K5woVPC2g8f6zLCaS5qNL9i
	7C0cz41MsIDObDfS7PrNYuAqhrYRrASDW7fE6
X-Gm-Gg: AeBDieszBZhCnyjSgG+LuLvPFm1FexomyHpPS7Z1zfbtEIur12UZnFAwLdR5DLlxdnb
	6StsMMuzEeyBLVufeX811LhCuAxN/NwDoAnYg7XbyifCzeHN28rmq14aP9YkFUW/RIVx4ChNoen
	onHSxxkL22UuTOWlltTueBP8gpbwvyK8vFFJzfgFmRzU/9TqCNQl1dNuIxA/FTtL5wqKMCzHtgW
	7ZCmPgLAuiz/YnJVYhS1QLmBt/xMV/UP2kUyb6jZIcZulWtJuds7d8FSZDundfrBe3+KujM2B57
	7ChhDCnPSPD1ckKpRmSxnUz3p4rfmy1NlQ8jYDIu++/230LbUFcCBe2+6BRnJAHj7HAaGLH1Bsv
	wWsLlb0bPWzowNBn3OwkG8hLdqUCoXFusT1uEbK6KMcfOtOIIaDlNAQ==
X-Received: by 2002:a05:7301:6093:b0:2c0:c55c:156f with SMTP id 5a478bee46e88-2cbfbc82969mr870935eec.4.1775245282274;
        Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2cb61750eb8sm339741eec.29.2026.04.03.12.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7623D34014E;
	Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6CCCEE41AC2; Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 6/6] target: use bio_integrity_intervals() helper
Date: Fri,  3 Apr 2026 13:41:09 -0600
Message-ID: <20260403194109.2255933-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bio_integrity_intervals() to convert bio->bi_iter.bi_sector to
integrity intervals to reduce code duplication. Make the same change in
the nvmet code that appears to have been copied from the target code.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/target/io-cmd-bdev.c   | 3 +--
 drivers/target/target_core_iblock.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4..dcf273360015 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -218,12 +218,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-		     (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sector));
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 		len = min_t(size_t, miter->length, resid);
 		rc = bio_integrity_add_page(bio, miter->page, len,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1087d1d17c36..434ef2b0b120 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -706,12 +706,11 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-				  (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sector));
 
 	pr_debug("IBLOCK BIP Size: %u Sector: %llu\n", bip->bip_iter.bi_size,
 		 (unsigned long long)bip->bip_iter.bi_sector);
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
-- 
2.45.2

