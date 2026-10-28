Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217464;
	b=BnYMfPsAgW2nsJnkinOOe3anHx9d46zT2qcpG9o1R0GbzFI6JchxhvzdIvC0wuFPN+PN
	 6z/xXCL9yf9T1Y1YBQ/LKBkGllYlZc+T+V5FPPAHEZCF1whR9IJFCqOV/Uqh7c0qh+9HI
	 9gvZgBfhioXp92TinE9dV7QnnaEPuipbqan1TsB/wZ2yk1u6dvszOzoikEEnklAITP75S
	 ZLBpLbSaQP9IHpcXIis5UbGUSfTN8/gKumYD3u/ST0ecYhgPaD2uZcCJAOqJhX59Ck/td
	 PBzE0B3VIdire6OFtOiOeBJ/2nQz7XVlZEJ4YAUdMH/bfmExgphxkdVAIT6mHCPWNSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=GBPQJGMr8MOVIs/+I4YvBSSXkYjGHa6zkMOaP2XIuTs=;
	b=W7oXZAD2JWyK+O+AJBn2OojFWdPHDbFTJSDcZjmwBsiL4ldRpygG3fAmpvUXFOP5T+Of
	 jMTCFXoonH7JlWCiCrr/VTzxy6bgp9UB181jQ/vgIlNxdVp5nTmVsNJDyM3rLAdaqgLCI
	 L6hV4GlPZ6AJPRaSP6Y9TCmGtNd8gHvHTnNsx5b7ZzNEw98WS0G3sQH6VdWd2slNrVXwY
	 X1gmSKXANBnQFk7AjekkjYCtx/c3HfSrVrhHiTWp46P+wBlV5BgjRtJmVr+uMk+FpJImz
	 8DInYu6RzUw8OV1k5v94vvtmq8HfNNCTWCmDi8f4lbnRPHOVK0r0dm83F9c0vkJPnmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=p+v6v3jO;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17450606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17450606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=p+v6v3jO
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFJ7C4NNVz1XM30n;
	Wed, 28 Oct 2026 19:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793217461; x=1795809462; bh=GBPQJ
	GMr8MOVIs/+I4YvBSSXkYjGHa6zkMOaP2XIuTs=; b=p+v6v3jO3npBFXr41D9oi
	+MZaM1tHJ8qUVaXvyEQvvJbdwfV1+37XkpGkBqk6dNHqZ+mQJHBJvUWe0kmSRs8I
	B4ybEqPDcZwyGlbQBUwVwYLdvgiKxFsN9LT0CpZTx1bilTT4kCMlFOsCvgv5Ptnj
	IyRz7zI8Z7w7gT7dvB77HkX2TiUV2WtuqEABCkaTDfdS96kXsbcnlR2ORuLPnnUi
	1EDOfcl/0p98Ctjbj3LJGfjna9Mbag5VtpfihX8yblDsXpQjFj5bUfAs0uzVEmeb
	qhKWZB47ykV4UiHi90pZpcXQFqNbOBxgaynWixPMPNr3HRbBMRzrupyXNmPc51QH
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 73K0WWOaZjI2; Wed, 28 Oct 2026 19:57:41 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFJ785XxYz1XM4Tl;
	Wed, 28 Oct 2026 19:57:40 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 18/98] aoe: don't free a device with its work queued
Date: Wed, 28 Oct 2026 12:57:13 -0700
Message-ID: <20261028195731.1591331-1-bvanassche@acm.org>
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

1. An incoming ATA IDENTIFY reply processed by ataid_complete() during
   that window still sees !(d->flags & DEVFL_TKILL), sets DEVFL_NEWSIZE
   (or DEVFL_GDALLOC), and queues d->work.
2. aoecmd_sleepwork() does not check DEVFL_TKILL either. If it runs
   before freedev() reaches cancel_work_sync(&d->work), it calls
   aoeblk_gdalloc() or sets d->flags |=3D DEVFL_UP again after
   aoedev_downdev() cleared DEVFL_UP, allowing new requests to be queued
   onto d and hanging del_gendisk() in freedev().

Should d->flags |=3D DEVFL_TKILL be set under d->lock before unlocking an=
d
calling aoedev_downdev(d) (which also prevents two concurrent
aoedev_flush() callers from running aoedev_downdev() on the same
device), and should aoecmd_sleepwork() bail out if DEVFL_TKILL is set in
case d->work was queued between flush_workqueue(aoe_wq) and acquiring
d->lock?
