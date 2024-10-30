Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87619AD8C;
	Wed, 30 Oct 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311017; cv=none; b=pL+sa3a2S1eXTRzMBfUe+3I1pZLpNxXZeM3sFxmWW9WOSTXosI8MYQoRWw8n/J2XMmyamSJTFUiADi//TQrPDXbCWds1QDKZvzaVm+iB81tG3WapvHnn2fIqVSEuj6BawYfyn431C42PNjbwnvSnIMnQ+c0rQY7arVvFZiB24Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311017; c=relaxed/simple;
	bh=aHXcN+ExzinhTKCXsF4nWfT7Ro+mpGxyap5iDqAMKh4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=LtKSX/RPJKmpu/rAtghsC3PqDYppTyo+fA+06HBr7VckTu5/COxZUfOsDr25xf3sqcTNakx7al+EsabiysC6pfYXPJQMr5KraRiWGU233GoB+MWu0ynaOwYnVzc+9bmtu2EVZRByxrHrKZxKP0WpUTt4a9ZwKQpifa9ySHd8TOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNNfeHxF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNNfeHxF"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so140988e87.1;
        Wed, 30 Oct 2024 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730311013; x=1730915813; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBrQs85pdruV9a+fUBhZBc6S+tBFf92Uv2s4okRK9jM=;
        b=YNNfeHxFTh7nu++mGnVGleh8eC/y+SNjd5Uq9g/i3ci1ujyudu/7qWQ9nSAtXqyZrS
         yzUGuxkNLDZIlk4VkhJldJPilv54wXCkbMGwapUlRWPA+sROqqQ/zEx9NdVfpTCtVKN8
         yMCGUfRDGlbVdejZhKDGNm5t47MLLBdgw5RnC2LRAIJM2EbsBXLBQEMwqJUdkJT1vgvl
         KUH7vPh2ryuYN6dhwZB0dt/5fSMiT/kI4WzGaIFmURCY3l5Dr4hske6WiMT4OL7RaGEz
         tz0oAhct0QqMa5/6Vmb7xTR8hg9IGwFPAtU1U9b7IrJ/oUKSOwJNeUKZgb2cEJNpFziR
         yMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730311013; x=1730915813;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBrQs85pdruV9a+fUBhZBc6S+tBFf92Uv2s4okRK9jM=;
        b=i2z6Pj0/s7F+KW/elxew1zhhom6EYzCjRbyU+e8v4ZCZI8CTopz9+JIWx7vzNW7H1H
         RwrUCm26PD1upd71k8YT9MDGapg/X/lZld6kSbR3pbqi6GXgufHuA/FdmM1iJaIEQVt2
         UIg61seaOHU432YPdX1iYqiGQZS2BX8Qm8CSIR3zDN6LY4qgRk3QYJT8kYRFculxA3Hw
         KXngsxpjE38e/MiVrF5ucIDYymQTfDv5extReULlWCzaAYpLwsnIQ7mycEoQjcbrb+E8
         q2Lq8EPLI4v0C6lQz3t6nJkq/e4XtBDImwGbAbqQ9MF+ily5zHBNLF29ZKar9UdPdBsN
         kPEg==
X-Forwarded-Encrypted: i=1; AJvYcCWN0O9vrgeWwamOlQ2Y4DW4iIWwMFsv2bPSe6j5cGAXEmPQCvhYj/WOSxd7WPyD4wx7BMUzCWAGicRIUw==@vger.kernel.org, AJvYcCWfgJ3vUH4pCyDYaJ22u5SVKGF2LSeHW574MDXLEUy6ZGUQR0xepoqlj1AIw6usuawCiITPOwBpHkpGj4ZI@vger.kernel.org
X-Gm-Message-State: AOJu0YziykJXf94CSmaIjLSP1qfMmngPxfV2Nd3Wd6rR/7fNGUiaD0Ha
	+PP9mFeuwuLU9G3fIr6xXn9UFORZZzozVYEonajYpv0iSkRcNlBd
X-Google-Smtp-Source: AGHT+IEP3MUkqcSOY6fu19Siy7ts/dqzY1CAShLg29VY/ZIxJ34grtCXLafqQxO+RROkxJofeuAwog==
X-Received: by 2002:a05:6512:1390:b0:539:e6bf:ca9a with SMTP id 2adb3069b0e04-53b348b7e12mr8427462e87.6.1730311012050;
        Wed, 30 Oct 2024 10:56:52 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bb81a573fsm309605e87.77.2024.10.30.10.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 10:56:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------JZiCjfbUoQi4wBEpSF1Xj0Ma"
