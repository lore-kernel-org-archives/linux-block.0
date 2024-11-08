Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156710940
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027592; cv=none; b=Fsw9SFrIAYsSzW78fD0qafsULznvbWGoKHm9IGxKjQBH9MARs2biNtwzqr5rci1Y3lHLhtCvpjinaxDWh79fcDtVTPXHQNWyguFlLDZBmF6IPMUuT6oVGpY8BgIaIoSkHEaBN4QTao87H1G+ByeebZtkNzcaPqbyLtLxv+KhykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027592; c=relaxed/simple;
	bh=W4hReRp2Mnbvh0WIskrdIeFbIogt3Hkskf8ms8EAoOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e03o/36bBnTyfr63wewOSBDrwMEaEk3k/Y7ac2OpgtoroLXkUP2loTCWAN3olMoMsgheOkvA0sNYu+LVYkVtO4fQuhPkYKOwgosE7rxTet7NefbxYw9qKKYXBrYD2Q5KDg95pFEzjBsEWdcyVHXwM173Q86b2UCU1pntGaLe2vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QR/oND6t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QR/oND6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731027589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrxY8mthm3WC9EQoiDbhDZtH2molPeBe5KI5KQp4nCM=;
	b=QR/oND6tXLM2fb809ey3aBwkxh9QSl7lmcXMWOejAQ9MmFzmXHdaiquAeur+wbE5n9EDLY
	5hJUCwgwgbh1KZ7Oiewu7kj5j/rF1n16S1YB3Wu8Zy/bIG8W15xWU132g7auc5OKhO2SMr
	ghTMQZVWmcZ/XMDEPz4FNiGq7QOU9WA=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-xvPdSFcxNgeOXzeOQElAoQ-1; Thu, 07 Nov 2024 19:59:46 -0500
X-MC-Unique: xvPdSFcxNgeOXzeOQElAoQ-1
X-Mimecast-MFC-AGG-ID: xvPdSFcxNgeOXzeOQElAoQ
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-855a975ac04so2839028241.1
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 16:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731027586; x=1731632386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrxY8mthm3WC9EQoiDbhDZtH2molPeBe5KI5KQp4nCM=;
        b=bcXiBRZtj6BXO1/uUT778cwBdoMv8Y7wgP+HnnjSMgbfln1wz8xUUi3KR+F5gdPxku
         9ym0DLdfpDDyPaEvLW4Mj5mn5UOJL3iVbBEuruBmlUCfKmfFON2D6dLcvge/eCfC0K1j
         YCcLLG/vNaX1nhYTRIohzTGbmJ7HQmWj/+TRXrQw7vyYMCzLYRmK1svC58JZqH0VD0Gq
         r7qnVfImEuR4AfnfEGwsVdedFslHBcqD5JrkgLWKSjsB2ms5aYxSnICikvRm8zddA75k
         CLghkawopN/sTjJ1VI51x5lmJJx9g87hkj0Awyp2f3mKuiU4mak8/gDZvnTeo+zTvXcR
         vI/w==
X-Gm-Message-State: AOJu0Yw4Gqp2cVua/gw2UshfuLUW4pn5L7qQfurwEl3fmmeXc3dsC2sa
	psCkpYU21SdiiUwEJWz2pyXqMVohbzpTvyHh2JFuwymHsw1sqnQFnOqXqibonDnREOIfmjarQqh
	0vYCEQadp3jUYqRMbQdPM7DY+FsaqB3QMPTd3kscrGX0cxekRPNdAWXCBHO8Prnru8hcnNBV+vn
	KGLgTm6rXjwT3VptyluZ39uRqs54kJqNJLhSQ=
X-Received: by 2002:a05:6102:f09:b0:4a4:4868:cfd9 with SMTP id ada2fe7eead31-4aae2155d07mr1001990137.1.1731027585789;
        Thu, 07 Nov 2024 16:59:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV2g7efsraeLBtXSmAhHbiS1EPg9TvsBp4gAzEj57wDFhMq4wrH7lpK+/pHfyImoFhI9XQ4HQC46BD6cztxeI=
X-Received: by 2002:a05:6102:f09:b0:4a4:4868:cfd9 with SMTP id
 ada2fe7eead31-4aae2155d07mr1001987137.1.1731027585541; Thu, 07 Nov 2024
 16:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107110149.890530-1-ming.lei@redhat.com> <20241107110149.890530-12-ming.lei@redhat.com>
In-Reply-To: <20241107110149.890530-12-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 8 Nov 2024 08:59:34 +0800
Message-ID: <CAFj5m9+wyUzA2WDN4YA1Q=YwnwVZ48g5=q1HSMaXbs7-oHgPYA@mail.gmail.com>
Subject: Re: [PATCH V10 11/12] io_uring/uring_cmd: support leasing device
 kernel buffer to io_uring
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>, 
	Akilesh Kailash <akailash@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 7:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add API of io_uring_cmd_lease_kbuf() for driver to lease its kernel
> buffer to io_uring.
>
> The leased buffer can only be consumed by io_uring OPs in group wide,
> and the uring_cmd has to be one group leader.
>
> This way can support generic device zero copy over device buffer in
> userspace:
>
> - create one sqe group
> - lease one device buffer to io_uring by the group leader of uring_cmd
> - io_uring member OPs consume this kernel buffer by passing IOSQE_IO_DRAI=
N
>   which isn't used for group member, and mapped to GROUP_BUF.
> - the kernel buffer is returned back after all member OPs are completed
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/io_uring/cmd.h |  7 +++++++
>  io_uring/uring_cmd.c         | 10 ++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 578a3fdf5c71..0997ea247188 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -60,6 +60,8 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *=
cmd,
>  /* Execute the request from a blocking context */
>  void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
>
> +int io_uring_cmd_lease_kbuf(struct io_uring_cmd *ioucmd,
> +                           struct io_rsrc_node *node);
>  #else
>  static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,=
 int rw,
>                               struct iov_iter *iter, void *ioucmd)
> @@ -82,6 +84,11 @@ static inline void io_uring_cmd_mark_cancelable(struct=
 io_uring_cmd *cmd,
>  static inline void io_uring_cmd_issue_blocking(struct io_uring_cmd *iouc=
md)
>  {
>  }
> +static inline int io_uring_cmd_lease_kbuf(struct io_uring_cmd *ioucmd,
> +                                         struct io_rsrc_node *node);

ops, the above ";" needs to be removed, :-(

> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif

