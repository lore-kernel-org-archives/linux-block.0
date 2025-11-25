Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864051487E9
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088426; cv=none; b=F/IwulHYBG4V76gqAbAXCM3Y4NDcBW6Ry6pjZCSQJOxMsVHJ690RNsH6C+ffacVrsj/g0D/Jy/BAxn5zKTB60MknKfExW7/sPherv7FsGm/CADEsE7B+xQvQmqUWJqMRwOA4tNnJe0/B07wGgVC8GtirWip/bHSfbj9gPrhuQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088426; c=relaxed/simple;
	bh=/MKVdZuni/Te6fIz+o62Jy7JaM786KTHt14gdDi+1To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roIqSjA8xdldu2VU4r5ywST7r8tD4nGdYGGy4xmV3gFKPyMn1VH3xESk7quSiuNXrOepPdYlflffTZphD775D5EBFE+8AC17YZNFch/NqQV5VyiDYeG1BIx/3WyLRjDmbQOU68NRBik7X2V2zkBsRQKj9HWgjEZRpuYw2+zrPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WHHk4xrN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WHHk4xrN"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bd5cf88d165so324807a12.1
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764088424; x=1764693224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAAgrHnwc0Uw+tyk/0PGollu1/xHO3jxKmRu9vaSYtQ=;
        b=WHHk4xrNyNaxRN5o36PsX/rp1lRU1EGXvYemelTPADrk4R2hvNQsY0lwdnyW0zOd7I
         mIwm23d4VRp38exylCi7pX/pQ5KMj5H0dIrBDP8KlnOvYx/ciwawyGAe+SWfFBnZL2s+
         UlltvbTY1uNTFlPMecs8+T7P/IsfAkxh4WAjytmo/WAb3FOQjbf2pWRRH3XtAiTlK8ry
         daBKFuFTigvA5mu9mir6Q8A7f6vobnI967LLQEbsUIc5wDd3r+ebyvjxUK1yn6Fym349
         zqTBjUl9ZQPIE4t54dOrnzKWKYrVMBJVyS+cxYS3l5FwfKxICuBTzz8mdxC2AYlJfCup
         YMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764088424; x=1764693224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAAgrHnwc0Uw+tyk/0PGollu1/xHO3jxKmRu9vaSYtQ=;
        b=MTouCdbVMUZbnwTwVb4/FqL3EXuPVSZbUG2x8gazbHc2tPjTbVHQGN7DmzeH0Klh8y
         gDa8A8iKbyUyvwLC3yANYkAkpfrHYk7FbJ6kaZUP0bhSFwao1dHiCG8tNCKjeuITZpVN
         ob4z9F1yX00ltr+f+geimPnVAIY8NTtuymJ+8qtzTk6A5uTxk4hkAs1mPp4AZQVPMkoA
         kK0uA488XS0A0P8t2j0ry0bRZBaEBcH0sDFnUs/88Xy+LAH8ATWn6EkRkSTZcoWL86md
         N2bg+JIAea4GmY0dqLwKnspuqnrBwdcMu4iCbTZxkePkGfXmRrWk5PrqgvUHbFOwMzfy
         TyVw==
X-Forwarded-Encrypted: i=1; AJvYcCWdPhy4G3Q6WqOSW+U8UQBFKsHyT7uapT8ORbpuCN+Abiz+L/d9jaSoRZZkjo087qgBoOAWIQ7PaSnMnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQakiY7mINzkBirS/yiF+KSSM2p8l/t1Eq5yj4BCBbmfAwl/J
	nOlMZNLPyQ5b6sjv+cLTDbfW5wMDQQb+oaZ13TD354VtysLaXaOSoz6XCDZU2lRKWz91VljZu27
	1gPRaMsBf9M3/IogrciRXz2Iyc+8sUb1gR/3T4tJpOA==
X-Gm-Gg: ASbGncsM6Pm46UtpDiMbhx6NPVJWxNC51emzdDRRbRDDatj9vejL6vKLhVZ2lU5Rmik
	9SqD6zdCvBn1fK1VGHFlFhD0uEIlxXeI4N3U9pUI7OqyT9zW0WNVye7H+/cvMBWkRn7ZSn900Ru
	QbmivAfIowh6SONo5aGzHm7dzc4JU4GpLy9ogUE8VAmC9a+NM1cG2RT9epsXJtOOPpZrBfUASee
	5umJO0SS0mqkIH5JELpnHHWaQEETm8cFBEGRLgIH1tDUctQFug/SOFhmH4yb9vTUy01
X-Google-Smtp-Source: AGHT+IHiUx7hG71zkWmvHWr7ctB0boEFrMluOA8S8GVDzt6RonmFY5TCRAeAdiSwoAN/jTkHUTHn3o+LGKgUuySc9IM=
X-Received: by 2002:a05:7022:ea46:10b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-11c9d8678famr7935265c88.3.1764088423562; Tue, 25 Nov 2025
 08:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125130704.5953-1-fushuai.wang@linux.dev>
In-Reply-To: <20251125130704.5953-1-fushuai.wang@linux.dev>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 25 Nov 2025 08:33:31 -0800
X-Gm-Features: AWmQ_bmJp9XHPG_oR3oFvveKJi44wiVWYY7j1lhb73csJirRImsz6ii4uu4ISTc
Message-ID: <CADUfDZoaXZE4D4L5+M4m2=b6j4_PYKN4zNZR=MxegzU5BkS7kQ@mail.gmail.com>
Subject: Re: [PATCH] block: Use size_add() and array_size() for safe memory allocation
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wangfushuai@baidu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 5:09=E2=80=AFAM Fushuai Wang <fushuai.wang@linux.de=
v> wrote:
>
> Dynamic size calculations should not be performed in memory
> allocator due to the risk of overflowing. So use size_add()

nr_vecs is an unsigned short and sizeof(struct bio_vec) is 16. I don't
see how the multiplication could possibly overflow a size_t.

> and array_size(), which have overflow checks, in bio_kmalloc()
> for safe size calculation.
>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  block/bio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index b3a79285c278..c7789469c892 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -617,8 +617,9 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t=
 gfp_mask)
>
>         if (nr_vecs > BIO_MAX_INLINE_VECS)
>                 return NULL;
> -       return kmalloc(sizeof(*bio) + nr_vecs * sizeof(struct bio_vec),
> -                       gfp_mask);
> +       return kmalloc(size_add(sizeof(*bio),
> +                               array_size(nr_vecs, sizeof(struct bio_vec=
))),
> +                      gfp_mask);
>  }
>  EXPORT_SYMBOL(bio_kmalloc);
>
> --
> 2.36.1
>
>