Message-ID: <fa2f2722-fab2-4108-8d3a-f7da87bb9efa@gmail.com>
Date: Wed, 30 Oct 2024 18:56:48 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, dhowells@redhat.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.lei@redhat.com, linux-nvme@lists.infradead.org, klara@kasm.eu
References: <20241024050021.627350-1-hch@lst.de>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20241024050021.627350-1-hch@lst.de>

This is a multi-part message in MIME format.
--------------JZiCjfbUoQi4wBEpSF1Xj0Ma
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-10-24 07:00, Christoph Hellwig wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> The iov_iter_extract_pages interface allows to return physically
> discontiguous pages, as long as all but the first and last page
> in the array are page aligned and page size.  Rewrite
> iov_iter_extract_bvec_pages to take advantage of that instead of only
> returning ranges of physically contiguous pages.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [hch: minor cleanups, new commit log]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With this patch (e4e535bff2bc82bb49a633775f9834beeaa527db in 
next-20241030), I'm unable to connect via nvme-tcp with this in the log:

nvme nvme1: failed to send request -5
nvme nvme1: Connect command failed: host path error
nvme nvme1: failed to connect queue: 0 ret=880

With the patch reverted it works as expected:

nvme nvme1: creating 24 I/O queues.
nvme nvme1: mapped 24/0/0 default/read/poll queues.
nvme nvme1: new ctrl: NQN 
"nqn.2018-06.eu.kasm.int:freenas:backup:parmesan.int.kasm.eu", addr 
[2001:0678:0a5c:1204:6245:cbff:fe9c:4f59]:4420, hostnqn: 
nqn.2018-06.eu.kasm.int:parmesan


Please let me know if there's anything else you need.

Regards,
Klara Modin

+CC: linux-nvme

