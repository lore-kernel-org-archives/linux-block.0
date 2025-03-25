Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619225D529
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916393; cv=none; b=XQSQ/Ubf1wznkG+nJBcAmjWRRrKGchQ3FAnO+zHU5Hd3JCFPqwsU4HxGya5z+nA9AF+i7D+7Eij88B+SqTgehW6FJfDU+c8Ua36+LQ7mroeFpvDtLZFyU9PAm/2krXzDIUG44T3UbSU1YyvjPRyOnnR23BhU83RFYDkFd/4auzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916393; c=relaxed/simple;
	bh=S4j9d6utTDYSb/6VBejg1LjDWSUnOWeKAOOCpY7h16U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPub+xB6n6zs5z7vAnGsjbG207myYxu68+aa7l3A+cFA4ISuNTKsMF6tejSTlr+/1CHV0bXoawNNmtlbHdQ2tGfMAudS6uWZ71gKwC+/W4cabTHK0nPKKElUCfnrHANHUdlRD5w5b4EKZBilO4IsHKcSNOSoOy4y+jWLBH9YBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZoeuFZa8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZoeuFZa8"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301b4f97cc1so1736962a91.2
        for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742916390; x=1743521190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cnv9qwT63ocl4FeNbSSE3HhvwjsZV+2/RwKRPst7B2A=;
        b=ZoeuFZa8nrmKlAF/ZVUN4/r1H+XbA7/VGzFsvyrLe8fkEu9/5PPENstIVBhtzI2UBf
         1IB/psfJ4CN+hx/pSXJBa7gnW5+mKBIKePP/c4UqYTYUz7WEcJHkzeqXdGsfSOh6hHan
         +K8x9/2bxPK4T30aQ3wDc4re/1ap+XDYzG67mNnxrVeM9GbXzNEKBnEU+ATL+htGpAMo
         YXspT/x+T6jIAhvS2LBslhNwMtNUP1zrAcJ/PpmtJo0lUjrerqKjPjG3PpxxEyUztaqa
         NVf4p5ckZD7SA3uEP9kMmmiZYS6ZNDjcAouBrskNtO2lQxCL1mi1apeeoXGmxPUeECxG
         kPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916390; x=1743521190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cnv9qwT63ocl4FeNbSSE3HhvwjsZV+2/RwKRPst7B2A=;
        b=qPZpIWAu5GoHYAd0P5T55V9rFHcxEZfuOnTIvi+sipnIBvEKvGTWO36ExnR7KtLUXF
         6aU2Idc4MoLdPgNh2+5QyLf3qUiykdWGmrJAtoZDuXdF5UEC8M/Y2FS6kwXIr1OhjJM9
         k/j2DiCvgfW6aTCMu/AEblrVLsFhvU11xJNknC+180oEHqv3I7uhY2rq8D1LAXXCkyfe
         5qcIRCo9rhq7p3Ja1ahWOpUx+f/HkDJMRSKbqM6vr7Zy3WTkS9pZweDoSd05Gl6Q+W1L
         t7Ava41OTPHrjc0dzUfMi3z4/aG3d+fE9muwBVIthlXIjkPsED7u3N8tPfFZI1SsdJL0
         rxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl1qy+9xnltuSwMSJP3yfZeUi6OhJHqes+elFkCW/mwvzcHwZss4E8YXZVuBxGBa43dlV/UQPUrUGREg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUezvME3mYA1bOTxyOrHeDohTCYuZlvNMsmpBAv5fdr6htqyi5
	MhGIgHRgNqLdan/z1N2kGJpO6+exVOHkiNqTC89ck51XcznKhdg6lqlG9Wi5lsm7bfydjJ1L+MH
	UAbWl+1ZtzcsQ9HEl8egc+vDVcnJYZqaJq5h8xknGhcumgDVEGh70Sg==
