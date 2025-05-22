Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47861B0413
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924466; cv=none; b=qDKxApHgNPuQxs6yUE3YAFpZfzl+vJCyoxvCutdkjrnIC3jJZGXIgGLPriRKi+7hzmY5c8Yudi0UPEzLZhaPLQJd0r5m2DoV0G/jDGpeB720q0+pRKisbHeqK4sz72kmDUWsJTYIEzc9f2Xi767U3n7zsPK5g/TBiCfFKk0yKp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924466; c=relaxed/simple;
	bh=RaC1uURdOyVfgSvUTIHPl9JVM1ZPrU9Co8xAGlfBA+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLRIBlz7oSyM1hdiF2fU6CSoXVfGNY3FDmPFsL68ITisxpFnc7w/QYKdhnz093ZFVNl2sSXmqX7pHzu3OzTqQrly9cArufjzEsUoLQPwOm/m7nhIK1WIubuqPiqyPIXE8ipovM98ls0KDPFpyf4BTMmCq1Q3/NpB7OP/16c09Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eideWIwA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eideWIwA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231bfc4600bso9089585ad.1
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747924464; x=1748529264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAFxDxcsV+O01UOyfhZfQi7+2P76SbnGLqYLGNFxF6A=;
        b=eideWIwAjaZu9wBQo6bYLmwMf7NPpdbgGRhBzVLCssB0LlThAsXWsBx3I+w3AWMWQT
         qSBAnqnfDgWlyJKIyI0p8yKl/04GFnVP1wGypesUXb5he0PbcL7K/0TvckKgU6US2NAt
         FW4EmZfUf/ubXaSdx/D4mSWFLsBXV86fYqMkvk+kChdz5oRcQAacN2jUSO3if9mi5TCl
         bWF6wvZTr3sOCezcwni54bdExFXsq3s77X4RQjeH2tEYRV/zYAydOacbVmwML2yNQLIY
         sDbqLCsdUcfSggtC/dWhShbJnMrBAd44XX3eFmOhLJfjoN9OxMCmegy2uZ1WrWOwqWg4
         yUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747924464; x=1748529264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAFxDxcsV+O01UOyfhZfQi7+2P76SbnGLqYLGNFxF6A=;
        b=Hlyoe19qxlEWWaQL2y2AgkQ3NpVgB5hI+fxGOze4yADDFlZw9iy8ZPFaBIwCQHel3U
         Quhx2CsrLBZZV9xZXMxQ/l2UGR5P9GrKasXAzXTbnyG9cgPFn3YXrjZAOVEaMcMGhGMg
         bMvEM7B14k8eFJ76XypxY0HpE+mNdJvJobwSkMWREjQC3ZOoLg9zmONo+2NktTLhNDRa
         jXXQXY0XXfOlX2CW2LQ5eV6FvSBGD1vObtvTLmZFTjrp4BL+xG4yiat8vd6OGT5NMMd1
         p2jZYidEjA6lrIiWh0JXb7I0ftofd8HMGDdsuH/wMdyjzf2w4WaXMwt6NwDNt8dQzcHf
         M5qw==
X-Forwarded-Encrypted: i=1; AJvYcCUBNHc24RlZhYN+69yVMB5gLaftG4ZtDAnFKjjuwt0V3HH33HIhoZ/x86wRZCOTb4TZUCTapWnOEvbvzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh2QtGWuZO0ytXDG5gJNYNpog0MPV77+ueyO/fZAniwXjq/ovK
	VuFmKv+6xFZ3RYDzTEc0r8LUuNmtTpNgGHc6C6u0Mdm4gw4Hp1oG0EtJlj8cUviDRzCTi9L7r6b
	F89GGXCjra0Ii4VPoE03JHeJoAkPvviAcfRSV6BPntA==
X-Gm-Gg: ASbGnctoa4GRDY2AM5WHxELun+Blfw1B+QYWE0VuTmdBPQduvTTRDytlwQ3NyAdtfiM
	DJy8iAom1CfmLX5EdJfWQ5tzByPIjKPtro1jA/G0RKX5fBV50LmndfDg+vj5ctk8KOAczGJT92+
	XTX6sJHIV9S5Jh51fyWr14sGOgA117rjI=
X-Google-Smtp-Source: AGHT+IHfVA2dllWqoa1e6AwwdxooDk4eZjcfbtmo8xZnZZG7eMBTZaMm3RZ1l01SXZMe3wwZIjAlXdjS7qv1SvCjhz4=
X-Received: by 2002:a17:903:1987:b0:22f:b902:fa87 with SMTP id
 d9443c01a7336-231d450f7b1mr138668925ad.10.1747924463942; Thu, 22 May 2025
 07:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522135045.389102-1-ming.lei@redhat.com> <20250522135045.389102-2-ming.lei@redhat.com>
In-Reply-To: <20250522135045.389102-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 22 May 2025 07:34:12 -0700
X-Gm-Features: AX0GCFtx02V3ZXj8RDgeYPnY48s2AdWzi_kc6hpsciFE9vh2CgQTHTaeo-nFVwc
Message-ID: <CADUfDZq5V=7ah8bHgPosjWk=Pshgw2S5jKuX7LhX8HVGRSH5dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring: add helper io_uring_cmd_ctx_handle()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 6:51=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add helper io_uring_cmd_ctx_handle() for driver to track per-context
> resource, such as registered kernel io buffer.
>
> Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/io_uring/cmd.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 0634a3de1782..92d523865df8 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -140,6 +140,15 @@ static inline struct io_uring_cmd_data *io_uring_cmd=
_get_async_data(struct io_ur
>         return cmd_to_io_kiocb(cmd)->async_data;
>  }
>
> +/*
> + * Return uring_cmd's context reference as its context handle for driver=
 to
> + * track per-context resource, such as registered kernel IO buffer
> + */
> +static inline unsigned long io_uring_cmd_ctx_handle(struct io_uring_cmd =
*cmd)
> +{
> +       return (unsigned long)cmd_to_io_kiocb(cmd)->ctx;

I would still prefer to return const void *. That would avoid the need
for a cast.
Other than that, this looks good.

Best,
Caleb

> +}
> +
>  int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq=
,
>                             void (*release)(void *), unsigned int index,
>                             unsigned int issue_flags);
> --
> 2.47.0
>
