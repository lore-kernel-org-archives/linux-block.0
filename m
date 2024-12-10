Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886223ED5E
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862218; cv=none; b=p3O6ewPv+YGURHdoZEbgGAJ6feEIKFFzWJnk8dDMXaqB5LzvIr/P3t20Gg0d/HSRjOSAFKcETYrv0bd+Ft6fVSMG2VfjI5T8nSTeRKWwP4R80Avq2K2/jeDIQ9kqeeZqb8aEDzKwesF92X1NcMQheVdRwyM1+vm9DdxRrdHHVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862218; c=relaxed/simple;
	bh=DCHahtbyJT0vs6kPWhN8RSEKoszP8P5jL7jWWXHi7to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpYr5wShSc9bTuyuXDN7h+PHJ6WDmH/94QOiq/MsI5ZtT3TVgjli2t+RjcqP8m+gLt/xNUO+jNcETNqwnP9oV6ppTUVgFBJEDsvFbobrmnqEiDG2AEVvXynbfGIW/S9H+PUxAeNJul4k8PPqY3F76VvSBfItCEEGHatIcEjyMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=5I1nIuJo; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="5I1nIuJo"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Y79D83bDwzlffky;
	Tue, 10 Dec 2024 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733862214; x=1736454215; bh=s0SYOT5pv9ueAQNbDxBOVM0I
	EIbiuO1bVXlvWRXVwLc=; b=5I1nIuJozEHvaP8p6vtnxHSL72Oqd6nQqFl30NDi
	PFa/bJd2D7tzL8CfD+PANMGglPIi6sdYXTo+1M4DFxZh85b6uCv0gox09sOtwpaz
	wAUMCjiImk3DfSldn48ZKavCP65uDVSNJ/uEiCedy2jqtCDO4LnL36Q4qIn42Iln
	R0B1pJ1+Q6hXT9nD00Sj5GP6uxdxQwWxo1Ru+VpUbpajtkiSI9VdeljkCAZ7IvsQ
	587TFV4f9sGWKeU8vA+lVFWZS4UE6ZtHBpB0cwjxqBEs4x2P86CmUkxtajqhjhc7
	tkkXAD+KKayTlJDUgGBN02QBD519p5lFt7OSxM849Rh4hQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id r4f1tufFjn7y; Tue, 10 Dec 2024 20:23:34 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Y79D51J5Yzlfl5W;
	Tue, 10 Dec 2024 20:23:32 +0000 (UTC)
Message-ID: <4ba9633b-472d-4d63-9282-bd68b79fba18@acm.org>
Date: Tue, 10 Dec 2024 12:23:31 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: get wp_offset by bdev_offset_from_zone_start
To: LongPing Wei <weilongping@oppo.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, bvanassche@google.com, dlemoal@kernel.org
References: <20241107020439.1644577-1-weilongping@oppo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241107020439.1644577-1-weilongping@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 6:04 PM, LongPing Wei wrote:
> Call bdev_offset_from_zone_start() instead of open-coding it.
> 
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Signed-off-by: LongPing Wei <weilongping@oppo.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> v4: update commit message
> ---
>   block/blk-zoned.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index af19296fa50d..77a448952bbd 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -537,7 +537,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
>   	spin_lock_init(&zwplug->lock);
>   	zwplug->flags = 0;
>   	zwplug->zone_no = zno;
> -	zwplug->wp_offset = sector & (disk->queue->limits.chunk_sectors - 1);
> +	zwplug->wp_offset = bdev_offset_from_zone_start(disk->part0, sector);
>   	bio_list_init(&zwplug->bio_list);
>   	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
>   	zwplug->disk = disk;

Hi LongPing Wei,

Since this patch has not yet been merged, how about reposting it?

Thanks,

Bart.
