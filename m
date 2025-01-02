Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9093FA95E;
	Thu,  2 Jan 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735806915; cv=none; b=dN6cmebAir2L8NDiW+23JdczCZcm0VS2Wfpf+qxkGQzSrkjLlB1/kEBUQiBHT9Ivk2lUE8KZD91hY7qLc7KE5NgA6qy/6xZniqBoY1EoZ3V7E20IAA+Zpl9vk5J63tAszHjstCd3l1hPn/Gi/hwK8yN9rysFiSV0MihEC40KDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735806915; c=relaxed/simple;
	bh=Rgywhf3ikL/ZqWQLCN+IL/wCaUYA7r+E/nfIFLUVaI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ItdrCb54kJF7AuasG9HuHSkqONcKbiCcMs++A5LpdTaAeVF5c4eh/BqDSRX0DYL5faUCUtWc+Q8AEy6GInd/dEOdNH4KcakwY5VzTi+sJitGDSlZUA78JE8O6ANnm8UKp0yEVhBQqhW+FV9m6eUBIRNFMBxpiN3dO2dR3vjWyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=An54iPlM; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="An54iPlM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IQYqa
	2NF3VuWbqIEnSwlQ/wlv6KOz7mLl3WK1/hsWpk=; b=An54iPlMKhAbwqC9FKAc1
	S6PS2s+NboJ4zeROTOsgbVxgYu9YxMvMm53Z0yj3PEQ5dw0vhkPjVXTShgbPFVCH
	u7Wmz+Ct9j11ZmETWQt7qKbukQt6VIbMWgrgQlIBKJ3pMO2gcItGV4ExbA8vwFzJ
	gnxKPzFuLSxVfiXB6iyRtI=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAnTQ9dT3ZnyHpsDQ--.59897S4;
	Thu, 02 Jan 2025 16:33:34 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: axboe@kernel.dk,
	satyat@google.com,
	ebiggers@google.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] blk-crypto: Add check for mempool_alloc()
Date: Thu,  2 Jan 2025 16:33:19 +0800
Message-Id: <20250102083319.176310-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnTQ9dT3ZnyHpsDQ--.59897S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW3WryrAw48tF4xtFy8uFg_yoWDXFb_uF
	Zagr1kZFyrAF1rCF1vyrWxCr9ak3s3ury8Ga12yF97JF4rGrZYy3W3ZFs8Gr42kFWxW347
	GF4DJF1Ut34IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjySrUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqBTIbmd2R+jZJgAAsb

Add check for the return value of mempool_alloc() to
catch the potential exception and avoid null pointer
dereference.

Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 block/blk-crypto-fallback.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 29a205482617..47acd7a48767 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -514,6 +514,12 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
 	 * bi_end_io appropriately to trigger decryption when the bio is ended.
 	 */
 	f_ctx = mempool_alloc(bio_fallback_crypt_ctx_pool, GFP_NOIO);
+
+	if (!f_ctx) {
+		bio->bi_status = BLK_STS_RESOURCE;
+		return false;
+	}
+
 	f_ctx->crypt_ctx = *bc;
 	f_ctx->crypt_iter = bio->bi_iter;
 	f_ctx->bi_private_orig = bio->bi_private;
-- 
2.25.1

