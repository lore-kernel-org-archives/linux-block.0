Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14E39903E
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475195; cv=none; b=pR1YU+UTu94AziBLZS75CdqUIY6DHrt2T3eRRQmpZU3IdYc3/7JjNCQ9+E8qkdPXTkMye88VF4nKSoZLu3YDbLQ3x3c0Em5IuhV+jhLyke9Bk2JivXMvvI0ZwQ0UYZFnalQqM9TyEOScQmz8KRqWyWeHx85a01CyFhPYsKSSR5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475195; c=relaxed/simple;
	bh=6lRtONjxRFaggLPemr1WKMESgTxNxTh0KAZUnHU1pZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi9MtsNUKELcPV+MDL9FnikA8OT3bMnCPj68w4hr15OCTzBqJI/G6AjKkl1vviHmoqtyUwPnkaAWxgaL+5GgSEixmvc/+GdE+6/JipxT9TljJoqrDFWd1VwAk2r6zkpM+/gr2R9bwP8VaCdc/cVxPFSJzM9bY/9KNHYWldRL5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kQHfi7Qi; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kQHfi7Qi"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0px6xq3zlgyGQ;
	Wed, 25 Mar 2026 21:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475185; x=1777067186; bh=BgCfr
	IzQz2v7P8Mu3J4wWLxdP677oH4xUglHw/LbRXY=; b=kQHfi7Qi7cqg+pJxxhd08
	HxF7J4R1+hOUMRh+G2fX2hYm4xYogvn8tUCBpzmli7i6Bd9NRzAdM2qXBe8wlQyW
	lyWGG+f2hxMQcLBxLLBAj2+hKh+HVc/Zr8WM8br7JJ2+Qx3/CEsTK1EEnnsLbk5c
	a9xmVb+7hsn9zMc6Mn5BFArntIc2lXXcwLyflfy8oumBDdzIvc3wQo9cfOOSVTwi
	BYvaVcSjG8eAcLT+Woc9Mg6zArebuZzdPzL88JjNEBw3XJMkAP0WxqmJDkqFfZJn
	17bynPsxrAL7NDpLGjiN815xLNGwvy5WP2/IpotTnHtjK4dTVj4RqVBr7roEC/MN
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BjakmhT63fEp; Wed, 25 Mar 2026 21:46:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pm1jgkzlgyGv;
	Wed, 25 Mar 2026 21:46:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH v2 21/26] rbd: Enable lock context analysis
Date: Wed, 25 Mar 2026 14:45:02 -0700
Message-ID: <20260325214518.2854494-22-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add lock context annotations and enable lock context analysis.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e7da06200c1e..31fe81b82548 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4185,6 +4185,7 @@ static void rbd_acquire_lock(struct work_struct *wo=
rk)
 }
=20
 static bool rbd_quiesce_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
 {
 	dout("%s rbd_dev %p\n", __func__, rbd_dev);
 	lockdep_assert_held_write(&rbd_dev->lock_rwsem);
@@ -4229,6 +4230,7 @@ static void __rbd_release_lock(struct rbd_device *r=
bd_dev)
  * lock_rwsem must be held for write
  */
 static void rbd_release_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
 {
 	if (!rbd_quiesce_lock(rbd_dev))
 		return;
@@ -4597,6 +4599,7 @@ static void rbd_unregister_watch(struct rbd_device =
*rbd_dev)
  * lock_rwsem must be held for write
  */
 static void rbd_reacquire_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
 {
 	struct ceph_osd_client *osdc =3D &rbd_dev->rbd_client->client->osdc;
 	char cookie[32];
@@ -6789,6 +6792,7 @@ static void rbd_dev_device_release(struct rbd_devic=
e *rbd_dev)
  * upon return.
  */
 static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
+	__releases(&rbd_dev->header_rwsem)
 {
 	int ret;
=20
@@ -6890,6 +6894,7 @@ static void rbd_dev_image_release(struct rbd_device=
 *rbd_dev)
  * with @depth =3D=3D 0.
  */
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
+	__no_context_analysis /* conditional locking */
 {
 	bool need_watch =3D !rbd_is_ro(rbd_dev);
 	int ret;
@@ -7143,6 +7148,9 @@ static ssize_t do_rbd_add(const char *buf, size_t c=
ount)
 	if (rc < 0)
 		goto err_out_rbd_dev;
=20
+	/* Acquired by rbd_dev_image_probe(rbd_dev, 0) */
+	__acquire(&rbd_dev->header_rwsem);
+
 	if (rbd_dev->opts->alloc_size > rbd_dev->layout.object_size) {
 		rbd_warn(rbd_dev, "alloc_size adjusted to %u",
 			 rbd_dev->layout.object_size);
