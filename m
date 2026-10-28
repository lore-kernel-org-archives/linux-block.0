Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217472;
	b=Glg+5eYUleM2fOZubGmBobhWN9IwoKAY/hAS9H3ulMzr0oSpoS3DeMRY0MMMCkc+TqWR
	 GnH4OAvABgTccNJcI6SmwENtbT9n5yUF0qUoQ5JXLweLdGJ+s7uI9hRj26PRyQYq+2gcJ
	 B3bw5waDGaTwUKPYrTeM6sufbjOInrmjGSLwaXfHd+UpgevYFftnpFgIMsJnlgI7MQGLW
	 VunT4FrxFD7QHdUdL4/2LNU32zfjkBtCfFtqGQQL6kEEsV2yeLvwuebDENTgcEoqTB5oK
	 cpJm5ERQ15TpDWJ91UGSoAvcuZh6IcOIR1eQxA2I4HD/TrLnR/Py246/RuOCrXoETRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=M6cNzSsFGc68s8imiGraTSFdWWQHIrxazO0CqpnS+mo=;
	b=FY0zpPl8auJA5jZiLZ5NDEnTo6s5yBB+AW1z8L7uB9mEV9Sy0dG5kK+bM2WhS9UU7D5H
	 koOAXfW5hSO4TO9GGVoMijqScG6JMXnk433ytu4smRvXg+ozqguBdPRtxlharAw+qjToi
	 27jBuUMVgrOOZOC1BT9sMu0smnGg+Zi7T+A+sRVsM4ycRh8uBYViHY4frbUsE9e8tBvlE
	 RrsJyJTFM2stl5a8zOgbngTcoPNVoa5nx+t3blwjg+L8apqt8N+DVTO6syFAF4UFFbWqT
	 3ViNsjn48R47xxq0wAGwOVDCibGeqX7WUi7dlQdeUYfK53sGE/1y1/xdbkdSSBsIqxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=XFJMc1Cm;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94DF606A32A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E94DF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=XFJMc1Cm
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFJ7M55Cxz1XM30h;
	Wed, 28 Oct 2026 19:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793217466; x=1795809467; bh=M6cNz
	SsFGc68s8imiGraTSFdWWQHIrxazO0CqpnS+mo=; b=XFJMc1CmXKsyEAM48h2Dg
	FhZU8Irh21CiTWyAzFUmj6cS7XYoiT2hVZZ85Zk9HoMgqm4ps+YKOMtiu55BPreQ
	CsKlkjtcLsY+Cj329fWJ5IMA6L0tEy3MVjCz407CVBifdiAkWc0fsimZ7E63k+HH
	73iDCSEI0m9D4lFMSE9Sl27yAZH47UmFCmw9kh9f+H5JuppyFIk85dGI7hAikbmq
	X4vWbCtg6xE5dfXqyDmHS5JlWhDM9oQ+TSTV6Us8ZtLQjKj1TV3GC58YFyqG7XGN
	WWl6SK1ynSG8sKvALuycCI+P5dv/e1Ardya9daizdjkiWa37riGJHUIp6K1ypp3p
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8UXbK1IOd4OJ; Wed, 28 Oct 2026 19:57:46 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFJ7G1t1cz1XM5kD;
	Wed, 28 Oct 2026 19:57:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 97/98] nvmet-rdma: hold sq->ref to post a T10-PI Read's SEND
Date: Wed, 28 Oct 2026 12:57:21 -0700
Message-ID: <20261028195731.1591331-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-98-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-98-axboe@kernel.dk>
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
> +	if (unlikely(!percpu_ref_tryget_live(&queue->nvme_sq.ref))) {
> +		nvmet_rdma_release_rsp(rsp);
> +		return;
> +	}
> +
>  	if (unlikely(ib_post_send(cm_id->qp, &rsp->send_wr, NULL))) {
>  		pr_err("sending cmd response failed\n");
>  		nvmet_rdma_release_rsp(rsp);
>  	}
> +
> +	percpu_ref_put(&queue->nvme_sq.ref);

In nvmet_rdma_free_queue(), nvmet_sq_destroy(&queue->nvme_sq) calls
percpu_ref_exit(&sq->ref) before nvmet_rdma_destroy_queue_ib() calls
ib_drain_qp(queue->qp). Because nvmet_req_complete() still drops sq->ref
immediately after posting &rsp->write_cqe, nvmet_sq_destroy() can reach
percpu_ref_exit(&queue->nvme_sq.ref) while the T10-PI RDMA WRITE is in
flight, and nvmet_rdma_write_data_done() will then call
percpu_ref_tryget_live() concurrently with or after percpu_ref_exit().

percpu_ref_tryget_live() is documented as safe only between
percpu_ref_init() and percpu_ref_exit(), and __percpu_ref_exit() /
percpu_ref_exit() perform unmarked writes to ref->percpu_count_ptr that
race under KCSAN with percpu_ref_tryget_live_rcu()'s unmarked read of
ref->percpu_count_ptr. (Note: patch 96/98 has the same KCSAN race and
should also be squashed into patch 69/98 so commits 69..95 do not leave
nvmet_sq_fatal_error() accessing sq->ctrl without sq->ref.)

Here in nvmet_rdma_write_data_done(), we don't need tryget_live() at
all: nvmet_rdma_queue_response() runs while the request's own sq->ref is
still held, so it can call percpu_ref_get(&rsp->queue->nvme_sq.ref)
before posting &rsp->write_cqe (putting it on synchronous ib_post_send()
failure and at the end of nvmet_rdma_write_data_done()). That keeps
sq->ref live across the entire T10-PI RDMA WRITE -> SEND sequence so
nvmet_sq_destroy() waits cleanly before percpu_ref_exit().
