Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15897460
	for <linux-block@vger.kernel.org>; Sun, 25 Feb 2024 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708830117; cv=none; b=QttLfSWbvVX2eOTJmRq0v0qDpKRabqJTqgCCsf3Hdbqu99m6rEecLUa62U10NNeoP7Rda2ojq66XdvL+NbuIFHlTHhdsIJgUB9zqmyjtciXAFlkb2nPeLxOLGaiNbR1+n4nXoi9Rzi/T1rkONeAcAHh4+8+v3Tw5B9teifOwGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708830117; c=relaxed/simple;
	bh=MlQH2SlK6j1W0Tg+eGb9FJi6RqtWhY6zdq7da4RTKnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYfkCHTTo+AmBCFRsFqGMmd6v85CSMeemmIqUgpo2lrlA+FWVkJSYtXEkvKJhoongtqb/zENVInFihsKiNfyOiQzrQWjj/R/0DeV1jJiQvVe5GpvdNHuPlyRnnWideVYanTow6+cDUMJz74rMGD39X3WBqI6Yw14KY6xuKUzBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heqKZMyv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heqKZMyv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708830114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TjhB/2HBHI7aWNqsXerNT/dGQ+MuEXL8ljwItunv9x0=;
	b=heqKZMyvSvweTUtsXz5MSMdTasT7rr5OzW2r20XjQ4ZHmTeSHM2OVBBFzG+cEmcp0BA4dA
	uShoJwn+vCHhr0/ObEgdYwHG3/GIi4+RY64hJfBU6/s2cOJZAAVE+OsV10Ti24hQpCYRE5
	2JeIVy+CEF2ycdOxDDeIslxZ45/FbDg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-cAVvGm_dM-OuXVNEfBF9Dg-1; Sat, 24 Feb 2024 22:01:50 -0500
X-MC-Unique: cAVvGm_dM-OuXVNEfBF9Dg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6A0A83B82A;
	Sun, 25 Feb 2024 03:01:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54733492BD7;
	Sun, 25 Feb 2024 03:01:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] block: define bvec_iter as __packed __aligned(4)
Date: Sun, 25 Feb 2024 11:01:41 +0800
Message-ID: <20240225030141.8364-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

In commit 19416123ab3e ("block: define 'struct bvec_iter' as packed"),
what we need is to save the 4byte padding, and avoid `bio` to spread on
one extra cache line.

It is enough to define it as __packed __aligned(4), especially
__packed means byte aligned, and can cause compiler to generate
too horrible code on ARCHs which don't support unaligned access
in case that bvec_iter is embedded in other structures.

Cc: Mikulas Patocka <mpatocka@redhat.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 19416123ab3e ("block: define 'struct bvec_iter' as packed")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 555aae5448ae..bd1e361b351c 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -83,7 +83,7 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
-} __packed;
+} __packed __aligned(4);
 
 struct bvec_iter_all {
 	struct bio_vec	bv;
-- 
2.41.0

