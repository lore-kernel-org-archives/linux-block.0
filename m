Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205899;
	b=SxIraWfhQUq5ApjmEfcGqDH7znS2GATjixcQeapjtEWiNSFVRiYWrhJ7U9LIUgcoy+3P
	 HQtlVbzBKesxjx5XSDNLjwjWOqBXdZzHtPlSDGxQvMcG3e9FXMavTucSsvNZ9txI+VUds
	 ItriIcrynrZj9HBF/rqnp2CmMOagPyDxRj9cGNu6+UMTEt8QPtM1cxWdpYhSTF3/Z8lUh
	 CFZZ0u2pTpbcjJli8l1WO4vvMbVG+7/siaEJBtY71zpz39c+FNLKg2bY833f+Yuykjidh
	 xWcZ4ad3sBiydUB+azPpHXKK7NuIyDmKSbni0h8wisfNY/QWwx9EBoX9t4iO6TYMJNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=43fNiymvfrbcShBUvXeBFpEWnvLGZyv5ExKLMUTpuaY=;
	b=Fu5ht1Dm0eqSXXfSytt2nu0VzSGCIIzC+XVO5x5hdQi3ogYsb5eiUmhFxTdbrlhtY48D
	 A7wmmzxjbHTUNQlo6mVERfwTfMYuJoKI1ttaFMh+HCaY4upHYK51+UmFEoYxArBRst3dO
	 bZ4WXL7xFhyOIJJW02UaJyLKJveWAtAwco4vJrbs6uCXiR9+TbBVvouk9ksXhSOF/QyKR
	 fsGZfNW9alhX0dSq0OnczycwPPD0bfXuQGO0cAC46GxejM/aIDy9AtTOLUzgKLL196qZe
	 u6MLc5xbDLebvwaHM6Wl6CBGWNsvksunpqdf5Ll5lL0ZYFDsQ2MEx9yDwxvsvkSIrqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DJJ6I8Bf;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97EB606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B97EB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DJJ6I8Bf
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-843a4ca671eso638455a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205898; x=1793810698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43fNiymvfrbcShBUvXeBFpEWnvLGZyv5ExKLMUTpuaY=;
        b=DJJ6I8BfpyMiESxS6kEEqQTB+Vcs1ksrOGcNxKfU+8ugk1eCSAMiMlpYKnBaqE2WZB
         lIr84zgP+v1UqaM9zNvI26/7V5y3Dy/IUAfiQHzbi3Im+gJNMVJFgwNEhLCytG7EEFZY
         gTBOuy3s7swLhaylURGXAaXOH4C4wTeGQKWZblLxrMorEs8QKv4duMnx97/DAW5SSsUH
         DyKhvuRPiZVPxamH1fEfVQxVdQlNn55KFgpsV/q8ijOB5c7cnqjnsJgsuMVEIaBHXKf3
         z68nriXw0ufIVEKoEVR+k/qA45QVthlghWWgs9JueW4zrsm5jUHquvRro03zvlWT5k9w
         siBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205898; x=1793810698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=43fNiymvfrbcShBUvXeBFpEWnvLGZyv5ExKLMUTpuaY=;
        b=qGy5PW81GNcTbJ9kRlBApr6cQN0r1T+InBV+qW5KuM/Ib1sRP1ZMHnhjoEgl4P3B2E
         oZwy0P8cJiH8LkJ7vUxJTU98gmuBPqHdVmDoEqfBbUXFcPHtn7ujOq5jFxfoRrsE8VFh
         HnIDJFT7kARFtkVTngRYmjjbRmxyE0PRXVkaHDTa8qQY61fX7YHyXehbXDylzDkrh0c5
         bN5aiISgsSX9vT5smNcfdP/nU7IcdEMBlD13z2H4sHl37CHEJnQTea3SvHbnbuuocM7p
         PYsp0N9rIhaBwc/Avuq3GcKXE7glhAeoH8SLfE2bAB99yEs1VrxV1RehSwRKEIsu+X6O
         PZzw==
X-Gm-Message-State: AFq9FYIowA+ruRJzXBpJZjpLxxvUPDDz9TxN2VcZmSwEEcFVNel3qewv
	UeEqZmh9zawg4WyTbUdyfuZImGk+eDYOCFe0AEVgJbdBuYJM61B6DKHqH1tVmXASS3j0SuIoZ96
	5FnRNDFk=
X-Gm-Gg: AYBFou2PDKXLLOM3doksJ1ysUs1t4ZvycKGZdYKgH2RcCZ8+PqS0wx/QoXurMxrZcfp
	HA638C7pU1F5M2gMlzL00c1BjmEYKk7f2F3iK5A0ra2NNHp5Im8SBYoAcsnCTlo4wVvWR9/qVe3
	/0Pbm1T2MdJh/HaSLWZ/R72yxV1QxxOTpdzdkeLxsry61sF2bW97EgoIUtDFrR/CrfwNQFoC/zY
	czdlTjeHE1ADZH60h44/biwDj+0O43ci9y5HqjRvNafm0Xt2/LqEduNBBqp63gjtC0GB8QuGEhr
	JbR+jOsK+C8BHdBT9FM85h5+RWCfQ7lQ9TYEvk9zw9D8ioDGRp+nyXCjnfpl9SIMbmq9/M0riYJ
	tOmuULLlEVtpQLLSAefSlRqbGRZu9g1UM/zzHgXy5w1jusSPSA7Whrni2O4mUPxcoHXTnBTEXHY
	yl+h6t7OwyXjI4G2pf5Dql9xUt97/zS5RAL1URxQleOAcwjxF1XYx3943ApL/Wf0HmE0CJhHT2C
	C5+Inhkz3yNyN6q8ByyxarjC5Fe2YCIwXcC2XAdQfTs9MwUYxtuwQfl3F66sfWyinPDOW5jneAc
	s9qyBvRRddCBH0a5KHfMPe9YT71I4chboFNv9yNgEaG6HP8o306mH6Dm4htfJCV9eSvjhtiCaGK
	3gvN5pdaEpNY+gWlt3G8=
X-Received: by 2002:a05:6830:6415:b0:821:a94d:3b51 with SMTP id 46e09a7af769-85ac0ed56c7mr2267982a34.25.1793205897736;
        Wed, 28 Oct 2026 09:44:57 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 32/98] blk-mq-dma: initialize the dma state for P2P, too
Date: Wed, 28 Oct 2026 10:41:35 -0600
Message-ID: <20261028164415.1262013-33-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

blk_rq_dma_map_iter_start() promises that the caller need not initialize
the dma_iova_state, but the P2P bus address path returns before it does
so. The state then holds what the last request with that tag left, and
blk_rq_dma_map_coalesce() describes a transfer as one IOVA range that it
isn't. Clear it on that path too.

Fixes: 858299dc6160 ("block: add scatterlist-less DMA mapping helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 88fd9cbc951f..e0e7a18790b5 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -181,6 +181,8 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 	switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
 				 phys_to_page(vec.paddr))) {
 	case PCI_P2PDMA_MAP_BUS_ADDR:
+		/* don't leave the state of an earlier mapping to the caller */
+		memset(state, 0, sizeof(*state));
 		return blk_dma_map_bus(iter, &vec);
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		/*
-- 
2.56.0

