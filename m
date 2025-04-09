Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E34A01
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744163254; cv=none; b=cL3FBeVB+pCigdv1dhhxp4lQs4ZoViUixCJNULoR0MBZIxV4ouEXGHYnPThRz1HIVNt7y0yS9uR05xRf/5qlb9yMl0un6zma+mQcO1IW++VZ4NbCwNbuleFR6w3VL7B0MR4sHA0RkgLs3JSV7HeiSL8jM/fAua0lpBkpdGMNKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744163254; c=relaxed/simple;
	bh=HEB664oI61aQWMz1cqymaFMuRBewAYPd6cPs6W0Uowc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwQ+cOx88f1nkHiGduUg7SxyGciAOHwddTyRK/+KguE2OvBIRlHQQkYnE8JkPd8PbLGPobk+6J1fRfhqXTSnjj52gZ9ciUaNken2U0+MKc6OlE5sXjPQdbuHm9HlyDI33EIGOgAUbsfZfrUz3y4KQEFRETAacLpXypMTi2MO9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gbR7GnMJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gbR7GnMJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so1228889a91.0
        for <linux-block@vger.kernel.org>; Tue, 08 Apr 2025 18:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744163252; x=1744768052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8wKj/t9wAn5RJZ9aqFO3Bzpu2/eXd0mPCvcX//fYKE=;
        b=gbR7GnMJE4aQRiq12ZDKJNcKf02tHVBN/wv7MVPnExqvlIDrof5DlxIZ3jTYz2In/n
         zv+GkxADKtm36qZuoo+x7laOP//8POA2nv+mFwyqknbcTro/HriAQtGFWeNE2UqE1N4f
         3fZABT47kfPQLaJwlmF0R8o3P4GV5PzcgNIhFxZrfsFM5ZyPBXksWW/P7PRe9jdUn6fu
         6AkzkHg+T6/D/w3/5In5h2tFU7HUQNox7edsgEjr8NzFsjnMRtddjZ0Eg96mtyk+C8wD
         002UgPYPk5YF0x7pQ8dKHiekzXsTMN3ulxPWi8x0u/7AwtGRODtigX5w1MiWacouFz1X
         fqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744163252; x=1744768052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8wKj/t9wAn5RJZ9aqFO3Bzpu2/eXd0mPCvcX//fYKE=;
        b=WdatnvzWI+e5v0AH6VpoIe8gSKBJsvHoERLuQ0USiCZTohCACLRi4q5v/z3dHL0ddH
         QX14BikXtGHrFCu4NaBmKyltIDZyuWFzMWi2Bn3tRyhJzrh58NOoxCRI6Kw6a/2gjkqz
         LEt0A5UaYORxU6n+lMgvmu+6XM8Oc6vXAcRSB2ZvqFJd4XFXZIbUk0x21mUhI37Wjml1
         FNUONW2Z3cgs8HXISEPP/1Sw/QOhVwYTJJjTtY6kb8sCEPSRume6+PhSrRMfdc1qWjaR
         H0BOF4frTfOK/yxNq6Q4kh0qDBaJuS146zxQ6C7azk/ZBkl0/iC4EHAXTbP4Ro+ACQFe
         kHGA==
X-Forwarded-Encrypted: i=1; AJvYcCWXx33Q9ciY/EUtdybfTjfpNE1iekhazOz3DJ+hyf9LOCJJFMOVN+AWgrrO3jBytsXoOayr25I6jh6gWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1OycoydAMjJSyqF7XcDWac1XC+9eUNwYlNNz9YK0cbdu5RSH
	JDs0/oFLFp9iJJcY1ysY3F6z/CPbJ4AntDWv8zSG9Nfh0WDXesvpE9SXdzZ8OU6JyX7IDUB3t2f
	QVp4MPEq5W5zBqv5xMWaqPiRfaQhySyB+pCJ4kTplNbusj3+vmTU=
X-Gm-Gg: ASbGncvk3Sjfch3tz1gL74qptiQtdiz11dIr6zzT92BV8hwh3Psyfle48epum7PTqew
	3UIO6/n5CJtDzbEgVnSNm2lnpg0LoteCGhFCvmkAzvDYpbE0hNyRYNoas3uXw4w4UTTiNRb9V95
	mdzy0xABDJTLqpNKaTw6xZB1RI
