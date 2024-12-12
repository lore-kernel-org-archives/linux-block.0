Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C11C2324
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039022; cv=none; b=eLsAQzU0eo8fihnlabpGGDyw4M7eYepysLf1nDozcDfhTnA7RK4sj4/cPtI7md6Y7b1jX+g0akeFhs40q6zW7Kelj5HPZjFiYIxKW6NGgfx3Y9yf8VZiU8XA/uMJd4vYxlBDqkYkmt+ZURMPI8Z+OrBAvh0MPsdCEQL7x3Fbk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039022; c=relaxed/simple;
	bh=HD3ejPS0Vx2Z1H/RC0aQKwDUhI+QLGY16pZ7wIRaSxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvHGX1iA9G1/k/tlONFdar6L2YUh7d6CAQQhK1tuNqym+eNTOSgGVo7ogqYk3MHGDcI9PHtYprDQf9DH5P9OlLkGywRhZyQehP+zSwP84x9mTyXye1oICk2i8DR8S3rcq9dxbTERCPIH3afUU/u2yqs/H5U6J8M4gHVg3uDemRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OS+ZOayw; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OS+ZOayw"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y8Qc61R3jz6CmQwT;
	Thu, 12 Dec 2024 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734039011; x=1736631012; bh=1f9Sq
	PgB0utFC7N2JbbEJFmqdSwBLEPEhCwFxMjO4YQ=; b=OS+ZOaywqKFVC2k23mnw5
	jIEvL/0DYVYRfA6hCiOMhqVQrweOygXjyI1uwI/MH2O3690gPfbCg2exlSr8H8zk
	e+Cw4gBULN/WTt70HR+dhICDJ0mYxfIJPw/JsIDRy4hVHKVhvAWKVu7MD4lepsm2
	V2mlSaqpW/en8d8MFiKhl1t25dWvrIoxGG1PrcWbe8ssvCVB4ixrB5okrNWtCiIo
	74WyRdXs4i6wjfW0rCQ4qBjJf5EYPvrUS2/2QYtPdWZ2XSrhCjJd0WIB7KTWxNAR
	0Zc4Vqb7wOnGc0q5HPfqL/ZOAew9Z+EZFRIXMUVZSzHSmQv6vyjoZdznIkhZWdM6
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AqQd7-TzLl0I; Thu, 12 Dec 2024 21:30:11 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y8Qc06DdCz6ClH0D;
	Thu, 12 Dec 2024 21:30:08 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 1/3] mq-deadline: Remove a local variable
Date: Thu, 12 Dec 2024 13:29:39 -0800
Message-ID: <20241212212941.1268662-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241212212941.1268662-1-bvanassche@acm.org>
References: <20241212212941.1268662-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit fde02699c242 ("block: mq-deadline: Remove support for zone
write locking"), the local variable 'insert_before' is assigned once and
is used once. Hence remove this local variable.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 91b3789f710e..5528347b5fcf 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -698,8 +698,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time =3D jiffies;
 	} else {
-		struct list_head *insert_before;
-
 		deadline_add_rq_rb(per_prio, rq);
=20
 		if (rq_mergeable(rq)) {
@@ -712,8 +710,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
 		 * set expire time and add to fifo list
 		 */
 		rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir];
-		insert_before =3D &per_prio->fifo_list[data_dir];
-		list_add_tail(&rq->queuelist, insert_before);
+		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
 	}
 }
=20
