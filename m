Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F18BF8;
	Sun, 12 Nov 2023 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIoa+YKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2DBC433CA;
	Sun, 12 Nov 2023 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699795457;
	bh=Rdg7guVsde60lidZ58DeJltgKtLbo3p0YkcWBeJAIws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIoa+YKemkY2ARznzt0JNS3lDatm2xjL8oG80p9IkD3XT/EsCu+7dLevBKkh7er5e
	 wll0CHDgDB/cOJyBRwGeJ8aVxKJc5fVJV16k04poTEukJSDBo6GdQ60/hnVN+HYSfM
	 DOQcJwtBZpgB47uxQJPJUlJQV44TkVhZ6xTM1cuV3S6SRgL7QTMnxgSC1w6glWCkOm
	 az/ewmt1pub02nuZmSND83dFcMsfC3a3IXTRMe0dqutxGoBiC9+cb/EjjlewsnuIxN
	 PcCBkxS0tHeAPxDA4wfeAvhFESv5JnHlPFuzpBicePRT+OvZPiFxrvNylaexuwxW8w
	 yYoOUr4vfU85g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: zhenwei pi <pizhenwei@bytedance.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	jasowang@redhat.com,
	axboe@kernel.dk,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/6] virtio-blk: fix implicit overflow on virtio_max_dma_size
Date: Sun, 12 Nov 2023 08:23:59 -0500
Message-ID: <20231112132408.174499-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132408.174499-1-sashal@kernel.org>
References: <20231112132408.174499-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.62
Content-Transfer-Encoding: 8bit

From: zhenwei pi <pizhenwei@bytedance.com>

[ Upstream commit fafb51a67fb883eb2dde352539df939a251851be ]

The following codes have an implicit conversion from size_t to u32:
(u32)max_size = (size_t)virtio_max_dma_size(vdev);

This may lead overflow, Ex (size_t)4G -> (u32)0. Once
virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
instead.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230904061045.510460-1-pizhenwei@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a7697027ce43b..efa5535a8e1d8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -900,6 +900,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
+	size_t max_dma_size;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -998,7 +999,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, -1U);
 
-	max_size = virtio_max_dma_size(vdev);
+	max_dma_size = virtio_max_dma_size(vdev);
+	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
 
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
-- 
2.42.0

