Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716F171CD
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752801755; cv=none; b=G91AYPTO1omgyGotFdG2R7mA+YbpCuvLBIQp24/XkyFkjFY6GZRiDIfI43uXsbgG0DFlF3DlM5MPLrtNfgT3i8yJOKmCJtTwLdLjVd2CkvePAsvd2RhoMjLZhRSyH3diWSzq+3+SLEpw8AgquTN3blqwkVcTybY8NkdHGqyxJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752801755; c=relaxed/simple;
	bh=bZKIPqzvBaKWjXHB2g2F+hwiTRnja8K2zuWWQVw6LuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceXwsaEYTfNe0XREYUHa6jvsBRT6RMKB5dsMerF3VHQozmMD2HAF8rxG/IzCaMyUbgf+Z9GBLQQlsKnUUTgRqscercC08R3HfQnLtEd8KVQVWWCMga1MgQUBOjw7Bl4S+a3UXQfNOO9PKWvHLkoRSS2aHCoFd9VLz0ooJy6rETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcTFVYEO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcTFVYEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752801752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvXT7o1/t6XtzC53nwk2X7AY/75l1j6hPDfPKaNWcp4=;
	b=gcTFVYEOpqmIB4Wy/QdTvjz6G58+VLMvpAnPtYFrIR10qs9SUDCF09mtar86I8uqHQO25e
	yLPkZ5cnCwa6e9JQMJTe/uq5lmLeuSTTPbjOpHO//NeDdS6+PDpybW7+r7eyOn9nbW9O41
	mHpmYQQ2/E7EheffoW8rhxItgFWQ8GY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-rCcYI5VvNw2Fr8wmjXXJMg-1; Thu, 17 Jul 2025 21:22:30 -0400
X-MC-Unique: rCcYI5VvNw2Fr8wmjXXJMg-1
X-Mimecast-MFC-AGG-ID: rCcYI5VvNw2Fr8wmjXXJMg_1752801750
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so1456572a91.3
        for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 18:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752801750; x=1753406550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvXT7o1/t6XtzC53nwk2X7AY/75l1j6hPDfPKaNWcp4=;
        b=wJJrn4JWSn/a5G7PHAyIpxake5DYaOMb1//VG/UrbDGK5+TK7LlbSMjr29GchnOgZU
         SQ3go8X8VBU4YG03jr8UcYwmlH+O+LHaPNVTeVhOWeNHz+Rhu0PL0W/SHjf44hv2YWhG
         2eVbTcud9S78KWxopXHv6LFI4vcvfR5Pk4emabVMVS8qXeezb6bgTfaprTSgjb3jKkqB
         MbATSFNQMjoCaQBdsfO4bnwrUWr+cgnB0989vKHhEFaEHzrRYM+QnNxz+k4I/Su59Nm7
         0eLvQSUyhTh3RawlenjgUETejcWQvW6zjxvOlMvDYihJYCDwi1C6BigAgMlXGlNCplvY
         qq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4xmYBaCvq+X596EI2tG3e5KCP2AM0MG3XbPRAMRgo+tOWPVTq9dgdXoH2cuE04O0hCdQ65p5eoImGJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGii3Al5FjdN2GD+uqztseutV1p3X0urNsZ0bIO3XzCo2Bv8wp
	uKYLxlDdKLAMU69mVmGfBkH/slcB4TO5jpqCIS3pGAoRNjxa9FrnNPzCgu5oU3lK8xzfBaTeqBy
	7xqGGk0Vq0sE52SdRhxRsFBZw7x/ROEBtt9ZaIxVdLCW4qfe/TFmpCxiat/O9PWAAP6kSexTfSD
	1V2ZaIKxJmiCzpA6mo8ePoDKGtFlrfNVjchGaFJ98=
X-Gm-Gg: ASbGncsQw7hoTmmJscV0E7PqLnWj4OLFaC6OWgpPO+KGUhfT5NYL+CEIlodnU5EWiG6
	c+paI3u/nn0RwOMTMf91Kiv4WD6UD3OhKl3M6nDmbPHHwHwsAYJqOy5KzyddLLxMWUiC1P182Pe
	+IYNZWjHhh4kc+8R8gbt1QOA==
