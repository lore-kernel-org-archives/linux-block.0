Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861968;
	b=XezXFBdDfATM/K8O/cAdmZwrSiNrIB61GVwFcgeh7mCXXG7r4nQ1c8pAwBt+ZsdYyPUf
	 2ukne+zRSzc6sdjtctxv86dBEa0vdXr0GmsqLSY8kEjjCXLV/SABIcnN9dhjmEZoK/8tS
	 1eHFJPexgwMgK7GKa82TKXMcipXCnfjr+steof9uYIC/6K4c5B4cRi4kEOREvpxrtrZoQ
	 LgzIGpsFLwg0xDRIxaMki1VsN0o3lv9Ea0wwNGAjNaPY9Wm8WEMDitrD15VIrnJiLJIsc
	 OnF5w3evibWfoYASWkp76sf6J+DkCY8t2NXDLDgUssJLlAw/3Y9TWX7SkjAIAayUhjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861968;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nIzPxp67nycIcgpn1aR+9cX2c2A9Fk/9SrE7eGQSDVI=;
	b=dTGVgxs1O3+P0B8Sx8xmzCxDkT3zNx4D0o50OGAoKcFZns0clbub3hTlJFRlwAolmIdS
	 Td4ZBcSK5UYIhD4uQPukZF7J3BU0WUnc2pkyBP1t5Z7vtuH/KWOvggO4KU/JLEwHRVeKs
	 /YkHx29dD8P/m+YtK0sc6xeL+G7Y9xG9WnakuXzfc/SQL/mkwcrBe2OPVEy0QCDbVpbzW
	 +hfw73z7YwXk/3k2QFuaTn38XE6zth66r+IQVIqd3yX/MClnQP2CeYeLKi9vrSI971REI
	 3rw0IvexhlUkj02thej/EqHCsVV1XqqJB4KqEDjv57X5l3J/vftct98izcbV0CWGXsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=URJ69ifo;
	arc=none smtp.remote-ip=95.215.58.201
Received: from mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F94606A33F
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 06:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63F94606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=URJ69ifo
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xVc3emtqQK3gdjiaDH2/ozjRn5r+zA/0E88efrFuawg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793861965; v=1; x=1794466765;
 b=URJ69ifo97ROruZ6pmwjXf0aKmSur7mh2uvlDandRG7mz4fCmrISF3oG8QPrDgE6EtbpnoLX
 DDOkrLFAjlHrjyterio5ErE9cY4DTjD2rrmzaqCHaS/HCXbs+pcE5kLsyhLVR0lxf7DWy2zDiJH
 ybQo4+FLjg9nVwpWWXkCsyjQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7015cdc676c618de;
	Thu, 05 Nov 2026 06:59:25 +0000
X-Mizu-Trace-ID: 7015cdc676c618de
X-Migadu-Flow: FLOW_OUT
From: Mengmeng Zhao <mengmeng.zhao@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	asml.silence@gmail.com,
	hch@lst.de,
	Anuj Gupta <anuj1072538@gmail.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	Li Wang <liwang@kylinos.cn>
Subject: [RFC 1/6] block: refuse a dma-buf bio that carries a crypto context
Date: Thu,  5 Nov 2026 14:58:42 +0800
Message-ID: <20261105065847.196540-2-mengmeng.zhao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105065847.196540-1-mengmeng.zhao@linux.dev>
References: <20261105065847.196540-1-mengmeng.zhao@linux.dev>
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

From: Mengmeng Zhao <zhaomengmeng@kylinos.cn>

A dma-buf bio has no pages for the crypto layer to walk: the
software fallback would read the map as bio_vecs.  Refuse it in
blk_mq_submit_bio() before it can reach that path.

Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index be5671966787..f0d978b1724f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3138,8 +3138,10 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
+	/* a dma-buf bio has no pages for integrity work or contents crypto */
 	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
-		bdev_has_integrity_csum(bio->bi_bdev))) {
+	    (bdev_has_integrity_csum(bio->bi_bdev) ||
+	     bio_has_crypt_ctx(bio)))) {
 		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
 	}
-- 
2.43.0

