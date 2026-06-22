Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5472222CC
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116305; cv=pass; b=L5ttZx6Rfpiv72mve7iceIVExTlJWaaC/JTYuhTc5URmMI8FC1jOZjOT+n7fKsKmSP2rxRWJeug1VV0U0jQG/ACRxR6qZsz91CidbrosyhVS/3RywlpAvfOliWxa2uGJDQy62IUwF+fkB5gQ1nta7dy0aSwP2jDLrgEGVvdY9yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116305; c=relaxed/simple;
	bh=Ysat58UPHNPIc5Z2ZJx5eLQX3NEqVZ8kJWnwpPQ9v0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkRvui5l38Ctp/m/RjJ9J468FKrDF3NnUnFs2z1a2+ieAE843m3+LbL04pAf4/fOAYS9dPxywx6v1vJoe8A/L+l2ZXZJ9JCtwC3Q4tEA/JJ8n6alTVxAGgeEk653HxMGW9zloFnIAWhAEpxi7XIAP+F9W37kbVAMfK9FdS1Px70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDYUXmJY; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDYUXmJY"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5176ca6bab1so48525511cf.0
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 01:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782116304; cv=none;
        d=google.com; s=arc-20240605;
        b=h2NSnfpqAXBbD17WJu6ek6FHhImXl8s5BE2K7DV/HhH+cTLAwYPojePWbWToVjspDz
         V7gQ/gJDQkxBn50XF5ZgOGSE5mhbY0S9zStiS3f5aFh0GCEYmSGVgczjBqJ0XVUA1sc5
         DV5yLo23xL3FU83d0pE5pH4IxDcs3ZWr+qjuYBq6Ac1mYiw8sw4dBPGHgGpxnbox4CpC
         jxHSVfkQTXpB/89qBV1fk0SeCKM2uY1M82bt3RUxImSTYc2RzzIp7qmsUt8ODSWWhsJW
         wEWuOBvHfCiTOt19vLkVzKfC39nv2l11fqK53Iea8Z+YBEsS5Vd28Rl9QEWaLZuqC+Xd
         NXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ysat58UPHNPIc5Z2ZJx5eLQX3NEqVZ8kJWnwpPQ9v0U=;
        fh=J6EBLp5cSFnoaUc1x1ZrdNDIORQmfB6viLbzEZuaYUA=;
        b=Ds8uqphr4Rng/sp/WaSwuyvOmjB3M2S8+Nif+IAb6Ujd32sfRg0DOStCoJ2Vrn0R7a
         6uA43wI4NTsPhhPtre6QRWjsWJkcDajDttez55uvqDHywS7CIwt2jswKBc4G2rUifXqH
         LKqZxox1eldBVBoe3bKU60h0/CMM//q0699fsIZfxVdtlbOml/URoUKc0UXwYGaXdThD
         ljw9MIiW1hD0weE8wJCEKphJvQCmls50P0jJqSO2goyMAsshzSDC/4bB/PwyfbJVCLjB
         t/cYH/RYTUHXNaq3oHu2CQCrLqMiwi32dD9ry+6xnBByte4VEkVSgKmLELx+jETq2oTd
         3AjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782116304; x=1782721104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ysat58UPHNPIc5Z2ZJx5eLQX3NEqVZ8kJWnwpPQ9v0U=;
        b=GDYUXmJYh9Tt6fLn+PFpombUSK//pilTHvO3dyFWOUqLUY2DrszkpVRi1pKCepMzdN
         jXIx9D2N4ONAg9wo8qzG/sPgL8QvpWn/EaiVA8+OSnWo7Kt0htb8aj9daAiY+koe/FCD
         lPQaGATkQGivj2FMiHxTrOgFdv0ZBqOkkzF69kzLWy4MZc/BecsGcOCH/KfHJhWm8uH6
         IT+2jdBHijTHeXqLuN/t+MUhCVVZ1T9/XTQ/NqzizH1t8HNr11ObVOMq/MLPAhfD6LQY
         1DOjbONKLxGo9NXnXaHyV9PEdd7n92xmH+w49jykJzjmdaLt0ggozZ5MY6XmqMKebm9l
         jD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782116304; x=1782721104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ysat58UPHNPIc5Z2ZJx5eLQX3NEqVZ8kJWnwpPQ9v0U=;
        b=QIeA0tTcqxHDnIQlM/f2GSIb/cTeig4OaLUYBgNttc9XpRFzFOhIicGc2wYyuS9o7v
         Fppvpx75IrawopfMtCRUCTBqSa8TO1TFKa/sJh/C+m47x34MRo3s6j/4DP9ND9rDtGAg
         OhbmMybp/GLndD1Izcl3fh//NDWWnz7byS0JfUxYx8QX2XpfWjJwhzhH6oI28NuBp1CW
         tNvBoyDiOF3EgK/wS+uD9JOHJxffxGZd9PCXLGh7nJIElP1rWQVHd8F4k+eM/C7fmc9Q
         uiVrGyJL0UtrXLd5dJBXe7FW8B5Q/iDtMoC8cDhDZYSkkudd6l5cZ/fBzDU6p6lKI6/m
         Cu1A==
