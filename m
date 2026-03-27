Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF33264FA
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646053; cv=none; b=Mknhyh6cOwo5gngmWL+9Fl1j69webpxBoSEPxdDJ9QmVv9a/mCwPb/+AQnu20FRRZT3N2G2OoZqKs6lMg1KFGHiIBIbZ0+RYX8l9pGE3NhppFOswu/liMerWeXDPG6lY/vaTbIVnRoVpDVDxvMWnAICHsOsyjQYdztEvNdSLvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646053; c=relaxed/simple;
	bh=I2fMgfr1HE6cuQbGMCLkhlBa23bmhgCBmvAEOogD7r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpZyTDzFulD0zXZTz03MZjT2I90XeB0EANY/gkowtmhDh5hNaeUhPG93hg2B/lPnQvuiHXRb/4iHnUaPETYiqfyI0pM3qVnuENmywy/4f3BdxKqs3GKkFrkwZLaEDQyvTOyjkNqAND/+hDuZFZag/LO44Hz36SBApfPsBQkN4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OQKq7Bwp; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OQKq7Bwp"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fjD0g5H7Qzlfvq4;
	Fri, 27 Mar 2026 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774646048; x=1777238049; bh=ufmxz
	pgD9wuQoiAf9NCbr3Q3IhA3FDpkGW/QhgDrj6w=; b=OQKq7BwpWbre1qVKHOuqm
	zLfaKAttvcz3rdk6lGpbqpW2d2v9So3AOn1XFzFb4JDA2meHtrEulgsQcz1lTMJx
	R+S3Xud44lJYpqgO1aaUE3KuaUasWhwYmtnQ4ocXVemtzNmGHzRveGQ7cjweFRMD
	Xx3J7Z2ispMpb39eQI9mHGwN1k8SMNwcoWDkHFUQsQyw+c4RmCXcO0dlfJdzur6c
	TUrxXx2MwSC05At1h9MlkAafJA4aOpce1IY+1pz8pSl2HGcFqjJAf0jJ8RDTd1aO
	2af3bN02FRhR1dNyaHHzEEOejsI7d0cMycVcgBlVtqb4js8ZDGF/3MW6+5tHAzPL
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UmEPTIDL695a; Fri, 27 Mar 2026 21:14:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fjD0Z61C6zlfvqD;
	Fri, 27 Mar 2026 21:14:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 3/6] block: Fix the DMA segment boundary mask check
Date: Fri, 27 Mar 2026 14:13:43 -0700
Message-ID: <20260327211349.2239633-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260327211349.2239633-1-bvanassche@acm.org>
References: <20260327211349.2239633-1-bvanassche@acm.org>
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

The comment about "breaking normal I/O patterns" is no longer correct
since the block layer now supports DMA segments smaller than the page siz=
e.
Modify the check such that it still passes for all current block drivers.
The qedi iSCSI driver is an example of a driver that sets
.seg_boundary_mask to 0xfff.

This patch prepares for reducing the value of BLK_MIN_SEGMENT_SIZE.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 56017098d2c7..e900405d0cc3 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -450,14 +450,14 @@ int blk_validate_limits(struct queue_limits *lim)
=20
 	/*
 	 * By default there is no limit on the segment boundary alignment,
-	 * but if there is one it can't be smaller than the page size as
-	 * that would break all the normal I/O patterns.
+	 * but if there is one, check that it allows at least 4 KiB of data to
+	 * be submitted at once. All known block device DMA controllers support
+	 * 4 KiB DMA segments that do not cross 4 KiB boundaries.
 	 */
 	if (!lim->seg_boundary_mask)
 		lim->seg_boundary_mask =3D BLK_SEG_BOUNDARY_MASK;
-	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
+	if (WARN_ON_ONCE(lim->seg_boundary_mask < SZ_4K - 1))
 		return -EINVAL;
-
 	/*
 	 * Stacking device may have both virtual boundary and max segment
 	 * size limit, so allow this setting now, and long-term the two
