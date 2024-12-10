Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61E23ED5E;
	Tue, 10 Dec 2024 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862133; cv=none; b=DdGJHHB4pf0OyEeT+reQn4REAxyFLknSjcQ91EpJzMxS9V1E1FbfGhDUOETBTUYV+Y+mW1Kg6bnfsXeVy0vzSQULiF7+wqTLTjh0RTrfjuDLaht+tZ5VoaG+Zee8si7Ew/jgiE2HUBDYsC4d4i0yW97a9mlSZB+w1FSZhNz8F1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862133; c=relaxed/simple;
	bh=6QRlDVT8aAvhb9sv6+l39Em9VkkXoSHVkNDik7ogRdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0NqlAwdMeYRyagE6Donh41NfHhwmnkY5H449B2e5tXuq98yqZ6C/FXJY6X1no0OD6P0eiJxYM1a/MUz5Km1zgSjbMJTveeiFOasG+rtztkpnwL9MSvOGIG4qkxTN9mVFWwctOYKXUmJ6iIo/OcvC8PG1sUo/I7NwXSL4QdiDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nKGMjNBq; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nKGMjNBq"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Y79BW36MVzlffky;
	Tue, 10 Dec 2024 20:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733862129; x=1736454130; bh=lbBlmFrFypE/E4umxPXn1kWk
	zm2D7qTPxypNvNpiZn8=; b=nKGMjNBqnpBRURL735CgULKSmDr34vl4MUr96Ofo
	cwRu2HlWG4CcMRGoBsSj5f/PyqzxEibOIfyLnYLj82DoEQsnkG3ooVwcQrNQGFFV
	cdH07JLChMdAxYJUG5QBma1yabhkOuQI48rHVygnmdTqOZYCIypjLXmrvqZhmyLr
	vCBkz6H6PynS06XtvtR5o6SJRjfpDIZGFlGOD6fhZGOp5P9TIYgcUj6uL5ZHdzK4
	qrweTe6NAACnuGJ9ACcaaUmP0KJQs/O0NbTLHgsVGpcfhQa3mSB6JhiM0OZRBfCj
	bbF7/u8PcynsHOHrYbhTGrW5wPAqOsSCswzhA5idwF24Eg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id efo6L0c1psa2; Tue, 10 Dec 2024 20:22:09 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Y79BS48ybzlfl5W;
	Tue, 10 Dec 2024 20:22:08 +0000 (UTC)
Message-ID: <ad413055-1f98-4f72-af03-80a07d261de2@acm.org>
Date: Tue, 10 Dec 2024 12:22:07 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] THE INITIAL VALUE OF wp_offset MAY BE NOT THE POWER OF 2
To: Atharva Tiwari <evepolonium@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241210062340.2386-1-evepolonium@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241210062340.2386-1-evepolonium@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 10:23 PM, Atharva Tiwari wrote:
> @@ -530,7 +531,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
>   	spin_lock_init(&zwplug->lock);
>   	zwplug->flags = 0;
>   	zwplug->zone_no = zno;
> -	zwplug->wp_offset = sector & (disk->queue->limits.chunk_sectors - 1);
> +	zwplug->wp_offset = bdev_offset_from_zone_start(disk->part0, sector);
>   	bio_list_init(&zwplug->bio_list);
>   	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
>   	zwplug->disk = disk;

The above looks like a duplicate of this patch:
https://lore.kernel.org/linux-block/20241107020439.1644577-1-weilongping@oppo.com/
