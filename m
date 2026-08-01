Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30E30CD95
	for <linux-block@vger.kernel.org>; Sat,  1 Aug 2026 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599426; cv=none; b=BaLxBIua+1fnRVY0tfo3mgTE5sHA//+n5xRqVv9V9aLbVLE/xpcel4VgOzs9b3KzTYpMrjjdr5NgxPROjxkuV1fjN0WdLMQFDM6pWav13uEI+qYHcs8Bv70ojhQlv5Ju1d2Wr9Kagxl+myhOUyWW9mQk25iChecOuaiYtSTt/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599426; c=relaxed/simple;
	bh=5jZAhWEaWbKaEJ0h/lpCMDFZsTZrSyaTXCzcWYUXgLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrWuqPus9QXA+M/paOdVLYpvZbxbE7zAbIY65DGC3aGadcYwTVPXlhhjc+IZVzz75o3bQC4fk9X1S3hSg7+ro3S+/K1foVgsQyoh0GbhYemSojCrjMtt+bOscUcpLpQ/XvUw8aJpIZtBaCOd2Bvu5fxQJv10gHxcJIxLxundHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8M7ui1M; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8M7ui1M"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce7d2adef4so32824765ad.3
        for <linux-block@vger.kernel.org>; Sat, 01 Aug 2026 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599424; x=1786204224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQw568s99USSdIytlPm2Vpoz5MduETOEjKRltqiPXcQ=;
        b=S8M7ui1M6pVxwnF0ZWZcibVPh5VuBiUtN70UqmuTG0Pxj4auY5LB2yJ662kz75HeQh
         x6aa3YQ2w2cUCj1H/zgsw6w1614lui4k+ZtkM9Vrm8osQ2givsBkxawLreVDmJBZDtOI
         oEhuDISM7a1bYmDAhhRvlsjqAZE0ncxnAljIYA6w7ZRh0nT13QZ7VX1YHBpovz8LBd2V
         Q6mTrtObaxBNmR5w3/6QDirbDoaQQCOn+Li3nMoJKEVUTILZpjSv0nYOkobL49RNX2fV
         vXloOWCNX0Rs8+vWRbN9OulBzWIBEUN0+tcLVfjbwC4TSMDjmfvjQ3w+fXzj7ez5uUzi
         Qgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599424; x=1786204224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQw568s99USSdIytlPm2Vpoz5MduETOEjKRltqiPXcQ=;
        b=A4g0zb5msEjFM4CT9arL07e097tuOFTG/epbpKKjyAfim6CvTtOl1lDM+qyLNmwjPJ
         QeqOz/gjhlq3mG4FHw1/QLDi+QbgCmyVafpWfPKRhfzyri1J1tnxeHWVOWhQLQOPATf/
         3VSlR5guHgO1p5Ce0rDYQJW9dJJAK/cyecc6MjkPY0q0FrQeasNyCJvlE4fuwxNGSAwp
         ma4aFT/tgbzvYzmGtNTZKuPe52NRMoVqlYTBAnCZa0NDXWUl9RsM1+rzXRkNazhHiwYU
         W8mCXxt80lUurJRfIunldT4nXzV4Dgi1RY5LhoWhIQdLdnKGrDPrvPj71saAGc9gNQ4+
         c0GQ==
X-Forwarded-Encrypted: i=1; AHgh+RqT5ajHktBeQvrUnAwplJ0EYILES3bg5wOYcGni2gBSqoS4fqp/0pRgv5KchBMDKZqRov+vcfaDjayRrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3lS+0YOK4tL99Fn8aOECtgo5KzszQoZPpGodRxAXs8cL+6aF
	NPdl/gC6jfKOsVq4pwiAQ8Z+xlJtuoZh+ZqwCbfbeBxENgTiYY0nfk1we3cKn/Hl
X-Gm-Gg: AR+sD10ssbA3WOmXPgfQ/6MdLjeJU5uxUdgzMMDYRcNyXgYBkxsjGkOz7+8qHELuO34
	UhYE3FRyOhRg5XztndLM45dJP5PXeuIK/rp6NKCfCpHTsiHcM+awngYk7Vh13J2XLfx/RFkS/Pj
	HZKXJvPSpjHRdxx57wEiTqph6k5CompFkDM9HO4gb+geAZjxZ7MB29/XO035/PBNMnhtizFIULi
	CjLSNLGa1LFxdbP0WMtXP+o8T+5JHOkZqQYPKG9nYWPBwpsTzSc9K46NgzUhk4adWS+WpJO/pFk
	5bU5/7e8u1HX1yH3qZO5kCHu6UmbYxdVMUUghRH9mlImyCVCgJNFjM0q3KOKu5g8Hbn0vsltAMC
	LjD3kvp/oA8HzA3uWHlrJBDmcigdX0qWzJejV1Z7n6nfnQZAMB51KlEdaXnRs+0H+MLvKWbs62Q
	tqLgCSacO5omrKDRlWS/1ZSyQlPfNUc+5smm1ttGEcFhap/czt3HU4mR9jBbwyYpELW9Ecth2oP
	6rf2sQNUuuR5ngZExtqbRy9KpDHVJA67Nq8m4azdwakq0Dxq8my70tMWA==
X-Received: by 2002:a17:902:d2cf:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d0521a5657mr42155635ad.8.1785599424386;
        Sat, 01 Aug 2026 08:50:24 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:50:23 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 10/16] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Sat,  1 Aug 2026 16:46:22 +0100
Message-ID: <ff507b4895521074938d82fe2647e003359ec2be.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
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
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5608ede6c479..7b8ed101a13b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1287,7 +1287,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1317,7 +1317,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1339,7 +1339,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1502,13 +1502,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
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

