Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D61E521B
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749508188; cv=none; b=Vu/oqsM7FhynO6jCWlUFGZx6a6g2sc8CC5y16mF5gRZoPVqxlnkNuzh/YEXkpw6jh/ZLJJQ7ha7ImTFKjOHB8nOzpCyIaOtnuso/l2LWE496MbLN3N5f6C5fHc+G9LSA0KXip/79lDkYWf2zTwdjqaLMf+AEpzmX85bphZKBBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749508188; c=relaxed/simple;
	bh=sr6gAu0q0HzCuNH4yJ5PjSIqG2kTCzVTpUbIRrzjkZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc/AgoAiUf6P9xYPOot2vhIjxhPRlhnD7LbfSj/mVTPKNNTVmfSFpbwVNWCUTYwiUyoke6Ug+xn1GhlyFF+AsYFMhXKggoR2zz8yiYirWFzl4QcjgwDGCJLmF6JSA+Dv7Pw4JNADvY0B5A/mJfpMoUBbV5voexK0uKMjLZu9c5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FZcfb6QE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FZcfb6QE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313862d48e7so267725a91.1
        for <linux-block@vger.kernel.org>; Mon, 09 Jun 2025 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749508186; x=1750112986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NLvxJwrldLFtjPyg6+gSgrwzVF6Vwkn6xb0iIUPxjY=;
        b=FZcfb6QE9tKHQhQNRx/To4NefK16ICz3ZTStnhPIZzFaTkV9V/XcLD1a9vDZn2np05
         /tYIBcWVy7HnzN6n9m1M5YI9ggzjhepxKnsgEnWtBqiJB/WZIDaac1gd9VKnesheavQC
         k7WaXPyhsk6ESx6nDJlglfP3fdgHv57c4WTXJbBD8PC/bbu4B5DXz7vwFGIbQvSZqqLV
         YsSzczLZPQclooCbrAb46LatXJ3OAEKkWBPdQFleeFJEHjrtc8qBJWPstwiD+o4SIaXj
         OJVD8/jGF4IfZj8dSwOGJ/CFImhvpX2/OsNVG5fpIpzconG/7w1Wi2QauCgAzN6MDbi0
         +u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749508186; x=1750112986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NLvxJwrldLFtjPyg6+gSgrwzVF6Vwkn6xb0iIUPxjY=;
        b=fUY+49U6azXgyiM14z9kKssCjhLqLNoBPYRYLWwt6cKkEb+wdq2xra8p4WorqxWwPI
         wypkzV/0+VESZxf+Ed/lAkn77FqEjNUt62M+NLpxFFo6VErbp7PpegUBTZYnEcNcyVkN
         knUZSaBexMdU6VCne0pP+uHAweN6K030NG7/jwp+oRua5ATYHAuqXZHlmufPOTeLWsJW
         5FkkAl4b+0zc/MfrBGpf3vz9Tv4FadbMxaGYK5i+Qj8oBrpZNCdTqhmARPwNYjN/vjUC
         SoWcRb+piIV3DiGgGnCCrF8TfhUfgeXmDysX5jvVFkD0rK5SbNVFtXYHFMAzQnZi36Jr
         y4yw==
X-Forwarded-Encrypted: i=1; AJvYcCWmyiPo2maKUq1VlCpdFx7swAWJEf+I9a5uI75uLUMfeYXjdYsrBET+skhzKlDPmPCPHY5WRdYjuD494g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBkYS7cUyVzT67FRWQ+CYUKI7o2eVHVnmTAMc9ghxHysj9YvVH
	cjvr4xfECzPS4FALgVlEm7vcYU96866F8XbRaPqIEcek/yYN31UIz3Cc+rTJiSjqI/KTVQrQjUK
	uW1CPs87aYwzsFdgQjYm1aehFPeoXELOgJOFCf+/Gmw==
X-Gm-Gg: ASbGncuNcqAqjw73JtM56Ms11kiNycxywvbTyTBGmddBNGoyHlyAdXYVlTI5MNCy5tR
	w7Gckw1p1buRQj7hIo+7izardyUTxHTvVx0VxAjR2qnsr6bI3+vl5hwxkdqdNWSdnNVTHwqO4P9
	L5FnSisP5Hnul7AybHGVnN/O1hyA21o+RxIVlfP47WE1o=
X-Google-Smtp-Source: AGHT+IHrCBGK55av5S0dxK0AKNraogqaGpegQ+r/MB3JmiTVuFNz5urB72UdPKXPa5J+FkZ0LLYDf5RrOTt/p69bTvQ=
X-Received: by 2002:a17:90b:53cf:b0:312:e9d:3fff with SMTP id
 98e67ed59e1d1-3134e2da3c9mr7342457a91.1.1749508185733; Mon, 09 Jun 2025
 15:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609121426.1997271-1-ming.lei@redhat.com>
