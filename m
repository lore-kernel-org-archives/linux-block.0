Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7573A1DD
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034075; cv=none; b=P3MXhPzql3gKRz4Fcx7x0TnQnbgKLY9mEHQOVbP+4RE8pQgmUp8ZAl7hdeXkOyphH5zHyk/smSOlZUvqfl5GmXfwK6HzKwzKbB5SFS4QU96uym9bs7j/zwqJwMY4jjLiO+wgNyeVp11WaaMcHcsCBQxfy1R4KfO8N6Nls1VkXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034075; c=relaxed/simple;
	bh=BrrXHbOSXDh63teeiqeae+Af53OWWaTWwF9nUIWy12k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cn3/pjYg8mycjNYidjfMMBScCk6h5nISwkFFRo4MH9uDxLvPtuLreypOB9n8TYyHPj8ei5LkeASGZg+pR4r+9O7tcXgs9NlQAwZb87f3PFouy1VVf93o5NPZPvjRbaYre9lfniAuE6FlAvnvIheLv/GoVQX6LevIHwd9IaZqOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mQhM4vej; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mQhM4vej"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V0psH5K3qzlgVnF;
	Thu, 21 Mar 2024 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711034065; x=1713626066; bh=d35xmSAYJbXKIuDNltVbTuJN
	jfh6Lvk5FYE1ru9SH1U=; b=mQhM4vejm6zP3zjXOt5RDASqrqsXPsH3vYKGEX8e
	QsdT8q/RFmjg/Hx9m+NWnQteUTOcLadbWBuUgEii8zbTvwUMv/rMDT8gEO5bT51s
	0MDx2OW5GMxhUfZ0y69BJWRsWlxpC9Ap2roPZE0zBM88yPrY/RtJCgy1YJy4vXjL
	u5A/QE/teCpKGNfmx7HRxo3MPJwP1XKnKFrox7bxFGlaOVrJvTlfXJtwbEZXWXht
	c5paUuZ/BMQEAFIyBJDJHimu+nR2g9TYxmBqf3KbgSBmkMWV0Fdl39Kg98JgXoGU
	qrfumkBOuh2bKmEFMwVHiNbMpJuj/cBnUqud1rf8/l+1rQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JdmysMsFmNQ8; Thu, 21 Mar 2024 15:14:25 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V0psD5v07zlgTGW;
	Thu, 21 Mar 2024 15:14:24 +0000 (UTC)
Message-ID: <36a990dd-589c-4da8-a41b-783a834c3797@acm.org>
Date: Thu, 21 Mar 2024 08:14:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fail unaligned bio from submit_bio_noacct()
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
References: <20240321131634.1009972-1-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240321131634.1009972-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 06:16, Ming Lei wrote:
> +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> +{
> +	unsigned int bs = q->limits.logical_block_size;
> +	unsigned int size = bio->bi_iter.bi_size;
> +
> +	if (size & (bs - 1))
> +		return false;
> +
> +	if (size && ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
> +		return false;
Why "size &&"? It doesn't harm to reject unaligned bios if size == 0 and
it will reduce the number of if-tests in the hot path.

Why to shift bio->bi_iter.bi_sector left instead of shifting (bs - 1)
right?

Thanks,

Bart.
