Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288773;
	b=vM7CAFluVQ0RJlOlIwOTjZVzAghClHV6XiWKQLJyfFY12bbQEkiRJr/7sc4dZohtJ+4p
	 1eXx17X0Lb45648e4iRG3rdo3qe2BVa+aS3oX3lPKlZywbQVRqw6iO72dkrAWQIZ/1aGl
	 0bflfaM0+r/aj2X6cktuitj1vl2Ig6uAz+DwSWUrppnT3/iXCE11VKez/k4w8CCNF3IK7
	 Y/KiATXOP/kUOENcJD6ojC9YWW9HdXqbrV3Y/mjkEWjOcdXOcHoZFBHBHl8qwGh2qfvMs
	 bLk6pragciFw82Oh8RmMwLD+TGWicD6WCG1vu1EsiNaCWcwVO7/YGNJzjRQycndwfwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LoBsGu12X73oPcjfh708NI+vQj0GrcVoJvchltfweQE=;
	b=JYnLZFhMT9W3gqMOF0dDWuyg4dOiR9WAT0OCrBy6VjngNnO8SKRLBYDjn5UFDOz0JxaA
	 ND9yt4zTye8KL7pQXffTBHK4FxtPKnB2z6bEQG08FyXskQaClUmWreb1IT4CTHHl2/6+Q
	 gpZw0VFpwCsgTbL11O00sQg7Itwr97uhAm8zEjY0TI87eZsLhQor6AlQs2IzL6ulpEmMZ
	 lXkIUegjyIPWHw7puLOBnpu5gpVMVe5orkAsxApMpgs5pWPf4B7zX/q7TfA2/SA/gBUfD
	 JygHQaTZ6xb5ZsuNX3tBuN38szp7hXsNLz4XHSSDNooSe9OWb9kwP4p65WCS78m/K+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=SZzlTVWn;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F63606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F63606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=SZzlTVWn
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFpVQ3Gxcz1XM4Tn;
	Thu, 29 Oct 2026 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1793288761; x=1795880762; bh=LoBsGu12X73oPcjfh708NI+vQj0GrcVoJvc
	hltfweQE=; b=SZzlTVWnSHqIwXsz3CEoZeYuEBNTI2kQUkE00uR0aZ+tD/gpjDM
	K5u5X81iixP4GvJ3Aefub5F/L5f+RF9WEmYAUU3gzxyTmbDAKriZfU+cTdDjvKZO
	tOLOvOxHQpnYttwJUuGTxPGLfN6ibsVtXEleuMtj6QCeK8D7VFXJ9Szb58i0vawB
	T3rhZ7M6Ii6ctvYKgttfNrjhresb7gVNW+CYO/wnmdUPl8AJx/jUMvxEy9uGf+dx
	RD7dY806NrNgV2sBzOXdpfS45XJdFp7VuK5Va44qpvSlwdsYw7MCew/+e8X2eOKy
	4zwXEf8tr1y84g4pV0etU1pY90oizWmSMyA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 82XlH-YmPYPr; Thu, 29 Oct 2026 15:46:01 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFpVJ4dPXz1XM4Tl;
	Thu, 29 Oct 2026 15:46:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Justin Sanders <justin@coraid.com>,
	He Zhe <zhe.he@windriver.com>
Subject: [PATCH] aoe: Do not free a device while its work is queued or running
Date: Thu, 29 Oct 2026 08:45:51 -0700
Message-ID: <d931ae52b451b1fa3e5de8baf828943f86324078.1793288725.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Serialize flush() with a mutex because dropping devlist_lock during pass
one otherwise allows a concurrent flush() call to enter pass two and free
a device that is still being torn down.