X-Gm-Gg: ASbGncsT3twgoS4oImyvZy5Y5aMD2AELGCh8gfPrHwYJiqL2l17h2qyeLQqUh4IEmrs
	RkJLy+IE4b+IA6tf2wIDuj2USglQfDJmXXonQnP5Xm4jsFTVFv0elysdN/dU8CCRp2pL9OjLy6S
	5wEXWV/NBNWmtt+5+mElsKvz7f
X-Google-Smtp-Source: AGHT+IHKTnd/f1qmnUacnuOwyG/mZqGWGJFtSRNihjhlSvXKuHpdAeRBitu1ruIsa/aDg/TX2Cnjbu1gWn051TOs/l8=
X-Received: by 2002:a17:90b:4c46:b0:2fe:b879:b68c with SMTP id
 98e67ed59e1d1-3030fefacf2mr9973877a91.6.1742916390470; Tue, 25 Mar 2025
 08:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324134905.766777-1-ming.lei@redhat.com> <20250324134905.766777-6-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-6-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 25 Mar 2025 08:26:18 -0700
X-Gm-Features: AQ5f1Jpd_6IU0WA03b54RZTOjItcAGCYEgFRf5_BsdYmRG4CZ35qHLzhqC9QNCU
Message-ID: <CADUfDZquEOA7ckJVkBbcso2Paw9viSa9-5eQptgRgQRoxgvVqA@mail.gmail.com>
Subject: Re: [PATCH 5/8] ublk: document zero copy feature
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add words to explain how zero copy feature works, and why it has to be
> trusted for handling IO read command.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/block/ublk.rst | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 1e0e7358e14a..33efff25b54d 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -309,18 +309,30 @@ with specified IO tag in the command data:
>    ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
>    the server buffer (pages) read to the IO request pages.
>
> -Future development
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
>  Zero copy
>  ---------
>
> -Zero copy is a generic requirement for nbd, fuse or similar drivers. A
> -problem [#xiaoguang]_ Xiaoguang mentioned is that pages mapped to usersp=
ace
> -can't be remapped any more in kernel with existing mm interfaces. This c=
an
> -occurs when destining direct IO to ``/dev/ublkb*``. Also, he reported th=
at
> -big requests (IO size >=3D 256 KB) may benefit a lot from zero copy.
> +ublk zero copy relies on io_uring's fixed kernel buffer, which provides
> +two APIs: `io_buffer_register_bvec()` and `io_buffer_unregister_bvec`.

nit: missing parentheses after io_buffer_unregister_bvec

> +
> +ublk adds IO command of `UBLK_IO_REGISTER_IO_BUF` to call
> +`io_buffer_register_bvec()` for ublk server to register client request
> +buffer into io_uring buffer table, then ublk server can submit io_uring
> +IOs with the registered buffer index. IO command of `UBLK_IO_UNREGISTER_=
IO_BUF`
> +calls `io_buffer_unregister_bvec` to unregister the buffer.

Parentheses missing here too.
It might be worth adding a note that the registered buffer and any I/O
that uses it will hold a reference on the ublk request. For a ublk
server implementer, I think it's useful to know that the buffer needs
to be unregistered in order to complete the ublk request, and that the
zero-copy I/O won't corrupt any data even if it completes after the
buffer is unregistered.

> +
> +ublk server implementing zero copy has to be CAP_SYS_ADMIN and be truste=
d,
> +because it is ublk server's responsibility to make sure IO buffer filled
> +with data, and ublk server has to handle short read correctly by returni=
ng
> +correct bytes filled to io buffer. Otherwise, uninitialized kernel buffe=
r
> +will be exposed to client application.

This isn't specific to zero-copy, right? ublk devices configured with
UBLK_F_USER_COPY also need to initialize the full request buffer. I
would also drop the "handle short read" part; ublk servers don't
necessarily issue read operations in the backend, so "short read" may
not be applicable.

Best,
Caleb

> +
> +ublk server needs to align the parameter of `struct ublk_param_dma_align=
`
> +with backend for zero copy to work correctly.
>
> +For reaching best IO performance, ublk server should align its segment
> +parameter of `struct ublk_param_segment` with backend for avoiding
> +unnecessary IO split.
>
>  References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.47.0
>
