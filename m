Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE27225409
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240046; cv=none; b=d/yNja/qaMprhLAWRSEhOvNazYE39J5fqxqf9jnR2ZaNyLYnEChLf7FQ8fndQsqI+clzh8nlkRtWtDmmeIkW9vYipXssvUCxoxL+k43hKPbIf5qCiqCmaGMyTSnG8mhENlUFun5KsY6ir9v3PgbVXQEuqexgIXSr3gscoEOFsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240046; c=relaxed/simple;
	bh=eqIjq1KN6H0u8pONRQI+HhuDHdbrAvS4XNfQZjemsnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6CKrg6sPo3u6GIzkzO8BJfBjzZ0jWH+6lq9anSVDQD45YTRU78Y1FWPt6Xvb61rCzT/zVm09nyR/dHC303t2JMnftOsm2yXB8tJH5mT6rHqOeq4G2N911iNE29IivDe2Cvki/NM7WtjXpisBKQ/X67iKcWaH5xeqSloiuGG8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eesEQkVV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eesEQkVV"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2700de85d0so169762a12.2
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752240044; x=1752844844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNC9hoqAxlRMDEPbNE5Lbh5IwThFTX+aGFISwit5OXY=;
        b=eesEQkVVkUQnkw5jdUlH9LHXr4JSLaT65XANMlctKMrIEIcObZCVCqwWWWlgwb9ABy
         0DyE7nb236k7cntPc3kgg3IaiWgCV4cOWmZxVNjkALnVVHmI7h/FPiCyZ3ioayeK6nq+
         YjdffWJvDYjw5UECRqWch59pYR2cYaNS+BnhMjP4yk5A9XbOVMN81o9kFiuhK94mVMGh
         22yux1yhmwofYoU46DkubakJTQvdxFhwvso2CA8Dsk30XHZ7ZG7ZQuGYC8n2pvTduRXL
         /Yqv+lPOVQEpj5NHvyOTDF0bGwUk53BGTuHnDPYNBafmJAwRAeTi83LfXfcmVtDyvxgt
         sONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240044; x=1752844844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNC9hoqAxlRMDEPbNE5Lbh5IwThFTX+aGFISwit5OXY=;
        b=st6i1bIxrh/Ko8r2Qd6zuvlPYGjYJjoYdhjLH3xTL1DTLJO9+KnNt5tTqhfnatmrgT
         Nsb2wa1zrk15RUHK28ez3umGXML9KL5xile7K6X/FetDIdQ62QES8+fPDRWB4wiN5kQQ
         4L3LWpCnMUQmDwcz6hdzAYMln8fz0qi+RXwsN0T6gV037j9H/UM5N9iFwujp/Dc/cdAX
         MttggIE69yXrmiqZys5w95GUalAKWxapPdAHONkUR62QI51sbcMRCKu725gK6Uh2AKjQ
         roYyIJ6yA/d+eLzZ0SBU50U/1faZV/xaiMllykwnN95qCru03f0p74zOvpnGiuMxcZfO
         1O0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAxG6709MeOTzYKicXQtOh91VsNDtFPR5KD2iwnDCsduPGx3Tozj2ayEVvPGndqykYtjHqEYhQxxYhWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZS4acmVAUe4NUgR9jUZe7A6VU5ym6meQ3hknU45mn0sZLxrK
	qnSHAAm4e5yL/Yd6egRacLs5d8K/ZYziX65/0ZUJL8YmMGcSeNgnCNB1gfejpgrjHgUm7+YKYpp
	5UhaDMT5mwNmg0oltebBg82MfN1JI20rglcrogqQmRAZhcN1wLkh2c8moyw==
X-Gm-Gg: ASbGncuws+q+NzghtQIPuPWz2mgb/eaZNFWTT9OML4XVdqfF1NX6dhnx6ea3ECFdnsA
	yPMPiH7QXiVjUq+oQcbBUcsuyHyuOsvdaWt3sy1yl1/UpXlXLBxAfgMB905L2KsbDIecH/pdetz
	YHDSkcd1wUKWN1xytjXjTUsSEFLtTc7cXmlCWrs3udIxkzFi9HZ0JJlDaPGC95Rxh4sEe1cw0+7
	oEFXc5o
X-Google-Smtp-Source: AGHT+IFWtrzaxcLVkdXOhffJ6oSA9v16H2R1oHUcvj9WD4WeLODMI6sL9nR+b3hbpLvXuk18O28rEV3vixiYXJxgTs8=
X-Received: by 2002:a17:903:1a70:b0:234:d7b2:2abe with SMTP id
 d9443c01a7336-23defb29ffdmr13128985ad.7.1752240043823; Fri, 11 Jul 2025
 06:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708011746.2193389-1-ming.lei@redhat.com> <20250708011746.2193389-3-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 11 Jul 2025 09:20:31 -0400
X-Gm-Features: Ac12FXxKFIczZWqIIUZG-eIJrNEZCO6k8yuuIJlD724dQBTXWIU5FukgR1aZylE
Message-ID: <CADUfDZpvqsQUNrcGefQo+dakaC-aijnXfSYSAPV2sEtoUFfWKA@mail.gmail.com>
Subject: Re: [PATCH V2 02/16] ublk: look up ublk task via its pid in timeout handler
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:18=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Look up ublk process via its pid in timeout handler, so we can avoid to
> touch io->task, because it is fragile to touch task structure.
>
> It is fine to kill ublk server process and this way is simpler.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 65daa6ed3a8e..d7b5ee96978a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1367,14 +1367,19 @@ static void ublk_queue_cmd_list(struct ublk_io *i=
o, struct rq_list *l)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>         struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> -       struct ublk_io *io =3D &ubq->ios[rq->tag];
> -
> -       if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> -               send_sig(SIGKILL, io->task, 0);
> -               return BLK_EH_DONE;
> -       }
> -
> -       return BLK_EH_RESET_TIMER;
> +       struct task_struct *p;
> +       struct pid *pid;
> +
> +       if (!(ubq->flags & UBLK_F_UNPRIVILEGED_DEV))
> +               return BLK_EH_RESET_TIMER;
> +
> +       rcu_read_lock();
> +       pid =3D find_vpid(ubq->dev->dev_info.ublksrv_pid);

It looks like ublksrv_pid is set based on whatever the ublk server
provides in the UBLK_U_CMD_START_DEV/UBLK_U_CMD_END_USER_RECOVERY
command. I don't see any validation that this is actually the ublk
server's PID. So couldn't a buggy/malicious ublk server that doesn't
provide its own PID cause ublk_timeout() to kill some other process
and leave the ublk I/O pending forever?

Best,
Caleb

> +       p =3D pid_task(pid, PIDTYPE_PID);
> +       if (p)
> +               send_sig(SIGKILL, p, 0);
> +       rcu_read_unlock();
> +       return BLK_EH_DONE;
>  }
>
>  static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request=
 *rq,
> --
> 2.47.0
>