X-Forwarded-Encrypted: i=1; AFNElJ8oO4lztG1JehOrPfAFlowkdJnIeXOrfbLSqlQhqsZBQjkFCrykZ4eqvyhPlGdl8wECraLyygX2ZVytYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx906xbG3BAMHlJDgGuNy8OdFLWSpIFml4Uq/CCoAmN5QOMUupT
	BBaxNjCAE3rLXYieMdk+1zzxSa0ghGqmWEXMSqKjgXbeuy7OZhdMdXkcRpYKYhJcjksV9PTlNHX
	bdODiUwiv/NGgzlTc4DLnuXt45mMif08Y6bYWY290
X-Gm-Gg: AfdE7cmeAnjF7FhGMOwmOHLQhq1x/tuH8kH4DdcftRRMYyQHLZ5gP0zI0S6lIo4o7yI
	zu/41mx5svVj2iO2JcLtx0NiYeTmjdswwIiP0SfNG+n8fSt9u/26chxecYWuCRj4dFe7iih8Rmt
	LmZ7bPSkrep7NeCGfvIDNELQlIxdlf2nnxlZXP3lmeHlnPjBmdXS60BOCBTGMsh4SdJ/j3QQpTG
	Nxgd2/trIHBw5fhYcCg8UXXgtEKqmWT5P5j5BRwY8FzRoPoDEjNHRYVBRjRqTyunfkXm7Kf77/8
	MkgrdYx2yLLSvILi46fjNWnKwSiu8/nM01/ZjkMFK3OESFIm0K6ANayrzDjhh3o2akxV5v0XCS1
	7EH7FPoxy
X-Received: by 2002:a05:622a:481a:b0:50f:c403:7ffb with SMTP id
 d75a77b69052e-519e67b8339mr168709421cf.18.1782116303091; Mon, 22 Jun 2026
 01:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621235255.66015-1-kartikey406@gmail.com> <20260622014328.115-1-hdanton@sina.com>
In-Reply-To: <20260622014328.115-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 01:18:10 -0700
X-Gm-Features: AVVi8Cf-1QZ27ykP333c-2nGDluMcSVlm8OvGXnxHRUILa5f0PO5YI80trF5YqA
Message-ID: <CANn89iJBomCNpwzOiYHmmPf0i3KQGaqoiKh6VFeM6NHOQaCn3Q@mail.gmail.com>
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
To: Hillf Danton <hdanton@sina.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, linux-block@vger.kernel.org, 
	nbd@other.debian.org, linux-kernel@vger.kernel.org, 
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 6:43=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 22 Jun 2026 05:22:55 +0530 Deepanshu Kartikey wrote:
> > nbd_reclassify_socket() warns via WARN_ON_ONCE() if the socket lock is
> > held at the point of reclassification. That assertion was copied from
> > nvme-tcp, where the socket is created internally by the kernel
> > (sock_create_kern()) and is never visible to user space, so the lock
> > is guaranteed to be free.
> >
> > NBD is different: the socket is looked up from a user-supplied fd in
> > nbd_get_socket(), and user space retains that fd. A concurrent syscall
> > on the same socket (or softirq processing taking bh_lock_sock() on a
> > connected TCP socket) can legitimately hold the lock at the instant
> > NBD reclassifies it. sock_allow_reclassification() then returns false
> > and the WARN_ON_ONCE() fires, which turns into a crash under
> > panic_on_warn. This is reachable by simply racing NBD_CMD_CONNECT
> > against socket activity on the same fd, as reported by syzbot.
> >
> Given the syzbot report, if you are right (I suspect) then Eric delivered
> another half-baked croissant, and feel free to cut it off instead to make
> room for correct fix.

Nobody (including you) caught this.difference between nbd and other
sock_allow_reclassification()
callers.

What was the "correct fix" you envisioned exactly?
