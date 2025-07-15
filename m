Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D619F464
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598396; cv=none; b=sTR0kxjXDQn1ZNdgWUM5MCfrf3coqCXb4QCFVtU31UA/5SKFKgJMdnTwlKY0LygCD58dTBM7RTX4ZydXE/VW9Ek0uh5TAuf3wShzDgG4lJtBzsgh7Og2AvKfyCL9KtEads52edjTTOzG0PGBaOV/XJSgnX4eHce4EFzVWEUFxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598396; c=relaxed/simple;
	bh=CVIWG4aYVtXlyXqwGiODVXZrgccO+lTN3tB5behfipI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr1ks1H0FJHjLl4tTopHrR99/3RYHyj28a/fBDXXYLfaUrYrw3di8PKo+qRHDnud1ghH30d/8nzP0zTjLVOmhKJ3qIU4PjY0ux4807jEUt9yMc3CXU2UkeFR4CKNdX0SpsFpmcrA6Gi5bn9QWtlhuqR8Twx+AwyDdeLJWg8ytNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JwDw5bEe; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JwDw5bEe"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhQH83569zm0pL1;
	Tue, 15 Jul 2025 16:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752598387; x=1755190388; bh=LD0hE
	qmPmDCVbz6cGmxV2uA7Rj/sdIdBryD/+CWPkag=; b=JwDw5bEebmKJ5I/Q67evZ
	KG5SALG2E/ljxH/XvmwW2drNBE2ImLOHHYnAZHQ5A6XuYHeYxhGe0Wlc80Zu0Ws7
	lLv9UUeY515m3ryjtr6ZRmyHEcv4MOP/QphBfyMSig1P/2mmKNeEYTcnY6c4ERI7
	lEyv9UegD0ZSi72xc1j2VRdPVhtZ/xZjZrfn6SN2/WO1GbmWNA5R4FSWkNLuZCEY
	bA8/mS1aV6SWRqUMhlZ9CTHhBLrw8Z+7icr6r98J/9Lium7NiYyzP8GqT0k0eD/6
	s/BQDq5XlGuE4Rubi6TtdPYW9tlSJ8yvpSHc3L1I4tcSOdRgnHDwhm/Q8YuaMf2J
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id y4nsiQL7rrH2; Tue, 15 Jul 2025 16:53:07 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhQH41F3czm174M;
	Tue, 15 Jul 2025 16:53:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 1/5] block, bfq: Remove a superfluous cast
Date: Tue, 15 Jul 2025 09:52:35 -0700
Message-ID: <20250715165249.1024639-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250715165249.1024639-1-bvanassche@acm.org>
References: <20250715165249.1024639-1-bvanassche@acm.org>
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-iosched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0cb1e9873aab..74f03bf27d82 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -769,8 +769,7 @@ bfq_rq_pos_tree_lookup(struct bfq_data *bfqd, struct =
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
