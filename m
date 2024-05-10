Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1312B176
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348739; cv=none; b=k9bkmtREcMB3Q0+pe5jQea5AZ2dX33oFNGb+3Yey0vu6dRh+bf5fuDPRXBNhtGmkVOO9r/X5ZLeS7Salf03akSabVdoI2nbRe8fINIwE2AnS+qD/JuH/Q/kD4gHWGKHYlMv0he5dc2o7DRbG8qTa3dViQKfHMvN/1yVhiu9pw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348739; c=relaxed/simple;
	bh=CPf52H3oFQLAqdeaDGBPN020rXRzE7tC02wGHs5u8vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgZxwbGB3gqJlwxwNEiNkYom22PVXECGCeNT8xCERvEA36Q81vkutPOeRdgenL5mMEeMsxDkR+reCoD7p/ZSzl/thVRUUfbAies4B7/FIg0mtEIye16oj8wjJHnbSU2SgazVeI0NHBVcEQWaiCKyJcf41/X09f7JMzTfR2QFgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HfJKkiBe; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HfJKkiBe"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36c0d2b0fdeso1810845ab.1
        for <linux-block@vger.kernel.org>; Fri, 10 May 2024 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715348735; x=1715953535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmsizxDlh8VGIxvKa46Kni5rgHbXmAGCqkr6DBGwWCA=;
        b=HfJKkiBeDAOgfFg11fO4anOTHfDSzGgbec6SstOuKvzoMQ/AAPOC9Pbl/k5xEiRbHh
         pOdDQ3mLXd+JHCww9zniJvPsD6KkJTx+o2HbJC7sZpF2jvQoo/conVCVndLxUcVl33TG
         xCr1Lb0QJ8YOn2DBZk/WdP04VEmgjwx7a9ywzyggvEQ+x1+VfOtpTrLXPhY7Jdhw9sEF
         cRI/5QcuAnu5VROAGDjYzyEq+x7BR9hXP1+QTrtKlDymcUfLSYgqPyckGMymYHW5wtjt
         5q+ejrmyO8xhdhAYoeQM8VWvBWpnaAObPtweDIzJcxjaNmZRK3ur3F2svCgqHIRuPgAN
         +LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348735; x=1715953535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmsizxDlh8VGIxvKa46Kni5rgHbXmAGCqkr6DBGwWCA=;
        b=kzibYSoW6FDJ43mSxx6qUbpNd7X3oxLV3IeyqX1aRFPzdZt3s7XxxFoeX4ksq6D0dW
         lzqwny9PYbnRsCTaJpRwREQ+4cyUgZlYCVV3XFQSGk72x8yrJ+1UbII67tv16zigguFr
         WyjID4RjmiOivBCgt3sKYgHUICKzONQ8joTS+uc3QUmMSZtTSV3TV7TeaGjLmpzak+1l
         SpJ3y5JKRWtaEWMsOwOe7ZYlOI+dAFE7Cs3f2ZJAPF7ggmP28LDUl/VnjB/ieeZEg+Rs
         pUdSfZKjSTuZ1eownWZXTXaEhjdP9+7LcOBrA6NRjn4J6RYPRJ1VzG/d7V+OuwuueUVK
         XRyw==
X-Forwarded-Encrypted: i=1; AJvYcCXYMk9RHuC8/CAGHNK9H8oygpttQ39Oqek2YgXFLaRqp4p0yTC3gQEqYwsxSGHO7SVf8EC0mtHyjcZDMVOjaOtkmx7IqltMM16ztbo=
X-Gm-Message-State: AOJu0Yy8Fi93sJfVNS62aonF6rErreKd3fHsXsBX2Z9HlkGlnTIiQ50Q
	CvEttzgQoBraFIXHsgw3yGioB1Fj/2Xg4LoZ/B6yBjnwhYDrgOLdT7uvZJPJSUI=
X-Google-Smtp-Source: AGHT+IG3qVDOspiQrCoZTdejYIWXEmeEyT0LSNue3i8UNQAJpOHdd6gPSJvkuIltbiGydLBUGu3InQ==
X-Received: by 2002:a92:ddcd:0:b0:36c:d76:cf5c with SMTP id e9e14a558f8ab-36cc14cf8f7mr27922825ab.3.1715348734919;
        Fri, 10 May 2024 06:45:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9e22041sm7913375ab.83.2024.05.10.06.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 06:45:34 -0700 (PDT)
Message-ID: <6936aab2-a8b1-42a8-a9e5-6df1e212df7f@kernel.dk>
Date: Fri, 10 May 2024 07:45:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: unmap and free user mapped integrity via submitter
To: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
References: <CGME20240510095142epcas5p4fde65328020139931417f83ccedbce90@epcas5p4.samsung.com>
 <20240510094429.2489-1-anuj20.g@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240510094429.2489-1-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 3:44 AM, Anuj Gupta wrote:
> +/**
> + * bio_integrity_unmap_free_user - Unmap and free bio user integrity payload
> + * @bio:	bio containing bip to be unmapped and freed
> + *
> + * Description: Used to unmap and free the user mapped integrity portion of a
> + * bio. Submitter attaching the user integrity buffer is responsible for
> + * unmapping and freeing it during completion.
> + */
> +void bio_integrity_unmap_free_user(struct bio *bio)
> +{
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +	struct bio_set *bs = bio->bi_pool;
> +
> +	WARN_ON(!(bip->bip_flags & BIP_INTEGRITY_USER));
> +	bio_integrity_unmap_user(bip);
> +	__bio_integrity_free(bs, bip);
> +	bio->bi_integrity = NULL;
> +	bio->bi_opf &= ~REQ_INTEGRITY;
> +}
> +EXPORT_SYMBOL(bio_integrity_unmap_free_user);

Should this be a

	if (WARN_ON_ONCE(!(bip->bip_flags & BIP_INTEGRITY_USER)))
		return;

?

-- 
Jens Axboe

