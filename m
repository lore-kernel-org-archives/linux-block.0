Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CF19F13F
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762750174; cv=none; b=lFk5dwKG0wKGf4LnzoSNWW8fhypTmz+q/C2rKWSC7D427OW9ZC5LOVTDNIZvBF0q5AICpXgvQdQNVBk2/R+DxUptQrEURCDdJHQfIvwlbdQymle9PDilvvDCfZH62dVs8KFjm2YwCCRm7s5whBv86ODC2hlUPwdtCQoeZP27Gm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762750174; c=relaxed/simple;
	bh=JJrfHDLE5lDw8HoUWCOGU+LDxN6zZNc3/zArvkGfYpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwR51lnbt/3OtLXSwSi5SOIM7TQbNubIhgE5bdZG5Ls1ojtnzy4LC46BU1MFyaZdRclZz44ekwMLKNUG3gh4lltfsWf9cUUsncDV1Mz4ONer42wuFffJjM0yUV6X9umnV5Vb77Rs6Ciy6VY/xvpQ+Oxofk7SgaxZRZXe131wQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=av5QdGqw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="av5QdGqw"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34374febdefso1493391a91.0
        for <linux-block@vger.kernel.org>; Sun, 09 Nov 2025 20:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762750172; x=1763354972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJrfHDLE5lDw8HoUWCOGU+LDxN6zZNc3/zArvkGfYpA=;
        b=av5QdGqwPYUO2zSK3VcL92zqYDt0Ngw04kbuF15dA0MagLBPwNPpbSe93rZd8bpay1
         6COOOuhwTXoAvfP8eeN0YBipWsMUud7BwWcgumjPHlSpKkImTRYcj9nAw1w8f8Q0ZB0L
         h48JWkV/2MvCDYdYjz4wxVGqKo5xMafun/ekk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762750172; x=1763354972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJrfHDLE5lDw8HoUWCOGU+LDxN6zZNc3/zArvkGfYpA=;
        b=knHOy9JOm3B8qbCyS2ejTKFHL54e7t18Q8UdIZAErm3M903/ipXDdhjkwNykBYQXWF
         1xsvA2CfwGm5/DD2Jnptb6P7WGPTvfEnoCTCxOBmh9Sop81AraqqdywbsQeFdFtcbVDN
         20iOlf7o/wwZ1RENMgsQvgsQbqXCR6/MrRzWKTJ80B/BGgeMY4Utcqa4gcTHGGJfsGoG
         LCZB95Olk72M93H/5MEo7lh9tMHcJdoz+qsAUFvxn1Bf2OWzmOGeRqZVkhLCxgJgMmq8
         Ebm8yDoHY/RMpQZ5mjnUGRyfBHCZZq6FPhhxWDzfw6QlEwPgFwKhaYIhrgvhJb+lXVOo
         9bVw==
X-Forwarded-Encrypted: i=1; AJvYcCUzGGkaxahWeH11lUPSAaUY3pjPC1eDpeCmkQ4E02k51s9hNrcE86f/9HQ5bZJU9Vwgew4lG0uaM44ytw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEdpe9dGvp1S+eXeGid5DMhyb2QWePz4q+RwUt9YQ+qVd0Kur
	bGpokVKTKrBJU7e2g1qQEjjsptASxYhO2BfRpgHNLSuZBdpUJjha6mMKvjVw7SGQUQ==
X-Gm-Gg: ASbGncvTPEf4DKFyJWIz4rPTC/6aXMOXmY7J6ZyHNT3m6bAbE5rT0yj/rsYuLFEcZfa
	kuxceJa/UbmqIShW5xB4iGBjYxRbS3DbCK8cImwMrbHm2VP2sKQGASyOM+SEwYuu7WOp9oc+QiO
	SBiH+ajcCvzXnuzYt3imMojIQk8gzxPc43ckZ2VwIwLIzzuOw2aYrioS3cNs9srx2DVb3hDTuly
	0xi4SV/YGLY7mkT6JZrYmMcBK/PWDU58fRW/JsZf0BJzCF3l2v/2kmmyXZTSgCd6TJ+/PwoUxik
	wWz3q16gb6ea1+2x6t6GK+gF09caAW6dWLxja/W6YgiZzMDwqJD1IttrLwnjf9BzxLuNRu2tzIB
	iIZzY80YZkx7MOFrfaaSpgvSwiZJwoiiff/nSUdBoxS8lLF1hHBVe6CCSwNlCRoSkUjnzVK8rP1
	XlnCMkoPHqrv+NTSM=
X-Google-Smtp-Source: AGHT+IFU2CaJomS2LyBwnHV14ftccCZxEQuCF/t81lUe+RkW65j+E/MggTuG8Flk2e7EBPHiXfOouw==
X-Received: by 2002:a17:90b:2d81:b0:340:c4dc:4b70 with SMTP id 98e67ed59e1d1-3436cb7d916mr10393716a91.6.1762750172021;
        Sun, 09 Nov 2025 20:49:32 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f189:dea3:4254:ff1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17ad4asm10139624b3a.37.2025.11.09.20.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 20:49:31 -0800 (PST)
Date: Mon, 10 Nov 2025 13:49:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <yv2ktkwwu3hadzkw6wb4inqzihndfpwb42svuu25ngmn6eb7c4@hclvcrnsmvvk>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>

On (25/11/06 09:49), Yuwen Chen wrote:
> For block devices, sequential write performance is significantly
> better than random write. Currently, zram's write-back function
> only supports single-page operations, which fails to leverage
> the sequential write advantage and leads to suboptimal performance.

As a side note:
You almost never do sequential writes to the backing device. The
thing is, e.g. when zram is used as swap, page faults happen randomly
and free up (slot-free) random page-size chunks (so random bits in
zram->bitmap become clear), which then get overwritten (zram simply
picks the first available bit from zram->bitmap) during next writeback.
There is nothing sequential about that, in systems with sufficiently
large uptime and sufficiently frequent writeback/readback events
writeback bitmap becomes sparse, which results in random IO, so your
test tests an ideal case that almost never happens in practice.
