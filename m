Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADAE396D32
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474666; cv=none; b=SihgEL3vGXti+p97rmg4TqsMsaJtgTTstbiFcAOs82s5z+IOseFaBZ099udvxIezcg+B2V7s+SiUGupD5jISoGUkM/nqJ62cUdAKJ1nYDdFjEqGn+CVaQ7schk5XQsdulCvbYvcNcnO4CTfGMsMlMyyIgwj8rQBBdA17nJ1NUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474666; c=relaxed/simple;
	bh=Njssehtgg5gzVfjSUvsQJAUp1JuSj9wVvDy3jNjZRR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfS6N7AqxL4XF4bgD1mWLF2wKd8oocZigeQAc4aghzt4z8ghWNFQ9b2BWx6fQXW0MvVrqBiw7ozCC0DCROn6xPDpQaVPyxWD3GrhbZw9VDR2I0xRWFLnROvJnhz5MHVM2Tcrrzy7t85cyd0X/VrymbCmClXNivP2kvJX6IsJx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cQjzAt6y; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cQjzAt6y"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0cj0xnczlfddp;
	Wed, 25 Mar 2026 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774474657; x=1777066658; bh=2fL81
	2RA0tslg4WHlCYpThUMAJRuK04O0IWtoVC4jvg=; b=cQjzAt6ybTYkQ0zYViZRj
	DENYluL4PDw2+HIKt/gVmXnCCv5lbfXX2w+nb9WMYJ/7AtRU2WVC98XnY7QRAhmt
	QVbNAuG0mxrR3gGELCJO1jVNwcJcT9/kMC9kR9QjtWnNYT3oYrV9PXPi3zsFm33y
	6IxaqRLu8aZ9WRqg1lU9qGZpuGRf5DJLxsQIT9LzhMcTIaf+MNCHMF9IrMbjIUmN
	I/rCNEFeq+xWGSrZ3frsDjMbWUrGmdN++mclq6g1q4TFETEcLfmvUbN8tRB+0CyM
	N/ebnRSDZuX5o+pd5hn1d90uwihBSEkENldqf2TV8mr4bp/2gn4gFXOoC64R7Jv8
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QqxxLruKejGw; Wed, 25 Mar 2026 21:37:37 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0cb1rjbzlfgS0;
	Wed, 25 Mar 2026 21:37:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 3/5] block: Remove a DMA segment boundary mask check
Date: Wed, 25 Mar 2026 14:37:13 -0700
Message-ID: <20260325213719.2850619-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325213719.2850619-1-bvanassche@acm.org>
References: <20260325213719.2850619-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit d690cb8ae14b ("block: add an API to atomically update queue limits=
")
introduced the following code:

       /*
        * By default there is no limit on the segment boundary alignment,
        * but if there is one it can't be smaller than the page size as
        * that would break all the normal I/O patterns.
        */
       if (!lim->seg_boundary_mask)
               lim->seg_boundary_mask =3D BLK_SEG_BOUNDARY_MASK;
       if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
               return -EINVAL;

The comment about "breaking normal I/O patterns" is incorrect - block
layer code like get_max_segment_size() supports arbitrary boundary mask
values as long as the boundary mask is not zero. Remove the comment and
the check because both are confusing.

This patch prepares for reducing the value of BLK_MIN_SEGMENT_SIZE.

Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits=
")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 13f5457f9f4e..8538e50afe2c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -447,15 +447,9 @@ int blk_validate_limits(struct queue_limits *lim)
 	if (!lim->max_discard_segments)
 		lim->max_discard_segments =3D 1;
=20
-	/*
-	 * By default there is no limit on the segment boundary alignment,
-	 * but if there is one it can't be smaller than the page size as
-	 * that would break all the normal I/O patterns.
-	 */
+	/* By default there is no limit on the segment boundary alignment. */
 	if (!lim->seg_boundary_mask)
 		lim->seg_boundary_mask =3D BLK_SEG_BOUNDARY_MASK;
-	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
-		return -EINVAL;
=20
 	/*
 	 * Stacking device may have both virtual boundary and max segment
