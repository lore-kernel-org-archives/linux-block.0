Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E954293B5F
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569154; cv=none; b=G22TSv6QKk1Dk3k6Rv2/IhlDcFn+olpYpwBikfwIRIQm6Wn5xBF8foDtkkHrCfCYd9NS9qncrb/6L/J3Nfu0ctzoE5GRgZdayH9pLYqu1yj8p8AULks60af3ihMyWNzOYSeJW2nz5U+c+EzB1Cmx7OkepcGkwd1ZzTgwYLZA57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569154; c=relaxed/simple;
	bh=o4thLCnmdh72Se3o2I2JcWsXuNEI9SDljePAf4hnfqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPa35Ty3CAIboF5b49I6ivTgU0ZvxzAAleWYI0em1XiQeVt3B62wdu8BvUYhUV3W5eckx+y2QWFTOFyk5sIktus4P+ezQ0Cq7vjONj0EQgnHt0CdsZJH+vZF757U/K7lbR1K5dRDggDeqYJ6QrSMWfsJUjrXXRfjd3RnlUqGSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TuR3wQJm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TuR3wQJm"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so990162a12.3
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 11:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765569151; x=1766173951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnqEhz1hzHNQvZFEi+2OeDMzensp4Fre9707UXAOt0Q=;
        b=TuR3wQJmjmlaEMQsEMDuelsytc1HXunISelIFZib41LMRMmRgJZo7jfm7AbAz/mBKa
         1Dij6LcYfbzaCH9geWRRjsdPUj4zshYNsHpxIP3JF5yO/XsI6A1TXpJekFAUBV3u/6WI
         4TK/ZcNTZfuoQSEgiMnw/GONKeSwktDB66HpJ4lypa7OW2M1lcJgkdrWL0CnuAAbfMtr
         HKq6FeYvfVVczoM8sxhldbqAJ0o+FHJcR9QGVYN9H6qXnOQxPZxdCIbM70SWZ2KKUc9V
         SI+lQ0K7tXLVfcaGycO35cjdNVYKZbtzKLWHyp7/XFWUg3H2gltAtuIrpSL8cTWcts/v
         J6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765569151; x=1766173951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnqEhz1hzHNQvZFEi+2OeDMzensp4Fre9707UXAOt0Q=;
        b=LcIRD3SYH/bLYtMgrVeap27XTNOVbTGq87rtnIbdZh9gk0VcqQIt2XEd3vNDnuwsGK
         rYHv3P4kJakGlGdDNYLJxJNgU6RQbeyiDB50D6jlv+ElezFERV1Ru3yvSx9NBLv+QCqe
         IL+9YxGb9sjYR3j1mCRo6pQSOzv/ZkPX/6h6jOC9X8TR0lMB8vV4wIKKzWthSu2pWxj1
         hxXgBmr26f0KYjWEDooU8U6eEcB4IAkBTJyKmur6/0NlsvlQP+ggKK5ojp4GxKGsy014
         MeM+B0qLcvjCOYp2Fr8vXlcSukoxqJysB+cJfTBYKcSPFgxZd0s2knaC1QG1akmiofHK
         RILQ==
X-Gm-Message-State: AOJu0Yw1yXAUqEwJ2Aaq6yS42xs+XQuH53hJLA2s/E6jJEDcwC20ZRpM
	394zRJrr7M/u9mce5Hdo3UViAdLkMA9duGQPsCKSQjes7I3yjRkFB2ulIKC6OBdyK8w=
X-Gm-Gg: AY/fxX74GpDy68cRSTH8bOX80z6K8O0Qtj2llzD5fdviGRkJ2avB79RS/5ZHR12BeUw
	ixwWVEa4h8jHh4SwASpaCIOppIRJvCY/7Ih4w2NrzXMAlxn8g8UzVO4r0Zyz9pnd5/Z4ELzJIx1
	AC8dKdRGfnsKugCH9Gs65oxg93jbtd2oOI0lNZFUI0PGO+aR7L5KS43al0q1l4tOv4v0mv/gRGn
	5bRBFKLdnRVer0PN9brQXrEQcheFnLx7fwM72CqQLzY57NvWK8pWujwM9z8N3Zjk8F8sxiUBLTv
	icruQriJYyzQ6xyBoniSoh5rN6PAex0Yqu1eJ23TXqv+ZyASTJsUUI9dwcZpUrmKNGJ7k2M6QqA
	ukFJj4OoJYfbOMD3p8HN5t9VWPcjhj1B7Wqo7Fh5pvMZztG+Q0oBJGy8qNieNrMWx1db/l8WXR6
	kek6/kUBtx0ggTzNXe+uaCnlNqU4K8H8JiUA3qHGfXW+U8kO1hvw==
X-Google-Smtp-Source: AGHT+IEr8FIfJbC44ZtFw548sXg1356TDgSoYhORFM+4XMeyZXlWiQtE8Qne6DxoAbSV+N1f/6kfuw==
X-Received: by 2002:a05:7301:1625:b0:2ac:1dd9:b933 with SMTP id 5a478bee46e88-2ac3039e900mr1637977eec.24.1765569150616;
        Fri, 12 Dec 2025 11:52:30 -0800 (PST)
Received: from [172.20.4.188] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ff624sm20673541c88.12.2025.12.12.11.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 11:52:29 -0800 (PST)
Message-ID: <77d57ec3-134f-4667-b260-f8f5ca593339@kernel.dk>
Date: Fri, 12 Dec 2025 12:52:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] zloop: protect state check with zloop_ctl_mutex
 locked in zloop_queue_rq
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251212144617.887997-2-yangyongpeng.storage@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251212144617.887997-2-yangyongpeng.storage@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/25 7:46 AM, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> zlo->state is not an atomic variable, so checking
> 'zlo->state == Zlo_deleting' must be done under zloop_ctl_mutex.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>  drivers/block/zloop.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 77bd6081b244..0f29e419d8e9 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -697,9 +697,12 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
>  	struct zloop_device *zlo = rq->q->queuedata;
>  
> -	if (zlo->state == Zlo_deleting)
> +	mutex_lock(&zloop_ctl_mutex);
> +	if (zlo->state == Zlo_deleting) {
> +		mutex_unlock(&zloop_ctl_mutex);
>  		return BLK_STS_IOERR;
> -
> +	}
> +	mutex_unlock(&zloop_ctl_mutex);

Probably a better idea to make the state checking atomic, and avoid the
mutex in the queue_rq path.

-- 
Jens Axboe
