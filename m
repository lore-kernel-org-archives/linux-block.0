Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2F537C91B;
	Wed, 24 Jun 2026 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334167; cv=none; b=ApqluQDDTVSBtpUB8UagIWcysvHdql5FgcwQqAcF+WqpRL2EiknHEw0VJlxkWci7oXvL4Ku/GvbTz1AtOe8nU461D9L3f9oCQZLERWsOHByZ6lz6GggcboJ8FYezL86hOUWziu6FbUvdIo8Ufjj6pSic8B65zDAsfkslkJTQqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334167; c=relaxed/simple;
	bh=MHNiV/cjbM0GYJqZAYCEtwMzr/SALslBDw1UZL8eSTs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IS6NYokcj1ck/jMxwWAcpPmMvoK1mFAC2oybcSQNnWfMMmOcF1v31yBlxpFsShEisoR40ihlsQLdHurWS0F9F9SDibM5Oj7Q/tajcb4r6ht2OVmIK9uYB673y1elFsDZMrmDO4fhdqfFgG5cYFB3RJQoq3VWlEpoTpV8/B6zxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.79.25.129) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 24 Jun
 2026 23:34:07 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, <linux-kernel@vger.kernel.org>,
	Karina Yankevich <k.yankevich@auroraos.dev>
Subject: [PATCH] block: bio: check offset/length sanity in {__,}bio_add_page()
Date: Wed, 24 Jun 2026 23:33:26 +0300
Message-ID: <20260624203327.25553-1-s.shtylyov@auroraos.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

Sum of the *struct* bio_vec's fields bv_offset and bv_len is calculated in
some functions in block/{blk-merge.c,blk.h> (and that sum is often compared
to PAGE_SIZE) -- that sum may overflow (and so the comparison yield a wrong
result) if some bad arguments were previusly passed to {__,}bio_add_page().
Add a check that the sum of the offset and length parameters won't overflow
to {__,}bio_add_page()...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
The patch is against the for-next branch of Jens Axboeu's linux.git repo...

 block/bio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index f2a5f4d0a967..daca63b94fae 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1000,6 +1000,7 @@ void __bio_add_page(struct bio *bio, struct page *page,
 {
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 	WARN_ON_ONCE(bio_full(bio, len));
+	WARN_ON_ONCE(off + len < off);	/* does the sum overflow? */
 
 	if (is_pci_p2pdma_page(page))
 		bio->bi_opf |= REQ_NOMERGE;
@@ -1045,6 +1046,9 @@ int bio_add_page(struct bio *bio, struct page *page,
 		return 0;
 	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)
 		return 0;
+	/* Are offset and len sane, i.e. their sum doesn't overflow? */
+	if (offset + len < offset)
+		return 0;
 
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-- 
2.54.0
