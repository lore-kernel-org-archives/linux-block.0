Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E5296BDC
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928554; cv=none; b=tYKTILcI5OSuwA67sM9OdQzI7E6Gn0mq21lqi3gWJtr6vJL8pqZjb/LodeS4on1F1worE4WNIJCip2RVQoVSAUT7O/NbyWAIDWHYnCpEVRP8pWsZlB+GcgwdlaMZaPesumS/JBkmDPS2NUOR4DMIYqWypr0MJcPk5w3eqJIbv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928554; c=relaxed/simple;
	bh=Nf+9f5a/6od9Bz4coXsjltP8SGWfOFgC2PDF4MDX8GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmwTLk/ezYZC9PYY9Dg136M/aCz7L8o+TMAelVf4+iGJEUUn5/66LANWpkavSGdRAbIf/3AT2ESpJiI23ogrXsDOVLD2Gm3FQSiVahM43sW9IsRLHIF41fZW6dRMCeBPzQ1VzXub6vLzw/zYaAkx0RDXzQgAbcXvv0obpnQnMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GRWOow07; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GRWOow07"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c0zmH1cpczm0yVW;
	Mon, 11 Aug 2025 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1754927837; x=1757519838; bh=B3JNc
	AneosbMY4wsO+7W73aoFiZWiG04Xv/nCY+jFA0=; b=GRWOow07MR8i7ARl7Zgaz
	jgVz0jFa/k/CQ+Q8wky5mwz1iOajR0gcVT+wGzXbzpB1G4QkaldDuQO5kT5mMwqf
	lrcY/Ilo6Yhoi6JQ5W+lZx1pYtS4eknu9vZ3wpr34uP2La3vbqdaq24oqBUO4yKl
	cPbunQlHcO31vKNrpPn+asPl8pXi//RDnMaJyreBPOs/oMb3MPvxelE7Syxnw/gz
	qMc0TTK7z8pdabAAbe77F3JNiuBm9hDATmDQMTP8A9LlLddJlaqp/G2jz4jDhZzL
	hT9JNtjCWoFIwMYJXPqgW5Hr2CNGO86aTiwrBMFkBFnm9AYg4hvpYgBe0HBFLnc5
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Es7VvrCQ16ol; Mon, 11 Aug 2025 15:57:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c0zm93j9pzm0yVL;
	Mon, 11 Aug 2025 15:57:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 1/5] block, bfq: Remove a superfluous cast
Date: Mon, 11 Aug 2025 08:56:48 -0700
Message-ID: <20250811155702.401150-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250811155702.401150-1-bvanassche@acm.org>
References: <20250811155702.401150-1-bvanassche@acm.org>
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
