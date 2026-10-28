Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217470;
	b=PB7xGWf9DxtBrdk5NVEYIHmO4wSB+bWvAd8so0TwcrcveGDXLfZ6uKLy/iAct7x2O0XB
	 LsWdsyD0vXNRIti0Ip2y9dNFnW1Sq7NgiTLGR5+9uK3XlyODai0QYXTK1fVPwqpowzpF+
	 IdKH/AKHsKMDaVc102K6cC7G5OJ/Ol+Xa2NedDdb58Pgsdv1A1wWpuT1WFwm0kOV7bXDm
	 0V6MCkIEPeGsoTKJe/g6JNjz1iGNmg+fgUE056bbFNnwWX3NXWayxdi8QuKb3fsTCHT5G
	 bbUG1Tt8nJMw+7sksh7uY4YnPLFT0wQJIuxf3YxZK43b/E9b65JEyQm/yf8Zq0hq2ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=daBMzN+zUHK+8PAEwkmNd7HTG4/diDUlIlrXzOdVlSg=;
	b=DYXH2UrLmum15G/avXVU51eXP0h7aefgZALOfur/VENvDg3SqpPH6gF8jZzH2ACNDrOj
	 EgnDDLdvn0sDPtwQHTZH/H8IST6W1EY2KvazKxTrUw1C/TKhYHHkFZOgCAcHp8Wl87TZ3
	 T9I2R5v9bF3EK+iedcUf+zjcSfTR+IGp59R1o2HOOyNtjQou7lmkgG/7rcTNmLOe2fxj2
	 tzxfUgSxYh5om2+tNqNQ7Fkr5WB1hpGOQcIkwaDgCihNtrilL8Lid2C9tNJKoPqvQcV+R
	 /KKmBmhylPjmCHIrikJ5nJ4f1oi/+Ef0uSaHIDWL+ox1REliOS9edvcWymd8KyGGAyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=eKOdiozR;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9861606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9861606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=eKOdiozR
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFJ7K3mFkz1XM4Tl;
	Wed, 28 Oct 2026 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793217465; x=1795809466; bh=daBMz
	N+zUHK+8PAEwkmNd7HTG4/diDUlIlrXzOdVlSg=; b=eKOdiozReOWVyI4/uw5za
	HLnN0T/sqy6f+DKhczHXA+CEsyCkmITaZbq4pC4eDW90IE7+QaoMcsVPAnHaWxqF
	AYKML63SALpEL48Qu+Qsea5FtkXq26ws6sDm91bfPFJ4GMpxTvMeNMOa44KfOz3c
	ouUloOL8BbYMpxVeO/xzdJe/ikJF07DTCu5P8Q4Koi7P4p/47vQdBigjVLMmNN+C
	EbustwNmkJkgsYxgh8wrLgTci14M/muq7YXstZBcYSLu8G3sihBCjahi5IcspN1P
	Wjo8NIAiC+7iQ47JM4RZ8xWmZaXGF/Fjg+WcQ3lg28XpOGPJGl8UExJrnmNAvikg
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LDp1bMwaiTT4; Wed, 28 Oct 2026 19:57:45 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFJ7D4BZkz1XM4Tn;
	Wed, 28 Oct 2026 19:57:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 76/98] nvmet: fix NULL dereference in debugfs host_traddr
Date: Wed, 28 Oct 2026 12:57:19 -0700
Message-ID: <20261028195731.1591331-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-77-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-77-axboe@kernel.dk>
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
> @@ -1849,6 +1849,9 @@ ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl =
*ctrl,
>  {
>  	if (!ctrl->ops->host_traddr)
>  		return -EOPNOTSUPP;
> +	/* They all take the address from the admin queue */
> +	if (!ctrl->sqs[0])
> +		return -ENOTCONN;
>  	return ctrl->ops->host_traddr(ctrl, traddr, traddr_len);
>  }

As the commit message notes, nothing synchronizes this check with
nvmet_sq_destroy() clearing ctrl->sqs[0] and the transport freeing the
admin queue: nvmet_tcp_host_port_addr(), nvmet_rdma_host_port_addr(),
and nvmet_fc_host_traddr() all re-read ctrl->sqs[0] unlocked and
dereference the container transport queue, leaving both a TOCTOU NULL
dereference and a use-after-free.

Instead of reaching into ctrl->sqs[0] from debugfs, why not format and
save the host transport address once in a char
host_traddr[NVMF_TRADDR_SIZE] buffer on struct nvmet_ctrl when the admin
queue connects, and have nvmet_ctrl_host_traddr() return that string?
That avoids touching the admin queue after setup altogether.
