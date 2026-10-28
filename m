Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231377;
	b=YzN8c18YY+YXVLFZzmx1XRjQA+SbUynaW3cS36O7ASeCg+MmUu5Ex/6/IwZUgBvCnOt0
	 vYCh1nmCFRcKxHo0tGs3VooVatzReonH0nePVunqN/WPUoFRSrDj3AlYkJzMnetpgTfw1
	 FDfZVS+sbSi1X93b6C7qWIkn+i1VY0nAAiBJ5+cI2hpys37qE3ZyNZAtjXb3RPRRm+/PS
	 y8AkoeAdVYOL4FAX6GB2HrFsKrz5hQ5Q2HIY2Z4o1sNh7t0/msVnit6yNQyTxtqNaRsYd
	 B7R/TA9w1ZeWdsGGuHR6B6hrCIZxsSGyimouERH/XsSSTXhWo6UxEOjpkzRJJr/vWYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=IOvxtlqRVjsBhmf6OO8K8WDSJ+NVUTKDQfwObTGv6so=;
	b=JmhyD6Papauyxhg+/J41o9dxIrk7hcNCKz1tD5qd4hGuiZqr5DmGOdWCMJsGUmEMnNDE
	 0Ar9++6jr1YWKaFVcaFejL32awwWhgXSsRrzlcNrpzJBDwJNLHQlAuEayvIFnOLcpi59N
	 IjsKXgI/+xQCe2bIfflqPDsVRv+8PnEGQkXdNwzc5LYAsqWsbeoI4xcDJsjedbDAorKin
	 yX8ilpg1NHqbnqEgEU4uEaBAEDOIDzh1PeQ2iZqZmAzq3c1JjS0waOJb2GKdzi3g4Jyf/
	 OnstIv6REQEVHgKM3M7h4QYWFcyky8WeYIyCwUOUwldncQJYGtxF/LvpQaqqln1iwaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=s4HzoqVi;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD534606A323
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD534606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=s4HzoqVi
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPGm4S4lzlfvpd;
	Wed, 28 Oct 2026 23:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793231373; x=1795823374; bh=IOvxt
	lqRVjsBhmf6OO8K8WDSJ+NVUTKDQfwObTGv6so=; b=s4HzoqViUiwy6jOvU3VAQ
	7qargKDOGtStbNUqXZTAUGnkuZAJAv+D4f9vK0X7bW+im72yBAzX6lt+rjy5tNMr
	1mB3RjbGFoYkljn0drJnrw8Q9RiPyROP0IBlHw9S1lWc7kwuDGmupJLpa2U9jUJh
	YEkW51ScGBkGSb15hvEv0r9REg1epbLqtpczuHR/APci7C9aUCXREXtBfri/vyQk
	EIqTG4vXZSFt/UM/Ghj6wAgK9e7hcfoPEoaODP8sO4UR0ED3MS9ilXz+3y1awVjR
	E8wwjmfC9oohs3KzX2H/iIemuXh8tSzgNRrS8U1elCN4+ST0jOfsvzVFspTCGtom
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DqZ-QL3pxw68; Wed, 28 Oct 2026 23:49:33 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPGg0hMfzlfvpr;
	Wed, 28 Oct 2026 23:49:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 28/98] blk-iocost: check again that the disk is alive
Date: Wed, 28 Oct 2026 16:49:09 -0700
Message-ID: <20261028234917.3067347-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-29-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-29-axboe@kernel.dk>
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
> @@ -3322,6 +3322,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_=
file *of, char *input,
> =20
>  	body =3D ctx.body;
>  	disk =3D ctx.bdev->bd_disk;
> +	/* It may have gone while the mutex was not held */
> +	if (!disk_live(disk)) {
> +		ret =3D -ENODEV;
> +		goto close_bdev;
> +	}

Look at the close_bdev unwind path in ioc_qos_write():

close_bdev:
	q =3D ctx.bdev->bd_queue;
	blkg_conf_close_bdev(&ctx);
	blk_mq_unfreeze_queue(q, memflags);

blkg_conf_close_bdev(&ctx) unlocks q->rq_qos_mutex and calls
blkdev_put_no_open(ctx.bdev). When !disk_live(disk) is true because
del_gendisk() and put_disk() ran while rq_qos_mutex was dropped,
ctx.bdev can hold the last reference to the bdev/gendisk. Calling
blkg_conf_close_bdev(&ctx) before blk_mq_unfreeze_queue(q, memflags)
will then run disk_release() -> blk_put_queue(q) and free q while it is
still frozen, followed by a use-after-free in blk_mq_unfreeze_queue().

Since __blk_mq_unfreeze_queue() acquires q->mq_freeze_lock (which nests
outside q->rq_qos_mutex), close_bdev should unlock q->rq_qos_mutex, call
blk_mq_unfreeze_queue(q, memflags) while ctx.bdev still pins the disk
and queue, and only then call blkdev_put_no_open(ctx.bdev).

Here is a replacement patch (checked with checkpatch.pl and
syntax-checked with Clang; not runtime-tested):

---
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7b5d865d8c14..df713bbc790b 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3322,6 +3322,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_fi=
le *of, char *input,
=20
 	body =3D ctx.body;
 	disk =3D ctx.bdev->bd_disk;
+	/* It may have gone while the mutex was not held */
+	if (!disk_live(disk)) {
+		ret =3D -ENODEV;
+		goto close_bdev;
+	}
 	if (!queue_is_mq(disk->queue)) {
 		ret =3D -EOPNOTSUPP;
 		goto close_bdev;
@@ -3437,8 +3442,9 @@ static ssize_t ioc_qos_write(struct kernfs_open_fil=
e *of, char *input,
=20
 close_bdev:
 	q =3D ctx.bdev->bd_queue;
-	blkg_conf_close_bdev(&ctx);
+	mutex_unlock(&q->rq_qos_mutex);
 	blk_mq_unfreeze_queue(q, memflags);
+	blkdev_put_no_open(ctx.bdev);
 	return ret ?: nbytes;
=20
 einval:
