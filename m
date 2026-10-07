Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38083345ED2
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337407; cv=none; b=ciPuoQ7+FGNHg65EDJLQpw3VhxKMz/yMvFTWKOh9ITO4weAMxyRfY2KjKA2nzid/rIyAdzw8bMcv4fYfgm/sDss++qwtO2Lhh5Vn7J0HHDYkD3rhFtPsAcwTLFpulA6FSBu3LXLO5WaufoBJCy5Du5PuoVleM1oI7EDH9Ue8s1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337407; c=relaxed/simple;
	bh=0a99AkCdYYlGDSLNyvcoHvxyA0h7cLM0HZDY04APdmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itJAy/hkGJsDbpBSiHIcG+Mc3hP9XWN9r1WZ4JXbqwja1Ncr5mINbieA1mhU/AT60ZbOfxtOjgtWrmE8niNARa7OfqVS5iX9OfKsR7nHow2VsKfkIAPP8mYzO3c1VLDUAL6woXcm3v/paXmnfNq7/nW83uto+HQXPNBCf5OqYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f27ty6mO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f27ty6mO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so9192935e9.0
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 18:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337399; x=1791942199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=f27ty6mORd8iV0R/oG+qG8LoZ4ztJUp5V/I6qO/Smujo/cToOggNECPqGLhxNCVjeS
         7is2ZvQ62x70H7sSSPf2IqOvzLiLKTjy4xDzFY+C7mD+zAszqqtJhFzgPOxEdVu0WH49
         GPxmNLP2mq7FJ9Idk8MHBU46Otf0P/B9OplADmA2KnytGpnM6/cULygVJfD5x3cLs5KH
         plSq+YnxUAzbcMKPQYD9pi1lPD2GUOaFqqNpBgeyJG3BZC9kgY+lfpKH/DtpEcHUj1Xd
         i1v3Zl+7hi0ooHz3Appux/AdHcE2PtVdTF6fqfRGWJ5DEK/Zwk8AxlZXFiCWUZVUWGbT
         0Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337399; x=1791942199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=TBVSsDq0itOziIyV2dNIHCVUb1zA6bTmEIff9/Lpe0vFuFRQZZUuWhflkBvPbp8dLL
         FPmgPxOQ24T2qCjFL9lhVlpMX2PGXoXxYpnK8HoyZg+N5W0BrbTfOyp+hn8qKaY8OMJU
         dYOqjC6Tp0wnQFWpekhNcn+nYN3LFGj0BYgmOSSaIY5FokCJ4SpzWgfyOSWpH+iq+Rya
         UH+e66gcNU1aW3x6GUYxS84FkoB66mExIJ2cQMfWur8UZOseWw5g5k3DLrhBcCpFKg/L
         g3Cvzj5EFzBfXxIM93Xgw+vaAj7XMMJnPbd/A6HG2RTR0e5d/jGMdUw5U2RHd+M1DSvD
         1wrw==
X-Gm-Message-State: AFuF++m82FdOBvaXsWO/datQSAWwH+qfKxgVs+OHHU7xtsWT529pYBP1
	F9PV+Cyc3M97gkV+bqrYHugP1d4f70XbzI2YXg4lkFvB6ofrDBEX4fAckyurdQ==
X-Gm-Gg: AYBFou1NeduF3avGhHi0JLxQin7p+OIAWlO5qeSHPexP2hEmT/pR/uT0psobSGra2cF
	AzV2azZUh2m1XvLYfldBxxaAqTQ90OgcJlTnpzpFLK0mmFs5UQ4Vyvw+9uXvXwFfF9iPqmZdizQ
	CLsWPiup3ACdZmTkuqLhI/kjYcOV8E1Yi/66u1o6o5/6HSqptMPIxo+sU+jqMBSuGLVf+PpWpfI
	3LNadf/UqDbLkjjTQElK3+s43IKoOeNivJhsVBNTc7sNlWLPj5WBmqaFanHoPmcWWPA3JNA1akX
	VfXPdnfNJ2XX6SQxK5cNTjaYhQkYc6fGq+8F2avm4/3QZpHvINM4I/LG4q2athkiM+OYzMO2i/e
	Tq1lr+pLdK96SqjnRQqOu4knqqV7IELm2VmqRae5YMNU00+Ut6F0xzccdKquWeBU6tlmddTxsL4
	gHYjS07AH4QccgRZxWFcEbEYg0R2pbLkDk2obTDqR+OGcsQm7wjzbqBQKGr7s/uKszFaLNt0UTf
	6AfSqmrEz4PpXtT9yvSXFjacJ6GT3iuPBiuP6fxuZLJVFRrF2UzBR2HXOTY87QbbHaPCE45o4Po
X-Received: by 2002:a05:600c:348f:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-4a18043b38dmr6958715e9.25.1791337399492;
        Tue, 06 Oct 2026 18:43:19 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:18 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v9 06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Wed,  7 Oct 2026 02:42:49 +0100
Message-ID: <2f8b57f68fd3e432085b3a7767971778bc7d1919.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anuj Gupta <anuj20.g@samsung.com>

Rename the blk_dma_iter based nvme_pci_sgl_set_data() to
nvme_pci_dma_iter_set_sgl().

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9..a65b77726e4b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1147,7 +1147,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1177,7 +1177,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1199,7 +1199,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1359,13 +1359,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 	iod->cmd.common.metadata = cpu_to_le64(sgl_dma);
 	if (entries == 1) {
 		iod->meta_total_len = iter.len;
-		nvme_pci_sgl_set_data(sg_list, &iter);
+		nvme_pci_dma_iter_set_sgl(sg_list, &iter);
 		return BLK_STS_OK;
 	}
 
 	sgl_dma += sizeof(*sg_list);
 	do {
-		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[++i], &iter);
 		iod->meta_total_len += iter.len;
 	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
 
-- 
2.54.0

