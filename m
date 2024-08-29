Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE8191F86
	for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931473; cv=none; b=Tm4X77MBZyNi328P3C8oCxY+W0QL6wIIb76uUJELSbRxMikSOUuPFPqUpWmwmUOaT8I6Hp/gOyqLUs33Vec/YnDOIJUx/jMYd3u+bYKruIVBfsjeYy0FViutll7Ug47RiA8bpzLrlYz8JXXYfLljNohfztbQgzWbuSkui885hLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931473; c=relaxed/simple;
	bh=cNzbsA+TbK++Ak183JvAbBvIZCIt69jGcDVpJSPxpEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adr4ygL/zLnX7PwK2iczxEdPYVEv67uEre7Dh/VY27M6zOuw1zC4sXV9uuEHKXZVBkUa98J73sDCnLa38uiwSKRFYJqfrte7hPZCRFuyDKKMNWmMpla1g8UqeLFwBpTJDYx8I0f1QlJMvx8H857dxPuVjrgm70r9wBvY0VUp1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dCMAb7hQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dCMAb7hQ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2021537a8e6so3901185ad.2
        for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724931469; x=1725536269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uwnGCH/YIzPLaHUb/2waUJ87bIA5++OGLa9jaJO7I8=;
        b=dCMAb7hQ5kGZLBBW5BJup3+L4zEz2hiCjVacfHWmJslYHpeGLp6nhbOsgHFm5Ak6u+
         Mp03g30F8H/uHSXuXLvQmzt+lkrro6xkFE6VnFXg6/I2/5g2qjJ15r9o0PxDdAfJpZpB
         OyM0Lk02J22rA4+EMfALbLXmjLaNKNKZjSIzMm1B997Txf1SpqmAGj4w95NR8HcWhyM5
         6q9Y0vV+pSA8kfVRXe07KNo1aDHHtPfowVkvCqUjEmWuXukMkgtRRKTmLvcGRoCWu17i
         NstFa8aniz3kpZHUDEjgXizqbYSBHARPFCyt2hn6u3WDXL+hFhsxXd8RbRVdyp/dxNop
         esqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931469; x=1725536269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uwnGCH/YIzPLaHUb/2waUJ87bIA5++OGLa9jaJO7I8=;
        b=nsyNobvm/jgkfsd40R0K3zulVS9pg/IZ2hZVkGgz5iJZ32rcze6m1YXUoUGxUPnOf9
         izrekQpISpJ0KgakZIj6GxuBVxzrR7/mvplIinVNDLsNd0Nv8RB5sE0sS5LDTaP3sVSx
         DdliQuXjLS7HBCCsgPfo9cvRVmHuygNcZOegJvCFimECejn3Pe3mQ0tRazdZeRKUEWYC
         Cc4pg25Q2gpzFV2/ZkVDXJ+RxFG/wamO4nwkRkCnsuedwsOykEXFXKl0KwhL0jzgQwXv
         0uvlcCJ1kjr7/xAR39m73znXN2361CZbZcTnezCB60MUu8kIqsInNgg4I5/MMgxY87XS
         TKXw==
X-Gm-Message-State: AOJu0YzPJ/xwk/MmFw6/7zIqmCBu4p4z1TwJ9+oclb5R68PTxzJl1RXw
	I5ZbNuwTa81kA9oqRMdpaPqSbV9lxAovmFhwYRgg+2mX84XYfksqy8rl6DP7Hjsvx1Y1Cdg0wP7
	k
X-Google-Smtp-Source: AGHT+IFCzL8y6Y0fPNCJTLQKLePeR4IrAq+Gu1W+X4VnQGS0d3COJICgpMgUCJOuCGUPlJhD/q5ZmQ==
X-Received: by 2002:a17:903:40c6:b0:202:35a8:42 with SMTP id d9443c01a7336-2050c46ca2bmr26184035ad.49.1724931468980;
        Thu, 29 Aug 2024 04:37:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152d6a82sm9666505ad.73.2024.08.29.04.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 04:37:48 -0700 (PDT)
Message-ID: <e5e97bad-075a-4d78-af78-3bbc124c06b1@kernel.dk>
Date: Thu, 29 Aug 2024 05:37:47 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] bdev: add support for CPU latency PM QoS tuning
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
 <20240829075423.1345042-2-tero.kristo@linux.intel.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240829075423.1345042-2-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/24 1:18 AM, Tero Kristo wrote:
> diff --git a/block/bio.c b/block/bio.c
> index e9e809a63c59..6c46d75345d7 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -282,6 +282,8 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>  	bio->bi_max_vecs = max_vecs;
>  	bio->bi_io_vec = table;
>  	bio->bi_pool = NULL;
> +
> +	bdev_update_cpu_latency_pm_qos(bio->bi_bdev);
>  }
>  EXPORT_SYMBOL(bio_init);

This is entirely the wrong place to do this, presumably it should be
done at IO dispatch time, not when something initializes a bio.

And also feels like entirely the wrong way to go about this, adding
overhead to potentially each IO dispatch, of which there can be millions
per second.

-- 
Jens Axboe

