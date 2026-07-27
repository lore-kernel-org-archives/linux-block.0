Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AB2045AD
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785113999; cv=pass; b=b89Q/Na7Fm3cWvX9ZPsEj9To1Fh88VL7zAbd7kvxWKN4PZLJ2XAz6ijcxSodCxPV2ga2XkEq6i3hVesijP0JmuGtNLN+J03lbrHq9T/q8zeHXSx/7eRH9EOnDqp/ENW7oP5dvn9cPUL9Axa/nYWQGZPIZzxUcnnJ3DqJsGXANts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785113999; c=relaxed/simple;
	bh=5xQ5wlyPzJPJBZyZbGy8HLnTPWuRdiO322KF/vvl+RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1Tf0cWMC50MGjWfws+THWPtxmkGoDjGmTpvqmqWrkLLTZU3xEe3tj/ZS4ZWYdEAIz2P/NuMoxVPXt9N8y24+Skhq0qiLnnce7d7iBx4oC86fCC6cdEwRourqEToYv7XA8y7DiKfhaV5TexRfaxYEj10C0G5yFlfOwtyFInjadM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVNOAxzR; arc=pass smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVNOAxzR"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-6682259cb3dso3274524d50.1
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 17:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785113997; cv=none;
        d=google.com; s=arc-20260327;
        b=eXrQRvJaHbHRL7Z2gZwBItIZy+/50gsoGG6UMlva7d716OmUIf+BImOsc67U/fX993
         1VqtSfslulhOEjcr1Ng3OMmA2SIsMv/ywW8WSRa6qIWtRQpOTwHFiUY7O+NuBbY4kqA1
         FebQux9qamdnvh3X7pXpgpGuG1+T6WpzB1liY6ql/Qq851dGKhGRZLhtq6jcouFPaUZq
         efGd+44Im3hQvsx9s0+zCUVksd97nLnZtrkaPFD/EbeVbhXxZ3mz9jwpf0jvnrq/HGrh
         bDsbjR1cRsT0HzXA6oRSgIs/iuwO2QcvEUQX8oYxhGtX/q4K4FG/pF5AwaAi00kyvuaI
         KOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=95YsidONp2kRhRwGHOy4CeEJEML/ngBb6skNrrEa7E4=;
        fh=vzr/1Oby8Cqtpj/bxmF14T6z8Aj2t0OEv1vRbzTNLek=;
        b=AIJq11KIv3YtnZcfyuZVNPyh7GeC4HI8WdVcCvrXmC81WyUN+cjfI+ZG2IPhNqo53e
         FbSz4zEgVg5dzgpHkwklPKdTP4qJagBCCp7WZ8K5asA4KSmieYLWnrTGcYghHNlRmEwQ
         m8KVkJEPLiht3ZM4rnWCUhu/vydSJiI8Vh2GHkccDk33GPwB9fO7iA2NcrisSuITZczM
         iCLa4gr9pVfJPBO6US1+fyiPqBUFrWe1Fj2spXbVlzSkC5ayvk80ELK7o3hQjakBxBq7
         L1c+rLbGhBAVYgTXMzi0lrm2JsUNkenrGd29J8hKitK44eIV5diWCSj2fLoQwq7GjkfA
         5bLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785113997; x=1785718797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=95YsidONp2kRhRwGHOy4CeEJEML/ngBb6skNrrEa7E4=;
        b=IVNOAxzRqRmxkfpXHLs3SxVfxnHl3ghOSJ/HT3/w/O6teD3qk54ZsVdj67XW+y/n8X
         HxlXgY77eCRn8EjsVNcDz2lKIo4NKmX6CCRmwI0PQTN+I6i8qWsCM5jgF3HWNXUrNc6h
         lVtBTzszPmk3Cq+AIen+DO4BSWP03RHJqyn34SRukjmw38URhW+4C9IOI6HKhnvameND
         4GZdES/5rAW7i/Dkwy+4EqFg3Ojn7aF3q4ijSFMA5bNCcyf0zR3/2ddk/xaUu9G0x0FD
         JiP0nGM9ydHFZdhLYDggkhv4dkwolb+/xlRWLBjhycGBvwxuHYzb6Ge4mb+t2oJuQu5b
         pagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785113997; x=1785718797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=95YsidONp2kRhRwGHOy4CeEJEML/ngBb6skNrrEa7E4=;
        b=nevXdXagyV2dT9Pffy8BDVcYB4AqvkTe6Nly3i47UEf9iqaPPdAGUIOHydHWGEscEX
         y/1/MHV7cse4IAUeo1/TvEsaR33U0r2k645JiSLg/N23u8B52u5zhdA4eB2nktbPU5pM
         3GghUIcZ0KtVjeqUxBq1UPYlaFUiJhs+0t4eaTk9gCNh4G5/WHOKqUtv0UVqU6zqIRrL
         EIeMfmyABfhvosYvIxePaXoVx3SvEi5YjYXIXbQw/4sSR55w4F6vMLmjgcSymndyybLh
         CdUrptuQ8Y5BMOIY3mCutfaeqcltStWuMG09j8kNG1A1GqFv76JYo04TP3J+p2WLtca0
         vzmA==
X-Forwarded-Encrypted: i=1; AHgh+Rq49I3a4vAXxMOl+Kpdt9AF/QMXOT+MkIBYiPfPuHvJBvX9aFOhyCRAPpsRe8HYX4mFLxp5qeBmOzouxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlv/NVrYZu9hjWhe2Td+ddpR+OrOa6AMWMC92q6Jog7rxXvkIh
	xxvlvPOoSlEYBG896nE0LBAJbOyVfCR2DXxxuMe0BIJ046yk3ZTVWZvq+2fuyLPnPSshfT5CMRA
	APD+C7kVXHM1Wnpm3Eb2ohRwIXjIKptm0KgTPMvZ/STTg9UE=
