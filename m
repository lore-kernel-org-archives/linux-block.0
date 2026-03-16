Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5873ED127
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691817; cv=none; b=I+oYXolv9IjpCiSHbNYjmfEKnzewErHN1a6lWJunCFDEThEBsDKE4FDew1DoFrQm3MtLYC2VFV0hY5DvvwYFd7X1Cups6DpHEMoMLnK8tbgFIrjEe+uMGfpRAf7+UubOiM+bMohvVZ1fp/ICOHuatrio/5DrxURBhGry4runie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691817; c=relaxed/simple;
	bh=M4rPLehfPVDqrAFFUua2ECNWHpUfRPjKTXQml4yV7f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exnkryO7eimDnLkB3osTXcb1Zu3IPBfKYysOKN8vRpIjCmwDgw3Ivp+ElMCQoWbQ3tno8qrf1F3T6/Pjrl94t1CEXpDM3W9tzmyRMi+LW1onp6mS5E+8yMJ4xwwgx+HFiAobLALMV+ayrdS1+7RaI4qeGTt5bI/gaTf/E6bf3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NG9lVlH9; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NG9lVlH9"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR5z69k3zlgyGV;
	Mon, 16 Mar 2026 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691812; x=1776283813; bh=SS6ci
	BNaM3Vh/VIS/Bjrj/JRHAh/+xuUjO6GdXmDymI=; b=NG9lVlH93lyEAqu5dEyO1
	a/QMd7TgccrHusl8tDr0F2j6Rr/NrUA5FjiE5SWGUqaQqTIUK2OJcggddq0U22y6
	imXQahgmdZlOgphB9iJHmueXzSzDqWnNFGC8822iiRJdARwRE2hMh4tGH+ZdiQ7y
	qIWWyWI0rOPSx+rW1IfDAp9gnJ8hkPMPzp8hCqR/cCpXf/R9N35vxBF/XGk1Mrus
	gm76n89WrJBCLGMqjvig3ihlDP8zmm34hyjvKPJEEkkInxS0J77ili3jgEbLkYAY
	3Cd096yMbYj6cFWaQdpkYJmh7Tia07JQczUrnhccsuaWXlzJUbW1HyHJSpyaAGo6
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1FcjgWvtf_e8; Mon, 16 Mar 2026 20:10:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR5s6YQQzlffvG;
	Mon, 16 Mar 2026 20:10:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 08/12] rbd: Add lock context annotations
Date: Mon, 16 Mar 2026 13:08:45 -0700
Message-ID: <20260316200901.4111651-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316200901.4111651-1-bvanassche@acm.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
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
