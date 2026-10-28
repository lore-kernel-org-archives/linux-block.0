Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217468;
	b=OG+7yUuZmW+OwF9H1MPSREz3GG5HFdhRnKdSCJPJ/4/lNxUssEr/YYIATZc8Ed8rET3a
	 OkJaIDPt4xw78mT+uMK6+U5ADX7Q1bGQh2YMunFdDS7OBA1VRw76sC+Qb8xCEbl7LqtEf
	 YUG5iqEy6J3CxC1FI+39cp5Ri6dYxVmjjMVQzSf3bX796l+TyyR/ncMsZVAqzPanh6v0n
	 33BqjqAgNH6ftAPCFr7HYrGmlR4PJHlAycwGemicmP5/Vba6KLXnEHarPGEMzlNzp9JUr
	 yijFZV2ma+3xoOnfcsfUhIC8TvNSQ6KRQN0KgW15sPnUg0Ov2QHVN+7CqB4OeKOIWOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=v+20CBeonlaGYQHH5jKjSLmOhgTTlz9vSMEGqyNMcEo=;
	b=uBkJH2ZpOiXlQ778RnKbyjkvIGzedcV0HSbewZt0M4YBew59Vuilng0xE2fwniVRoNn+
	 TnOm6JfwZr0ckIktSVdiNvdiY4DMpzdpZ8fM/01Wa6AQ7Qpmg1m2gX9HbHh/aNSmwjXX6
	 n+NS9u1/x3HkjvCmslp0bOFsDUFFLbvNaxbSe+AKYBEVw1JvzJh20ar3dI065PJ9XF9V8
	 wZYvoLIhuolBVANcA+YUuNgLnfm+p1lwM8cCSGfqhcHYHTQ9I1BNG0hFs8wzriJyuQzf9
	 BYuyF3J6WPVtyefam21oUeoR70Js6tk4AV/D7RkG4i7LVA3tMCr3D0UWHv/PFPEBQUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=RckRlVfb;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAF606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52AAF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=RckRlVfb
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFJ7J0DSCz1XM30j;
	Wed, 28 Oct 2026 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793217464; x=1795809465; bh=v+20C
	BeonlaGYQHH5jKjSLmOhgTTlz9vSMEGqyNMcEo=; b=RckRlVfbk3F0OQNHBi9Il
	rZYu5VYnU4d8A9473defhMCvbyK2711Cg9aayJiguDgbPztOD2hxaOs9x1BuWBnn
	DjMMOqHXW03j8AFVIiMjnDn8wdqLzA6Fe3IKMqeurKcIbURN3wJx+bqosS2sFbQ3
	qV1uBtt/0U2yzPpbtNqYJy/U3qZAx0C4WB7IgcA94CWDL/OVapBAzgXBM9+U53Lz
	GzQSBDBdj2sS/vjNsbMhVlKUGOl6Lge2EwqUoUmNL05k6bTWfRWAWSbaV5Skm/q8
	kq7qo/a03D4lWt3CWLu6uDGYvhtIzQJWhqgTtDY0fkVlPBdM8f+TY1y/olqEOkiT
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id a-f04KiZH1IV; Wed, 28 Oct 2026 19:57:44 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFJ7C5F4Dz1XM4Tl;
	Wed, 28 Oct 2026 19:57:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 48/98] nvmet-tcp: rewind the iterator after non-data records
Date: Wed, 28 Oct 2026 12:57:18 -0700
Message-ID: <20261028195731.1591331-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-49-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-49-axboe@kernel.dk>
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
>  	case TLS_RECORD_TYPE_ALERT:
> +		iov_iter_revert(&msg->msg_iter, len);
>  		tls_alert_recv(queue->sock->sk, msg, &level, &description);
...
>  		if (queue->tls_pskid) {
>  			ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
> -					&cmd->recv_msg, cmd->recv_cbuf);
> +					&cmd->recv_msg, cmd->recv_cbuf, len);

Rewinding msg_iter fixes the iterator advance, but TLS_RECORD_TYPE_ALERT
is still broken in two ways here:

1. In nvmet_tcp_try_recv_data(), cmd->recv_msg.msg_iter is an ITER_BVEC
   initialized with iov_iter_bvec(), whereas tls_alert_recv()
   (net/handshake/alert.c) unconditionally reads union member
   msg->msg_iter.kvec->iov_base. For an ITER_BVEC, iov->iov_base aliases
   bvec->bv_page (struct page *), so tls_alert_recv() reads the first
   two bytes of struct page instead of the received alert payload and
   silently ignores fatal alerts when byte 0 !=3D TLS_ALERT_LEVEL_FATAL.
   (Also, up to 2 bytes of the command's SG page were overwritten before
   iov_iter_revert().)

2. If queue->left =3D=3D 1 when a 2-byte TLS alert arrives, sock_recvmsg(=
)
   returns len =3D=3D 1, and tls_alert_recv() reads data[0] and data[1]
   without checking len >=3D 2.

tls_alert_recv() either needs to handle non-kvec iterators and len < 2
properly, or nvmet-tcp should treat any TLS alert record during live
PDU/data transfer as fatal without calling tls_alert_recv() on
cmd->recv_msg.
