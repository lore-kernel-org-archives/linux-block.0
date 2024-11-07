Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711C17E473
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945399; cv=none; b=mWR9T4V5sEjoug/j88y4XLCMxAwG+ENvcbJlcpdEzIZjzekeEKmK+8XifKbsZQCDfzV3XU3rWdDpQfArZyRSAaT/q0/bLlo5B9lr3c6OIUblrM3zw3kI33+3WcLVIovpT+9RSofOJkqbBf0EinnaSTwhrMY+Kv9KTcWiDXmLlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945399; c=relaxed/simple;
	bh=U9UwNAev20LVjIzoelIDNy9digyaRx9q0qybyVFRXUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slF782oIJzS/fJMFEpvqwwF1wqAANADknRvLvaXnutI/npEeMWlX9T2xYBbNyKs9O/9V6uKJzcGQx/GsY3s3Q/yUwQrAIexYOw8xx2vSxpxTCqgzAn6bibPWz+Hq0cd8D4z3XiebD9BpiczjzRaDMY6j3wA+zRvsgGq8Qggo2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=o37u+N6W; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="o37u+N6W"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e5130832aso307630b3a.0
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 18:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730945395; x=1731550195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5VEXH/UjVZxKSBS42OsN1z+40kpn9n52otycPhBNjg=;
        b=o37u+N6W5u5b2gtR/PZami0YGkuUQpsCQQQEwzHS9f3Axo8vf06/YD7OxwHceCDcni
         GgUsy1fNvkpaQ5+7HkNf3OqCq8s7KjrvfGh56TLOVTGqyE3SaMrT5tqhCm5ZK4BrekFX
         el08KYfIIqcbYQpO2RCRXxj9CImDomBNJGsYFmPN4OexxtmDCf4YYQlYAtBWGlraC+TX
         erQxB8PN6CjVZhmoIpI7pZetZDkqnZr94yF2VIB4CVOqHnvIZamELJG950Rv9C2pmf0a
         GxOh6J65yKCwRohGmy+SJWTFG7/63TIfZUcnzJUT1ihbvl3zq3ajUPqAjGXiAQo4AGNp
         f/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945395; x=1731550195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5VEXH/UjVZxKSBS42OsN1z+40kpn9n52otycPhBNjg=;
        b=hGA03mcjNczz8423bnqwe8TISZeU+eNNBkuvYWG7Q17d8AqvWSly8mOgInnBtgd8N0
         nHWE9jolayUXWJCtxckDFiy144FwsuXqBkAOfTXr6ZpVMjiRpcACElcAvm71OLGjYYPw
         N900gkFUNlsW4bcusJ0Tw2TkpkMjCjYdP30TJwgCrvMvRxh2h1HtLD9p/UUI2MUCptaf
         WsqlMauzm4b3ZovkVKokCNTWeSMBEgh54+6vdSlm9P3LD0b1YDYQdL+yERtK0cvFY8Bn
         Yp2YgI3qxjR61YoT82SFZQFVZvhaYKWXWw+aS63zXsrfLTkDFKVadhJrdula0USMlQgD
         MJbA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ118FgnkS+HCEXCCsZrAsgfjci/JbJLjsKOBcclcab7uqtI/Kr+IzHpplJwBCIZl4jLgMZttO5B0V6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfps8Fz136v/shMSmwzeEv+qdc82IN5xgKJVFhBZVQTSZbwDYn
	svQVsoKBVa3sqGEn0qhXYaKBhlj9JJEJdH0WgSlfM8bfcno+Z7LKBPAiOHRQtuM=
X-Google-Smtp-Source: AGHT+IE4FdVcCFM7JfMcQ3SKmd1UC6mzCGq6q6jfwTYIDNNfVDV6mTuEsMVwx/N+IlnX034mAbpOSg==
X-Received: by 2002:a05:6a00:170d:b0:71e:1314:899a with SMTP id d2e1a72fcca58-720c998d8b9mr30360940b3a.20.1730945395467;
        Wed, 06 Nov 2024 18:09:55 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a50512sm256626b3a.173.2024.11.06.18.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:09:54 -0800 (PST)
Message-ID: <e757bfa0-0c21-41d6-a072-ce85f4ea8a04@kernel.dk>
Date: Wed, 6 Nov 2024 19:09:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 6/9] io_uring: enable per-io hinting capability
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
 javier.gonz@samsung.com, bvanassche@acm.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-7-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241029151922.459139-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 9:19 AM, Keith Busch wrote:
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 0247452837830..6e1985d3b306c 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -92,6 +92,10 @@ struct io_uring_sqe {
>  			__u16	addr_len;
>  			__u16	__pad3[1];
>  		};
> +		struct {
> +			__u16	write_hint;
> +			__u16	__pad4[1];
> +		};

Might make more sense to have this overlap further down, with the
passthrough command. That'd put it solidly out of anything that isn't
passthrough or needs addr3.

> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 7ce1cbc048faf..b5dea58356d93 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -279,7 +279,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  		rw->kiocb.ki_ioprio = get_current_ioprio();
>  	}
>  	rw->kiocb.dio_complete = NULL;
> -
> +	if (ddir == ITER_SOURCE)
> +		rw->kiocb.ki_write_hint = READ_ONCE(sqe->write_hint);
>  	rw->addr = READ_ONCE(sqe->addr);
>  	rw->len = READ_ONCE(sqe->len);
>  	rw->flags = READ_ONCE(sqe->rw_flags);

Can't we just read it unconditionally? I know it's a write hint, hence
why checking for ITER_SOURCE, but if we can just set it regardless, then
we don't need to branch around that.

-- 
Jens Axboe
