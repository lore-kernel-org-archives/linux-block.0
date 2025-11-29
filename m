Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97821F12E9
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764443577; cv=none; b=AgNdktDLoMFIKSqvqcvWfBuY27fe8AVGTR7JOdWzDABixUbVmmxRedjq4q//bSOFxwbdHU6Kisi1xf93uraQr75Ns1WzigJs0FnEkBNryQEC9P4+fmnGoPFFTxlVUVQavYQiWoztmWfeficAXCAYXxkgdyI4neJBQfVzoekB6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764443577; c=relaxed/simple;
	bh=I9pRSvpM/Q25AtDAkr2tSt8mZq5fB9V0o3rHVIT1oN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVmEDrU9685Hr2DbnlhoU9CKswIl8ZBnUauhZ/A7Havl7SgrQmmxnlvyxpUO5JaN6DtPIrZtJ2pnIbv5e7WGBwUO2UY3rStmHUk6IwRbfpV4M3nmszJ7n44yFVMBKINJSmztaJnnAojnJpeMUzBJwpGSgTIcaNu+1SJuYSCMe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NFUF05XI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NFUF05XI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2960771ec71so5208715ad.0
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 11:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764443575; x=1765048375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3S8sNBD5NmX6kFPRjuCIXIcTjWuzmRYhkncha79vzM=;
        b=NFUF05XIWhIN4BxX7Edxp4OhgAEUQmguYWCX2qroPrwAMpfvJTO40oyxvbF+9kNQiq
         yYEruNq5ySfrQjQorLFa6T+6QboSCqtdkfZfvwAm85qWvVXP4UMbTnO9xvElSGSanNZZ
         IBefsuk6gT7Ob81p1qhp1YAZDN8pf23wmDvhpi8liX6mRTQLddl0gucyTYrOvjoDjW6W
         dRtIbQDgn2F2rvlMQipZz878ZEsrBmSUGDqOLj6fST1Hexou5JUa6aN9vz6dVJZm4CKK
         tZ//Xm9JFSjSjE7R1u5bhO7Xi0fdW6vcDZKjU3dr0LSNXZACKO365faeGn6vepwTOJCF
         lGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764443575; x=1765048375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F3S8sNBD5NmX6kFPRjuCIXIcTjWuzmRYhkncha79vzM=;
        b=e684fA2U6NdvPQlBogZXAEXmKSAqXgpP4UZJQ0l3ofUKj9fu4LReVuoRT2laKVPLfd
         wQIj/XHPt5QkcP6gUMaHMsrNgJY/p5qyxAozf89+IWa+ZjYoWv15DLTYMQb6BmLG0oon
         OS8kCosOoive0YY67yaFu8KzUbOqjumAgIOLk/iJ4lKTpLr+zxkewMotocQbyvyiK+hq
         9RcvYL0mBKl6QGk/5gyeAQGKhQKOMUfg8yuQMxVZRdQflVs5yDF3d2iCQuNvxnWMBi2w
         1OPUy8rGoAI2+B58xyUpEPpm1mzftQeI25uMtWPm470lEZWmMuNJwHdnjTk5C0RWq3iT
         E83A==
X-Forwarded-Encrypted: i=1; AJvYcCWMWvfNEJ3oWzwpy2dItg5UHrDA1pvAXGC8hZuJC3M8lgkXjXSH12eR8hq4cX54SlRu6McMciVnTS/adQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWIn1jaX/ph/YFtpmlx+e8LQEzmqhraIP+qeVcyr+V3tnq+JvN
	g4CtjZuc7U3kZSvVKvUFyW7LZfp/kvW5dZ+w2mCv/HX95ZHUjz8NnTVIJpypOUnc1Qf6p/tciRF
	Uku7y5sQp86MpBeegYE8HdiDSdJmRkhnnXT9Z1Ki0Hg==
X-Gm-Gg: ASbGnctfEETx7W/k46zu+gO26mkWbXGHYgEkY0rDJs2/8IY4jjrP1sVbZpcByipiGuz
	j7bK6UfYi2JTLysRNu2X8xBrP/jsgRMJRf5KVC5G5i+ctCjQaC8bfjOD/BgGTy4Buk4cPPWpzLT
	8pI9OsucVAnv3DXYZyYoWz5ubFyDpTdG/CjszKD3MK3b9lW2OhgqVm5H4ZVL4pnLL8l8vjucelA
	0MN5E6NwsZ59EKVm1EnUjKN/gYH3JfXXgo+76bJZBKaOHllMSJuio52UDT+3+yJSSMpv+TX
X-Google-Smtp-Source: AGHT+IEQ88ZY876+P4bcSo2IK8kfBLG0hwiSBNO40jWV+tyEB6cFcpsQEJggvN1DJyGidxVlpjQsjoRT8+v3OXK93dw=
X-Received: by 2002:a05:7022:429e:b0:119:e56b:46b9 with SMTP id
 a92af1059eb24-11c9f3806d4mr19719189c88.3.1764443574742; Sat, 29 Nov 2025
 11:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-2-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 29 Nov 2025 11:12:43 -0800
