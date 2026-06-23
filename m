Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF231F4176
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174128; cv=pass; b=rlTCeZU6S0VWynX7fFm3+0L4+E+87k3WAu0HYvdF3mlQpKT9sxD/Fj+wQBQO/g2/7j+XrtKfQCOdQO5JuLpQl1DuVDKwWIhek+kb67sO83lXSRsrnqYOFGKJNUO/JLAJKpG9J95W1AKZ37g3yw4+PjcB/3iZoKcZfzxKqGhWQt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174128; c=relaxed/simple;
	bh=RIuY5a2HKJO6h14/lkjaRYtOWipwqSkPLwZPgqIxLZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3Nt9ztHUG/l0GKvm2sa1gxFxyjJkSr4YKY3D4cN+F1d6ALX5mipHbmL7oDwG/K1cDiPtQQ4xziljc2Oh9UqBe0ViWbNw3lRr24fDp3sBqZgThk0DaD84HOJGIAG3WL7ir5I/0Ima1+f+tAyU1yiBBfz3DQffOG6zL8GF+gt1/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+CdHzpB; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+CdHzpB"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5178a42caa3so4396151cf.1
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 17:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782174126; cv=none;
        d=google.com; s=arc-20240605;
        b=V/NABnrj4G+kaHjXtiWut1tl3kTs2PMuvR11MgcHmHrAGSYGWbSlNbGZwL7+pyddJh
         412xLo76CZJFjQKijtnOmjhSpc8fs96ouVEC94ucTWV4kdTQRkav2vdV8j36hoTNKKmC
         d80nUqiSdV6BcwlCoGPiKCD7bjRQQkD743WIMwUbvMBWirvsEwyMLFZfmadf30HF0/kR
         igSCpEmXrOYcTvKHhvDj5HJTbTaUBt08R3BSaEBoYI8Xbqb/rRLulK989dV8YvKMWjsn
         jpoz7fycBYaci90HMwYNTwnuJCH+mA/Ei6P6DDpIq6WGIzFNZBZoCZrE+msKdhvXgHtK
         TPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RIuY5a2HKJO6h14/lkjaRYtOWipwqSkPLwZPgqIxLZI=;
        fh=y2wiqTByM5f/k4ueN5vkMOw7XhT6uJlFKzk0sPrxODQ=;
        b=i+UtmDB4MFhpDAAAZHHkPtCniQ2Wb4h21huOMn8fnm7m8qIke6BVkAHCqpzAFE/K5Z
         1+KybNbPyGSp6F+A9XtQdXMB5gs0xbLDOEDsSB2XJRbI44/UDolV5y87O3mGiSsLQeKY
         AI/GxY7q72yYyJqYu6fZuDwc11CSibfZrZJ60IMpzJEqaMMNtl15stYFocxipN8B+j5T
         G4FdUWPEDOBdiDigBdFMRxz9tPH410THrA7RmBglvql6WSOgtgAAJ2Ndda/9YKzddpZk
         DfcHYsbGJmouBjxW/TIAvVJqvGmS+cZXF5DPmhe0NyNRHxfhxhKHD/4jqKMphOOogBpT
         tNlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782174126; x=1782778926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIuY5a2HKJO6h14/lkjaRYtOWipwqSkPLwZPgqIxLZI=;
        b=S+CdHzpBt3EBLTYO97ql3ho/BHCviK1NFAEbp/XOvS5FAqXbwds813OObslItxQ5NR
         3OcOUD1PgMyLcXzqQPhtVm2i+9hBlWTJV1HaOZRpNpGzZTqglb5W1qdsWCIo3UllUL6y
         VvLPTP8qLEdYofnZCihKdT5zp1HJENHJLdRFPIlLAPRU1l5tSRYBy/WKS2P2kCpf9Quy
         N3UxJ1fXatkgSpghHoRjXK4PvxrtM9pm6jUUQ8pd+uWpIqbT7fayEGtsnbtMRRYoMciy
         +bmWrPBK+Y4bu+f2QUR/OeQVLwVnioJbNJld3J2CAFchcJ22rSBdl6T1kTLxlXPSDXRK
         c+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782174126; x=1782778926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RIuY5a2HKJO6h14/lkjaRYtOWipwqSkPLwZPgqIxLZI=;
        b=nTEwKCQSNvoHmpYoJcVIQVdlhY6zXl9Jt3s7vCb5SdLBrqgfUhhEaXlZVxGH1gYON0
         FZKjmlRT+5Yrfw1DdNv1JA3N5oRYuol4oNrJG+B9JR9/A6KzvPOWyHQjP/9Uj+xQxknJ
         2+9mDH1f+u8pN2d0Nk/t5NzXTx+MhPUiSpDS15fbhTh4w+m9z6UoVBQEkUMm/lwxImA1
         uIPww7Zn8BcBvcK1b5rKh3QUR13xzjZg1iSm+RdnF/cPxx4AJ5DW385NrkUKKphu/ifi
         sSpGywXmTuP8UhBYr05iQW229uulKuTXlHoPGwSB8/lquhsmLBjdiMidZ/cxMOtu57Nh
         ULMg==
