Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDE442C
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917188; cv=none; b=ngKQeEbCq+wpDCRqhroSHQecyUZ36MgCXCcQCe7oRVjBuxp7EE5oLEmnjird2F2nC+Y3XrT4MqlXbB3LCjvxdAs4wfpa5zCOqRktpqyYVyiHFLJeLXTDPmkQgLurHkYUvkvo62ge4C/o5fmmu/v9ae8gA1s7lK2krP/SOGaD120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917188; c=relaxed/simple;
	bh=+AfZuFvCS3fgc1EA+P+zkg87IdI0SBkNtCn9+vexS2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPND8jhd+XpqWNJvRgptZxhRQLV69+ZO8/YVrZnxEZqJAtDNZSmNpaZObt3vuOgrSDFkZPCUOgGuMbMMxTZJlVytT4IrWZ+WWET+oJxIfdqyKnLU+oD0/jkhXI/TipqZjJkccpRcYkOKVeYL7hij6fX9d+jbgu3v2UuKkRHRMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qCIbPH5F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qCIbPH5F"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21680814d42so147062335ad.2
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2025 07:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735917185; x=1736521985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Wj258D+kUTkxTWmQR0Kz0eot3ear1X5orgKLKx7nHc=;
        b=qCIbPH5FTpt8witIbIn2xlBqwdRxz9FNUDUfHj1bLSP8PRsBk4+RuNrgqXvvdOKe1X
         O0q0SqIwxy3QUSc5OHtgms4UcJ6JMzBwekCHVc2DgzUHjBfcGvpLgAlhTMX9HRIYQatC
         3qH59FCVXlCXNt/BXMYPVj94oHQszGWFvpeEAvK+eIWtmqelM/kt0zp8xf/8OgRznUpi
         0IhlfUbBoRkI5vCIYv8LMIDA0YeBzW00znBKtfL+wq93c36xa1ba0NGgVFrniNfV9Fnj
         V3MmD/Zl1s8DtMPS9oz7l0ooNJ+rIXWIzBNTaFImF2BeR/IL1n/UKDU3Lw0h6TK5xLjS
         1jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917185; x=1736521985;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Wj258D+kUTkxTWmQR0Kz0eot3ear1X5orgKLKx7nHc=;
        b=qKH2Ut5G89uGOvD0ualBHbz/FCylx1SckUoqeZoHAoxFOXyar+eZwObIEjZm8ajTw8
         LZKUDraxvnpBSsYZvA1D0EkdFFthoVSBnHAQNGIWgzeJ5Nbr8qgWUIHc3B+FP4wcHB9e
         48h0TT0qHu0wCpaDgzSLVqyHtnOBvv/lyh9FcXdyjmYC7yFvV2D4JyH8hgRRJrEfd8ZB
         hpdBVJp6i4p+9J3nmckiP0+BywESqVZJozu/Qncl+GG5xkdHGO5z9sNJKMvom2tMZl5P
         8G7P+ZgslXnnDHip1PszVJFUQcEGLQ1seJwf9cm7CYMdOB4ZY38A+S4uNwGA428U33m2
         DRQA==
X-Gm-Message-State: AOJu0YzOACQ/ecxKrPdkBYu2/SHv+IsHK4XUWN9UkZX+AqRG924EUl6C
	Vd9zD8imQM1fi8QQXJmfAMArDNoCvQIocaKAkcz3huC2oigTSPrrhc3AfmAVJ18=
X-Gm-Gg: ASbGnctYWM9WWFK5NCqcqc792X4Gk7v1DJT6fljT4Voee+CdKBWamNP7L/UVNx4JaFi
	/CCnfjCDbTh/99qo3DRNQGzXN1BUpkEmHYc6UGlwjUPL1QSFH1QYQOlaCxcQLib6AmBA2YlsE3+
	AtdnvAVQeKcrLKSMNEJQLgOxE4d/Jyf0YIpJJF1DKDX4ZgxglJLHdbeFVeywB8Gd9Y/kbI9a0n7
	geceBWhuLPgXfne3JiKN/Gwn4rMSTgQpfVf9D4tHJCUvJFCOIG5dw==
X-Google-Smtp-Source: AGHT+IEoqL2cuJXspR6TceLnFsxTlvfAd+xzR9pwBGT9mfOKcCotE6EmVlySvM5C8VJacktOARfgYQ==
X-Received: by 2002:a17:903:2a8c:b0:215:9091:4f56 with SMTP id d9443c01a7336-219e6e9f997mr729542615ad.14.1735917184982;
        Fri, 03 Jan 2025 07:13:04 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06dcb0sm30389485a91.35.2025.01.03.07.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 07:13:04 -0800 (PST)
Message-ID: <c4a93b03-2053-40f1-b10c-af979118ad7e@kernel.dk>
Date: Fri, 3 Jan 2025 08:13:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Use enum for blk-mq tagset flags
To: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org
References: <20250102144426.24241-1-john.g.garry@oracle.com>
 <20250103064427.GA27984@lst.de>
 <f3852e75-dff7-4cc9-b64c-01ebf1020808@oracle.com>
 <20250103082723.GA30419@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250103082723.GA30419@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/25 1:27 AM, Christoph Hellwig wrote:
>> - catch missing blk-mq debugfs array names
>> 	- this has been a problem in the past
> 
> Again who really cares?

I do care about that one, it's pretty fragile and I can remember at
least 2 or 3 times when an issue like that has been discovered and it
was introduced several releases ago. Yeah not a huge issue as it's just
debugging, but it's annoying that it's so fragile and easy to get out of
sync.

-- 
Jens Axboe