Set DEVFL_TKILL under d->lock before unlocking and calling
aoedev_downdev() because commit 430380b4637a ("block: aoe: Fix kernel
crash due to atomic sleep when exiting") dropped d->lock and devlist_lock
before setting DEVFL_TKILL, allowing d->work to be re-queued while
aoedev_downdev() sleeps.

Guard queue_work(aoe_wq, &d->work) with a DEVFL_TKILL check under d->lock
in rexmit_timer(), ataid_complete(), and aoeblk_gdalloc() so that timers,
ATA ID completions, and gendisk allocation failures cannot re-queue
d->work once teardown has started.

Cancel d->work synchronously in flush() before aoedev_downdev() and in
freedev() after timer_delete_sync() so that pending work cannot run
concurrently with device teardown or outlive the freed struct aoedev.

Check DEVFL_TKILL under d->lock in aoecmd_sleepwork() and aoeblk_gdalloc(=
)
instead of triggering WARN_ON() or setting DEVFL_UP on a device that is
being killed.

This patch is AI-generated and has only been compile-tested.

Cc: Justin Sanders <justin@coraid.com>
Fixes: 430380b4637a ("block: aoe: Fix kernel crash due to atomic sleep wh=
en exiting")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/aoe/aoeblk.c |  8 ++++++--
 drivers/block/aoe/aoecmd.c | 15 ++++++++++++---
 drivers/block/aoe/aoedev.c |  8 +++++++-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 34ead75e7e02..69586dc6d379 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -385,7 +385,10 @@ aoeblk_gdalloc(void *vp)
 	spin_lock_irqsave(&d->lock, flags);
 	WARN_ON(!(d->flags & DEVFL_GD_NOW));
 	WARN_ON(!(d->flags & DEVFL_GDALLOC));
-	WARN_ON(d->flags & DEVFL_TKILL);
+	if (d->flags & DEVFL_TKILL) {
+		spin_unlock_irqrestore(&d->lock, flags);
+		goto out_disk_cleanup;
+	}
 	WARN_ON(d->gd);
 	WARN_ON(d->flags & DEVFL_UP);
 	d->bufpool =3D mp;
@@ -427,7 +430,8 @@ aoeblk_gdalloc(void *vp)
 err:
 	spin_lock_irqsave(&d->lock, flags);
 	d->flags &=3D ~DEVFL_GD_NOW;
-	queue_work(aoe_wq, &d->work);
+	if (!(d->flags & DEVFL_TKILL))
+		queue_work(aoe_wq, &d->work);
 	spin_unlock_irqrestore(&d->lock, flags);
 }
=20
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index a4744a30a8af..c7f762180b9b 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -787,7 +787,8 @@ rexmit_timer(struct timer_list *timer)
 			 */
 			list_splice(&flist, &d->factive[0]);
 			d->flags |=3D DEVFL_DEAD;
-			queue_work(aoe_wq, &d->work);
+			if (!(d->flags & DEVFL_TKILL))
+				queue_work(aoe_wq, &d->work);
 			goto out;
 		}
=20
@@ -899,6 +900,13 @@ aoecmd_sleepwork(struct work_struct *work)
 {
 	struct aoedev *d =3D container_of(work, struct aoedev, work);
=20
+	spin_lock_irq(&d->lock);
+	if (d->flags & DEVFL_TKILL) {
+		spin_unlock_irq(&d->lock);
+		return;
+	}
+	spin_unlock_irq(&d->lock);
+
 	if (d->flags & DEVFL_DEAD)
 		aoedev_downdev(d);
=20
@@ -909,7 +917,8 @@ aoecmd_sleepwork(struct work_struct *work)
 		set_capacity_and_notify(d->gd, d->ssize);
=20
 		spin_lock_irq(&d->lock);
-		d->flags |=3D DEVFL_UP;
+		if (!(d->flags & DEVFL_TKILL))
+			d->flags |=3D DEVFL_UP;
 		d->flags &=3D ~DEVFL_NEWSIZE;
 		spin_unlock_irq(&d->lock);
 	}
@@ -974,7 +983,7 @@ ataid_complete(struct aoedev *d, struct aoetgt *t, un=
signed char *id)
 			d->fw_ver, (long long)ssize);
 	d->ssize =3D ssize;
 	d->geo.start =3D 0;
-	if (d->flags & (DEVFL_GDALLOC|DEVFL_NEWSIZE))
+	if (d->flags & (DEVFL_GDALLOC | DEVFL_NEWSIZE | DEVFL_TKILL))
 		return;
 	if (d->gd !=3D NULL)
 		d->flags |=3D DEVFL_NEWSIZE;
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 6e8b3807c1c8..4eb2e68439db 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -286,6 +286,7 @@ freedev(struct aoedev *d)
 		return;
=20
 	timer_delete_sync(&d->timer);
+	cancel_work_sync(&d->work);
 	if (d->gd) {
 		aoedisk_rm_debugfs(d);
 		del_gendisk(d->gd);
@@ -311,6 +312,8 @@ enum flush_parms {
 	EXITING =3D 1,
 };
=20
+static DEFINE_MUTEX(flush_mutex);
+
 static int
 flush(const char __user *str, size_t cnt, int exiting)
 {
@@ -333,6 +336,7 @@ flush(const char __user *str, size_t cnt, int exiting=
)
 			specified =3D 1;
 	}
=20
+	mutex_lock(&flush_mutex);
 	flush_workqueue(aoe_wq);
 	/* pass one: do aoedev_downdev, which might sleep */
 restart1:
@@ -353,10 +357,11 @@ flush(const char __user *str, size_t cnt, int exiti=
ng)
 		|| d->ref)
 			goto cont;
=20
+		d->flags |=3D DEVFL_TKILL;
 		spin_unlock(&d->lock);
 		spin_unlock_irqrestore(&devlist_lock, flags);
+		cancel_work_sync(&d->work);
 		aoedev_downdev(d);
-		d->flags |=3D DEVFL_TKILL;
 		goto restart1;
 cont:
 		spin_unlock(&d->lock);
@@ -397,6 +402,7 @@ flush(const char __user *str, size_t cnt, int exiting=
)
 		kfree(doomed);
 	}
 	spin_unlock_irqrestore(&devlist_lock, flags);
+	mutex_unlock(&flush_mutex);
=20
 	return 0;
 }