X-Gm-Gg: AR+sD116UIVEp2nnTHJaZ5xGQqW8D19a3yYua8MX0+Xcpy19LYSSvbAhYimw6awZ0EM
	v14+tg3jJBvkB2NKeNCZNF2gyntWDAX6z4DBb3SosiQCzgDZjL2fsbBSg88AJktPC0Z38GSJeNg
	dKhjlIJnYBGHq7LsSNoKnBU/4UTBanFwaHQZ92tvtwLDjwo38MxoAs5iPATOAMnVvuxDXh8uM/s
	rINDgsmsZijc8kA5Xbp1b1dU6d8nvR4QkvJj5tyBN+DvX5rJdLpyL+OtFrbihka
X-Received: by 2002:a53:acc3:0:10b0:667:82d6:eb47 with SMTP id
 956f58d0204a3-668bfdb8ed8mr1709002d50.17.1785113997245; Sun, 26 Jul 2026
 17:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713120242.1284559-1-l1za0.sec@gmail.com>
In-Reply-To: <20260713120242.1284559-1-l1za0.sec@gmail.com>
From: Li Zao <l1za0.sec@gmail.com>
Date: Mon, 27 Jul 2026 08:59:42 +0800
X-Gm-Features: AUfX_mzbdtQ4GTIYSYfwvPeItDT_XgYEqauQJZGyj8All9Y13jYcDLJ-7tb3pxo
Message-ID: <CAAwbnpfikLQUap0MLYFpk83BahLaiYZWP50hV1J6YTftkeGT2Q@mail.gmail.com>
Subject: Re: [PATCH] nbd: do not reclassify userspace sockets
To: josef@toxicpanda.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm just following up on this patch to see if you've had a chance to review=
 it,
or if there is any additional information I should provide.

Thank you for your time and help.

Best regards,
Haocheng

On Mon, Jul 13, 2026 at 8:03=E2=80=AFPM <l1za0.sec@gmail.com> wrote:
>
> From: Haocheng Yu <l1za0.sec@gmail.com>
>
> A Syzkaller-based tool we developed reported a pvqspinlock warning when
> one thread passes a TCP socket to NBD_SET_SOCK while another thread
> concurrently calls setsockopt() on the same socket:
>
>   pvqspinlock: lock ... has corrupted value 0x0
>   sockopt_lock_sock()
>   do_ip_setsockopt()
>   __sys_setsockopt()
>
> NBD gets the socket with sockfd_lookup(), so the socket remains a normal
> userspace-visible file descriptor. Under CONFIG_DEBUG_LOCK_ALLOC,
> nbd_add_socket() calls nbd_reclassify_socket(), which in turn calls
> sock_lock_init_class_and_name(). This function resets sk_lock.owned,
> reinitializes sk_lock.wq, and calls spin_lock_init() on sk_lock.slock.
>
> The sock_allow_reclassification() check only samples the current socket
> lock state. It does not prevent a concurrent syscall from acquiring or
> using the socket lock immediately after the check. Reinitializing the
> socket lock while setsockopt() is using it can therefore clear the
> queued spinlock state and make the later unlock trigger the corrupted-loc=
k
> warning.
>
> Only reclassify sockets that are private to the kernel before they are
> published. NBD accepts sockets supplied by userspace and cannot make
> that guarantee, so remove the NBD-specific reclassification.
>
> Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
> ---
>  drivers/block/nbd.c | 37 -------------------------------------
>  1 file changed, 37 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 8f10762e90ef..e2fe9e3308fc 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1238,42 +1238,6 @@ static struct socket *nbd_get_socket(struct nbd_de=
vice *nbd, unsigned long fd,
>         return sock;
>  }
>
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> -static struct lock_class_key nbd_key[3];
> -static struct lock_class_key nbd_slock_key[3];
> -
> -static void nbd_reclassify_socket(struct socket *sock)
> -{
> -       struct sock *sk =3D sock->sk;
> -
> -       if (!sock_allow_reclassification(sk))
> -               return;
> -
> -       switch (sk->sk_family) {
> -       case AF_INET:
> -               sock_lock_init_class_and_name(sk, "slock-AF_INET-NBD",
> -                                             &nbd_slock_key[0],
> -                                             "sk_lock-AF_INET-NBD",
> -                                             &nbd_key[0]);
> -               break;
> -       case AF_INET6:
> -               sock_lock_init_class_and_name(sk, "slock-AF_INET6-NBD",
> -                                             &nbd_slock_key[1],
> -                                             "sk_lock-AF_INET6-NBD",
> -                                             &nbd_key[1]);
> -               break;
> -       case AF_UNIX:
> -               sock_lock_init_class_and_name(sk, "slock-AF_UNIX-NBD",
> -                                             &nbd_slock_key[2],
> -                                             "sk_lock-AF_UNIX-NBD",
> -                                             &nbd_key[2]);
> -               break;
> -       }
> -}
> -#else
> -static inline void nbd_reclassify_socket(struct socket *sock) {}
> -#endif
> -
>  static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>                           bool netlink)
>  {
> @@ -1290,7 +1254,6 @@ static int nbd_add_socket(struct nbd_device *nbd, u=
nsigned long arg,
>         sock =3D nbd_get_socket(nbd, arg, &err);
>         if (!sock)
>                 return err;
> -       nbd_reclassify_socket(sock);
>
>         /*
>          * We need to make sure we don't get any errant requests while we=
're
>
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> --
> 2.51.0
>