In-Reply-To: <20250609121426.1997271-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 9 Jun 2025 15:29:34 -0700
X-Gm-Features: AX0GCFuFKEtzc4jYIbL6iZEHTs2zpLcD_ThlJlziu3ECl25TMO98HL0WUjnRdC8
Message-ID: <CADUfDZrHpGFKAEJhDqPNq_WMzWU5v9riN-i8V0dROo2tc=1DyA@mail.gmail.com>
Subject: Re: [PATCH] ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:14=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Document recently merged feature auto buffer registration(UBLK_F_AUTO_BUF=
_REG).
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks, this is a nice explanation. Just a few suggestions.

> ---
>  Documentation/block/ublk.rst | 67 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index c368e1081b41..16ffca54eed4 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -352,6 +352,73 @@ For reaching best IO performance, ublk server should=
 align its segment
>  parameter of `struct ublk_param_segment` with backend for avoiding
>  unnecessary IO split, which usually hurts io_uring performance.
>
> +Auto Buffer Registration
> +------------------------
> +
> +The ``UBLK_F_AUTO_BUF_REG`` feature automatically handles buffer registr=
ation
> +and unregistration for I/O requests, which simplifies the buffer managem=
ent
> +process and reduces overhead in the ublk server implementation.
> +
> +This is another feature flag for using zero copy, and it is compatible w=
ith
> +``UBLK_F_SUPPORT_ZERO_COPY``.
> +
> +Feature Overview
> +~~~~~~~~~~~~~~~~
> +
> +This feature automatically registers request buffers to the io_uring con=
text
> +before delivering I/O commands to the ublk server and unregisters them w=
hen
> +completing I/O commands. This eliminates the need for manual buffer
> +registration/unregistration via ``UBLK_IO_REGISTER_IO_BUF`` and
> +``UBLK_IO_UNREGISTER_IO_BUF`` commands, then IO handling in ublk server
> +can avoid dependency on the two uring_cmd operations.
> +
> +This way not only simplifies ublk server implementation, but also makes
> +concurrent IO handling becomes possible.

I'm not sure what "concurrent IO handling" refers to. Any ublk server
can handle incoming I/O requests concurrently, regardless of what
features it has enabled. Do you mean it avoids the need for linked
io_uring requests to properly order buffer registration and
unregistration with the I/O operations using the registered buffer?

> +
> +Usage Requirements
> +~~~~~~~~~~~~~~~~~~
> +
> +1. The ublk server must create a sparse buffer table on the same ``io_ri=
ng_ctx``
> +   used for ``UBLK_IO_FETCH_REQ`` and ``UBLK_IO_COMMIT_AND_FETCH_REQ``.
> +
> +2. If uring_cmd is issued on a different ``io_ring_ctx``, manual buffer
> +   unregistration is required.

nit: don't think this needs to be a separate point, could be combined with =
(1).

> +
> +3. Buffer registration data must be passed via uring_cmd's ``sqe->addr``=
 with the
> +   following structure::

nit: extra ":"

> +
> +    struct ublk_auto_buf_reg {
> +        __u16 index;      /* Buffer index for registration */
> +        __u8 flags;       /* Registration flags */
> +        __u8 reserved0;   /* Reserved for future use */
> +        __u32 reserved1;  /* Reserved for future use */
> +    };

Suggest using ublk_auto_buf_reg_to_sqe_addr()? Otherwise, it seems
ambiguous how this struct is "passed" in sqe->addr.

> +
> +4. All reserved fields in ``ublk_auto_buf_reg`` must be zeroed.
> +
> +5. Optional flags can be passed via ``ublk_auto_buf_reg.flags``.
> +
> +Fallback Behavior
> +~~~~~~~~~~~~~~~~~
> +
> +When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> +
> +1. If auto buffer registration fails:

I would switch these. Both (1) and (2) refer to when auto buffer
registration fails. So I would expect something like:

If auto buffer registration fails:

1. When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
...
2. If fallback is not enabled:
...

> +   - The uring_cmd is completed

Maybe add "without registering the request buffer"?

> +   - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.op_flags``
> +   - The ublk server must manually register the buffer

Only if it wants a registered buffer for the ublk request. Technically
the ublk server could decide to fall back on user-copy, for example.

> +
> +2. If fallback is not enabled:
> +   - The ublk I/O request fails silently

"silently" is a bit ambiguous. It's certainly not silent to the
application submitting the ublk I/O. Maybe say that the ublk I/O
request fails and no uring_cmd is completed to the ublk server?

> +
> +Limitations
> +~~~~~~~~~~~
> +
> +- Requires same ``io_ring_ctx`` for all operations

Another limitation that prevents us from adopting the auto buffer
registration feature is the need to reserve a unique buffer table
index for every ublk tag on the io_ring_ctx. Since the io_ring_ctx
buffer table has a max size of 16K (could potentially be increased to
64K), this limit is easily reached when there are a large number of
ublk devices or the ublk queue depth is large. I think we could remove
this limitation in the future by adding support for allocating buffer
indices on demand, analogous to IORING_FILE_INDEX_ALLOC.

Best,
Caleb

> +- May require manual buffer management in fallback cases
> +- Reserved fields must be zeroed for future compatibility
> +
> +
>  References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> 2.47.0
>
