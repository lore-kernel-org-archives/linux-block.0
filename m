Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637745;
	b=z2HarIpJKABT2akGwfH6rf13+mu5Ac8zUn7xPJ9+um5KWhHhM4HyiU+VCNwLIxu0z2c2
	 rgKzqOXboD9PA9ZlNfcps7mBaqng5Dej3VZS2BiuE084t9uitHdDUFliUSMQBelZwiB5Q
	 tAb3pVp8c9AfnnEONfzHfzrYhBsyjPUmk2qE77FDA3YeViUsvW4X2LLIVFERMKoYB60SU
	 YboiCd/2vY1AjLg9xOR+1uKf8GlzI9To+hFmfVf3EN8aevkDJ6idn3lmlDCDP3SLQfs99
	 WfD42F0tA7ck8lj2zrjAz488h29w5da4E5ubnFE702Caq+OYC68ZzGmmmL6jG1mdKOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Cr4fF23yKRo0SqQXK8klVw/Syk8sr6hkGOQHdTp+MUU=;
	b=ACZbmLYw3xYQdrG3Ez9nEXmIAzF+1+TJOuL81UGPXqSZ0Tmd9BssmTK/0THjCFrIKzed
	 PUqGIF2eXkHt9Wd3xvUPaj0HyTLuxl8SE58UHNnUvaq74zaIUWkVUYBVkEOfgRTxpPm8H
	 02Fsonnkhd5yJ1V8PhXCC9SQ7FyxDIXuoy5MRfSc+lmE9V/zKFY4q3tMkN9EByYUlGfRa
	 MZx9WF4/k3CZrd9gKf6RxBqp8IU2mWoc4symkV8hlyp0EhSfBNkj+wYyAE5OfHeNJVfSw
	 rF/x5B0TjaOTrP27wJPuWoEuv1WmpLLE5p8trgNWcBlpqzsTXpDYApY0L8EtpeGxZ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35765606A31D
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 02:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35765606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35f1f76ea84so2003558eec.1
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 19:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792637744; x=1793242544; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cr4fF23yKRo0SqQXK8klVw/Syk8sr6hkGOQHdTp+MUU=;
        b=hXvKaNXjGoRUKXPDJB5peVk/oGgRC/sI+dePrB+CKlNOPHv00cw2AezXkZkIce/MJ2
         sWsnWAh4jWTgiq6EfbkB3FKAMgojpfE5w0g++3+00XlIdfkldU7rbrWrymeZAk+N5hpp
         p8xwuziRQec6hkbg251u8lYdHCNyy16me0NSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637744; x=1793242544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cr4fF23yKRo0SqQXK8klVw/Syk8sr6hkGOQHdTp+MUU=;
        b=eTaG3ruAkvELhNltqexn1S1vUMi9swQIe4sQaKG6m805/wisJ2l5pwMrzrzdzmeBcU
         KTALdYI7g5ky4F4bsKqxCOUIN1Mfab1CVf6VEL8dxCh0Cky8LbjVdc7wT8JgX9lXagMc
         PpjYuZHptgGmV+NssWV/2guDvTUiMAQdope4i9kboAvrB0hByJTWpcePxGyMcXFB1DVt
         IrQLITf9Ovr4kQMdPublsxKqVGAHlGtc+i7Lx3iJE/+KTS/q1xpJDlZ6VuMIg2zlJGvr
         zKU3o+aPFcF1wUfd4S3Vnewd1/blJ0UBrMsPBCTxdobKW2S0WUDRCwS0LPQTOXAgQm/d
         6yqw==
X-Forwarded-Encrypted: i=1; AKwUvBzbULs4ltXBGulHuv3nyYag/Gfq07qRaPzzdhjZZvVhno5KLt2vrPyLY9XpZR+nz8XAeexW8Y1ZeCqdJw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIRj40YVakJevZ7yg1M5rLbQ7/GEvuJlEfmKO1kU5UY6Pl1+tt7
	Rw59NvxWXpllxCJbcIQPUPrOlPGcV25iqe1Dqmk/ry0unbVJbwhIUUou8rYP3yxD4g==
X-Gm-Gg: AYBFou3hXOuy23xEZEQgSaxtQkW1PISBGCVLJ9oB4ZF7fiWDRsy5Rt0k6yREhq6uk1c
	RUbVfvaTzLF+u7lZQt3NG8YzQV/EbS6CIoM+C+PO5qeJawYcSy8FX56i+Ys8SDq/aiRbNZlLSFx
	GMT3V39898L3F0Kxtuz7w5ZkOgatmhMs/QEe/rRCrL4cuIe0tWlnxJ+XhYO2E8R6XbF5dsfCu/R
	8XoHxS9WrTdnPjTGRpYx0ZTggnQ6s7xBIGi1avEH0dt+9hM8sYyfkISci2L0SNvJoOlCZTe7PBA
	cGrcVuBfaa2K5Jr8NmS3ZS9mgM6ZgXesYrzqJek62qe3E1dpxQUeBJhHOVwP5mOv3f+G1fM4bI6
	zC+E+webLk5iBcP/71oofahcl+K52+og33FYPQ7XyM27lBk2rkxdKGenqLOGLD7Latx1XBjEg9z
	5esoy+Kv9OWiQRxfa5EHi9IORddH6bjpgtdyFaGkj43rDo3VJ+mlkQGsIU2FS/2zkdPCZYjk/Rq
	HDJibkXP2gQW0vUGAA6CNraM5FEIr13uw3EnEE1rl1k0EKRTwxNOG6l1L9OaM4B8u1Ibn06nKtL
	GVBtTRKn249plfmLy7ifdjwINiDHHiA3NipRaG1s+A==
