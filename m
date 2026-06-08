Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86E3EC2F5
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930407; cv=none; b=PyWgFehFRC2iqEiq64HwFRKN35sbNNIXLcsgsYGw16XiF8cA+nb51QrkdzmEp13MAtLOCcpID0/qvk/HOAOhtaI0IJH8xNbzwjO4nWuScU4knKZjciuHbTG/Mnx1wmwbeeb3k7LvUJbWJQZPSakI+LL0HVZ+MC//aR9PCgtugak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930407; c=relaxed/simple;
	bh=aXBtlEnjwFrQKovFyPfzhs9uZjhW40u8HNLp3IKF/LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozYVI1+fxBOzeBzm9EVjHLeursdLvvvhY2qxwLy6NBCJ36rkB5iD6CJnoGw5kp9EzoFRwn5EASr/chlhzPS/mcJJfji+cWUscsaiGdGxZc3BIwNIj6yH1cWqpyuA28d3+l/MImef+ELjdYbl+ezlTnJxTLIVp4tMEfzqu7VAIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LS5ktwsI; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LS5ktwsI"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43d2ff651f2so3653511fac.2
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780930404; x=1781535204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezWnP2UXKohE5V9tSBhtiAoUtofNw0gKy3ylNXOeXQI=;
        b=LS5ktwsIwbjkuocNDMmWDEv1Z6U6lJrwQZYoHn3DL+Eo+8EoSe4T50cB0QolIqp9TS
         QZL2OgNadtSRW1TOtDdPLV7J51fsemuITyBVXJgjja8YiAKpoIw3Evp54AccxHs68Lhu
         yCcp3oP691G4PbnhOl4awTKooEtEmwKcxKy8FuO4a+ktKNLG+k333K7N9UFPeogR9LWE
         kKiuR/Z8DDWC31YFJ5B09CPeNFfEQ8ah6QvAb5Sjbs0mhIqpPUXNUA9Wn//LhkyEVE8T
         Z9thToSn+EiiRT+4ru1NlDn6j+II4OECjNkm+bTtrY8esbxWxJODb2ysQ1w6i5kCW5iv
         bnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930404; x=1781535204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezWnP2UXKohE5V9tSBhtiAoUtofNw0gKy3ylNXOeXQI=;
        b=KS6xqroVwDAPdvt+iRBsJ3EBmApLILyb5IBglXCqzb7aRxaKJI7dJWXc0IWr2HZ4pg
         Tu0IfqJFbP0w+1JYWdtuxMoMe/xcxck0qKH4PjZNRreT7boelqwQ6oWcK5Osli5MmzTt
         R29fbFnpnpfWOv+0yDJyN5tDpGTR1PQGQNg6pqI+k60prLEIXqC4/DAEr/99lP+UKIoU
         QRNk2H8mPnNd7jfqrtBUrNSH5sYUXqcho8ZTyPCZdixVxSXq+dHXJeaY/iuekaLbDZYs
         xE+8N+DHNJyDrGS9pajqym8rsN1AG0mC2h1wP0belchGXgWkNlOXbWNr2nGIJ8FOmzSL
         KZlA==
X-Forwarded-Encrypted: i=1; AFNElJ+JBJAKbWPUMnl5HhJ2hjAFkE/Sb1nq1YLIMT/hdaYVYJkW8fqmCWrjR0TifoTD0TKXF0gjJ7AFPyxa8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YylxJajxYa5CAopk5e3Nbh8k0VAIGfITcClINVbI9MqFTVEXkma
	TEjmMnzpovuvpu8Hj13Fck7d3TTX5AvX9LLa8h2BjNYaUxQ4RgkeDS6RlFLRnFOuSCs=
X-Gm-Gg: Acq92OGxxbmMjFhKdNIfrhnNEGEhLpxSmgFouz11lkOv6h3csOPnMtIpItDtVQm7V1r
	WJj5OKJANrvZSEI0akeY1+Yw/XLQxDTifzpTDCw0LwvBEbQM1pbQ20SLRDhNez/8M5VYOfUNQT2
	hvkSKbD4yaDnB2kGaP7D7RFmr5bJ0rdls8NBLx7ul73HFQt/i+tcy+4EDaL7fn8SWqfeN/Q1P/V
	SZKmbx4nXtbIUt8hdgiZgHBGlkosm+QaX9/cs1I24B3k/G9fMu766U3F7jpBgZ/u7cXbbrV3Ucm
	04vMEVaAG90ZI9zjsoyjqAE9+whm3oFZN1C2vci8H6aiASzBJ6ng2h12NB4QKnkYlMPnpXq3nVH
	SSdHA/ilbFsATD43228HZqpU/ZI6ob/I5EpkDWpyPWub+AbIRUP8qFG7e9bkGg3RhqMuuY3URqT
	OtX0Twz9yxHm+ICM1kJ4zFYBDEMcx3Y+DtCi8WAJSldQYRz2ON21t3ViOe6LBmCyKu/N/oDYPeG
	7tAxxh9QozJpGyhg+h7
X-Received: by 2002:a05:6870:d6a7:b0:409:5ef5:be0c with SMTP id 586e51a60fabf-4413d3b4b67mr9871451fac.12.1780930404545;
        Mon, 08 Jun 2026 07:53:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8295aaasm16163044fac.9.2026.06.08.07.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 07:53:23 -0700 (PDT)
Message-ID: <bac50400-dd86-4c7f-bab3-481c1306877b@kernel.dk>
Date: Mon, 8 Jun 2026 08:53:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] block: add configurable error injection
To: Christoph Hellwig <hch@lst.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>
References: <20260608051416.1205282-1-hch@lst.de>
 <20260608051416.1205282-5-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260608051416.1205282-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/26 11:14 PM, Christoph Hellwig wrote:
> diff --git a/block/blk.h b/block/blk.h
> index e8b7d5517086..10df23b2cb90 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -660,6 +660,18 @@ static inline bool should_fail_request(struct block_device *part,
>  }
>  #endif /* CONFIG_FAIL_MAKE_REQUEST */
>  
> +void blk_error_injection_init(struct gendisk *disk);
> +void blk_error_injection_exit(struct gendisk *disk);
> +bool __blk_error_inject(struct bio *bio);
> +static inline bool blk_error_inject(struct bio *bio)
> +{
> +	if (!IS_ENABLED(CONFIG_BLK_ERROR_INJECTION))
> +		return false;
> +	if (!test_bit(GD_ERROR_INJECT, &bio->bi_bdev->bd_disk->state))
> +		return false;
> +	return __blk_error_inject(bio);
> +}

I really hate this part, that's a pretty deep set of pointer chasings to
figure out if injection is enabled or not, when in practice error
injection is only ever enabled for specific test cases and distros
invariably will set CONFIG_BLK_ERROR_INJECTION because they turn on
every damn thing under the sun.

IOW, that won't fly for the hot path. Maybe a static key would be useful
here?

-- 
Jens Axboe
