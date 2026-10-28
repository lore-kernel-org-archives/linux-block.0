Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231374;
	b=HkHcadg5faF3/aeMAA2fXlECaEdNes69n/k2BdN8QdFpIxs+HD3WqWjuf3sWp1Z3JSSj
	 GNtlKjCK7d6+Dkp5FdCvWB74rRwMyFRsCUSvdR3djZ/UiPMvl89kaCb8gER2A3qbPFJvZ
	 0E55Y67SIQ+o6K2iRIjE1duLjizQwd2ZbjgDg5n35NrnNFuafrNzUg7vv6uFAILpK5RIG
	 0Qo8bS4g+Wp33tbXHPVPGCq77yeZIKCwtgGR/9lsdgldaEFsft+RPk5rEUz9WWn4bkpmX
	 brzA6wapEGZA6VEUVEaDQiFFs+guUn+btzgDeyUTrE8utt30m+W97NqBR8hdrzxiCBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=q288pBJwVmPXpB+FW0MORM9hqcsIXPImg4gXaxIst44=;
	b=umbXVTW7h+e6hnPMEd2lqZj88+usE/OnPJ4nAqNOElNzdD5Ku3KDeDqSNifCwMCOT4Mm
	 gPGKYiBk7B1ELt1+9Juacscl1rRGbwbnZihtciOL1LaClGyb5vYsMpTLq3COQ0gh6/uDV
	 to96lKq1HT3ZjXgNIMt0prxzpRV2U8XNEni1gDMeRPetNS9t6WMSDSi8dHPkxu4pFceRk
	 4FvK/70HZQSiFOTf7krlEtO4R+COeWpmkLf7+pYX8YVRCV5XmIUpASbB7cb/sToeFgxVc
	 M9yxLuwnJpHftp4sV6xILRQ1xaReyFYidv1t7QHIywPWgUmedUvzerwck4JeQv1eJqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=BDY5RWfq;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC822606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC822606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=BDY5RWfq
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPGj2Mcxzlfvq2;
	Wed, 28 Oct 2026 23:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793231369; x=1795823370; bh=q288p
	BJwVmPXpB+FW0MORM9hqcsIXPImg4gXaxIst44=; b=BDY5RWfqnRR08OC+TqMyz
	vCj6kt03CXMs8e8qx9GBUQ3ZzEEZB2w8lOTNRu4wotl9YNUxNNMrtk53NRgTQsnB
	reKS5n44G9mg9kwdNuVttR08uHwLUGlN6VVELkwpNgLdouV69aZxhCwUIpWRRUg5
	nBk6Jpwi8JU5yECJHOyBe37FOP8W7bntcc+7ofe+8OI2RIH2fr0FM20xnaKGz6mo
	4JqzJ9yiejn11MPvU5JGyfmxHBwbHjdxdtj/1yoEQjDnX5iDJSFOypA1COC/ciQb
	jfmW1ujRlru5S5my7NabvzuEaImUkf+aT/yBCQmCrNORd9KeUBnGOIEJw02YFpIN
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kg9SJkjlsdVc; Wed, 28 Oct 2026 23:49:29 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPGc39v3zlfvpT;
	Wed, 28 Oct 2026 23:49:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 18/98] aoe: don't free a device with its work queued
Date: Wed, 28 Oct 2026 16:49:06 -0700
Message-ID: <20261028234917.3067347-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-19-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-19-axboe@kernel.dk>
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

On 10/28/26 09:41, Jens Axboe wrote:
> @@ -356,7 +358,9 @@ flush(const char __user *str, size_t cnt, int exiti=
ng)
>  		spin_unlock(&d->lock);
>  		spin_unlock_irqrestore(&devlist_lock, flags);
>  		aoedev_downdev(d);
> +		spin_lock_irqsave(&d->lock, flags);
>  		d->flags |=3D DEVFL_TKILL;
> +		spin_unlock_irqrestore(&d->lock, flags);
>  		goto restart1;

Setting DEVFL_TKILL only after aoedev_downdev(d) returns leaves a race
window open while aoedev_downdev(d) drops d->lock and sleeps in
blk_mq_freeze_queue(d->blkq):

1. ataid_complete(), rexmit_timer(), or aoeblk_gdalloc()'s error path
   can still see !(d->flags & DEVFL_TKILL) and queue d->work during that
   window.
2. aoecmd_sleepwork() does not check DEVFL_TKILL either. If it runs
   before freedev() reaches cancel_work_sync(&d->work), it can call
   aoeblk_gdalloc() (hitting WARN_ON(d->flags & DEVFL_TKILL) if
   DEVFL_TKILL was set in the meantime) or set d->flags |=3D DEVFL_UP
   again after aoedev_downdev() cleared DEVFL_UP, letting new I/O enter
   and hanging del_gendisk() in freedev().

Instead of setting DEVFL_TKILL after aoedev_downdev(d), how about:

- Serializing flush() with a static flush_mutex so a second
  aoedev_flush() caller cannot enter pass 2 (freedev()) and pass 3
  (kfree()) on a device while the first caller is still in pass 1.
- Setting d->flags |=3D DEVFL_TKILL under d->lock before unlocking, then
  running cancel_work_sync(&d->work) before aoedev_downdev(d) (and
  keeping cancel_work_sync(&d->work) after timer_delete_sync(&d->timer)
  in freedev()).
- Checking DEVFL_TKILL at all three queue_work(aoe_wq, &d->work) sites
  (ataid_complete(), rexmit_timer(), and aoeblk_gdalloc()), as well as
  in aoecmd_sleepwork() and aoeblk_gdalloc().

Here is a replacement patch against the same baseline (checked with
checkpatch.pl and syntax-checked with Clang; not runtime-tested):

---
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
@@ -427,7 +430,8 @@ err_mempool:
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
@@ -353,10 +357,11 @@ restart1:
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
@@ -397,6 +402,7 @@ restart2:
 		kfree(doomed);
 	}
 	spin_unlock_irqrestore(&devlist_lock, flags);
+	mutex_unlock(&flush_mutex);
=20
 	return 0;
 }