X-Gm-Features: AWmQ_blOc4l0ULIrj57Rf6FGwYCvLrWOmrh3moWUmau4BsFmm6a3Qh0FVJ5jLYo
Message-ID: <CADUfDZramMrqZ1=ZH2xXcT=n-p-QsdQ2nOpAeWGzxEpjc-9-Rg@mail.gmail.com>
Subject: Re: [PATCH V4 01/27] kfifo: add kfifo_alloc_node() helper for NUMA awareness
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 5:59=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add __kfifo_alloc_node() by refactoring and reusing __kfifo_alloc(),
> and define kfifo_alloc_node() macro to support NUMA-aware memory
> allocation.
>
> The new __kfifo_alloc_node() function accepts a NUMA node parameter
> and uses kmalloc_array_node() instead of kmalloc_array() for
> node-specific allocation. The existing __kfifo_alloc() now calls
> __kfifo_alloc_node() with NUMA_NO_NODE to maintain backward
> compatibility.
>
> This enables users to allocate kfifo buffers on specific NUMA nodes,
> which is important for performance in NUMA systems where the kfifo
> will be primarily accessed by threads running on specific nodes.
>
> Cc: Stefani Seibold <stefani@seibold.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/kfifo.h | 34 ++++++++++++++++++++++++++++++++--
>  lib/kfifo.c           |  8 ++++----
>  2 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> index fd743d4c4b4b..8b81ac74829c 100644
> --- a/include/linux/kfifo.h
> +++ b/include/linux/kfifo.h
> @@ -369,6 +369,30 @@ __kfifo_int_must_check_helper( \
>  }) \
>  )
>
> +/**
> + * kfifo_alloc_node - dynamically allocates a new fifo buffer on a NUMA =
node
> + * @fifo: pointer to the fifo
> + * @size: the number of elements in the fifo, this must be a power of 2
> + * @gfp_mask: get_free_pages mask, passed to kmalloc()
> + * @node: NUMA node to allocate memory on
> + *
> + * This macro dynamically allocates a new fifo buffer with NUMA node awa=
reness.
> + *
> + * The number of elements will be rounded-up to a power of 2.
> + * The fifo will be release with kfifo_free().
> + * Return 0 if no error, otherwise an error code.
> + */
> +#define kfifo_alloc_node(fifo, size, gfp_mask, node) \
> +__kfifo_int_must_check_helper( \
> +({ \
> +       typeof((fifo) + 1) __tmp =3D (fifo); \
> +       struct __kfifo *__kfifo =3D &__tmp->kfifo; \
> +       __is_kfifo_ptr(__tmp) ? \
> +       __kfifo_alloc_node(__kfifo, size, sizeof(*__tmp->type), gfp_mask,=
 node) : \
> +       -EINVAL; \
> +}) \
> +)

Looks like we could avoid some code duplication by defining
kfifo_alloc(fifo, size, gfp_mask) as kfifo_alloc_node(fifo, size,
gfp_mask, NUMA_NO_NODE). Otherwise, this looks good to me.

Best,
Caleb

> +
>  /**
>   * kfifo_free - frees the fifo
>   * @fifo: the fifo to be freed
> @@ -899,8 +923,14 @@ __kfifo_uint_must_check_helper( \
>  )
>
>
> -extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> -       size_t esize, gfp_t gfp_mask);
> +extern int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
> +       size_t esize, gfp_t gfp_mask, int node);
> +
> +static inline int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> +                               size_t esize, gfp_t gfp_mask)
> +{
> +       return __kfifo_alloc_node(fifo, size, esize, gfp_mask, NUMA_NO_NO=
DE);
> +}
>
>  extern void __kfifo_free(struct __kfifo *fifo);
>
> diff --git a/lib/kfifo.c b/lib/kfifo.c
> index a8b2eed90599..525e66f8294c 100644
> --- a/lib/kfifo.c
> +++ b/lib/kfifo.c
> @@ -22,8 +22,8 @@ static inline unsigned int kfifo_unused(struct __kfifo =
*fifo)
>         return (fifo->mask + 1) - (fifo->in - fifo->out);
>  }
>
> -int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> -               size_t esize, gfp_t gfp_mask)
> +int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
> +               size_t esize, gfp_t gfp_mask, int node)
>  {
>         /*
>          * round up to the next power of 2, since our 'let the indices
> @@ -41,7 +41,7 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int si=
ze,
>                 return -EINVAL;
>         }
>
> -       fifo->data =3D kmalloc_array(esize, size, gfp_mask);
> +       fifo->data =3D kmalloc_array_node(esize, size, gfp_mask, node);
>
>         if (!fifo->data) {
>                 fifo->mask =3D 0;
> @@ -51,7 +51,7 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int si=
ze,
>
>         return 0;
>  }
> -EXPORT_SYMBOL(__kfifo_alloc);
> +EXPORT_SYMBOL(__kfifo_alloc_node);
>
>  void __kfifo_free(struct __kfifo *fifo)
>  {
> --
> 2.47.0
>
