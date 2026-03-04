Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE53890ED
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653748; cv=none; b=PMZvuo/mPeOqNaBDrhVtiOyManS6TtSfr5cx5i8w+1bePKIdaOhmW4OzLe/7rHR4SSwTrkQaq9y7DdiMaOoNdA9J3OP9UB0+bnKqPqPgeVlkhzPpkCrPVP9Kc64ATjZLXzh9IcvKCFTFS0ytAEiW4BUvqfaLDpVD9p5Kj1QVgeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653748; c=relaxed/simple;
	bh=/PnOWD/r4W9LHWpcNcSONJ2AAgLpqXf4LKNWN/sK4fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPtMMD80IPUSnD4w4Uru/KwmETKEp3U5RMBn0VqwUfeHymmuIbv5a/H+qzbyEixfoIiOQXt8v2WTB5nbwmM6GA5TtHbtJNhzgVaMNy7y1s5NOff1L2Phvq+FODPiXZtWMcIQiYKgzWLhwAkYT5YZEYUNv7Pg69hXuKYRaYVFueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KkFvzlil; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KkFvzlil"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3C66pHrz1XM6Ht;
	Wed,  4 Mar 2026 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653742; x=1775245743; bh=gs6e2
	6AYFYZTPWUS0JCDkj71C7BCJS8FnFmyZrPRjXk=; b=KkFvzlilNx3TrtSJiQiGj
	1ikqlyRqwQhM/mF0JOxrA1AmvL0ZboB9HcfKmyuKoOVYiBlrq7/qP5tcFUnqMjqf
	TthlRYxjlImYTJlzamgAn9RI7cZw/Wtg3KHcvWHLmU2WmzhyHeewj0GaNeEFQ4s7
	SP2y6WsIOrUSkxuTNPqqy3azZyxr1KQAhgQqJH0jBVq6tS7DEzskT/gyeHASEg9r
	OOKE6IQGFZ/PfqYghFvu/CajZU0kSryfv1vfVIIuaDIYFD19wVAW7yAl407WzyLO
	sIuKr1okc0i0QAVFkbtUkReqqOLmPDma2xsjCYm8tGWvNsrAD3uQ+uVeOgn/2Yqr
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id a0rV2VD-cVS3; Wed,  4 Mar 2026 19:49:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3C04KQNz1XM0p0;
	Wed,  4 Mar 2026 19:49:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 02/14] blk-ioc: Prepare for enabling thread-safety analysis
Date: Wed,  4 Mar 2026 11:48:21 -0800
Message-ID: <20260304194843.760669-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Clang thread-safety analyzer does not support testing return values
with "< 0". Hence change the "< 0" test into "!=3D 0". This is fine since
the radix_tree_maybe_preload() return value is <=3D 0.

Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d15918d7fabb..0bf78aebc887 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -364,7 +364,7 @@ static struct io_cq *ioc_create_icq(struct request_qu=
eue *q)
 	if (!icq)
 		return NULL;
=20
-	if (radix_tree_maybe_preload(GFP_ATOMIC) < 0) {
+	if (radix_tree_maybe_preload(GFP_ATOMIC) !=3D 0) {
 		kmem_cache_free(et->icq_cache, icq);
 		return NULL;
 	}
