Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23101BF7F8
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794226; cv=none; b=oz+lltn6Qj9HNVtMauc6tmSCD0DGTXz2vYHPb0vI+hBWvFPbs0Mrk2RHE7X8obAcgYVme3X9zyh8shWr1JkWtPYLTO1H2y/xJiLcbfTagiwL5lFP1BJjik+zAJqNaXMEaV3Ie9evgxCYnii6nSgmUDL302tMDI2vif94atS8jw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794226; c=relaxed/simple;
	bh=P7Mh/0k5f06GwxeCsSl9O3t7BO8WWiTvcbVK1mF2FSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwXUV7UX9AdHPLb/xRdO/jK4wt3B2VSZhyaDuQLln5Nt8hhLT/8AC66H4QxbhRCHdA/QVmdC08U0z88RDXcYojSsC9Vj16HV0iiIpC8NeBMlUzsJmhVFD9PSngVh+lWNJeEbV3AmnIlKAgxadx2E+Xlx0FWXF/n9KS+EZU7jHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+UIJbbP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+UIJbbP"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5398e4ae9efso3389504e87.1
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2024 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727794223; x=1728399023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cSyeR9abJDVNh3IbE3iMwWTMv0KT43vGwZgDBM7Wbg=;
        b=N+UIJbbPM8ojhHjLwBAleqLLYdj+9Jj76G3dztwDf04tWAX7d7HReGwNcKw9RfhLow
         mHWXW6W3TloVYavgiD83EI/6kCpPbIUxmtpwPA3+HUApz5X1sRfrFGdoHRr7WirekNYL
         SnnfdYvCxtGWD+78i9eUnl6ADm2ZG/sGvv1vI1Ql8MTukUo40JTfkOnELGTfnLBscMKZ
         eIn7OBcXYclbz018xTxDxQFyMqrb+v3m0fOfgjJe0zFw/zffXZ1yRrEcRfu5ToC+ETMq
         cziwOaQE9/G3neosrBg2MQ3cWKi7QNlIZQ1W5jBV+soL/BotTi5KJFg6s+uNmBRoBUUi
         1Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727794223; x=1728399023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cSyeR9abJDVNh3IbE3iMwWTMv0KT43vGwZgDBM7Wbg=;
        b=Ag0hEl5rFDwraWycxAyCF7es3cvsmExLSZzNJrbOLdFpQdS/x80aKKAZELt4nsWhzK
         Zf8vYKmKPNAYc0u6RypNOMF5FBKB8FnOowomvvgwusNXzAAFxjQq8uE/WjXE+aJJd7Lk
         7q4847KcZQATWZZUEeSKdagaq5Akj9OoOCfmdIJX+2qou2CJ4mVbC8Oc1y3zzSQ8hOXN
         ROlHZNka5UblORJV5x04R93upCaszNjXz7HCQrwK4f7tnp55O5Y7lb++4CpZKjC6PSwX
         lElqu3aMaIdQdJtWJECTGapLDbMXXRp5VPs2j14o0ArAsf1tT5+FD9wOSmjNcl3L5gQY
         u8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVM+Shgiz4+NzPa0KBnMSJ8gaXUoFcBpimcoPTXMa7XWQIJqhWBZ53ymmaP7cc65ian6i2FlhB9faaidw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4kUKIrhfm6LnbuPedwYbKr7p3Z2mhpBjFdNxbL9e2J6FJ7uhq
	dAID62DFaTjJ6jsShx2V5Ac2Ggk26XhYRv7jOFoTb3tLx9v02WmGqbDgSgPiy0YZ1WHwm0f+CE9
	4Q4s5lnzy+B3mveHg7Ld3WIBFz1Q=
X-Google-Smtp-Source: AGHT+IHjd7sSKcg/ku9VJaZ3qqa0ntw0KjgjijNTNSnxnRp33GMi/Fp+m2pyySF0Hqc8zWcZ4+YnGRENriOE71Izr24=
X-Received: by 2002:a05:6512:3089:b0:52e:7542:f469 with SMTP id
 2adb3069b0e04-5389fbc6f0amr7029314e87.0.1727794222640; Tue, 01 Oct 2024
 07:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001140245.306087-1-nilay@linux.ibm.com>
In-Reply-To: <20241001140245.306087-1-nilay@linux.ibm.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 1 Oct 2024 23:50:10 +0900
Message-ID: <CAB=+i9QEQJ-LVZsDSLG8xf2g5eLP0vi0HUNnCwLqWSpx0St2bw@mail.gmail.com>
Subject: Re: [PATCH] mm, slab: fix use of SLAB_SUPPORTS_SYSFS in kmem_cache_release()
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org, vbabka@suse.cz, 
	akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, 
	yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, axboe@kernel.dk, 
	gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:02=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> The fix implemented in commit 4ec10268ed98 ("mm, slab: unlink slabinfo,
> sysfs and debugfs immediately") caused a subtle side effect due to which
> while destroying the kmem cache, the code path would never get into
> sysfs_slab_release() function even though SLAB_SUPPORTS_SYSFS is defined
> and slab state is FULL. Due to this side effect, we would never release
> kobject defined for kmem cache and leak the associated memory.
>
> The issue here's with the use of __is_defined() macro in kmem_cache_
> release(). The __is_defined() macro expands to __take_second_arg(
> arg1_or_junk 1, 0). If "arg1_or_junk" is defined to 1 then it expands to
> __take_second_arg(0, 1, 0) and returns 1. If "arg1_or_junk" is NOT define=
d
> to any value then it expands to __take_second_arg(... 1, 0) and returns 0=
.
>
> In this particular issue, SLAB_SUPPORTS_SYSFS is defined without any
> associated value and that causes __is_defined(SLAB_SUPPORTS_SYSFS) to
> always evaluate to 0 and hence it would never invoke sysfs_slab_release()=
.
>
> This patch helps fix this issue by defining SLAB_SUPPORTS_SYSFS to 1.

Hi Nilay,

Thanks for your effort in investigating the issue and fixing it!
This makes sense to me, but is there any reason the code avoids using
IS_ENABLED()?

I think technically either IS_ENABLED() or __is_defined() (with your
fix) would work
in this case, but it made me think "What is the difference between
IS_ENABLED() and __is_defined()?"

IS_ENABLED() is already frequently used in mm and only few code snippets us=
e
__is_defined() directly.

Best,
Hyeonggon

> Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immedi=
ately")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs9YCCcfmdxN43-9H3HnTYQsRtTYw1Kz=
q-L468GfLKAENA@mail.gmail.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  mm/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index f22fb760b286..3e0a08ea4c42 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -310,7 +310,7 @@ struct kmem_cache {
>  };
>
>  #if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
> -#define SLAB_SUPPORTS_SYSFS
> +#define SLAB_SUPPORTS_SYSFS 1
>  void sysfs_slab_unlink(struct kmem_cache *s);
>  void sysfs_slab_release(struct kmem_cache *s);
>  #else
> --
> 2.45.2
>
