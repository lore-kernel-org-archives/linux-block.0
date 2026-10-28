Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217471;
	b=N15N32wm6mWJNMvvR0X3wQKYykTlG0dKz7w1l1UKS0y8nYKbaY/shNxHAT+cfxndAlyU
	 La+Agt3dmB6Pz/mxd8h6Llnt5aqhCqjbFIbt9gVKXHA6y+rXXm7H+GRoXoUlMWFKh6c4t
	 rtPCTw8BeKjtHpVx94iVQ9Crw4fJu/HBiiPkleAulQeEM5QLidfCTewYiwjAmC72CcC9E
	 Cr7Orvyf3mFdCZVpOEVUMbHlF9DPEP0sw/MxDzJoazwQ6S0Om+wIsYO4FEaIONiQKvXo9
	 ba+l06Q1K+cprpHQ0jd/pDyHXgQ9Bq9Ivx2fpUbYDDmIUEnEXsi5wx73BDTWMTqSDyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=G86X/UNH9kFIKPY//me5UNiYS/uKPYt/ZDm6ONDpOoE=;
	b=hCPOXbvXOlH1sfn8Uoz4EajG0EVoiDLkvX+Pj0BSVSngF0Iu6cCKw6jhqR4P+szwjJ/I
	 B0Yy/NHeNBze9eE7Lz08HxYy9Gzhm3S5s+ZCGp6gLid/jEeU0O31uJmabVFsP+niNJDE8
	 VXAKr3gaKngCuuJhxT9PtoP3qG4YpUAMtn4ImA5NN+0fGpkY3TzP/gwxhthky9tiyRgR+
	 kAb7yTnWwPjeTLxJKxtCxptci1G1r5ktNr15jELrBsVddklUjQ0oosp5BxAvI3g0tSUSw
	 qTIp6Mmi4/u+uUL3Q0fRuxWU6Fo2TWJPiAzGzsgPjenct6ZT2ZiwGBKgOEexdO/zqFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=vnc+5RQw;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD077606A324
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD077606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=vnc+5RQw
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFJ7L1vr7z1XM4Tn;
	Wed, 28 Oct 2026 19:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793217466; x=1795809467; bh=G86X/
	UNH9kFIKPY//me5UNiYS/uKPYt/ZDm6ONDpOoE=; b=vnc+5RQw1Y4W3X4CjD4qy
	pZUp8t7VDbUNJT4xFmWUUbHtdJGd7zFhf2e177/PaZuqqXtc6dUMLLxpVw0ZR9Uy
	mBajHmHpn+PZXOzTmhGxbemOCZ0adLfVGtspLn2+zpZTbcIJ/m1lgojUZk35nIHI
	Y1WEFxRpdBzqIfF1jNsDVMOe+guxbLE7CehohH8l9QCr9f2rnHQptgswZgg90ICg
	GCL/aLo7kt4M/optwR5YuaFsLWR0v7QBXbsPAZYfI+zTZk653DILaPG2FTqRJp5t
	j3aa7mC2X/FWMr1V3EwO937Shr4KPWkL3vYJkE48arRL2zcymRmJS308+8U9n8LI
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eFZ0Ss-arjBM; Wed, 28 Oct 2026 19:57:46 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFJ7F2dsjz1XM30n;
	Wed, 28 Oct 2026 19:57:45 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 90/98] nvmet-rdma: disable interrupts under rsp_wr_wait_lock
Date: Wed, 28 Oct 2026 12:57:20 -0700
Message-ID: <20261028195731.1591331-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-91-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-91-axboe@kernel.dk>
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

On 10/28/26 09:42, Jens Axboe wrote:
> -		spin_unlock(&queue->rsp_wr_wait_lock);
> +		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
>  		ret =3D nvmet_rdma_execute_command(rsp);
> -		spin_lock(&queue->rsp_wr_wait_lock);
> +		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);

Using spin_lock_irqsave() fixes the rsp_wr_wait_lock deadlock itself,
but when nvmet_rdma_process_wr_wait_list() is reached from a bio end_io
callback in hardirq or softirq context (via nvmet_req_complete() ->
nvmet_rdma_queue_response() -> failed ib_post_send() ->
nvmet_rdma_release_rsp()), spin_unlock_irqrestore() restores that
hardirq/softirq context and calls nvmet_rdma_execute_command(rsp) ->
rsp->req.execute(&rsp->req).

The nvmet ->execute() handlers assume process context:
- nvmet_bdev_execute_rw() allocates bios with GFP_KERNEL and calls
  submit_bio() -> submit_bio_noacct(), which hits might_sleep() and
  manipulates current->bio_list without interrupt synchronization.
- Admin, fabrics, auth, and PR handlers perform GFP_KERNEL allocations
  and take mutexes / rwsems.

Shouldn't rsp_wr_wait_list processing be deferred to a work_struct when
!in_task() (or whenever nvmet_rdma_release_rsp() is called from atomic
context)?
