Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496151FA179
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458070; cv=none; b=fty7dqlGNRFbHHoOUmpjQv1KNW46c7GPcVDkaGefebxrPLvdyZ/5PRq6DHSBzhYzs4LMDns+egdwna4psl/cLpoaYEw8/F1xTilLj+qBjz0JvIWIJL9XQlHjQbSqHcAOVb17Sq5rjVLVVNWnAcTJJVIIJrxVAXAl5q14v4NhlPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458070; c=relaxed/simple;
	bh=Lyz3pxba+WfjDFPIDQ6xn8XAtkSqhUaQDO2p6HbBcnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txsrUupS99MOqBURrK+g8pFeoa6eqg5ASag1vmUb8WmHtugKChvEDrf28RhWZUFe8qjacmAlEPFRR1fd89RcbP7w5+W6WMi7cl64kemo0aTI0NzcuT7CiLxZVhgacTOd2FiSwL54goSLK4v6v9PcqRJL2suNUIb8RA/sb/MMNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RyHAqJ/m; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RyHAqJ/m"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ab29214f45so18832235ab.0
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734458067; x=1735062867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+S2KbhIrhYKECFApyJjGLk7qrmZwBnp+gEfOwbZqgUo=;
        b=RyHAqJ/mDor0NPB6E4y9tWb453DBiOvljE6m6eiPMtOr4e2sRJSzWqNZYd1dkMO3bl
         7vKY0s0MkSFXVmEZ3ZA8VhVNsx62cY3/jKsFeVzfY/bsR1gHnKXu4hx1iK1dKA8Cce6p
         XrKrmuCa8p7I7qyn7u8G5SKpBrsC42+6iXol+y7UoYJ+YT3cHPwn8p2zBVyFDkfpjPyF
         JfoaFmmD3JyyXzanbOmSUA+E8coMIOaRCGJkBDpr9Q6CgsaoyRaLZENp2i9/cgpjxPEu
         YUaxV2SMYjK6shepU6EPMNADn+CZGuDKOYrzxXC8n+1TTnIQVopfXVRhWJe1KbHD6wMI
         rksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734458067; x=1735062867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+S2KbhIrhYKECFApyJjGLk7qrmZwBnp+gEfOwbZqgUo=;
        b=Z5wwfgZRYFwtuswfRkA19bq1V7LouQA1vicQI6fljCycYOXTSL/wJwUGltwUDcyM0/
         R+z3U1Y6VuvFikPfsZoQJH3U0iF+7QH/496IK7O/2AzbwYEFW4rGPv7Y+ZqUIctYMFbX
         fd7rbiTriUQp+V4WrkDgxhHO7fyDbVBhGC+Ciq+OaiStLJFZIVATm95Zh2nTBsLFboFk
         +kOAK8mk/erGbtAIS1Hy4QBQZGGME3uyUvHdjAfG3khWOxH/oc7zr7v9q81vlEUItGe8
         lFwOkxZLX/aZ9Z5zOZcOXPljUgJGpxilOpgULPjBJWgc1IpDbKaayQ+vCbnrS5q9IBNv
         ZDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLEkuyNa/NUfOfg0KgOI7SmXx3/akJiI6ffkh51dcVQOQ/Rj6skna6fwIjKV6oMKJa4NM5zAUY23C3Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQCbLWlJ+pb9dWX3qkKBDPpN9WHyB/Q/H/kWTZ6zEkQevvm8YL
	dqMvHVti/XNazyQQFyIBQF0cTXCjkWYu3Ams/3CjzU3DBGVQNdw7hpB8h4iAdVg=
X-Gm-Gg: ASbGnctuRMCSR5LhAyIxdnpneP7dGK2nNKGREp/ufcMJPgAf97tqdsE7f7bm/65vdi3
	O6gGJ1csD8rsO827Pp13fVkZyD7qQI4N0fSgbepr7+OifIEAJgu5AdgM1CIhA1K9z9gS1t1YOL8
	uuwC7OEBLmw/60ylQZ4I3cdsddI54BMPycIbPXDJcUXLfPfRgJK1D9V0gRdojOsMwOjbuE9Md+r
	eM+5IUTPeQwKSuiYMkdUkNLnsoIfUhzcAtV1mHVWS8/8WvQpwLt
X-Google-Smtp-Source: AGHT+IEu4IjNs/5xorwpYlZBESvq5LvFi/8gufZqjoD/nmtALPkmYF9FSVwvwu7wAaOMQC3j/4k6gQ==
X-Received: by 2002:a92:c564:0:b0:3a7:6636:eb3b with SMTP id e9e14a558f8ab-3aff800d5d2mr172047215ab.17.1734458067401;
        Tue, 17 Dec 2024 09:54:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e32a33cdsm1793038173.81.2024.12.17.09.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:54:26 -0800 (PST)
Message-ID: <acaf46f3-3f6c-44c9-86b5-98aa7845f1b6@kernel.dk>
Date: Tue, 17 Dec 2024 10:54:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support for
 virtio-blk
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Christoph Hellwig <hch@infradead.org>
Cc: Ferry Meng <mengferry@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
 <Z2BNHWFWgLjEMiAn@infradead.org>
 <CAJSP0QXU_uNqL-9LmLRkDdPPSdUAGdesQ2DFuCMHnjyEuREvXQ@mail.gmail.com>
 <0535520b-a6a6-4578-9aca-c698e148004e@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0535520b-a6a6-4578-9aca-c698e148004e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 11:08 PM, Jingbo Xu wrote:
>> That's why I asked Jens to weigh in on whether there is a generic
>> block layer solution here. If uring_cmd is faster then maybe a generic
>> uring_cmd I/O interface can be defined without tying applications to
>> device-specific commands. Or maybe the traditional io_uring code path
>> can be optimized so that bypass is no longer attractive.

It's not that the traditional io_uring code path is slower, it's in fact
basically the same thing. It's that all the other jazz that happens
below io_uring slows things down, which is why passthrough ends up being
faster.

-- 
Jens Axboe
