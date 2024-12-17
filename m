Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D091F9EC8
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469429; cv=none; b=U1isJg9SGmn+QWrVX34O2BfLzW9RGRL/KxmwupAEw1ohwDWRBGQco879WN4X1saQYnp7n/1pacqT5wWyDbjxPHhGpKSyVhtHcxwcHJCFBl+p3k4Nzr2jXSF72DruU6l2Jq4drbrgs20dH6zFp8KfnzfefzLpBacD2rsB8Ut/gas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469429; c=relaxed/simple;
	bh=DuyLsVnWhrzYYdDZAEtQCNUwRrgzHgenWRbdrcmjqG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUOp3gWQe8IbxQFweckwFsBfANvkUBlyqYZa1xoHfg2vac0s1Qje2mbpXUlId3/QXqpjQb7vFYUBxw2QdbATyliUZRMpS31REaCWhxy44iXsmPVp3mL35TFpzOMjT2ghdtWb78h0bfQZKkDBZG/jA96MAjrQhoctZ41kJIc3ozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fneg1bue; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fneg1bue"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCTnH1775zlff0T;
	Tue, 17 Dec 2024 21:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734469425; x=1737061426; bh=hQh4h
	lwBz5ACefTfyXmFGa8/l1NyschLJQ2aetxmvvE=; b=fneg1bue2aWa3ktSUpHra
	v96YVWMGvhO/6omOmAWQsE46S2JIFyzbpdbRLrxDkcMEmeomDEc5f6WYb6XiSxqx
	9CMlBoiyFfoGGMNdbSvQm3uhLqFtxLVd5PoCYhKky/9U2MWOnCzWDJNcznRrvvZn
	E59EfXKuPgb8zsvRBrIFoempQQ5s6Vc117DEgzJvaKYNEMtZyYIwqF7g+5dAgvq6
	vtzUh86kHngVq710DWRpgxjtfTpo1MTHjnM053SrqiozbDSr3/FHk0roLUzCuGxK
	2WvjVMm2upNW5nJCmNLpubsuWlHknS40MEZiB5eKv+lRfKf/8o4WQD1CdRCK+AgY
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id asMXGCIReAfU; Tue, 17 Dec 2024 21:03:45 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCTnC2YrPzlff0H;
	Tue, 17 Dec 2024 21:03:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 3/4] blk-zoned: Improve the queue reference count strategy documentation
Date: Tue, 17 Dec 2024 13:03:09 -0800
Message-ID: <20241217210310.645966-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241217210310.645966-1-bvanassche@acm.org>
References: <20241217210310.645966-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For the blk_queue_exit() calls, document where the corresponding code can
be found that increases q->q_usage_counter.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 954724a2e3c6..7876a6458022 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -582,6 +582,7 @@ static inline void blk_zone_wplug_bio_io_error(struct=
 blk_zone_wplug *zwplug,
 	bio_clear_flag(bio, BIO_ZONE_WRITE_PLUGGING);
 	bio_io_error(bio);
 	disk_put_zone_wplug(zwplug);
+	/* Drop the reference taken by disk_zone_wplug_add_bio(() */
 	blk_queue_exit(q);
 }
=20
@@ -893,10 +894,7 @@ void blk_zone_write_plug_init_request(struct request=
 *req)
 			break;
 		}
=20
-		/*
-		 * Drop the extra reference on the queue usage we got when
-		 * plugging the BIO and advance the write pointer offset.
-		 */
+		/* Drop the reference taken by disk_zone_wplug_add_bio(). */
 		blk_queue_exit(q);
 		zwplug->wp_offset +=3D bio_sectors(bio);
=20