X-Forwarded-Encrypted: i=1; AFNElJ9/rXRHjHQ5uVv29JpWMNRRNmxSpf8mslhBz/w5TdqAxM9VDDN1eW57xuULSUtfmT7/CK2dL8qeNXF24w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIq22PvIS+8Yc/q/u5sdkAKhfv8m1TAklt88g0bh1bQymey31
	45szSyEKKM6t+vvbgxW3lZd/uN4O2dD+VBgJOtcUAagR8wE5CuSD+tE8CZbOVUsADn4Oy1wc8uM
	Vsbn9ieKSUMPvYgyeGOFXkZiVL2VM8/BQG+MnoNTa
X-Gm-Gg: AfdE7ckutulIncTxVVoFQjHgiYNnUUm6ohOjuc8Z5MWZAVMejjZn4+5yl6fTP4Bgohy
	Y1sgBbG/SmFBKLwlrDYZm7SUWN1BE4dDluPzPXUX+n7TduqZe/kUyI2Dp9NhiiF0lCbXVHagxA0
	+AoSREVamC1MLsekkpdqT8g2hO4PiJ+VmYMWmRg6gefdJYqUHOaxruEu3KoW28alLQ5WFr2NsdU
	8cXXwsvgla33yA9tNj44YNWoxRU+3bIXWRROICYqpguFLX37Ihzv5LcP3110Ai32wq6MOPoHh8H
	u6V1egSMKUk4W1hgq80ki+bLVzIxAtYPWqbsizgIjfqZKAshc70RXR3fDtJBcKCc9DNsT/7oz4k
	TQTS2set9
X-Received: by 2002:ac8:57c8:0:b0:513:e686:b361 with SMTP id
 d75a77b69052e-51a51794604mr23792491cf.2.1782174124992; Mon, 22 Jun 2026
 17:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJBomCNpwzOiYHmmPf0i3KQGaqoiKh6VFeM6NHOQaCn3Q@mail.gmail.com>
 <20260623000723.135-1-hdanton@sina.com>
In-Reply-To: <20260623000723.135-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 17:21:53 -0700
X-Gm-Features: AVVi8CfjcFjX-lSy17ur8ZhZC6YM0G5CgTrGQiRsMgjOp8hORMT5Fa9cgvOgEO4
Message-ID: <CANn89iLPWCo_u-8jCsDM6jjZYfESvtUt9n3xD7yuAyNNntSw6w@mail.gmail.com>
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
To: Hillf Danton <hdanton@sina.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, linux-block@vger.kernel.org, 
	nbd@other.debian.org, linux-kernel@vger.kernel.org, 
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 5:07=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 22 Jun 2026 01:18:10 -0700 Eric Dumazet wrote:
> >On Sun, Jun 21, 2026 at 6:43=E2=80=AFPM Hillf Danton <hdanton@sina.com> =
wrote:
> >> On Mon, 22 Jun 2026 05:22:55 +0530 Deepanshu Kartikey wrote:
> >> > nbd_reclassify_socket() warns via WARN_ON_ONCE() if the socket lock =
is
> >> > held at the point of reclassification. That assertion was copied fro=
m
> >> > nvme-tcp, where the socket is created internally by the kernel
> >> > (sock_create_kern()) and is never visible to user space, so the lock
> >> > is guaranteed to be free.
> >> >
> >> > NBD is different: the socket is looked up from a user-supplied fd in
> >> > nbd_get_socket(), and user space retains that fd. A concurrent sysca=
ll
> >> > on the same socket (or softirq processing taking bh_lock_sock() on a
> >> > connected TCP socket) can legitimately hold the lock at the instant
> >> > NBD reclassifies it. sock_allow_reclassification() then returns fals=
e
> >> > and the WARN_ON_ONCE() fires, which turns into a crash under
> >> > panic_on_warn. This is reachable by simply racing NBD_CMD_CONNECT
> >> > against socket activity on the same fd, as reported by syzbot.
> >> >
> >> Given the syzbot report, if you are right (I suspect) then Eric delive=
red
> >> another half-baked croissant, and feel free to cut it off instead to m=
ake
> >> room for correct fix.
> >
> > Nobody (including you) caught this.difference between nbd and other
> > sock_allow_reclassification() callers.
> >
> Nope, actually it raises the question -- does the deadlock still remain
> after your fix without the lock key you added applied?

LOCKDEP might have a false positive, but it will be much much harder to tri=
gger.

I had about 50 syzbot duplicates (that I did not release) before d532cddb6c=
60
 ("nbd: Reclassify sockets to avoid lockdep circular dependency").

>
> > What was the "correct fix" you envisioned exactly?
> >
> Frankly I had no evidence against your fix a couple days back, but now I
> see your lock key approach fails to take off. And the correct fix is to
> erase the incorrect locking order ffa1e7ada456 tries to catch, more
> difficult than you thought so far.

Which incorrect locking order are you referring to? This is a LOCKDEP
false positive.

I suggest you send a patch so we can discuss it.
