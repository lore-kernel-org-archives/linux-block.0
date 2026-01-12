Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832CC387593
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242578; cv=pass; b=H2rx8zAvzJO1H6anT2K0lDX/CGuyU1FxOkZkHlUILmmrgBzelGz2qtYi4wVgLw8YgG/LVxz05ONZ2IO+GZpsV1aRK+qzXgodyJAEoDytrVymai20n9XsJWc029TzqVrg8U5bh4m4CrVSs9kIl0ItWEswZhaVgz2AAOwwQ8KmNlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242578; c=relaxed/simple;
	bh=FUpHOPt4IEgZcX0r1LogNpavV3zSOIqpKbst42N5uaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F00JMudaqBnGaRgzhQM0TW37fpaS9w1mk+nxchBO/j3BeZTvdQpS6zV3SozZimu78MDUxnZlKJBApgziIPRehA3XxY9MJZNhUNk7SZ45N2PfNkrvPv2CHGfK9c45SU5fl/TAhWhv9p14eW7RPJHPDpvrbPdm420vmDGYKYpi4TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EWhXdRjy; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EWhXdRjy"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11bba84006dso578165c88.2
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 10:29:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768242576; cv=none;
        d=google.com; s=arc-20240605;
        b=XtuDgi2bI0jtjqXXLy/Hg3kTJRZ9c7XkYqor02ULLrAw7/W5a2nnLJ1/jQHCHjWvUD
         1XWGoLw/yTBcq4W7Qz/L5TQkpti3C3bWECUXQSL2GTOhDO1IeRe2GQCou3cyWql1cZFB
         hQr3r0r15fnVZWNMH/XAEadabNfD6n/H1O/c3nbZ3U908RXXp0USo17FDAnpxM6Jntk8
         PENqCIw5Inbtn4kGHnASSNi1cjAIbSwn/DQaER4YIfd59RsWofF4KjILqZItqwdwB9wq
         ETAafGNZ5+N8WOazmj/SZQ5kvSroLz+F3P8pO9Eu5LpIXbz8fcF3m0wnRUeOIhmHwi/R
         WqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogd853Kk4ubl3A3TV6d4A1RR6W2yCsORLXTCLFqIUIY=;
        fh=YcO0/1lGEGMojAw7MoXo6zuC2ou+WVd4NaWoU8oVfMg=;
        b=kag+uaUfLIu+Ve/PvovhsOj3Jq26ul3Baok52LzMvtbCHI6CDoHCFevDsW9kIS5YvI
         QCOs3W3xFiWRD8pDuvrLTGOyjK50GeWFloeHNSLLqaXBPnoj8U1F7hQvk/fiPTo9NB18
         B+fcO5hR4aIsJWbgsI0rVpnyODnVJZaFwBYjLUv5ezvloWXDITiemKqszZYXvTexEIkZ
         k+la4MQTXxUrXBlrWcTYrsMS9ZzwaXwT2Sg144MIE829bLREhmt9Et+7NfnxjbOTLAJ4
         rown7vqcxvXtL5Re2nq0l63uSq4s4xChmtuoAuEyVmgTE7LciQU0pOEN8A1DRjOfEy87
         ts7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768242576; x=1768847376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogd853Kk4ubl3A3TV6d4A1RR6W2yCsORLXTCLFqIUIY=;
        b=EWhXdRjys9U8oWSyDTKqpLqI6y+xeaKZtwZpPmqFp5pxgmIr1Is4buV5af6J7vF4E4
         7us5kPcrne6eIELwDZ5nX+iYfpFUAiTuUaqqH4D9Vy7W6OQKFzMt240v91xLlFjrzLqo
         gqy30lh+2VoCu6lNptgZYMqMXmFFbKaa202Eu88pEirKcOG21FmoYq+D5UJHAzCGwMRU
         sQ3EeCpDsUZ2CPUqudmt8uRHlmbg4Cejh26Fa0GV29HPXIUMQP59YRWfYg+SXlQ6L69L
         +8191zi939GwNNMzzRbSs22cghb7k8zQD+g65Hn9zmPLLlfvNbn9hCZlTUXGLVuWWwy9
         dDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242576; x=1768847376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogd853Kk4ubl3A3TV6d4A1RR6W2yCsORLXTCLFqIUIY=;
        b=UHIM1xk/2Vu2BNe74NSl3WT2sJn6b2LB8eL+B7av2cPSHyLg02ZUakpfcSiDnLANV6
         g4kThrurv9gnraCPhg/42M6f/SuMP4YfDD5Wrt0SwvJwA+ab/47QnV/G5mTN8oG2gkJ8
         oKpDRZKYb7SEKRO2uw4xGroh9E4y8oTrFx+TeeG3AQtouif7FA8+1AbTUC+Fe7oHX0On
         KvF5GXkV3ap3w+VYHoqBNAkLL5QlmLliz87mMK6Fk317J5n3A6YKAxO31sthvBokHZ/b
         43TZ2TkXfqk6yq1ZdBPZdFFcWzB7mZ6BKUm0QW0yL+DT8JWV8vmsbwf8yqyXbk15DLRO
         EKYg==
