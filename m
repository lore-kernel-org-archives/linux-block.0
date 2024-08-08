Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51918DF70
	for <linux-block@vger.kernel.org>; Thu,  8 Aug 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124245; cv=none; b=mOGYjZsZiTJdpfFX22h5fcqkHwWnvVSNjgMTVUPHIDoDGt5nq3e2nxEIJWARg5uY3ppPztdtS7S4wna0btN2R1Lzp0rCCUpZ6o2pza+Ec/M1JKap0DIA/0qpQUAzg+vEvf46Y2cY+m1bJ4CZPt+KtTWsKKZhzQtMQQDqMed/kF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124245; c=relaxed/simple;
	bh=3ZiTOAaXUPmHMS+kcP/7fLCSSJvy0HJAPk8oCSO93e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0a7cCJS5NgMb5J23lcvwCz1MEEFEvSUN5nEpnf4KUb2PPlNR5k3I3y/DNehoX9gjPEhYcXEsXuPyu42hrjl1CtVsb7XA3zUArnK4HyUs1CBopjW4NUI04hd8tpdO++3SRo4Yo8AiWy6wlZ5f+Yt/oWVbCzBDOMkqhz3MV7NEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sJ6wbF9N; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sJ6wbF9N"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6c386a3ac43so90263a12.0
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2024 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723124241; x=1723729041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVChcYY30Mpv4pcrAWYyddiPC20nI4GsEyGh5Z8PoV4=;
        b=sJ6wbF9NuWemgk+CVIcZ7ElWmsHZUhNO5Thb4E59bsBhgy8ROvRpz4XfGqIhCBM+m1
         oanCivvzQ+H8IdyfKAAggF64Hr8L67dPaowYXjdqP/JNqFrIzcYa/3wQ5H5YonJGjJX4
         w4KFUdu8wxIBFv5zFDe3nbHtIxd9etzXBliwnFCdzIgIB1aVL4k9X4xYcpnHVo9k32qg
         u/YNLNECNKbynU7HNUdy0Zg8Gm0KENVVga/605HMY7C4Yj8qFWJ9pubJntwpXRs5aBaJ
         g8diXNllRWq6qxymLu5eHwmskQYtfzfwmgJpVo6+Ca+GZekTlelfBpI6AXmD9AVkotIo
         V27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723124241; x=1723729041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVChcYY30Mpv4pcrAWYyddiPC20nI4GsEyGh5Z8PoV4=;
        b=aFGc4GsbUYuON/dX8zjoQOpVCXmrrLu9zeRhq6SPyZQiMRWYXcvCTjwuh3q+6diKgj
         PxX/XYvIo6UTxJeI/Ne2IK1vGtkSPX7bYJ+Y787cwm2HPDbYPR1s8DqnkVxTEl6fDwbe
         bTxWtvz8aELce29yKiJ2OHvNO5Y8b0zu8uW9L6MJVQFkHXNWhCVE50kudNRJblqMZiSF
         08f9klhPpE3SVnQiv/aDfcDWi+Ikz5/t5tx62X0HuISignmkfvlUkfDImC70y4obNTQ/
         zHrmNAiNd1SAEnLXrNCtpfqp69ofbp3Prtztq94k+C91azUW9OTU/upIbK6QTLlRtgD3
         nMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWPgnyBI6JhSVYpPi4FonWX1eCm7zyN/9WpooAnsl1jNQsTpnB62vc4knPMG569u+VqJn7nesoXks6FhGsUvkXeS5VwqvCVP0/dwQ=
X-Gm-Message-State: AOJu0Yxhf4VudsCzVfyIXwt5w0dpM7gdqYuo8qobuLjm4gLGoDChK+Hi
	XH05RiBt9HpSYp2Hyz1+hB5rJeNnQVHrstS2DMm+1Y3fBAV7Sw7Trk4yFI3RbAE=
X-Google-Smtp-Source: AGHT+IEk6xoZ/zlRSb3U/GJSm3CHUT6KiD1J07T2LKOms6ygd4Jc8qBlHMKfZG58uLAif+L2dix3TA==
X-Received: by 2002:a05:6a20:7487:b0:1c4:84ee:63d1 with SMTP id adf61e73a8af0-1c6fd05f845mr1187450637.9.1723124241540;
        Thu, 08 Aug 2024 06:37:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f219f5sm124997345ad.29.2024.08.08.06.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 06:37:20 -0700 (PDT)
Message-ID: <35c7b39f-415d-4d23-bf44-75e655f3eb8a@kernel.dk>
Date: Thu, 8 Aug 2024 07:37:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_blk: implement init_hctx MQ operation
To: Max Gurtovoy <mgurtovoy@nvidia.com>, stefanha@redhat.com,
 virtualization@lists.linux.dev, mst@redhat.com
Cc: kvm@vger.kernel.org, linux-block@vger.kernel.org, oren@nvidia.com
References: <20240807224129.34237-1-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240807224129.34237-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/24 4:41 PM, Max Gurtovoy wrote:
> Set the driver data of the hardware context (hctx) to point directly to
> the virtio block queue. This cleanup improves code readability and
> reduces the number of dereferences in the fast path.

Looks good, and that is the idiomatic way to do this.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


