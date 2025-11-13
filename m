Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20942F6563
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000423; cv=none; b=L3ermblZr9leE7q95hPpKVmvn5v/PJ6AH0AcKNJla+RVZ3p9wDsCgfPmDKPI1kQMwYlZ8sEEuokY7vi3POws5BSMNNuS04Vq7L1m4PnWCgLCJdNgpRMY2VQlz7KL4KbV3eReysIU6BqNV7diX1RKvbfVshZlQLoqOs/mSznE5UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000423; c=relaxed/simple;
	bh=fCkzI0NP2q5JcJvxTPOpaNWnDEjnFQu9MkMV3EqXpMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AioGeF4b+WQ7rPRXw0IE9pW/52zQzGd5UYHro1kpcTt+p3FbMie1/3d2Um0QT9Z/ncEtI0n9tCBcDJVlIIAgMVUGiuBI8DHN8+nJ8QDXOZksXX5E0Mvabqp4odz1vMnyOAYLuh0yGU0ksUO+fjMbjxckpYK7ZipJLWEwJ4KBt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mSlQubCu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mSlQubCu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298039e00c2so3346225ad.3
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 18:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763000421; x=1763605221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/w2/PdviRdTlw070F73adAMmi8JBjtS57Q4Bt5NlWRI=;
        b=mSlQubCurCgAlCjkrJwBE8BO9AVRZTKeXRL0SP8GCUsP0/m8QYMdds9WgW+YpX9CfM
         rkPDkB5dVygBbneOM+ST0iRBhkSLjhM9G/WgeL6lnXMQrnkygWcttzeUf7BGi7KSLlUI
         WGVfVddNKRkwcApYQvf2q1pN3tTzYpauemJGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763000421; x=1763605221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/w2/PdviRdTlw070F73adAMmi8JBjtS57Q4Bt5NlWRI=;
        b=KtxVEc7sGJhou2aAN9Nm0McvCpoGC88H7MsCqMPS3lShLpR/m5drQKep3EksYMaoKC
         +TxyGnKaAXWJ4qAkB4maqTjmOc3BRIFawiyvEgbHqz0VILjl0yQaNYnr77V7PB2f0O+m
         XZwrVf90QQr36SdAHAGyqQ8c9QhOhvqMBg7Ka9VlGK6SY9UbBMpNZsB9nfwE/BJlF4HF
         uLv9HIhP7r5+9y4Ey568gmm3ttNZwHINuCmB/Vj9M9JHtap7icjLsNbFdEqhS5viaQHP
         XHqIKbYBLVAxlIqmaoH0hQ0sId/zODxBBWTZuZZepNlJTBaOt30kkyQImkhjvlz69sLt
         J6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUN/ff8WgHiTQGFtqKolkeALnd0gQygbQdfVSPO6+/9/mgGLk4a9DkEp6botu6pXeJ7rINY0KMYA16peA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwerV6gtoTnA7/4cs515vYolCvdh/WnmLs5uZbKYFAWj/G4Jjg1
	wG9cdER/xCIE/GOdvBRv7sR0Mun40x0KPrhCi3pDaYQKjaHp/KQO3WdietLKvlb1Yg==
X-Gm-Gg: ASbGncv+dqduWBNkkfd11NrV03+Ei7ccaVdO2Oq14b76Hk6CZw5LJ/KhGoX5poIHV4g
	QsIN4HbDXnGu0e5Lk82FGJQyDeUuJ7aE9PahAudxfQUq9jiuphV8YY/V8FHoL7y8FKiphMZUkZn
	WsIVDD8nfT2X5CBhCPb4YVE+tWgP5STJMLBw0t/J0K7mnZ6s4XXviQKNwuyGxojsgr38zvqEzBr
	r081106VZJGjSXcNJIch4Z0v7n350mch4N49W6FWA6SrXTCw2ZjytiPbIumgkwigz/G5i1jmv89
	7a3hSI3v1xNL0j5TC9iShRQCY5EKyVZRVHX1klZ/LT8nPr4vTiIxuhuyFRPpWeBWYw/dNFjhkx5
	THMrfJLbFsyP9Vn/5dLqHjKXb7MTNWuVdBM9aOiLBL0xdcfBbhMb44txVDcIwjg5oedZBWoE4Hu
	YMsIb4
X-Google-Smtp-Source: AGHT+IEEUGpj/C7xlJlOjaN9FHEmFsBqdEM3aCXQOZ4vqMNOSNOagKZXMJ3scVSlRlMs6U2ceqWAZg==
X-Received: by 2002:a17:902:da8b:b0:297:d939:393b with SMTP id d9443c01a7336-2984ee307f5mr53960045ad.58.1763000421049;
        Wed, 12 Nov 2025 18:20:21 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:f9c3:243d:2a7e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36fa02c42sm462699a12.16.2025.11.12.18.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 18:20:20 -0800 (PST)
Date: Thu, 13 Nov 2025 11:20:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <x6ksirxv2xffhzpvdxmm5fa7r4b56mlh3kbhopljdsvwzg62wm@rrsslefk4rb4>
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
> +static struct zram_wb_request *zram_writeback_next_request(struct zram_wb_request *pool,
> +	int pool_cnt, int *cnt_off)
> +{
> +	struct zram_wb_request *req = NULL;
> +	int i = 0;
> +
> +	for (i = *cnt_off; i < pool_cnt + *cnt_off; i++) {
> +		req = &pool[i % pool_cnt];
> +		if (!req->page) {
> +			/* This memory should be freed by the caller. */
> +			req->page = alloc_page(GFP_KERNEL);
> +			if (!req->page)
> +				continue;
> +		}
> +
> +		if (!test_and_set_bit(ZRAM_WB_REQUEST_ALLOCATED, &req->flags)) {
> +			*cnt_off = (i + 1) % pool_cnt;
> +			return req;
> +		}
> +	}
> +	return NULL;
> +}

So I wonder if things will look simpler (is this the word I'm looking
for?) if you just have two lists for requests: one list for completed/idle
requests and one list for in-flight requests (and you move requests
around accordingly).  Then you don't need to iterate the pool and check
flags, you just can check list_empty(&idle_requests) and take the first
(front) element.
