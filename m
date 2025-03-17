Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3AE1A4F21;
	Mon, 17 Mar 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233090; cv=none; b=a1yXllPXlNFTHBC3bzRi4fiZ6Y8M5/YGPWq+dKDQ/g2lYVvcWkdVIsyXqrq9D9cU9NO5V3jvNSiVTXu6urJhH2fjCilnPKzYdvBpt5FZRc6ukak+MIFmGvElYUTi50j52rV0PdzHlralMTPptc9JVV69kAppVr1KWbIc7xZJv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233090; c=relaxed/simple;
	bh=uMyIM2a3hCj4fo5uDuORTOP5YfPaHIBtJM+ilAprrzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxZxiBv4fAOh12F8rlBnmI/JrZOW514Ui7tN1AHat1wFJaL0/cuvT2iVdmrqncVuw4S8WjEqZ+IQSytyXnaXuGd8FWnaSwFBgTYbAMG/kKja80eHZsi0pNSvNjiVkSLwwN2YHekW11GB0ufyVebqT0snHAu5e3YDyve8X0Vn0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XF9yy9wD; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XF9yy9wD"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZGhyL1jgFzm1HbZ;
	Mon, 17 Mar 2025 17:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1742233081; x=1744825082; bh=bpd9/sYn2lGjFRExHt31Ceh7
	1iSTR4WLZ5wIQVQq7tM=; b=XF9yy9wDUg7VvISLmpf1rkx8ynVvvTUzi/Ocsg7T
	J+HhoCVq112cJVLKCET2O5i1pIek9PFQHd66FeBl6jdcZnopjN4+wCNFZBAD9pOf
	uF2AFtQDCa/CpZmekUlh7WOJNE6Hx3AVnpF/T3Xt/uJh1ITjUdcMxoDO1H64Q7t6
	aNzH7mDABd1lIZVLY+xwjMtCk3HJOgtzZQTTJ3tH7pTYFgi9bTKj8BOIQdW3hWF8
	g84HSDtwjnAo2aWtBKJuzzScLySRoDg7L+aFWP4x2BIIHw5ZeblPETUN3PgO5tgH
	KYfOp3b4ZeTEWZz+eFbf5Gtd1YgLsC5bDSXsmaWRarv8Rw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cy3Gewyb3M6o; Mon, 17 Mar 2025 17:38:01 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZGhyG2fwGzm1HbX;
	Mon, 17 Mar 2025 17:37:57 +0000 (UTC)
Message-ID: <f46f0286-8052-4a29-9d89-376bf9b48d8a@acm.org>
Date: Mon, 17 Mar 2025 10:37:55 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] block: Make request_queue lockdep splats show up
 earlier
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>
References: <20250317171156.2954-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250317171156.2954-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/17/25 10:11 AM, Thomas Hellstr=C3=B6m wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d6c4fa3943b5..4aa439309406 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -455,6 +455,12 @@ struct request_queue *blk_alloc_queue(struct queue=
_limits *lim, int node_id)
>   	lockdep_init_map(&q->q_lockdep_map, "&q->q_usage_counter(queue)",
>   			 &q->q_lock_cls_key, 0);
>  =20
> +	/* Prime io_lockdep_map as reclaim tainted */
> +	fs_reclaim_acquire(GFP_KERNEL);
> +	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> +	rwsem_release(&q->io_lockdep_map, _RET_IP_);
> +	fs_reclaim_release(GFP_KERNEL);
> +
>   	q->nr_requests =3D BLKDEV_DEFAULT_RQ;
>  =20
>   	return q;

Hmm ... my understanding is that it is fine if FS code calls block layer
code but also that block layer code never should call FS code.

Thanks,

Bart.
