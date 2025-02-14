Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E40267729
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554635; cv=none; b=qPHvQTQQ3DA9h03Edi5XxMlNHxAd+mUeJVoSeMYiziMPCezUGaABoE1JNg10h+vVVvq9ia0cRBCqgkoHUHUaGF7rlNgMaMO5i7OinzkCZ5KFkklwKif1deW+cXAF6u5yX42hjHGg6pa8o6DS+SyLHzOFd2nsbkWAhDa3SG8Qjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554635; c=relaxed/simple;
	bh=WyzSRAe6kPqQjyT27yPlzrJtQtTf9Bco6D/s3keaNoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPto66J43iTy5QJvjy6RB29+jHDQLxZnI0dlBGjFIu17f0b9mduKk7P/qPN+Dy6WWhGmvss6+66njidIERY9jMYzvxbyCljTpinl3zTtItnIozkw2ufB9g/qnSTbn603MduZIDVZyQXyaS0eKQY4L85yqweNQVf3UjQQZ3VXmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KcQZSRvV; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KcQZSRvV"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YvfPh5SZwzlgTwr;
	Fri, 14 Feb 2025 17:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1739554631; x=1742146632; bh=P+MwjqFrkGitVFE4cWn3pUUl
	PKI3Ns73lzowiPhCeIc=; b=KcQZSRvVU5o5ylQTa/vSarP1Y9vb1nlJoUDbKbuc
	/5P7UBoiddU2gMuOr/mOgzdnjPlP3WXZU6FLmtqHE+rCPQSAHuLLzYau8B0c7I5j
	E70JvSGgC2u5GpxaKPrhP3JnAbB7IQcff/5mhGPqngkqWz5FYByMusrRC2X/LeU+
	E2mw83elRFn/4SKxfqQSASHlmEcaWhDOKFOuDx209h1MyrXIS2m85aNBUO6M0dJd
	WBIcSCeQHGUDHgIP+DpW4z+clCXiV0QqhBgJpoHLudoHuU8dluvRZt7VVTitWS8l
	ddJX+n3zqkpPwi+9zQJmpuaQlIzx3L2tg4A2HnAz21tT0A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NdZ7bbyxWdpg; Fri, 14 Feb 2025 17:37:11 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YvfPc4RXrzlgTwp;
	Fri, 14 Feb 2025 17:37:08 +0000 (UTC)
Message-ID: <1a2c11c4-6f38-4bf3-9d7a-2692a1c4d75d@acm.org>
Date: Fri, 14 Feb 2025 09:37:06 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] block: make segment size limit workable for > 4K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Paul Bunyan <pbunyan@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
 Luis Chamberlain <mcgrof@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Keith Busch <kbusch@kernel.org>
References: <20250213120040.2271709-1-ming.lei@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250213120040.2271709-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/25 4:00 AM, Ming Lei wrote:
> PAGE_SIZE is applied in validating block device queue limits, this way is
                ^^^^^^^
                used?
> very fragile and is wrong:
> 
> - queue limits are read from hardware, which is often one readonly hardware
                                                             ^^^^^^^^
                                                             read-only?
> @@ -1163,6 +1163,8 @@ static inline bool bdev_is_partition(struct block_device *bdev)
>   enum blk_default_limits {
>   	BLK_MAX_SEGMENTS	= 128,
>   	BLK_SAFE_MAX_SECTORS	= 255,
> +	/* use minimized PAGE_SIZE as min segment size hint */
> +	BLK_MIN_SEGMENT_SIZE	= 4096,
>   	BLK_MAX_SEGMENT_SIZE	= 65536,
>   	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
>   };

The above comment could be made more clear, e.g. "Use 4 KiB as the
smallest supported DMA segment size limit instead of PAGE_SIZE. This is
important if the page size is larger than 4 KiB since the maximum DMA
segment size for some storage controllers (e.g. eMMC) is 4 KiB."

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
