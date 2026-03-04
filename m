Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44C38645C
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653775; cv=none; b=IviveyxzWv3XBJDqgAlDUz/S18jGSgz1YtP/vwgwAFAeKhYVhmZIELz8Txzb4qw2shEKFb74wLk2HoCmQt0ByCaichy3BjfFYMr3SwYY3vjJRwtILKZlOcfpBJb8EeFm0+09Rde7kJE149HTtAmZEPKJeHKAJFzGPOTCswYzBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653775; c=relaxed/simple;
	bh=M4rPLehfPVDqrAFFUua2ECNWHpUfRPjKTXQml4yV7f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgwySpmIgqD9R5Zr41/GeyYt44xe2hSofENxA6CQKv03IwlLIcJcAuGfhMhbeniOI92GI+cFIddpzmAfksvxNb8Ak1+4tjAMFGUnokwL+HcC01svVMlcF+ezd5p9j+dGC3SnyfeQBcKnxRuJi1CgHXoYhh6ED+ptQdQh21L36Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eLbUar0s; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eLbUar0s"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3Cf33hBz1XMFhv;
	Wed,  4 Mar 2026 19:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653769; x=1775245770; bh=SS6ci
	BNaM3Vh/VIS/Bjrj/JRHAh/+xuUjO6GdXmDymI=; b=eLbUar0snkannxG3fKlMh
	YjGfkFsXxTUNpceSIypiPdvouYrdlfK4wyg7gIouBoQaVhIPPXaD9XLz7lsZu+F2
	/jZlGl2LG34n9m3T82G8gqRV5bshvPRb4Ag74up89t8XNP974IQlhigG874FedUZ
	8uSccrnHTptJs7wuabCbtldq4haDHANHv9zR8u2+i4Mzjy8zJYi90/EQhe8e2Iex
	Fz8ArZJnzYJ9fiZ1/p3FA+9jxKMSQhxeri+tr56jF5gDGoY/dJpQIGCaJm5rYHHP
	6VMmNW87zi+ilFBzTqDYkslr21k5xwqklyHph5DcSMBtaHFNTh/FSyvjVcS6KGjN
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id r3Blr1RMlSJh; Wed,  4 Mar 2026 19:49:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3CW3l6hz1XMFjF;
	Wed,  4 Mar 2026 19:49:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 09/14] rbd: Add lock context annotations
Date: Wed,  4 Mar 2026 11:48:28 -0800
Message-ID: <20260304194843.760669-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis by adding the lock context
annotations that are required by Clang.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e7da06200c1e..595e4ba720ec 100644
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
@@ -7143,6 +7148,8 @@ static ssize_t do_rbd_add(const char *buf, size_t c=
ount)
 	if (rc < 0)
 		goto err_out_rbd_dev;
=20
+	__acquire(&rbd_dev->header_rwsem);
+
 	if (rbd_dev->opts->alloc_size > rbd_dev->layout.object_size) {
 		rbd_warn(rbd_dev, "alloc_size adjusted to %u",
 			 rbd_dev->layout.object_size);
