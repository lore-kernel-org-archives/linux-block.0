Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E5556BA7
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924933; cv=none; b=tXZzkyLHHEUCThIJQPNAboTdlr2UdOgGq7eGrYR+gIkMw4Ru4EV3bYAN+EZuVhig/XpxRCzIRBrXy294JPeS/5Y42ez28OGdraf8cgkiybw12S16mmrkCaZ35m5LCbvCghuyYDZTz3ggVB9596grpS3K6TmVn3kH8N625DGnnPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924933; c=relaxed/simple;
	bh=0a99AkCdYYlGDSLNyvcoHvxyA0h7cLM0HZDY04APdmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4TODz8UgdFE850SU03rx+S2HHBqOQSAaQBBAQ3o+/P0Q2XA1YiOuKVo/mhykRw9egYVHl7bfsDehC+9ErqRcA3XSwwoioHMTbbGWocGLmt7EmkXjks29U3RFg3ci5QbN6o9YVhA3lVJyTX4509Ty+FPIQmld4wJ7xStKa6BiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwcO8KdU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwcO8KdU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afbd2c386so1987002f8f.3
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924928; x=1792529728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=LwcO8KdUHyYrdKQ/8j7tAKiNFwHbDujT8GdFEX2KNcqlHFfG/Na5K5kxM9B1aG/3XM
         UopK6UUi7ijG+DVl0L5VdYAdDQ9I5KVXnl9K4yNUsLrXbjkdYgCeUmeM2orJUZ6wJk49
         V4XRyAyXaQo9AbwQMG55LhvqPfWwjfWLV0rVhmLJSkuS9+HyZWRmeJUcwdQMGRw8KYaN
         zVivHMHc0OobZ548LI1ZHAplQU9CqVRAzggD5J04MEBpto8/6C9n3vYEmdGSXmvc2Z39
         B21/xy+LGe9qvbbIKlqo2VKgw5gmXchSSo40VSvJn/J2OQQYl/waRhyPMtrNBQiMToSh
         FT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924928; x=1792529728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=GQLW9AIZyx3j/1O72DhigexzGVdimzcuQA4cX2kTLmTyNEqlFw02lHW/IcIm5xYBrB
         PnLbzVLLspOFsE8J+K0reWHOjiDXSffb+a6YMeNznremGNIlVpk7iz08u+ncKEWyvjiY
         KTLDGhpNn5Lx4AECT8aBWiPTHIa6SVktn6TpL40s5tpvt+ukQDRr2KbtdTZrERzcjKPk
         aid8qfsJhy06JZcO4J1Z8v3dqobSQZXWngSu7GadFW9LBYRKLsZsORAbogm5nphk0jLB
         HZkOBtKVztQ+Wlio74TyTy7DSb49Qk0gE0dmZ9zLA8BXaUTzu8ikos499i5+GDiuzgvL
         cCkw==
X-Gm-Message-State: AFq9FYKh98BbCr5eTW/FwdAHcmY060USPGxElStUu+90fvlbjb/AeGlq
	AYikZligXbvpNSL++DB4M2uLVAVNonMhbHfGib9fTIzAlMsE0uPUnowl7aMwVQ==
X-Gm-Gg: AYBFou3v7lfDvlN6grBibog6wkCP4EIOEEE5hJbl86ELLvEDoZQakuTcUr3JpmpPW0+
	jPcpDmNSabBzBrz7bL3FnbTQQWrS7J2Qn4JV/GKaBXlXblMaV9dL6L4ZoLbqlCjjeMIZBOz+59Y
	CwYwD1p6yrDm2Zn+7rnmv63vrnSwnzY6MzEwrF4mE1TXNXPZunF0RyGetXaepcpLGUVG84txoiG
	3PY2tn4S4QybzX33frP4Fv5jvlJTRZK524BZ8fol4+Mk8fkyqog8ctRGGdGzMpU8J5rSCyQAPWa
	d73t42aE1PRsVjALbJxjwkz0Rp4RF4ekBUGk43dsSnWe8jxSI7vENtXnHU2JzJomAgZg3bSuhia
	BzjLV9NHww+9eaViYZ3stWyfQG5eVHy1uoQ/mAmj7LZ7BJq/76OqTe6so/JPr/6X1UxXIpWRm55
	ZUUftJliEb7PId15Vp6E0aXnLFYv/cA3950h5cUdByHbigfngrdzXa9FHHdCUwPwTRWyFArZWPc
	6gsN/dYU0/vaIcQy1MadGEkk8lRXpj/kRKRvZ3uI578h5tkdYuQcdLdpjRuil0x3L9mwzn30sjD
X-Received: by 2002:a05:6000:186f:b0:48c:7c69:2dce with SMTP id ffacd0b85a97d-48dbace9dfemr26073729f8f.16.1791924928152;
        Tue, 13 Oct 2026 13:55:28 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:27 -0700 (PDT)
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
Subject: [PATCH v10 06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Tue, 13 Oct 2026 21:54:50 +0100
Message-ID: <54f1186d20a7c24075dd38eda1dfc7ac3705a13e.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
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