X-Received: by 2002:a05:7301:f89:b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-3674f1186b6mr4958712eec.38.1792637744268;
        Wed, 21 Oct 2026 19:55:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5145:5add:2df6:4671])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ee5e3sm11457355eec.4.2026.10.21.19.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:55:43 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:55:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Hongfeng Chen <chenhongfeng0212@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, 
	Wenchao Hao <haowenchao@xiaomi.com>, Wenchao Hao <haowenchao22@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Hongfeng Chen <hongfengchen@xiaomi.com>
Subject: Re: [RFC PATCH v4 0/2] mm/zsmalloc: defer object free to per-cpu
 batches
Message-ID: <atl6mcXcDt9NZoW8@google.com>
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
 <CAKEwX=ONniSwdiZAe_8NT5XwVj=Mmc-WJs_rWE4Y5snjFg2=Eg@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=ONniSwdiZAe_8NT5XwVj=Mmc-WJs_rWE4Y5snjFg2=Eg@mail.gmail.com>

On (26/10/16 09:09), Nhat Pham wrote:
> On Fri, Oct 16, 2026 at 5:10 AM Hongfeng Chen
> <chenhongfeng0212@gmail.com> wrote:
> >
> > Performance results:
> >
> > ROCK 5B+ (RK3588: 4x Cortex-A55 at 1.8GHz, 4x Cortex-A76 at 2.4GHz,
> > performance governor), single process munmap on A55:
> >
> >   times in ms, speedups over base
> >               Base       Patch1       Patch1+2
> >   size        time    time speedup   time speedup
> >   64MB       13.81    3.62   3.81x   3.28   4.21x
> >   128MB      28.50    7.18   3.97x   6.49   4.39x
> >   192MB      42.19   10.71   3.94x   9.69   4.36x
> >   256MB      56.06   14.26   3.93x   12.89  4.35x
> >   512MB     109.50   28.43   3.85x   25.66  4.27x
> >   1024MB    217.10   56.70   3.83x   51.15  4.24x
> >
> > Same machine, single process munmap on A76:
> >
> >   times in ms, speedups over base
> >               Base       Patch1        Patch1+2
> >   size        time    time speedup    time speedup
> >   64MB        5.59    1.58   3.54x    1.49   3.76x
> >   128MB      11.86    3.16   3.75x    2.95   4.02x
> >   192MB      17.18    4.72   3.64x    4.45   3.86x
> >   256MB      22.89    6.29   3.64x    5.87   3.90x
> >   512MB      45.15   12.52   3.61x   11.64   3.88x
> >   1024MB     89.16   24.75   3.60x   23.12   3.86x
> >
> > x86 (Intel Core i7-14700HX, P-cores locked at 2.1GHz with turbo off),
> > single process munmap:
> >
> >   times in ms, speedups over base
> >               Base       Patch1         Patch1+2
> >   size        time    time speedup    time speedup
> >   64MB        2.87    1.50   1.92x    1.14   2.53x
> >   128MB       6.00    2.93   2.05x    2.21   2.71x
> >   192MB       9.33    4.35   2.15x    3.33   2.80x
> >   256MB      12.51    5.78   2.17x    4.38   2.85x
> >   512MB      24.96   11.39   2.19x    8.62   2.90x
> >   1024MB     50.19   22.78   2.20x   17.05   2.94x
> >
> > 1-4 process munmap of 256MB each:
> >
> >   times in ms, speedups over base
> >               Base       Patch1        Patch1+2
> >   mode        time    time speedup   time speedup
> >   1p         13.18    5.78   2.28x   4.35   3.03x
> >   2p         25.83   14.41   1.79x   4.57   5.65x
> >   3p         35.70   22.14   1.61x   4.68   7.63x
> >   4p         44.25   28.71   1.54x   4.75   9.31x
> 
> The numbers look nice, but I think it's a given that if we measure the
> process whose work is offloaded, we'll see a speedup.
> 
> But would this come at a cost?
> 
> 1. Would memory freeing be slowed down? Could you compare the host
> memory usage over this period of time etc.? Hopefully the parallelism
> would cancel out the extra overhead of setting up the work offloading.

Right, especially interesting what happens if OOM-kill of an app with
a considerable amount of data stored in zsmalloc pool, is not immediately
easing the memory pressure.

[..]
> If it's the former, we should dedicate more time
					^^^^
					and tokens ;)
> towards improving zsmalloc.

