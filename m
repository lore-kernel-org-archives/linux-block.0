Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8115538C;
	Sun, 25 Aug 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724603030; cv=none; b=CWODf/mJIOUcPcWgPWiVjUJA7P5uqzVt+csu/t0wRNv78oisk2MWjv0R/rl6kaFal62aQlsV2dCBctHndHOHYHD/k1aTiHkOcWb9BhE9UimYJeNw7WuWHmkm1+swjoAHrS0FRRK4db3nAHUaCRkmkAEdr5KMN9T25/Chv975f/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724603030; c=relaxed/simple;
	bh=AwruPQNWEj3O9iDHvIhAch81aQxRPzP0uPk3sr2VxBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RoR8Yclc5iHf6UgShV70oPxTH1SwkBMRzoLye7b2lE80jFpZ5BpZc4/tBxGpfZtAawT57hcvviNTij+tvn63x2XfeRoCzommJq4zxjIoJfYW4Q/jpX/m57nxAdmY11lTrSLChH+pyts9JWPohJizsK7KQRQfIz8pzETYj8+FMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jD4Y7aGW; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jD4Y7aGW"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id iG0Zs22q8jDE7iG0ZswTyj; Sun, 25 Aug 2024 18:22:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724602948;
	bh=dWmD0V+W1NiHZUZkeWhaQAh8ZUporSmdN746Lio9aro=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jD4Y7aGW+AP7mCFOiQtxNv1Ze05yNleFkbmCSCIJjBErp9S+CNqbeq7isXLW8S7e/
	 l80O6buXBuwgjC2+BC9F8brGqjHZDPs7PYqOiyTLPMwc0EbYekuo9H2pJaukRvO4yi
	 jXl+UTQqWROs3SiAWilcm7o2H9KD+WnlwCCO6s3sMy5B+0bRWqMQMjVyWC+QisB3SF
	 rq9XS+GTOGRzVdD6ruO4tTKJmZ4EtFXSjkwUgnRVeSP3vO/ak23syLNAUMrZWVfNqj
	 nyszHp3pbfo7p8Vex4KD/d4LlnNkiqCy4bsxn2F7iJKGwxLsKpyr+SLt6XX4yNc0v9
	 pn8vWnCHPuJ+Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Aug 2024 18:22:28 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Subject: [PATCH] drbd: Remove an unused field in struct drbd_device
Date: Sun, 25 Aug 2024 18:22:23 +0200
Message-ID: <d5322ef88d1d6f544963ee277cb0b427da8dceef.1724602922.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'next_barrier_nr' is not used in this driver. Remove it.

It was already part of the original commit b411b3637fa7 ("The DRBD driver")
Apparently, it has never been used.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/block/drbd/drbd_int.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d2937bca1fe4..2a05d955e30b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -860,7 +860,6 @@ struct drbd_device {
 	struct list_head read_ee;   /* [RS]P_DATA_REQUEST being read */
 	struct list_head net_ee;    /* zero-copy network send in progress */
 
-	int next_barrier_nr;
 	struct list_head resync_reads;
 	atomic_t pp_in_use;		/* allocated from page pool */
 	atomic_t pp_in_use_by_net;	/* sendpage()d, still referenced by tcp */
-- 
2.46.0

