Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED02E5D2F
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276920; cv=none; b=E5s6fefyc0S4jXDOgtc5kYfVg/tPo2DTC74WEr7NNAKdy5/5EXa0PBm6Gu/NCixU07sb4nlmyRGzQQpNHWvtSd1Wsz0/J+53Z3cw+pFcS3g6YzHPzk/jIjrhP6ij9glvgLWwa+rL8NmuruxNJiZoHmnFX3sh8VYGAw4Wia6J4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276920; c=relaxed/simple;
	bh=Nf+9f5a/6od9Bz4coXsjltP8SGWfOFgC2PDF4MDX8GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgOJUB6GzjUy3fYFGpOzKE4yD/xsj4ipY8+9N36RRszgGp5RITuNN71/ZThsxSj97uno/635lw/afLB8h36ebxMyjCph218VtQpnawtc40JoG0fu2BfS62pihwXCGZ2+3bGSrX18MD6QV37J/NaUorspawRsTVwmuCXXUourEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EWs4cgaD; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EWs4cgaD"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c3SsH1Nh7zlngRT;
	Fri, 15 Aug 2025 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1755276913; x=1757868914; bh=B3JNc
	AneosbMY4wsO+7W73aoFiZWiG04Xv/nCY+jFA0=; b=EWs4cgaDscdBMaOjelm/k
	XtGpnH6IB5Hv8NkaW/BPnfKfWsby1QDDTjGVKgghKEhLQ8jbgh1vFaK/dCtpPWGX
	cI6s88/pd6FftO3OYvNPK7No41e3nLfKX4rJ6TAfmku90+T3F/SuwmIYGU5phiDk
	l2rYNzFyeUsTVPKnoty7QjKD/B+ZGQgN5fdCDbo0snffY10oNIs6G8DvfCEROVH6
	WRKuPEhsO49oawxHfoBwSrhO52RslPN4beFwY6peuDAwFQHAhlUn5lEAA+oGj7tl
	RKrhMwkkoA1BYJ/Eftm/Grgwfh51pRWyAhH+3TSgCT2yE/SGCBZG38cS2Gez6cW8
	g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wUQv9cZZVruv; Fri, 15 Aug 2025 16:55:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c3Ss96h58zltQmk;
	Fri, 15 Aug 2025 16:55:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 1/5] block, bfq: Remove a superfluous cast
Date: Fri, 15 Aug 2025 09:54:39 -0700
Message-ID: <20250815165453.540741-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250815165453.540741-1-bvanassche@acm.org>
References: <20250815165453.540741-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sector_t is a synonym for u64 and all architectures define u64 as unsigne=
d
long long. Hence, it is not necessary to cast type sector_t to unsigned
long long. Remove a superfluous cast to improve compile-time type checkin=
g.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-iosched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50e51047e1fe..d24143f55fd2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -760,8 +760,7 @@ bfq_rq_pos_tree_lookup(struct bfq_data *bfqd, struct =
rb_root *root,
 	if (rb_link)
 		*rb_link =3D p;
=20
-	bfq_log(bfqd, "rq_pos_tree_lookup %llu: returning %d",
-		(unsigned long long)sector,
+	bfq_log(bfqd, "rq_pos_tree_lookup %llu: returning %d", sector,
 		bfqq ? bfqq->pid : 0);
=20
 	return bfqq;
