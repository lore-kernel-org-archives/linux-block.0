Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D16FC08
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250953; cv=none; b=XHmZezeXOkG4XXlwplEF7z8oFIYiNiI3S4Jpx1L/uW82XBEEZ+jG7lvyOqwadfS9g8gESUMoz55KWhkCbW+YvysthAUDKXRcIaEQfr2/hSTaAfNNqkWDTMLV20Bcvu/l4DgVuHlXoShgqJCFLGW7BXSG12wMkCu7K0bJfXcafQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250953; c=relaxed/simple;
	bh=QmeIwQOhg5p9QUK96WEvx8PzYn7hWtuCg2VHAiSNdS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne/mKTJgxMxDygez7LrgTFn5OBoYnzIdfxx8AaNYfKwJQ1FCqt2MP6CsE2QPpCHWFwz2swdOnfv825RaCkp8qebHowf4dhVEiYC+wWyu9+iBtbhOVuNOLJZfa94Z13nfaA6bxLCYyMWszvXvJAGOYLXmuMbg0KG80dr3OKvOf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wO0pF2OJ; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wO0pF2OJ"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4W7FfH40S9z6Cnk8y;
	Mon, 24 Jun 2024 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719250949; x=1721842950; bh=BgV7rVfPiBbmwM1oVXF/G892
	9ZNaXQwurw5Dl9xp6AQ=; b=wO0pF2OJzmQ6GaF2bk43kg/+XWd3lqxxW2bf2eNT
	TDk+NF+r0WqcdeVyuGtkD9FXo2+dgaHteiJiqsCzRrM8f1tayWueHVBesT6JLwY6
	65AuwWTM7q95G7I9qytGgKN4VE2mozKqyjfll1m7vpdK8QtsphA59XuldycFg+tm
	7KJv53qE4EsrhGBl6fKlGiZFarTWdGGgaV2Y79iVrWR7/S+YeiqaQDfpRc3bi507
	qci5lVB8airz0RA+cANp4umx3dJeMCV/hpIz17XCVFQlP+ZK+tjL53kN0ZyOdcGq
	DDpRUTVimuNWs3KIcw+gFxCIVEpC6Ks/zddHLmnOQqjqJQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PGBwju-8ydTQ; Mon, 24 Jun 2024 17:42:29 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4W7FfD22F2z6Cnk8t;
	Mon, 24 Jun 2024 17:42:27 +0000 (UTC)
Message-ID: <cfa35a47-3698-40ff-828d-92ba1cd04ffd@acm.org>
Date: Mon, 24 Jun 2024 10:42:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix the blk_queue_nonrot polarity
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Keith Busch <kbusch@kernel.org>
References: <20240624173835.76753-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240624173835.76753-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/24 10:38 AM, Christoph Hellwig wrote:
> Take care of the inverse polarity of the BLK_FEAT_ROTATIONAL flag
> vs the old nonrot helper.
> 
> Fixes: bd4a633b6f7c ("block: move the nonrot flag to queue_limits")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/blkdev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 69b108a98b84c1..4a56ebf28da6ed 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -617,7 +617,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>   #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
>   #define blk_queue_noxmerges(q)	\
>   	test_bit(QUEUE_FLAG_NOXMERGES, &(q)->queue_flags)
> -#define blk_queue_nonrot(q)	((q)->limits.features & BLK_FEAT_ROTATIONAL)
> +#define blk_queue_nonrot(q)	(!((q)->limits.features & BLK_FEAT_ROTATIONAL))
>   #define blk_queue_io_stat(q)	((q)->limits.features & BLK_FEAT_IO_STAT)
>   #define blk_queue_zone_resetall(q)	\
>   	((q)->limits.features & BLK_FEAT_ZONE_RESETALL)

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
