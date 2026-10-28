Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217467;
	b=vCneMuCNNkrxV3fhPwAhU/g1wZ3zG8XFPJyEuaCHhj8PpDN7gbBhsPjyZVqvEA/M9dvF
	 CZKTciypjNVwcfGLAxKXxmzkMuQZhuBNSuM31ByqrMLCCfMJAsvHQh+CmC/WBEgmfDvUf
	 hmI0ev4ptUmcFeTxXEqRD3LAA1m/IhWZh6VbK1mKNMQD4PuNZQXBe73aYHqEHpjPIQ6Za
	 7HNPxB4c7o21sYgvNlDYZMZ6pWFNJT5xsrolK2MOjO+rRuszYflfH6nZw8dRXi74GNkQQ
	 woSMdAxXIonp7zS+gf6xAyxBd5IhClIQ31QiZWJ+GooLf72j4EWTBOMKz8nOgUlLqaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=offDEXI5REUzf6x9U5Vcrz23TrhcK45+EwJ7w+MOIBU=;
	b=xYaDtbBfog/lE+Dr6Oibj6EFcnRi75N9xnyFQxt+196nCwjOoLrhAuSxSq3M2mEd5Eib
	 TwKf2m4XIewpAs8OzVyM65+oeLFfUiVSvYt/bPhVBuEFNqv5yb3jt88dXvD0/1jA/D+vC
	 36sF4YD35Qr3gnVUC5d+WwcfiyzuufL/TyC+K1Q+XAwK/bxqsNyZoPSvs+EcXjjNyBT1J
	 ZZ2YrEgsqWbCYX21oQf1VgFp1WrFi//6AJ2hq5qtfyFnXMCO/vTN1b9FLfz7AR7rTePWv
	 wR0UXcRjEpy2bftIqTckxF3q3wmqfP9VfRoHuxYx35jZEbNCJFi39aUriFhnqI4gjOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=MMB1XIpo;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6A606A321
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AF6A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=MMB1XIpo
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFJ7G2r7Wz1XM30w;
	Wed, 28 Oct 2026 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793217463; x=1795809464; bh=offDE
	XI5REUzf6x9U5Vcrz23TrhcK45+EwJ7w+MOIBU=; b=MMB1XIpoUyxY+JhHPPdDU
	uyjG+IwAHv3vxzaqyLhvppWtHVD0xNlIosyXHjE+EfN4fSkY6vgd2aATeVYkNfKF
	ZbUyytppWp8f7n6oqjX94WoWZEww+Waz9Fta5jf2WTbzUwm3xkzOIQuhRxqxTrf+
	7Zk/ceuOEtAsG60o5CKEanrCy19/ON62mX9aCVsHgYtlaYYIL1HeZNnr85JWs65F
	ceBMkW9Od1Y7K/kHm7n7vyZLbgfR2vR4VB/x6InnoD944dFlshiQW947CbS1D4Ty
	Qu+nxfA+MY+V8Aj2OFfGuuS1IGhVC/x/sNNkieQ7eNt80Bv+AGd4PWehNXx6sC/T
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eYyRYFNk8riy; Wed, 28 Oct 2026 19:57:43 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFJ7B2NCtz1XM30h;
	Wed, 28 Oct 2026 19:57:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 28/98] blk-iocost: check again that the disk is alive
Date: Wed, 28 Oct 2026 12:57:16 -0700
Message-ID: <20261028195731.1591331-4-bvanassche@acm.org>
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
del_gendisk() (and potentially put_disk()) ran while rq_qos_mutex was
dropped, ctx.bdev may hold the final reference to the bdev/gendisk.
blkdev_put_no_open(ctx.bdev) will then run disk_release() ->
blk_put_queue(q) and free q while it is still frozen, before the next
line calls blk_mq_unfreeze_queue(q, memflags) on the freed queue.

q->rq_qos_mutex needs to be unlocked and blk_mq_unfreeze_queue(q,
memflags) called before blkdev_put_no_open(ctx.bdev) drops the bdev
reference.
