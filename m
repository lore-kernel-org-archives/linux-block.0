Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640941A87;
	Tue, 16 Jul 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122151; cv=none; b=JyGPTrmAzbnz2Z6HRqgw0EBv9kplGrOkljmmLm3m5SaLXQWvBzWmU0KQw/3T2o/UNBZhjV4QWOuTZT0JtF4Jia6hdnTIKKtTTmJgBvYfbmoKVO7kAYMCb+y5NYQgqKD+428ubvLziaHCqc2MWoShH/aUSvnVidn31+9BtffRiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122151; c=relaxed/simple;
	bh=PWafDMA3nAmTKUCsHotIQrVEnAKwP1snc0kk495JPQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQzmLq+jcZAdTBcoljAXhLBtMzofA2WB3nu02JeZaIrCdZKfxENh8ujjGceQM5Jt4TOL5gGPZqhGoHkcX5rq3MEdRgWKSN0+7F3RG1zAcdL+3aZb1+lKs6DeEpMAbE/5jYsK/hz7dLN6wtqwdE49J5S0rycajmQYVFMjk6Jsf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeKppaMo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeKppaMo"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368255de9ebso317260f8f.1;
        Tue, 16 Jul 2024 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721122148; x=1721726948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfGBCFg1TxUQ0m+kDDNis5njrwTl2DSqMiWSlz2UN7k=;
        b=UeKppaMoZeA8yMsJ8ioMvf72B2Q4c8p/CDKqiP5HefIN2NffvKgUkv0q1XpdXNrqBp
         +5nnAOgtyZVDmd77xc+kkBAnh1QXIdAWz+57+JQFOhwYYRiuQlNKdRv8Fjg1Mj06+Qpb
         qVkKdTka8B1b/tKg9BZAAliaw8kriYEDbvKhwLJDisHThRShWfwohJ5pdoGmG1en1PuV
         kgK7YsxDgyBS/llmImkkSALCGOwjJFW6X9wRdXB8r6cvilWDJNLlGXnvy57rOg/FkfZK
         wXbEiAubW9vE+ROdyxF16g2MIVgtso7WCeXd11eqkgF3+gxCA56PpCd6fI4KIXWoQktt
         x3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721122148; x=1721726948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfGBCFg1TxUQ0m+kDDNis5njrwTl2DSqMiWSlz2UN7k=;
        b=Tuo8CDhCFrrUhJ83XRDtzikA19n24Nf3uLzzGWAV1tTp/e+TV7uf+JYYOuIugxbSFG
         VudDX2Yj1fptYRQx4o7lYj3TAh97oFDBE3WEPx7DZnoYIWuFbqGAuKomE0vc6cSurkIu
         ki6xLeJFZ3IODZq6DO2TEHWWTWUvJymhCzNWr6QknRROoYx0SU+j1ICtAuQgAXMARkGy
         J9mT+O57VERD+ov5oGHOuvWo7QaGKE5F7bxnK6nek0t/by+IthMgfTdLHfpsNWiNa6bo
         Rhbn1kZq2a2I8imr8XgYcn5gZzrYQ72kh0tZ2b2DK1Eb8MlFmAZwjSdTE/+fIF71S+45
         vwbw==
X-Forwarded-Encrypted: i=1; AJvYcCUr2nnH0zXoKE+6QjFw1bdqD5GE03uB6uTi7hHsK+P/APU5THjuaTIbMKr/JeCDgFKX1g3PwsZdYERaBuXQu7oUDzI8A9pVt6g5Xj601LnDLNr3lxvfC8HHZJXFilEJd/0YORsPgyyNp0E=
X-Gm-Message-State: AOJu0YyHOaK50UfApzyj8u0Ogh3Dlen28EENIzVJr+PdL6w7tWdVhZlw
	bu8s7r7htJfVNuAZGARrCpYW3tjekXjsSRRFnTmaGYrGxDJS7mPjTvy5eKuKuHyLWIqA0EEzrBu
	+7476SgXaaew5n/hNoblhRUc1ZNOJbA==
X-Google-Smtp-Source: AGHT+IEIlpce3gvsiAdYcfBzP2cKueZmkNAch2fOB3He9ZCro8x5v5m11xa+vfnvWzNWQlRylnvPO/qoXyu40ae4vDU=
X-Received: by 2002:adf:ff8a:0:b0:363:b3ea:7290 with SMTP id
 ffacd0b85a97d-3682753b33bmr944598f8f.20.1721122147833; Tue, 16 Jul 2024
 02:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720518712-28301-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1720518712-28301-1-git-send-email-zhiguo.niu@unisoc.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 16 Jul 2024 17:28:55 +0800
Message-ID: <CAHJ8P3LTxcMK0fuM5XCr5fmXffQUGxXsRSYdW46MtPoX8961UA@mail.gmail.com>
Subject: Re: [PATCH V2] block: uapi: Fix compliation warning of using IOPRIO_PRIO_DATA
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: axboe@kernel.dk, dlemoal@kernel.org, hch@lst.de, bvanassche@acm.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

kindly ping...

Zhiguo Niu <zhiguo.niu@unisoc.com> =E4=BA=8E2024=E5=B9=B47=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=8C 17:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Generally, the input of IOPRIO_PRIO_DATA has 16 bits. If use format "%d"
> to printk IOPRIO_PRIO_DATA, there will be the following warning or error.
>
> fs/f2fs/sysfs.c:348:31: warning: format =E2=80=98%d=E2=80=99 expects argu=
ment of type =E2=80=98int=E2=80=99, but argument 4 has type =E2=80=98long u=
nsigned int=E2=80=99 [-Wformat=3D]
>    return sysfs_emit(buf, "%s,%d\n",
>                               ~^
>                               %ld
>
> This is because the output of IOPRIO_PRIO_DATA is converted to "UL" from
> IOPRIO_PRIO_MASK, which is not reasonable. unsigned int is more suitable.
>
> Fixes: 06447ae5e33b ("ioprio: move user space relevant ioprio bits to UAP=
I includes")
> Cc: stable@vger.kernel.org
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Link: https://lore.kernel.org/all/1717155071-20409-1-git-send-email-zhigu=
o.niu@unisoc.com
> ---
> v2: add Fixes tag and Cc tag
> ---
> ---
>  include/uapi/linux/ioprio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index bee2bdb0..9ead07f 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -11,7 +11,7 @@
>  #define IOPRIO_CLASS_SHIFT     13
>  #define IOPRIO_NR_CLASSES      8
>  #define IOPRIO_CLASS_MASK      (IOPRIO_NR_CLASSES - 1)
> -#define IOPRIO_PRIO_MASK       ((1UL << IOPRIO_CLASS_SHIFT) - 1)
> +#define IOPRIO_PRIO_MASK       ((1U << IOPRIO_CLASS_SHIFT) - 1)
>
>  #define IOPRIO_PRIO_CLASS(ioprio)      \
>         (((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
> --
> 1.9.1
>
