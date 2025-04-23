Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F64288CAF
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420911; cv=none; b=VAqe1qcSOUKIk87Ud/cQvUrG9yaen2ForjAUEpOHeaRhOwNE2V7uHIjG1f2RZj/SrU+FK5RFCshfLa7hvl0kjyfJfmz9DX6S/AcfnSQmA9BQXfs/WxWuTY++sqmXf1Hrf97b1ASRCr7v6lb4dBj4ckNUHU/7Ip+itSxfbpvn7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420911; c=relaxed/simple;
	bh=vfHRK1Z78x7MzBkK1umX8iFjMXqR4+VI8MlzVzX0rYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQudZXFeFahFD+jxT6Hxg8UezDS2+ksGdV9OWyiDYtlJC1/4brGYQBQBCuVxPctp7IJncd7Z1yRW7fiYzhGl2NY0xHodW3lasyD0kVJM34bKJ364qNjz5m137FC+u3L1g0Sq287mJRis/d2tT4aIN7do6Wh6CUaU1YkUY9fu8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ip/lXu76; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ip/lXu76"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so803724a91.3
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745420908; x=1746025708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0FB6YT/XT7xdqqt/W5ciOk4D/IqF32FPJRyWTT7GCU=;
        b=Ip/lXu76mKl1O6Bnny4yZsekDB7x3CeA87IKfI4fXckQvN17PVK3MpUeaj5Plc1+VH
         N3SZEpkSYSJmjc3mtbrloRlx0uAIfWC69vOqOiH8LNyE3z43dckyvBHvdFZC5qF0d+qn
         Z2W2ClzrUgdSfULe/ejmuk7LbNnLTdGJOyspwXU/ZLM8aLmhPWfuE6tfKjfA6ncONWK5
         NeFDUCOhRNKaBph9EOMRjAwcQV+9M6LtJ5nPg1wAh67yLrv0bgCAiUMcFVVhtx8pCixQ
         uUFEDHteDOR716H6adED46I5aXxqiouRhJY628kzYhWycaiFvelIz/bPbEcj6cMdBuLP
         2guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420908; x=1746025708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0FB6YT/XT7xdqqt/W5ciOk4D/IqF32FPJRyWTT7GCU=;
        b=STxBT0XT6qlbHNZfcIlSvtY7hKteYk5t/5a1evpsRqC3bswMHm6tMb3siUbbic3dR2
         dtyqqfAhXtyxKVfmkWJF+6hyGvz4vg6/5k/nqC4ASMWuGLk55jPRpWzvIKIC80ipJdjR
         whkulH6kOyomOHx7sv1kayliKEjJZ/AX37TgXvsygEwrvYcbMx4i3IIRrADVgK+aeEfg
         LvIa3eb1QlIEK+LHNGoiIpfoJUuC6pzg/BpYRfGrkNNSj7r1lcArRrBa8bpc7FIQFUsY
         hljQMGHN3dVckVVoUWKjNW0nG4OO83aUeXbQOqJFQXbRaTVvWmw1e/a8vi7ha7/P5LDl
         PgYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL7ALicB1ehfo5gbQztyEI6L7hT8e09thEWalI9hnUyyju+U82TPuDDwjOliKf0uV80TRPd2pD+Maw5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUanAb2W/Zeh37i5dwYdS0Ra2dp0Kd1+rkYuUP9ebKZv2TX/l
	08Q+8/1IMQgH1plDE1gTPd6+DQ0uOcdhPB9fyMzsICDwbN756J53vCDKs0jR4meLOHmBgXNWTMG
	NhWLJcN462NFu1W4Q4Rt+bxqJwX0Zm226EpSCNg==
X-Gm-Gg: ASbGncumhI+PcUsvgFfqym44EJ7SJWir1Uz5XGeSXn+Jz+WELTZH2n3ROM4WYtGVlZz
	rorPQtdhy3PFWqtueUIRfcJ2Xfg6cBkZ0j6Tn6z0JIhKRZHZdpaCg0hfGvg+Jbfc+CMm9kXStKM
	fZawX2osVaqFbxDuQlWIqjSyFATNrfQNg=
X-Google-Smtp-Source: AGHT+IGPbRUmU9NIa5Dff50RQhWqrdWV7Xkmsm33Xakcu9kdxn7L87X4G1kjJscfva0xnVwpsnHrM5iB/v4F9Xg4bMs=
X-Received: by 2002:a17:90b:4f46:b0:2ff:4be6:c5bd with SMTP id
 98e67ed59e1d1-3087be01afemr10955712a91.8.1745420908406; Wed, 23 Apr 2025
 08:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423092405.919195-1-ming.lei@redhat.com> <20250423092405.919195-3-ming.lei@redhat.com>
In-Reply-To: <20250423092405.919195-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 23 Apr 2025 08:08:17 -0700
X-Gm-Features: ATxdqUHleI5AiWqfs362jtTdn9Dn7hoSqC67blzKfFqpqucBidXyjDUIwpOOEiY
Message-ID: <CADUfDZp4zMWBjGGsVXSXqvP2aoo2O1-SXCeyzfVj==FfKmAtcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Guy Eisenberg <geisenberg@nvidia.com>, 
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>, Omri Levi <omril@nvidia.com>, 
	Ofer Oshri <ofer@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 2:24=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
> we may have scheduled task work via io_uring_cmd_complete_in_task() for
> dispatching request, then kernel crash can be triggered.
>
> Fix it by not trying to canceling the command if ublk block request is
> coming to this slot.
>
> Reported-by: Jared Holzman <jholzman@nvidia.com>
> Closes: https://lore.kernel.org/linux-block/d2179120-171b-47ba-b664-23242=
981ef19@nvidia.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c4d4be4f6fbd..fbfb5b815c8d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1334,6 +1334,12 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw=
_ctx *hctx,
>         if (res !=3D BLK_STS_OK)
>                 return res;
>
> +       /*
> +        * Order writing to rq->state in blk_mq_start_request() and
> +        * reading ubq->canceling, see comment in ublk_cancel_command()
> +        * wrt. the pair barrier.
> +        */
> +       smp_mb();

Adding an mfence to every ublk I/O would be really unfortunate. Memory
barriers are very expensive in a system with a lot of CPUs. Why can't
we rely on blk_mq_quiesce_queue() to prevent new requests from being
queued? Is the bug that ublk_uring_cmd_cancel_fn() alls
ublk_start_cancel() (which calls blk_mq_quiesce_queue()), but
ublk_cancel_dev() does not?

Best,
Caleb