X-Received: by 2002:a17:90a:dfce:b0:312:e76f:5213 with SMTP id 98e67ed59e1d1-31c9e77ab0dmr11865404a91.28.1752801749778;
        Thu, 17 Jul 2025 18:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+r9YM8Fd/1Yrhv34dqg7tRxCzG/78Q6VWWzaxdHTsBw5+PXC5R+XS1ofZf5kq5GG4N1wUG67GdEBYI9z0Mvg=
X-Received: by 2002:a17:90a:dfce:b0:312:e76f:5213 with SMTP id
 98e67ed59e1d1-31c9e77ab0dmr11865380a91.28.1752801749395; Thu, 17 Jul 2025
 18:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716114808.3159657-1-ming.lei@redhat.com>
In-Reply-To: <20250716114808.3159657-1-ming.lei@redhat.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Fri, 18 Jul 2025 09:22:18 +0800
X-Gm-Features: Ac12FXzd9rjDB20g_QbZifAxJ0n3y8AMt93HCglbUQHm-9dK0-9t9rW1qIW7m_A
Message-ID: <CAGVVp+U-AmGc2gZw7XGvJJ3NXk_CsFnK5coZyzPHg2p8yOmpSg@mail.gmail.com>
Subject: Re: [PATCH] loop: use kiocb helpers to fix lockdep warning
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:48=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> The lockdep tool can report a circular lock dependency warning in the loo=
p
> driver's AIO read/write path:
>
> ```
> [ 6540.587728] kworker/u96:5/72779 is trying to acquire lock:
> [ 6540.593856] ff110001b5968440 (sb_writers#9){.+.+}-{0:0}, at: loop_proc=
ess_work+0x11a/0xf70 [loop]
> [ 6540.603786]
> [ 6540.603786] but task is already holding lock:
> [ 6540.610291] ff110001b5968440 (sb_writers#9){.+.+}-{0:0}, at: loop_proc=
ess_work+0x11a/0xf70 [loop]
> [ 6540.620210]
> [ 6540.620210] other info that might help us debug this:
> [ 6540.627499]  Possible unsafe locking scenario:
> [ 6540.627499]
> [ 6540.634110]        CPU0
> [ 6540.636841]        ----
> [ 6540.639574]   lock(sb_writers#9);
> [ 6540.643281]   lock(sb_writers#9);
> [ 6540.646988]
> [ 6540.646988]  *** DEADLOCK ***
> ```
>
> This patch fixes the issue by using the AIO-specific helpers
> `kiocb_start_write()` and `kiocb_end_write()`. These functions are
> designed to be used with a `kiocb` and manage write sequencing
> correctly for asynchronous I/O without introducing the problematic
> lock dependency.
>
> The `kiocb` is already part of the `loop_cmd` struct, so this change
> also simplifies the completion function `lo_rw_aio_do_completion()` by
> using the `iocb` from the `cmd` struct directly, instead of retrieving
> the loop device from the request queue.
>
> Fixes: 39d86db34e41 ("loop: add file_start_write() and file_end_write()")
> Cc: Changhui Zhong <czhong@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/loop.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 500840e4a74e..8d994cae3b83 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -308,14 +308,13 @@ static void lo_complete_rq(struct request *rq)
>  static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>  {
>         struct request *rq =3D blk_mq_rq_from_pdu(cmd);
> -       struct loop_device *lo =3D rq->q->queuedata;
>
>         if (!atomic_dec_and_test(&cmd->ref))
>                 return;
>         kfree(cmd->bvec);
>         cmd->bvec =3D NULL;
>         if (req_op(rq) =3D=3D REQ_OP_WRITE)
> -               file_end_write(lo->lo_backing_file);
> +               kiocb_end_write(&cmd->iocb);
>         if (likely(!blk_should_fake_timeout(rq->q)))
>                 blk_mq_complete_request(rq);
>  }
> @@ -391,7 +390,7 @@ static int lo_rw_aio(struct loop_device *lo, struct l=
oop_cmd *cmd,
>         }
>
>         if (rw =3D=3D ITER_SOURCE) {
> -               file_start_write(lo->lo_backing_file);
> +               kiocb_start_write(&cmd->iocb);
>                 ret =3D file->f_op->write_iter(&cmd->iocb, &iter);
>         } else
>                 ret =3D file->f_op->read_iter(&cmd->iocb, &iter);
> --
> 2.50.1
>

Thanks Ming=EF=BC=81
Verify that after applying the patch, this warning message is no
longer triggered=EF=BC=8C