X-Google-Smtp-Source: AGHT+IE9KdKZ/JGBAF1MaIUNqrJu/ThIyQ4wdfd3GtCWWEyo8YJ/ipfzWmwcYwsJ5teX1u0Nl5DYBW5VLzuhN3szkmw=
X-Received: by 2002:a17:90b:1e03:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-306dbc29846mr752616a91.5.1744163251755; Tue, 08 Apr 2025
 18:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408072440.1977943-1-ming.lei@redhat.com> <20250408072440.1977943-2-ming.lei@redhat.com>
In-Reply-To: <20250408072440.1977943-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 8 Apr 2025 18:47:20 -0700
X-Gm-Features: ATxdqUHmfy04Izvj-TL5xz0lfkou016wAYUuvOBrmDUlOCNF9EgxeJfv8ML_sy4
Message-ID: <CADUfDZrHu=8Muss4zSvdLqq-EVoOE9t9PtqYEm343bTWaA-80g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: fix handling recovery & reissue in ublk_abort_queue()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:25=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Commit 8284066946e6 ("ublk: grab request reference when the request is ha=
ndled
> by userspace") doesn't grab request reference in case of recovery reissue=
.
> Then the request can be requeued & re-dispatch & failed when canceling
> uring command.
>
> If it is one zc request, the request can be freed before io_uring
> returns the zc buffer back, then cause kernel panic:
>
> [  126.773061] BUG: kernel NULL pointer dereference, address: 00000000000=
000c8
> [  126.773657] #PF: supervisor read access in kernel mode
> [  126.774052] #PF: error_code(0x0000) - not-present page
> [  126.774455] PGD 0 P4D 0
> [  126.774698] Oops: Oops: 0000 [#1] SMP NOPTI
> [  126.775034] CPU: 13 UID: 0 PID: 1612 Comm: kworker/u64:55 Not tainted =
6.14.0_blk+ #182 PREEMPT(full)
> [  126.775676] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.3-1.fc39 04/01/2014
> [  126.776275] Workqueue: iou_exit io_ring_exit_work
> [  126.776651] RIP: 0010:ublk_io_release+0x14/0x130 [ublk_drv]
>
> Fixes it by always grabbing request reference for aborting the request.
>
> Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> Closes: https://lore.kernel.org/linux-block/CADUfDZodKfOGUeWrnAxcZiLT+pua=
ZX8jDHoj_sfHZCOZwhzz6A@mail.gmail.com/
> Fixes: 8284066946e6 ("ublk: grab request reference when the request is ha=
ndled by userspace")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b..41bed67508f2 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1140,6 +1140,25 @@ static void ublk_complete_rq(struct kref *ref)
>         __ublk_complete_rq(req);
>  }
>
> +static void ublk_do_fail_rq(struct request *req)
> +{
> +       struct ublk_queue *ubq =3D req->mq_hctx->driver_data;
> +
> +       if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
> +               blk_mq_requeue_request(req, false);
> +       else
> +               __ublk_complete_rq(req);
> +}
> +
> +static void ublk_fail_rq_fn(struct kref *ref)
> +{
> +       struct ublk_rq_data *data =3D container_of(ref, struct ublk_rq_da=
ta,
> +                       ref);
> +       struct request *req =3D blk_mq_rq_from_pdu(data);
> +
> +       ublk_do_fail_rq(req);
> +}
> +
>  /*
>   * Since ublk_rq_task_work_cb always fails requests immediately during
>   * exiting, __ublk_fail_req() is only called from abort context during
> @@ -1153,10 +1172,13 @@ static void __ublk_fail_req(struct ublk_queue *ub=
q, struct ublk_io *io,
>  {
>         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
>
> -       if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
> -               blk_mq_requeue_request(req, false);
> -       else
> -               ublk_put_req_ref(ubq, req);
> +       if (ublk_need_req_ref(ubq)) {
> +               struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> +
> +               kref_put(&data->ref, ublk_fail_rq_fn);

I think this looks good, just a small question. If __ublk_fail_req()
is called but there is at least 1 other reference, ublk_do_fail_rq()
won't get called here. When the last reference is dropped, it will
call __ublk_complete_rq() instead. That checks for io->flags &
UBLK_IO_FLAG_ABORTED and will terminate the I/O with BLK_STS_IOERR.
But is that the desired behavior in the
ublk_nosrv_should_reissue_outstanding() case? I would think it should
call blk_mq_requeue_request() instead.

Best,
Caleb

> +       } else {
> +               ublk_do_fail_rq(req);
> +       }
>  }
>
>  static void ubq_complete_io_cmd(struct ublk_io *io, int res,
> --
> 2.47.0
>
