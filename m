Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292E392811;
	Tue,  2 Jun 2026 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379186; cv=none; b=D9/AjSZXcZIijwxgGXK8BnicrzB4GYNRa2JMnQvflaQEudwNp+o2NBhruriqqzdC5fJ6RAnjSw8J5nsQfdPXMDk49IsRgBkB7xauRW9+QYEUWQPsKuvQh5iR83dB8LlcxaN2BtctvAcyTtSkddLBINfcMePNTQ1ZHBIVjcVZW8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379186; c=relaxed/simple;
	bh=Sb8ljAGNmK1EOUT/DtQ+EKZUYX7ZGp0X/rmFpygFOFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsQMCs9G9hUxNTDpzi0ug+u7mNrUt4Gboo17sTHomNCUoAeDaYbey4mncvOEWH3bYbri5dQx5oiD9qYDO016ZYM4bs3eh71fx1tv4YsznTv2ZUgkoyxMYKPMyPPU0gsRdBLIH0sQBz5FOOYE1Vp2fsBZcTqSgmxEq6xQuqPcs9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ffFEM1X6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffFEM1X6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tyOFrxUiDR7BOvUqbt0/cBh7aJioKZwhadwZDmQVxCg=; b=ffFEM1X6nCcaocU+K6iaiC6FtQ
	oIDSp9kQjR7wfVQEtbIRo9+k5OaNsjOq7jBjYMwfp+Y5MRWblhAjEffTbOlogPSdWGfN/fYBnfZRE
	O4X/YHjhOd8ZSB4vlJ/SfXPgPefZ6SDd6syHqj/bPNMhMMjGS72qbWM4/0XZlLtPxmnQYo6SkkSp+
	9wFfze167Y6oohFOl7e5LgHKIPOP+pEzsn+Jn+vTPZORpFQHT30q07rPLxnyo4Y/ICuqBYkJbS+Fz
	11uXkJKqMB3OrivhrPNsPmoOCcMlQIk75XPSf8OaWDfFmNfqmYqmGNTh5Xh/L1yEtAwOa4OyP2ZkH
	mVx8Pfvg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUHxH-0000000CL9d-2M2P;
	Tue, 02 Jun 2026 05:46:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/9] block: remove ALLOW_ERROR_INJECTION for should_fail_bio
Date: Tue,  2 Jun 2026 07:45:33 +0200
Message-ID: <20260602054615.3788425-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602054615.3788425-1-hch@lst.de>
References: <20260602054615.3788425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allow error injection for should_fail_bio is a bit misguided.  It allows
inserting an errno, which is then ignored, but it forced and out of line
call for something that should not exist when error injection is disabled.

Remove the error injection flag in preparation for adding better block
layer error injection, and switch the bpf test to use a MM error
injection site instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c                                           | 1 -
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b0f0a304ea0b..3a23af3e26a9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -545,7 +545,6 @@ int should_fail_bio(struct bio *bio)
 		return -EIO;
 	return 0;
 }
-ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
 
 /*
  * Check whether this bio extends beyond the end of the device or partition.
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 2e0ddef77ba5..6c8b161cdd7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -588,12 +588,13 @@ static void test_attach_override(void)
 		goto cleanup;
 	}
 
-	/* The should_fail_bio function is on error injection list,
+	/* The __filemap_add_folio function is on error injection list,
 	 * attach should succeed.
 	 */
 	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_override,
-						     "should_fail_bio", NULL);
-	if (!ASSERT_OK_PTR(link, "override_attached_should_fail_bio"))
+						     "__filemap_add_folio,",
+						     NULL);
+	if (!ASSERT_OK_PTR(link, "override_attached___filemap_add_folio,"))
 		goto cleanup;
 
 	bpf_link__destroy(link);
-- 
2.53.0

