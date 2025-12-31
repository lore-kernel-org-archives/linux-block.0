Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAD248867
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767150086; cv=none; b=S/aKHdVT2CBXVUY9NVXSgOxx2OzW4MOY26ebzjziBfU/EEQOAfFOLfJAjRqIZmg5gDrSWjDMaWZw/7Jp9xijg76HbF1Zmv2XkrNZmqp+Ymh85F/uTZm794rzUmxBOhVvhuBkVtJf5+xyKYTFMVyJeucpluMsGwQrpGOjMh31dVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767150086; c=relaxed/simple;
	bh=HPQj+IjmdHZtM3pl5etSXXufv35he1qYgfeOCluJoss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7peiYS9vuKdHgmwlkDqzOBPKBLrLdi2B5USDRJk9NDVYvWQdu2EJVzuOumgrKPRRv8v/c5vLLR6dsXBSDClc2Le+KnS42lei/7LXIMW1O0tJ/+Lc9HY2LUV6QbQOPBx7P6qxNWrhyQcCh0iZNp+JcZaZ7fQNkV8E+uaPiQTVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2Lk7FwB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2Lk7FwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767150084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3hPaOgaCF5Luoo8MXUNHW3gn6xM6oL6YK1pVMx58vQ=;
	b=d2Lk7FwBW7LYiWucpgnSyk5hceAjcH0WLS2jUPZsRzf+o/igtvGHxILwMWo4THB7xmHSUk
	L/qwhvEhlQO1MA0oEwq8o/ZhH2ZPwPDN8sNohDZPHXlpxOSiy3QgiFtedk1x+zoLjO47Sn
	IPzLlRSFTVChbJid7kaGQWqep2Tw+hs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-dpLK0Tf7ND--vSGGyNEJuQ-1; Tue,
 30 Dec 2025 22:01:20 -0500
X-MC-Unique: dpLK0Tf7ND--vSGGyNEJuQ-1
X-Mimecast-MFC-AGG-ID: dpLK0Tf7ND--vSGGyNEJuQ_1767150079
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30DF21956080;
	Wed, 31 Dec 2025 03:01:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.52])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6511F19560AB;
	Wed, 31 Dec 2025 03:01:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/3] block: don't initialize bi_vcnt for cloned bio in bio_iov_bvec_set()
Date: Wed, 31 Dec 2025 11:00:56 +0800
Message-ID: <20251231030101.3093960-3-ming.lei@redhat.com>
In-Reply-To: <20251231030101.3093960-1-ming.lei@redhat.com>
References: <20251231030101.3093960-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

bio_iov_bvec_set() creates a cloned bio that borrows a bvec array from
an iov_iter. For cloned bios, bi_vcnt is meaningless because iteration
is controlled entirely by bi_iter (bi_idx, bi_size, bi_bvec_done), not
by bi_vcnt. Remove the incorrect bi_vcnt assignment.

Explicitly initialize bi_iter.bi_idx to 0 to ensure iteration starts
at the first bvec. While bi_idx is typically already zero from bio
initialization, making this explicit improves clarity and correctness.

This change also avoids accessing iter->nr_segs, which is an iov_iter
implementation detail that block code should not depend on.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 0e936288034e..2359c0723b88 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1165,8 +1165,8 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 {
 	WARN_ON_ONCE(bio->bi_max_vecs);
 
-	bio->bi_vcnt = iter->nr_segs;
 	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
+	bio->bi_iter.bi_idx = 0;
 	bio->bi_iter.bi_bvec_done = iter->iov_offset;
 	bio->bi_iter.bi_size = iov_iter_count(iter);
 	bio_set_flag(bio, BIO_CLONED);
-- 
2.47.0