X-Forwarded-Encrypted: i=1; AJvYcCW9bkdtCOF4+eEzdmFsJtLwjgO889bPa1jOxzUxPm8Fm8AKCcmoDahbwQK6CSpNiLbynNhDylsgbyVQ0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRBjOggbY2tNClABHVjnXnmNkNUaUpQem356iV0kl31+YEGRf
	7vRXo9poEUY9T0AF+Gs9oTR9zm+87No3gyWVfWBu6d4BjBamsgujY5Zgmb4UdQBgM5cjoTv6Shz
	+QUf9hEyRU2i9wvijrWx+Jcu24CU9wovEJ0xz/jZNTQ==
X-Gm-Gg: AY/fxX6eIAOwESAaaEhvKQ0vLFi2Z897cOTwSWOcWhYfQzL35+CHQRJvxg5nw9cmAMH
	s5LF3PMU3XtzwZYlyrfUvbWWdHMdDt83kCUwtjIdEeUnj69uPu9wP8iO2gdBR4XKew76Ewvb/q7
	OurMNTSePFPNUtM4vPviVt8iy8ZwXfDSY9JrgkHDDuwYoKkVM3qJx+EBxX/J/8tTB/s1qct4uky
	7ApN+JdcaoJTGVPbYcBtlrIqS+AsWy5NBP9667wR+uwDQLS41GowAwc5wIzr8BRjLSzWB5g
X-Google-Smtp-Source: AGHT+IHM5mdp2ESFbQnQHup/EVrjeLulpF3EjsgWvB8/FOYUzcdsyBgaH98XYKE3lyl6wNQPNUR2nsmM6vwuE9x3X7k=
X-Received: by 2002:a05:7022:799:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-121f8abf499mr10911260c88.1.1768242575232; Mon, 12 Jan 2026
 10:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-9-csander@purestorage.com> <f0c205d9-609f-4b08-af67-3d8730eb6fce@zazolabs.com>
In-Reply-To: <f0c205d9-609f-4b08-af67-3d8730eb6fce@zazolabs.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 Jan 2026 10:29:23 -0800
X-Gm-Features: AZwV_Qide7yvit3jonWa-fQp0nnmgkkOuuK8FL6QKxDxsErOmM1S8B6V58DEkss
Message-ID: <CADUfDZrAx-ALGpNckfZOwR2LUqQMYud9cb14bMp1SW_E12isLg@mail.gmail.com>
Subject: Re: [PATCH v4 08/19] ublk: move offset check out of __ublk_check_and_get_req()
To: alex+zkern@zazolabs.com
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Zhang <stazhang@purestorage.com>, 
	Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 10:17=E2=80=AFAM Alexander Atanasov <alex@zazolabs.=
com> wrote:
>
> On 8.01.26 11:19, Caleb Sander Mateos wrote:
> > __ublk_check_and_get_req() checks that the passed in offset is within
> > the data length of the specified ublk request. However, only user copy
> > (ublk_check_and_get_req()) supports accessing ublk request data at a
> > nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
> > always passes 0 for the offset, so the check is unnecessary. Move the
> > check from __ublk_check_and_get_req() to ublk_check_and_get_req().
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/block/ublk_drv.c | 16 +++++++++-------
> >   1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index e7697dc4a812..8eefb838b563 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -253,11 +253,11 @@ struct ublk_params_header {
> >
>
> [snip]
>
> > @@ -2603,13 +2603,10 @@ static inline struct request *__ublk_check_and_=
get_req(struct ublk_device *ub,
> >               goto fail_put;
> >
> >       if (!ublk_rq_has_data(req))
> >               goto fail_put;
> >
> > -     if (offset > blk_rq_bytes(req))
> > -             goto fail_put;
> > -
> >       return req;
> >   fail_put:
> >       ublk_put_req_ref(io, req);
> >       return NULL;
> >   }
> > @@ -2687,14 +2684,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_i=
ter *iter, int dir)
> >
> >       if (tag >=3D ub->dev_info.queue_depth)
> >               return -EINVAL;
> >
> >       io =3D &ubq->ios[tag];
> > -     req =3D __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
> > +     req =3D __ublk_check_and_get_req(ub, q_id, tag, io);
> >       if (!req)
> >               return -EINVAL;
> >
> > +     if (buf_off > blk_rq_bytes(req)) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
>
> Offset is zero based, bytes are count so it should be >=3D here.
>
> It will work this way but for buf_off =3D=3D blk_rq_bytes(req) user will =
get
> 0 instead of EINVAL.

This is the existing behavior in __ublk_check_and_get_req(). I agree
allowing buf_off =3D=3D blk_rq_bytes(req) seems odd, but changing it now
could break ublk servers relying on the current behavior.

Best,
Caleb

>
> static size_t ublk_copy_user_pages(const struct request *req,
>                  unsigned offset, struct iov_iter *uiter, int dir)
> {
>         size_t done =3D 0;
> ...
>          rq_for_each_segment(bv, req, iter) {
> ...
>                  if (offset >=3D bv.bv_len) {
>                          offset -=3D bv.bv_len; // bv_len is same as
> blk_rq_bytes(req)
>                          continue; // this breaks the loop when =3D=3D
>                  }
> ...
>         }
>         return done; // done is never incremented
> }
>
> >       if (!ublk_check_ubuf_dir(req, dir)) {
> >               ret =3D -EACCES;
> >               goto out;
> >       }
>
>
> --
> have fun,
> alex
>
