Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E020D51A
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935259; cv=none; b=ZiJ4rVoZV+jqFVHz3cmEHyQSCSSqga70N7hlEHhMF2wzAtHsS/6jFkUlK8dz+3nwFQTAmU86QKJPexXkZ62EO70YiGQhBgizR9kNZK1ie2qYAOCP/WSsbniOjWZiYFwGssdJZWjSKe+WFxkCiYFF0clKrotKiUUso/x2EuSdv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935259; c=relaxed/simple;
	bh=1MMggs4NNVjjuV0dZBj5UCuhZye512gF+BtHDzWK66o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uq7DlUxZ31Q6PGsBXdxTg3o9nJDkqRI2rlYuBfcI4btDboBoF1nDaBHPUXqsIvvkpBQm28au0hwCbbnfR51fDVlc8mxmvjAZsEqF4Eu+51P451giCE0D6+Xse+jX1PGbx77yFtHdzWuTE/HGgLDOPd2eRDa35fXp3xxuu+rF1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=swaLOcBn; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="swaLOcBn"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XkLmM1LLBz6CmM6M;
	Wed,  6 Nov 2024 23:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730935248; x=1733527249; bh=xXESywgTOMAVL0zxzY1xayQf
	zSWUkWlVKZre/gq4u0I=; b=swaLOcBnDHC44FMMR3quVTWy4NqPrGwvy30cVycc
	JKFqC2F/kcyKoDylqLu5wQGV6Jf71bxxIdF8yhbqkT+EkbYqrdabEgaeOtw3P4Tb
	O4PW0UUZWhAiKiqnKmwUH/j+NMB2RUmWBwMeBY/yOvkQe2AwH9O5sBiV8Y66Mb5K
	n/PLexvwu4gCtECMasnE+NT971E5+UCpVqJQ61O8lOn37+UdihrKbh6wmSpdFTX8
	s9x300v6XCF+7ENnVKmaUfWt8m2qwGY8QXVyk4l6Aeu1QiREg86SSeHF88h2nAXk
	GgaMJJGh5JGyi/juujjgrm9rZEIDVscLB4R7aB1239RbbQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id t23arJhfAKqu; Wed,  6 Nov 2024 23:20:48 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XkLmH2hysz6Cnk9X;
	Wed,  6 Nov 2024 23:20:46 +0000 (UTC)
Message-ID: <f199b1e4-2fef-465a-bbff-88008f521e22@acm.org>
Date: Wed, 6 Nov 2024 15:20:45 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: RCU protect disk->conv_zones_bitmap
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20241106231323.8008-1-dlemoal@kernel.org>
 <20241106231323.8008-2-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241106231323.8008-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 3:13 PM, Damien Le Moal wrote:
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index a287577d1ad6..7a7855555d6d 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -350,9 +350,14 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>   
>   static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
>   {
> -	if (!disk->conv_zones_bitmap)
> -		return false;
> -	return test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
> +	bool is_conv;
> +
> +	rcu_read_lock();
> +	is_conv = disk->conv_zones_bitmap &&
> +		test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
> +	rcu_read_unlock();
> +
> +	return is_conv;
>   }

The above code can be simplified significantly by using guard(rcu).

Otherwise the two patches in this series look good to me.

Thanks,

Bart.
