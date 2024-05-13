Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595A1474BC;
	Mon, 13 May 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605079; cv=none; b=X53Gc3813twOsELTjCN/ZMVxa8130C7rbKVsV7/P5BQy7taDetj4Yt62hKuwjlZxh1oF4R9tVoGT77rG26hwuQUIXbQ188s6pgMlt5rVkvE2r14O5mGcEE+qknFbrv89iawi836XNC9ZBb+2RA0eRMn+WlJSXRjTeEAQVLeadnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605079; c=relaxed/simple;
	bh=fdD56XwxroFvMwkZ6TClTv8CsIxjJn6h9JoAc0tn4+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mv7cop0TIUFoQvy/jAgZCkhkWlrIxp7iBIEts/QjQre61vsPbd/w7KpLbHR5F/Ti2RzhyYhi4q2MUNsrU06Dxebt9OukFSqdSnsMbO4DCKVZ4MsQImwlFohwEov3GbhpaL/4lPW9rI7Qd9MrO7H4MPkhkAWIxSOlD80uk9n1mb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi3s7lPP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi3s7lPP"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a9d66a51so996305266b.2;
        Mon, 13 May 2024 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715605076; x=1716209876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLcTT2KtLjHOkdlO+CJAEl9veRtc7j9SuiexbSgJPRI=;
        b=Gi3s7lPPyW9+Qu5QmWCfwK2EZHktSWRfQV2oT0Pn82Uc1CY4oH/VGDQG6bpkJijExn
         1/vSXdgbUcXE76bVOqK4QWLSpYVErHmmfeDJPTGKWqPGbFBCIk1lp2MAP8081zH0Wn1Y
         r5rgf8ug+2yu23PC7GqEvQnVUs5O8SaeISNgpS77E3Qri/L2m9zzv4Xpd3Ceh9EUu9Ag
         dDKsEosdbR+uCQNgmdHA6XZAKLeDODihGUMw1VolovKZiEe1c1R1Q7AqfSEXFVg6C4YE
         q8oaTK+Uyt6s38IjMOOLETTrwuUVTDHf/EtubpfG/tfiHq7bR2pyDZgMqDkx6CeiXSin
         wiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715605076; x=1716209876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLcTT2KtLjHOkdlO+CJAEl9veRtc7j9SuiexbSgJPRI=;
        b=wHrfG0dXerb8SLzcyUOjrtxXZI720YmA+CF8T9EyNRNVKT6as09RqUu+Oa6BqcdlLc
         FXmEB4tWNeuc3uJrCzz2OZJDbw1BijQvO77KrP8R0diZEyWOrkNk0ZRIwUy6Yp4FKYE5
         IQjL7O9UXw1t/L7YMtbMd8N8EwusjXZ5597wD32frTgiEB8v5ZzCS2EYxGGBFIqthQxL
         ileOoeG3xNy6zABpa56ql4gjKxf6ZhZn0ljEPAeYA1NQaAOg/TyKJiy8Ucqs8+q7uVOj
         9gjwt9B3W/gsuTjKmihk9dMaiiY6ata9WQsJpUNnS02R/Ka3UUyCbCuZXF5klIrvuOaC
         +tfA==
X-Forwarded-Encrypted: i=1; AJvYcCV2kgTsYR6VX/OsuUE2fQ/+HOSD2yKHGqOmQkuKH8PiU2P9/hV7EpbTlvIdYN2yZw6LgncrxX+XKwGC9T59iqghS/hWQXO8ffgqtyY=
X-Gm-Message-State: AOJu0YycBi4opE3VLLCvSg9fB5rUADRhiwcvjFaAXMJgGq32Yznx2bqv
	4iAyxKkTWD8wj7JrLc5KEkqasx2EMB+nHI0pqd/o+Df3V1fpGHw7uCqYkV/ZzPVajNtYjUkmn/6
	8WHa2W5r6w2KkxOJAnBQLH2KqxwM=
X-Google-Smtp-Source: AGHT+IFrXlbUV42Hk5YOUPCyaLFkqVmd+yMjymbz+RjeGmhjmJk4RrklE5HWupQrv5wyIApq7HiCUDcxwLjUG9Jd5ig=
X-Received: by 2002:a17:906:a013:b0:a59:aae5:5837 with SMTP id
 a640c23a62f3a-a5a2d5cd442mr553874666b.44.1715605075750; Mon, 13 May 2024
 05:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPO8OK=JCFphuZvqzqCWpUjPiTVoHma3CY0gLo+rdLKNw@mail.gmail.com>
 <20240513105413.2951-1-hdanton@sina.com>
In-Reply-To: <20240513105413.2951-1-hdanton@sina.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 13 May 2024 20:57:44 +0800
Message-ID: <CAEkJfYPxWBfEnuKeCGEsscVTYy8MrNxCJwdbxS=c2-B0H+HfTA@mail.gmail.com>
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 6:54=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 13 May 2024 10:38:34 +0800 Sam Sun <samsun1006219@gmail.com>
> > Dear developers and maintainers,
> >
> > We encountered a task hung in function blk_mq_get_tag. It was tested
> > against the latest upstream kernel which was compiled by clang 14.
>
> BTW make it clear if repro is available and if you could test patches
> in reply.
>

Thanks for pointing this out! I am happy to help testing patches. As
for repro, I have a C repro available, but it is too long so that I
attached it to the first email. Should I just paste repro with bug
report?

> Thanks for your report. See if the below low-hang pear is sweet, I
> mean see if it could survive your repro.
>
> --- x/block/blk-mq-tag.c
> +++ y/block/blk-mq-tag.c
> @@ -180,8 +180,10 @@ unsigned int blk_mq_get_tag(struct blk_m
>                 sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIB=
LE);
>
>                 tag =3D __blk_mq_get_tag(data, bt);
> -               if (tag !=3D BLK_MQ_NO_TAG)
> +               if (tag !=3D BLK_MQ_NO_TAG) {
> +                       sbitmap_finish_wait(bt, ws, &wait);
>                         break;
> +               }
>
>                 bt_prev =3D bt;
>                 io_schedule();
> @@ -208,8 +210,6 @@ unsigned int blk_mq_get_tag(struct blk_m
>                 ws =3D bt_wait_ptr(bt, data->hctx);
>         } while (1);
>
> -       sbitmap_finish_wait(bt, ws, &wait);
> -
>  found_tag:
>         /*
>          * Give up this allocation if the hctx is inactive.  The caller w=
ill
> --

I applied this patch and tried using the C repro, but it still crashed
with the same task hang kernel dump log.

Best Regards,
Yue
