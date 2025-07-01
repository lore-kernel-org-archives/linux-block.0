Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE127B4E4
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381800; cv=none; b=raRMvO7kqj4Qep30/UEEm3Bm41iSA3ezyc4n2rBjhtnsgQlSRKotk8G/zxgrvQYIQqsuIribImi8pd6oz4z/y4tvlg6xsU9Wl0vLSOyKoGKQGsxVAkGooBFcPtSbWZbu9GSAK9VYtdMWNPb/oO4I6I/Pal6lnBKSktI8Jen1BRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381800; c=relaxed/simple;
	bh=jDp6geyEeezT46RD6NJjbcx+2+/kMNcp7EH9MhYepws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQ/eMQc/S62hBeelIFJLGE02Df7bXfLl74EqF/+BxG8Ul7NX+zPu9Pep8o2lB2J95/zMVPUcIUOv+rKYir+NPg2K/SiOyEXVlQU9qK7Ru/sVjfKnTe14xI99+eYkq0ANajAOGQmtvEbk4YaZBj2r0ArmX8knYIXCVjcMDa7njBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFbvFsVm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFbvFsVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751381796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNeWqT8Mo2QAOUBkHy82hCh1okUFbi5rpYxbvfcUBzM=;
	b=bFbvFsVmyd8J5pDXY9jl5xWHE87ZbHGfEPg5Ndvn1uG2Rb78Axhx77gxKEAVkKa14XKjKT
	mOjwJsQhc4x3DVBnkY8nBttqtaw7oUzRwEqOr/VG59oFew5PYrQVP6J8Te2W+uXTg7dmqr
	6Wusv4SyM16hfUopXk0xuUd+I7EFrek=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-6JO0Uyl1MZK_Qkaovr2-vA-1; Tue, 01 Jul 2025 10:56:35 -0400
X-MC-Unique: 6JO0Uyl1MZK_Qkaovr2-vA-1
X-Mimecast-MFC-AGG-ID: 6JO0Uyl1MZK_Qkaovr2-vA_1751381794
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so6332921a91.2
        for <linux-block@vger.kernel.org>; Tue, 01 Jul 2025 07:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381794; x=1751986594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNeWqT8Mo2QAOUBkHy82hCh1okUFbi5rpYxbvfcUBzM=;
        b=CEhX7ndRfZfdhkKH1H79hZ7HymsQXFq3e82rIjIukeO9mQowzMp7U1uWS1RKA/WaaC
         S9x6Qxp8/n60tBBiorLWrv/XNShuUjnHU7XC3YK8z2r4cFdkkqydn4YNxnfxncLtbYt2
         rRxkoyRRgxIJ+yy8rBidQOu+FStbLqljS6omY59Ma2ZKUQ68J2caTqjDlRnfCd0oU6j+
         qBsAB5MTJp+ETQamZ/JdpDxJ5aq7DE1OGYgHEIQ5T3WRN5dalZt2Ym8zRU/kGYV/GBYD
         L1Utzdm8dpQd+3z/WmIwXGoTeOY913gw3u6gewwN4fqhYPENIRXH0IW26ixnZ1q0Jizx
         PRhg==
X-Forwarded-Encrypted: i=1; AJvYcCVKMB13vCHmQz50nCNx5QN5kCONfiBd9ndhtQ+UjYQTsgvaa8Bdo1vib9Bfe56lczRKR4SFWKf5Divozw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRdl39BQDzc6HQngdlPv6sFawzK9Ju5xE5dtmcfpXxL4I66PJ
	A9OuAm7ZWfORfjo6nTkF9M/4/txzpWsqFMrkDogjRO1y5r9f8YbTvWMzoegSE4LvB5mfjoSfPdz
	RrHv5w+g5YSQ9CeFzyPxpoIFbFa5RFI+Hk9kKfUX5gpwrT65AzPOQIXOfHs0BjZBB3C0u3zUDhd
	NTfQMfQtrpnbzgnSeWoH3nZEkEai3SVlbDptnkdNo=
X-Gm-Gg: ASbGncvEXh8G/4ciOBPXO2VhP9o6geJG8ZjkUkrj5upmKfP0uv2rtD/pVRRZGsN+TfW
	siPw2HJqR/+WNXB3lGjkNYc54N288mNi8ygx1YtELK9Iqx2pz7ZtcDfao4MrL6kF8yinoJjkW1S
	ucUIDw
X-Received: by 2002:a17:90b:2ccf:b0:312:ea46:3e66 with SMTP id 98e67ed59e1d1-318c9243c60mr23329540a91.21.1751381794335;
        Tue, 01 Jul 2025 07:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXfe9a0WCxo9eY7HyHOSNa4FXPodBfR/vp+JQOhGhzOMoJdloMUBnYn36eYLgpVdwRnOnbkb1FwJhoFzuqbdE=
X-Received: by 2002:a17:90b:2ccf:b0:312:ea46:3e66 with SMTP id
 98e67ed59e1d1-318c9243c60mr23329513a91.21.1751381794015; Tue, 01 Jul 2025
 07:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701072325.1458109-1-ming.lei@redhat.com>
In-Reply-To: <20250701072325.1458109-1-ming.lei@redhat.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 1 Jul 2025 22:56:22 +0800
X-Gm-Features: Ac12FXx5oZWauCgvXcpnnBw3KrJBTHRrgpeETirTEAEmYGVckS__qFIHRkeoqhw
Message-ID: <CAGVVp+XJFXJN0OotANjOyGN1YzfH9LPf5dPBdzwAdePA0c-Dfw@mail.gmail.com>
Subject: Re: [PATCH] ublk: don't queue request if the associated uring_cmd is canceled
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Caleb Sander Mateos <csander@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 3:23=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Commit 524346e9d79f ("ublk: build batch from IOs in same io_ring_ctx and =
io task")
> need to dereference `io->cmd` for checking if the IO can be added to curr=
ent
> batch, see ublk_belong_to_same_batch() and io_uring_cmd_ctx_handle(). How=
ever,
> `io->cmd` may become invalid after the uring_cmd is canceled.
>
> Fixes it by only allowing to queue this IO in case that ublk_prep_req()
> returns `BLK_STS_OK`, when 'io->cmd' is guaranteed to be valid.
>
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Fixes: 524346e9d79f ("ublk: build batch from IOs in same io_ring_ctx and =
io task")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c3e3c3b65a6d..9fd284fa76dc 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1442,15 +1442,16 @@ static void ublk_queue_rqs(struct rq_list *rqlist=
)
>                 struct ublk_queue *this_q =3D req->mq_hctx->driver_data;
>                 struct ublk_io *this_io =3D &this_q->ios[req->tag];
>
> +               if (ublk_prep_req(this_q, req, true) !=3D BLK_STS_OK) {
> +                       rq_list_add_tail(&requeue_list, req);
> +                       continue;
> +               }
> +
>                 if (io && !ublk_belong_to_same_batch(io, this_io) &&
>                                 !rq_list_empty(&submit_list))
>                         ublk_queue_cmd_list(io, &submit_list);
>                 io =3D this_io;
> -
> -               if (ublk_prep_req(this_q, req, true) =3D=3D BLK_STS_OK)
> -                       rq_list_add_tail(&submit_list, req);
> -               else
> -                       rq_list_add_tail(&requeue_list, req);
> +               rq_list_add_tail(&submit_list, req);
>         }
>
>         if (!rq_list_empty(&submit_list))
> --
> 2.47.1
>
Hi,Ming

run tests 40 times with your fix patch, not hit kernel oops issue.

Tested-by: Changhui Zhong <czhong@redhat.com>

