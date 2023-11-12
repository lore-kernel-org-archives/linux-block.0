Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5AF8C03;
	Sun, 12 Nov 2023 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePuys/dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E5C433BC;
	Sun, 12 Nov 2023 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699795478;
	bh=lMxgzkyq2IcTJHsewfFDozAFajBZzVRz4hG3yP0Tjpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePuys/dxFOA67ikj+6gTPNls66j9J/032mVTVtL8rwLY6LgyubYEhKdocIuiV20UP
	 FX4qfF6asO7rRsHrRIwVlfSPUO8bpF92EwHp95/BfRVg8YnxdGWCaXqjbh+Ol5yqHE
	 dmbKv3Fdyg6Thol1Kq1ShEHgO1GhwxI9C9rZEpWSBxGWoeC3K2y8jSxsgIJ/SzcwRr
	 oDIcgEtv8SQUiELJNgSt4RLZFe2dY6wjYEr/DKbaTtmnMqLLJGEUNJAhQVBHlf4H7P
	 prtflBIOaNltfHp4pg4Gys245q0Azy7lFH75rtrX12GMm+sliBwiF5fELOU0DjTLqI
	 mma9JsQEQBtPA==
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
Subject: [PATCH AUTOSEL 5.15 3/4] virtio-blk: fix implicit overflow on virtio_max_dma_size
Date: Sun, 12 Nov 2023 08:24:23 -0500
Message-ID: <20231112132432.174680-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132432.174680-1-sashal@kernel.org>
References: <20231112132432.174680-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.138
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
index d2ba849bb8d19..affeca0dbc7ea 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -743,6 +743,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
+	size_t max_dma_size;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -844,7 +845,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, -1U);
 
-	max_size = virtio_max_dma_size(vdev);
+	max_dma_size = virtio_max_dma_size(vdev);
+	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
 
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
-- 
2.42.0

