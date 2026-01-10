Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF1617C69
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768052610; cv=none; b=FTPZncrkawYlksBsW7KWVet0p+BxRbzDA2UwgCNSbhVNO/dD0lHFuUH1OPRHl1LqiPwJ/15bPvSx8cpL97xNuv5PU5zs/YgnPfyT6QIeJaryu9FsG2jJsXQwQv+ZdlRSw/ikOkQXHcsAYFZ4gi0bKtYYK9csLhEtucYj1e0I7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768052610; c=relaxed/simple;
	bh=UE/wscJhli9u5O8GPxCu1FUMteMNvlC0UTw8ttHR8sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dmums8kJ64cJDYOFLBPTXekxAgTklcC1fyuWObFoaw4NlXTqgX3sWvpdRK/llSzFqbPAuqMlwQiEZLOiD3bpshq/xHUc1f0iSrf+Kl5+hm6fIgk0fyrTmj+3QQM79BD4a7W1OSc7PLAhgJy1Z7ctjh8oWXeBkwxeGDODpA1NAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLygvM6v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLygvM6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768052608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nm1YAwzANwxHks7J/KfMII0i0bjmngtYucnHe3oKZv0=;
	b=KLygvM6vv58bYnnJ/D3EbJoTGFPHTq0OjxyW0vR81W6dn2CpwUyjkzdOFZ0q6/jEgCsuVV
	cTQfab4LVGzdxCB98NIQjjKe8SbRNt1yyDPjCp53iwUh5YVjyNpnQtkspVSahyL3PJ11JL
	/3f7EjMCwwIbHSSvEdbm8q6z+c7ypHQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-vmVWhSwFMgG5fSUS0zU5AA-1; Sat,
 10 Jan 2026 08:43:22 -0500
X-MC-Unique: vmVWhSwFMgG5fSUS0zU5AA-1
X-Mimecast-MFC-AGG-ID: vmVWhSwFMgG5fSUS0zU5AA_1768052601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFECD19560A3;
	Sat, 10 Jan 2026 13:43:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.172])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F4671956048;
	Sat, 10 Jan 2026 13:43:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH] block: account for bi_bvec_done in bio_may_need_split()
Date: Sat, 10 Jan 2026 21:42:36 +0800
Message-ID: <20260110134236.442681-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When checking if a bio fits in a single segment, bio_may_need_split()
compares bi_size against the current bvec's bv_len. However, for
partially consumed bvecs (bi_bvec_done > 0), such as in cloned or
split bios, the remaining bytes in the current bvec is actually
(bv_len - bi_bvec_done), not bv_len.

This could cause bio_may_need_split() to incorrectly return false,
leading to nr_phys_segments being set to 1 when the bio actually
spans multiple segments. This triggers the WARN_ON in __blk_rq_map_sg()
when the actual mapped segments exceed the expected count.

Fix by subtracting bi_bvec_done from bv_len in the comparison.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Close: https://lore.kernel.org/linux-block/9687cf2b-1f32-44e1-b58d-2492dc6e7185@linux.ibm.com/
Repored-and-bisected-by: Christoph Hellwig <hch@infradead.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Tested-by: Christoph Hellwig <hch@infradead.org>
Fixes: ee623c892aa5 ("block: use bvec iterator helper for bio_may_need_split()")
Cc: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 98f4dfd4ec75..980eef1f5690 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -380,7 +380,7 @@ static inline bool bio_may_need_split(struct bio *bio,
 		return true;
 
 	bv = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-	if (bio->bi_iter.bi_size > bv->bv_len)
+	if (bio->bi_iter.bi_size > bv->bv_len - bio->bi_iter.bi_bvec_done)
 		return true;
 	return bv->bv_len + bv->bv_offset > lim->max_fast_segment_size;
 }
-- 
2.47.1

