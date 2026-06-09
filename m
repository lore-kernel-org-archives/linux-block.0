Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A624BD03
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042811; cv=none; b=ImoQ5REUnuNZYnccOLvBZlCtCQRQN02yzG2Qs5RI6D0b6RiFU4y6CeWbjl4DkNl4Hl4rDZkxMk55b9esbht9SFaEl7paESD4tGyNJyCUwPlliAd8FFz+sssd0fRYSv+QojS1b4OpuFj0j/s7PKGeQMbFw+i4NRaLBMh6ccdu11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042811; c=relaxed/simple;
	bh=sUOjsTIuJDhsBfx2d9y/ug6hGFLLd272FnQhurDUHZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckQfP5Psixl0WgyuXGzEIYLsZ3+gG3Gv2CGRNPxdexzM9DdDLwKvyGxvNWs0KGroX/4clp629q97e1FyoRrCMAPfXZFwLdfjvTo4STuzxIxzpY/u/OhTKLpMofVOmuXAJw2Ayv8gBCqkljT9oNJeWIwnXENsn8n+xldPQhw709M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s9fIHboa; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s9fIHboa"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjgG4W0wzlh2rw;
	Tue,  9 Jun 2026 22:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042806; x=1783634807; bh=VJloy
	R14ucbIxZTeVpQ/C07pGs9YFTGRkhyon9POBok=; b=s9fIHboaF+Fue2lq/+Wkm
	OE/RARU2CrF6qxnxIDAj3i+y9XyxOZ4WNuk8bukZ73/APcmFFZ4f5rL8gVNya4sr
	BGbxVN9GMOYSW3GYDPG+KONuNe8R4BzZcfUC8+ui+qQeF9FEX/MDpZouyJAqRARj
	qlifft99pt76Jhbojnq6TizbhFN9eyW/MXbExkZxqGgRaj6zpX7CvvaS6oTZrD4H
	4Gejtup1bRqgcKDselSuqXbV9eOlpO5crjbF3GxXYiDw2QMuY8Fm54r8eD/NRgvq
	RwgVwZJNYpRH3NSinvQBpuIylcya8rUQ0nihx06elCZ7M70+npsw5oITDyW0Ba/k
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id msgS-zcGiYcP; Tue,  9 Jun 2026 22:06:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjg911JYzlfpM6;
	Tue,  9 Jun 2026 22:06:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 22/27] rbd: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:05:09 -0700
Message-ID: <e239f06e82bb4e6f527a9be87d87dd58ffa265d1.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
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
index 90c13de47cff..13077d85e8c8 100644
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
@@ -4585,6 +4587,7 @@ static void rbd_unregister_watch(struct rbd_device =
*rbd_dev)
  * lock_rwsem must be held for write
  */
 static void rbd_reacquire_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
 {
 	struct ceph_osd_client *osdc =3D &rbd_dev->rbd_client->client->osdc;
 	char cookie[32];
@@ -6782,6 +6785,7 @@ static void rbd_dev_device_release(struct rbd_devic=
e *rbd_dev)
  * upon return.
  */
 static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
+	__releases(&rbd_dev->header_rwsem)
 {
 	int ret;
=20
@@ -6883,6 +6887,7 @@ static void rbd_dev_image_release(struct rbd_device=
 *rbd_dev)
  * with @depth =3D=3D 0.
  */
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
+	__context_unsafe(conditional locking on @depth)
 {
 	bool need_watch =3D !rbd_is_ro(rbd_dev);
 	int ret;
@@ -7136,6 +7141,9 @@ static ssize_t do_rbd_add(const char *buf, size_t c=
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
