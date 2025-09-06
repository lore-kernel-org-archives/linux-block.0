Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114423FC66
	for <linux-block@vger.kernel.org>; Sat,  6 Sep 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757150232; cv=none; b=V4QwbE9YcSFRkq4cDJ+u4ApsD++5eS1dGwSkllCxUm6AlhfLS8MCQnwuHSgqbwV2FhOfYL672Rv/BSe6KonpbWFugiRp4ryFIFQR8O9OiD5RZjPsBL/WYkCNJiPpyOLTpzXBCTjCOR9/iyKzI3C4wPOIZJtGM/sNPNhyUvjJn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757150232; c=relaxed/simple;
	bh=4tcf+x1bAGP5gLbbX2/0mJXn6QiSKzTB0gWtNPgyCvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGneC3sKPl3QKIek5nHDMv1J9d9ytsgbJdKUcMrH2UJnWMe87YQmvHX4L1sdBEiAVUQCr5a2L/JfX2sLJBIV3ThKTt7nUwlIExb9CofUx3XMm6efJkym+PMT1sqgk1IHEWwn+DE1IA2ID35hwGPuFUNqxf2vuAaNw9CTPyDGioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uo4szKVP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uo4szKVP"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-80c45a0b023so280249585a.0
        for <linux-block@vger.kernel.org>; Sat, 06 Sep 2025 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757150229; x=1757755029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyTsTWBfEVvg2d8Q116wig3LF6X3zwSWXkw8iB2bvBY=;
        b=Uo4szKVPKNwugn/xYEwclUxWlsz/wfzT0y9wtG3my9pHhhcL8wsOsbrRJZDfUE+9Vd
         qvkuh+VnfzmX76DBCPWCv1gaIuMdie+q6XRHbVKvwhgAe8WqTMih8rf3oXo7MtKzOqzv
         zAst9Dxnbkk5NC16gEv0aSMfZ3MJDI0sFkA9l8xteaGy0z0HpvS0fLcq95u0c7ypFFNQ
         j8dNe66mdVCav+vJOz/byabyP+13IqJQ3Uz4R8+GqF7Stt0cbNPrzcKvjbGXyQkw8ttk
         XjEfxfTytfyVaULVheLtxif9fxFABEp5m+r671ggybaYPoo5GD/jplvX+UVy0Jn/Pn/v
         C+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757150229; x=1757755029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyTsTWBfEVvg2d8Q116wig3LF6X3zwSWXkw8iB2bvBY=;
        b=LVie7Jwe+6IC6nftfkQPXFTW9yxMJ703aSbXNkeAVDsqh+F7neLl4XWZog0AgYUB4j
         hsIG6PZ3c/O/gpDqhG/UdMNcpBX6XIN7bSeNzOZe7EXXscwQTdo7MjmRytRI8JL/uRLH
         wPmxHyEPBGpICscvY35gq8GjXZZ1imqKvHFDAtftMnz8ZWjNqWQT5TQvTcXLmLnK5BZc
         4x/zj0mE5qqw2XGFVbduo96T5HXRCxjXzYTxzJo7FJpiO6jk5dJhUFN/M9cx6mm/Zd4z
         G8IItsduzFjtjYe5/ylurMyo1C0a6I/6Il2bl5bIv8XQynoHsI0ylu5DCtBAQYrNVyPo
         2NJA==
X-Forwarded-Encrypted: i=1; AJvYcCXBEvDL+YoUTvD9kv2eOGlOMTt+O2scwzQ3diAIf0/LNauvp7lHT1ZOej+kgND5IaiKpZ5CEY6RwOUEXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGjotDJQY2jQNtt10/t4GfrdHCgK0SrZcVsG1oKF3G0u9ESyI1
	cv1ymdUZucWElGLPmzzO/I9Ps34l/i8KHgWl5rdZ8lhy0iKvX9sRoc/xr8P08GAuBilTRd/C3+A
	zOygvY4l+MRPcIg0DiAyQrulc1F4BxGjxg6vyyTE9
X-Gm-Gg: ASbGncs1txBZjwwvPr4Xuy5TX1+38FliG+vPGKU3aHrfobjLZivUE4APADEEcZavCMo
	BVoldYa7i9dW6UGm1xnO9R6CzydJtiL/AxGj+xQmhoPH/FXHsOHJl4ywbk218gJdJFhoKe1VoS8
	fZ2E1N1bPf7FtU/GzmK8DAMP9q4XbupeE+vGAYeHyPwm70TkqFfcsSEs1/6Qn9s3lAz/4dcAztz
	1njp4Gp2j4CV2QcKAxUM+o=
X-Google-Smtp-Source: AGHT+IFNHk3o12uxwbf6OpMNI0I53ugLfIK2NXUHGthDfhTNjq2NSap4D+GDM5PavZ580+AiwTooTru70iUwX14qHME=
X-Received: by 2002:a05:620a:440f:b0:806:7c82:fd2f with SMTP id
 af79cd13be357-813c33dbd99mr153395285a.75.1757150229022; Sat, 06 Sep 2025
 02:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68bb4160.050a0220.192772.0198.GAE@google.com> <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
In-Reply-To: <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Sep 2025 02:16:58 -0700
X-Gm-Features: Ac12FXxOqkfzxU_8v9kW7s_ChUAwPmKMRLy0TrO1zWLZ0WwxfLDIRZs52c2CrbU
Message-ID: <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Sep 5, 2025 at 1:00=E2=80=AFPM syzbot
> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:

Note to NBD maintainers : I held about  20 syzbot reports all pointing
to NBD accepting various sockets, I  can release them if needed, if you pre=
fer
to triage them.

>
> Question to NBD maintainers.
>
> What socket types are supposed to be supported by NBD ?
>
> I was thinking adding a list of supported ones, assuming TCP and
> stream unix are the only ones:
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 6463d0e8d0ce..87b0b78249da 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1217,6 +1217,14 @@ static struct socket *nbd_get_socket(struct
> nbd_device *nbd, unsigned long fd,
>         if (!sock)
>                 return NULL;
>
> +       if (!sk_is_tcp(sock->sk) &&
> +           !sk_is_stream_unix(sock->sk)) {
> +               dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
> should be TCP or UNIX.\n");
> +               *err =3D -EINVAL;
> +               sockfd_put(sock);
> +               return NULL;
> +       }
> +
>         if (sock->ops->shutdown =3D=3D sock_no_shutdown) {
>                 dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
> shutdown callout must be supported.\n");
>                 *err =3D -EINVAL;