> ---
>   lib/iov_iter.c | 67 +++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1abb32c0da50..9fc06f5fb748 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1677,8 +1677,8 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
>   }
>   
>   /*
> - * Extract a list of contiguous pages from an ITER_BVEC iterator.  This does
> - * not get references on the pages, nor does it get a pin on them.
> + * Extract a list of virtually contiguous pages from an ITER_BVEC iterator.
> + * This does not get references on the pages, nor does it get a pin on them.
>    */
>   static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>   					   struct page ***pages, size_t maxsize,
> @@ -1686,35 +1686,58 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>   					   iov_iter_extraction_t extraction_flags,
>   					   size_t *offset0)
>   {
> -	struct page **p, *page;
> -	size_t skip = i->iov_offset, offset, size;
> -	int k;
> +	size_t skip = i->iov_offset, size = 0;
> +	struct bvec_iter bi;
> +	int k = 0;
>   
> -	for (;;) {
> -		if (i->nr_segs == 0)
> -			return 0;
> -		size = min(maxsize, i->bvec->bv_len - skip);
> -		if (size)
> -			break;
> +	if (i->nr_segs == 0)
> +		return 0;
> +
> +	if (i->iov_offset == i->bvec->bv_len) {
>   		i->iov_offset = 0;
>   		i->nr_segs--;
>   		i->bvec++;
>   		skip = 0;
>   	}
> +	bi.bi_size = maxsize + skip;
> +	bi.bi_bvec_done = skip;
> +
> +	maxpages = want_pages_array(pages, maxsize, skip, maxpages);
> +
> +	while (bi.bi_size && bi.bi_idx < i->nr_segs) {
> +		struct bio_vec bv = bvec_iter_bvec(i->bvec, bi);
> +
> +		/*
> +		 * The iov_iter_extract_pages interface only allows an offset
> +		 * into the first page.  Break out of the loop if we see an
> +		 * offset into subsequent pages, the caller will have to call
> +		 * iov_iter_extract_pages again for the reminder.
> +		 */
> +		if (k) {
> +			if (bv.bv_offset)
> +				break;
> +		} else {
> +			*offset0 = bv.bv_offset;
> +		}
>   
> -	skip += i->bvec->bv_offset;
> -	page = i->bvec->bv_page + skip / PAGE_SIZE;
> -	offset = skip % PAGE_SIZE;
> -	*offset0 = offset;
> +		(*pages)[k++] = bv.bv_page;
> +		size += bv.bv_len;
>   
> -	maxpages = want_pages_array(pages, size, offset, maxpages);
> -	if (!maxpages)
> -		return -ENOMEM;
> -	p = *pages;
> -	for (k = 0; k < maxpages; k++)
> -		p[k] = page + k;
> +		if (k >= maxpages)
> +			break;
> +
> +		/*
> +		 * We are done when the end of the bvec doesn't align to a page
> +		 * boundary as that would create a hole in the returned space.
> +		 * The caller will handle this with another call to
> +		 * iov_iter_extract_pages.
> +		 */
> +		if (bv.bv_offset + bv.bv_len != PAGE_SIZE)
> +			break;
> +
> +		bvec_iter_advance_single(i->bvec, &bi, bv.bv_len);
> +	}
>   
> -	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
>   	iov_iter_advance(i, size);
>   	return size;
>   }

--------------JZiCjfbUoQi4wBEpSF1Xj0Ma
Content-Type: application/gzip; name="config.gz"
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
--------------JZiCjfbUoQi4wBEpSF1Xj0Ma
Content-Type: text/plain; charset=UTF-8;
 name="nvme-tcp_host-path-error_bisect"
Content-Disposition: attachment; filename="nvme-tcp_host-path-error_bisect"
Content-Transfer-Encoding: base64

IyBiYWQ6IFtjYWRkNDExYTc1NWQ0MGJmNzE3YzI1MTRhZmI5MGM3YzA3NjJhZWZjXSBjcnlw
dG86IHJzYXNzYS1wa2NzMSAtIE1pZ3JhdGUgdG8gc2lnX2FsZyBiYWNrZW5kCiMgZ29vZDog
W2U0MmIxYTlhMjU1N2FhOTRmZWU0N2YwNzg2MzM2NzcxOTgzODZhNTJdIE1lcmdlIHRhZyAn
c3BpLWZpeC12Ni4xMi1yYzUnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9icm9vbmllL3NwaQpnaXQgYmlzZWN0IHN0YXJ0ICduZXh0JyAnbmV4
dC9zdGFibGUnCiMgZ29vZDogWzU4MzdiOWRhYTMzOTMxM2I5MDA5MDExZTAxNzNkZDg3NGRl
M2YxMzJdIE1lcmdlIGJyYW5jaCAnc3BpLW5vci9uZXh0JyBvZiBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXRkL2xpbnV4LmdpdApnaXQgYmlzZWN0
IGdvb2QgNTgzN2I5ZGFhMzM5MzEzYjkwMDkwMTFlMDE3M2RkODc0ZGUzZjEzMgojIGJhZDog
WzY0ZjFkNWMzYWQ3NTQyZWE4Zjk3OTk4OGQyYWY3NWZkNGUxODE0OGVdIE1lcmdlIGJyYW5j
aCAnZm9yLWJhY2tsaWdodC1uZXh0JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvbGVlL2JhY2tsaWdodC5naXQKZ2l0IGJpc2VjdCBiYWQgNjRm
MWQ1YzNhZDc1NDJlYThmOTc5OTg4ZDJhZjc1ZmQ0ZTE4MTQ4ZQojIGdvb2Q6IFtlNzEwM2Y4
Nzg1NTA0ZGQ1YzZhYWQxMThmYmM2NGZjNDllZGEzM2FmXSBNZXJnZSB0YWcgJ2FtZC1kcm0t
bmV4dC02LjEzLTIwMjQtMTAtMjUnIG9mIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
Zy9hZ2Q1Zi9saW51eCBpbnRvIGRybS1uZXh0CmdpdCBiaXNlY3QgZ29vZCBlNzEwM2Y4Nzg1
NTA0ZGQ1YzZhYWQxMThmYmM2NGZjNDllZGEzM2FmCiMgZ29vZDogWzc0ODdhYmY5MTRlY2Fl
NmFkMjY5MDQ5M2MyYTNmYjk5ODczOGJkNzFdIE1lcmdlIGJyYW5jaCAnZm9yLW5leHQnIG9m
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2llZWUx
Mzk0L2xpbnV4MTM5NC5naXQKZ2l0IGJpc2VjdCBnb29kIDc0ODdhYmY5MTRlY2FlNmFkMjY5
MDQ5M2MyYTNmYjk5ODczOGJkNzEKIyBnb29kOiBbM2Y3NDNlNzAzYzI1MWM5YzNmMjIwODhi
Y2RjMDMzMGUxNjVjOGM5NF0gTWVyZ2UgYnJhbmNoICduZXh0JyBvZiBnaXQ6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZHRvci9pbnB1dC5naXQKZ2l0IGJp
c2VjdCBnb29kIDNmNzQzZTcwM2MyNTFjOWMzZjIyMDg4YmNkYzAzMzBlMTY1YzhjOTQKIyBi
YWQ6IFs5NDAxZmY4ZTJkNjBmNDNlY2YzNDNjMjBhNzU5NWIyNzExYmNlMjE3XSBNZXJnZSBi
cmFuY2ggJ2Zvci1uZXh0JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvbGliYXRhL2xpbnV4CmdpdCBiaXNlY3QgYmFkIDk0MDFmZjhlMmQ2MGY0
M2VjZjM0M2MyMGE3NTk1YjI3MTFiY2UyMTcKIyBnb29kOiBbYWZmNzUwZTcwOTRlMjZlYWU2
ODY5NjU5MzBlZjJiZWM3ZjQxNTJkYV0gaW9fdXJpbmcvcnNyYzogY2xlYXIgLT5idWYgYmVm
b3JlIG1hcHBpbmcgcGFnZXMKZ2l0IGJpc2VjdCBnb29kIGFmZjc1MGU3MDk0ZTI2ZWFlNjg2
OTY1OTMwZWYyYmVjN2Y0MTUyZGEKIyBnb29kOiBbOTA0ZWJkMjUyN2M1MDc3NTJmNWRkYjM1
OGY4ODdkMmUwZGFiOTZhMF0gYmxvY2s6IHJlbW92ZSByZWR1bmRhbnQgZXhwbGljaXQgbWVt
b3J5IGJhcnJpZXIgZnJvbSBycV9xb3Mgd2FpdGVyIGFuZCB3YWtlcgpnaXQgYmlzZWN0IGdv
b2QgOTA0ZWJkMjUyN2M1MDc3NTJmNWRkYjM1OGY4ODdkMmUwZGFiOTZhMAojIGJhZDogW2Q0
OWFjZjA3ZmQ1NjI5YTdlOTZkM2Y2Y2I0YTI4ZjVjYzA0YTEwYmZdIE1lcmdlIGJyYW5jaCAn
Zm9yLW5leHQnIG9mIGdpdDovL2dpdC5rZXJuZWwuZGsvbGludXgtYmxvY2suZ2l0CmdpdCBi
aXNlY3QgYmFkIGQ0OWFjZjA3ZmQ1NjI5YTdlOTZkM2Y2Y2I0YTI4ZjVjYzA0YTEwYmYKIyBn
b29kOiBbZjFiZTE3ODhhMzJlOGZhNjM0MTZhZDQ1MThiYmQxYTg1YTgyNWM5ZF0gYmxvY2s6
IG1vZGVsIGZyZWV6ZSAmIGVudGVyIHF1ZXVlIGFzIGxvY2sgZm9yIHN1cHBvcnRpbmcgbG9j
a2RlcApnaXQgYmlzZWN0IGdvb2QgZjFiZTE3ODhhMzJlOGZhNjM0MTZhZDQ1MThiYmQxYTg1
YTgyNWM5ZAojIGJhZDogWzc5M2MwOGRmZTc4YjY0NjAzMWZlMmFhNTkxMGU2ZmVmNmU4NzJl
NGFdIE1lcmdlIGJyYW5jaCAnZm9yLTYuMTMvYmxvY2snIGludG8gZm9yLW5leHQKZ2l0IGJp
c2VjdCBiYWQgNzkzYzA4ZGZlNzhiNjQ2MDMxZmUyYWE1OTEwZTZmZWY2ZTg3MmU0YQojIGJh
ZDogWzJmNWE2NWVmMzBhNjM2ZDUwMzA5MTdlZWJkMjgzYWM0NDdhMjEyYWZdIGJsb2NrOiBh
ZGQgYSBiZGV2X2xpbWl0cyBoZWxwZXIKZ2l0IGJpc2VjdCBiYWQgMmY1YTY1ZWYzMGE2MzZk
NTAzMDkxN2VlYmQyODNhYzQ0N2EyMTJhZgojIGJhZDogW2U0ZTUzNWJmZjJiYzgyYmI0OWE2
MzM3NzVmOTgzNGJlZWFhNTI3ZGJdIGlvdl9pdGVyOiBkb24ndCByZXF1aXJlIGNvbnRpZ3Vv
dXMgcGFnZXMgaW4gaW92X2l0ZXJfZXh0cmFjdF9idmVjX3BhZ2VzCmdpdCBiaXNlY3QgYmFk
IGU0ZTUzNWJmZjJiYzgyYmI0OWE2MzM3NzVmOTgzNGJlZWFhNTI3ZGIKIyBmaXJzdCBiYWQg
Y29tbWl0OiBbZTRlNTM1YmZmMmJjODJiYjQ5YTYzMzc3NWY5ODM0YmVlYWE1MjdkYl0gaW92
X2l0ZXI6IGRvbid0IHJlcXVpcmUgY29udGlndW91cyBwYWdlcyBpbiBpb3ZfaXRlcl9leHRy
YWN0X2J2ZWNfcGFnZXMK

--------------JZiCjfbUoQi4wBEpSF1Xj0Ma--
