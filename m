Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF7945A
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274137; cv=none; b=UKf/zL3BRgZWUmf3eLDpxaLU0mBtl8Fd248HMfTYFP4P5uGrfKKd6aDRxahgiSIYuHdeMhDsByQjdj5YEqTeexlsnmjgSHrKK3lXkP32lXO6g9RRVqcQ3v9iAHCrsfmJOgaa+smZkgxBdpQeW+kpg97hMgQEvDm0yFJoSVICE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274137; c=relaxed/simple;
	bh=E7BXl2V3/Opp4NtNtBuqMsiN7ZJ31jbkZhDWs9PH82s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=js5hxFhP3tVP9QyLCrdUN7EMbk3UmjQNn5K7sOmB/kbeHu9wzfbFjYx1MhKKk8tMugNaeGsm9GyrVg3wkr/UvhII+5bV6wlQjNr4JYSj6UffFQz/HMnZrg5m0SbJfWi9e8ou/3cBZadnFwoSwx8FpYcns5hXWPMl63jFP3r6bUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZOnwVoNL; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZOnwVoNL"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VZyx31kHpz6Cnk8y;
	Thu,  9 May 2024 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1715274132; x=1717866133; bh=uJTF4
	+vyTibGOAD6m1YeVB3bweRb8m2pAGp+fHDKSAM=; b=ZOnwVoNLRwApExMhgMXco
	JbnmVfJQiptR3Gu98A87IGYrYOUaKrp1bmXbfXRhc8OIdT4v+p0oSlDwofmxCzeX
	Ox8ZNY6IiJrB0coiN6T4lORbEiajlyRH4lt5sGGm7OX4io9HuJWHsP8dBaGuqRvf
	PcYSLUg9zuyKaX8ZqY5OzJDuUlYVIE9GXhxA3IRypX+PydmCH6aw7WBKGSP6cNV2
	cO1J4R8xnnrKlncj9azobaI+0PkiPsq2fcQRtG1pjrsxg4Ur0L/ELMWynow+gj1P
	WXLd770vGzYHgOJD5NCRhpSA6P6xz293OUNy4nShHI+3+OYYLOKU/phPfqVui9n4
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0jGfjXgnAc1u; Thu,  9 May 2024 17:02:12 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VZywy5qbkz6Cnk8t;
	Thu,  9 May 2024 17:02:10 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH v2 1/2] block: Call .limit_depth() after .hctx has been set
Date: Thu,  9 May 2024 10:01:48 -0700
Message-ID: <20240509170149.7639-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509170149.7639-1-bvanassche@acm.org>
References: <20240509170149.7639-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Call .limit_depth() after data->hctx has been set such that data->hctx ca=
n
be used in .limit_depth() implementations.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>
Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags fo=
r synchronous requests")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9f677ea85a52..a6310a550b78 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -448,6 +448,10 @@ static struct request *__blk_mq_alloc_requests(struc=
t blk_mq_alloc_data *data)
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |=3D BLK_MQ_REQ_NOWAIT;
=20
+retry:
+	data->ctx =3D blk_mq_get_ctx(q);
+	data->hctx =3D blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+
 	if (q->elevator) {
 		/*
 		 * All requests use scheduler tags when an I/O scheduler is
@@ -469,13 +473,9 @@ static struct request *__blk_mq_alloc_requests(struc=
t blk_mq_alloc_data *data)
 			if (ops->limit_depth)
 				ops->limit_depth(data->cmd_flags, data);
 		}
-	}
-
-retry:
-	data->ctx =3D blk_mq_get_ctx(q);
-	data->hctx =3D blk_mq_map_queue(q, data->cmd_flags, data->ctx);
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
+	} else {
 		blk_mq_tag_busy(data->hctx);
+	}
=20
 	if (data->flags & BLK_MQ_REQ_RESERVED)
 		data->rq_flags |=3D RQF_RESV;
