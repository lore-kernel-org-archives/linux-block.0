Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4546255247
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745368853; cv=none; b=IPJ3lI0k/PHPOcJjEKZ6fwhpzdlCQxcNao04IXv8kY/5FrwReGBOU0sw1y0XRp1ivuPRzI6RylTOD906eLLYHQny5vx11BB0GcicvPxUWOkfudiqKk5SF/ddnMcVrzlKgAZnVzUY0tZbxs9e98sXmLUuUz1OpC/xXf08k5cK/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745368853; c=relaxed/simple;
	bh=Syva1iN/oMJBnZoP6XVS6eM+3t78OBSIKce4uOfivKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOON+drqlmN2NaFLsNQwvTj9wqrqX+10kN8NOeGp7xn2of3mRF1JeRs1MnXb79t2IuN1G6wrcC20+kzTj+zFthyxzGOkPkK11QhXLCUasuBV/F4awQpycYxYl1dv4eENygBWvR0PgT8EuOHu7S4VvHa6a3VudZimDJuFhrFzBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AePzWVs2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AePzWVs2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22792ef6215so7606735ad.2
        for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 17:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745368851; x=1745973651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlaMJGQ/nAvElMgJHvPzYsN612vvvBWvX4nIclqUR4c=;
        b=AePzWVs20YBCKT7CWxBBJQhWa3ScrT0XQqxjb8xWtyUtNsooKgO5YJDy0oaMdSlrVs
         cJTcbI+RF0J8jcOXntKd4yFRWnsrebPu9DzD+DpcAmzRv30tT4rsgq4aQlKUgpkptT2k
         N7QDI87BhMPR5x5tc1g9zO5+HSn/5M8xc2MMVYf+m47gFuE8m/JHuNwYJAQlbMTkJ8qF
         wlAWvAh9hp662upz277WwCUOiXvTfF53TNXZpbXMmB+BP2TqaZiF7VBt88NrlaktPVCi
         QxXk2Xf51vGTKODuvLqeqrIAg+bwyWI836R9MQr06wRuAq1dnvwGr8U64Xv7iJX+0YVO
         ZoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745368851; x=1745973651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlaMJGQ/nAvElMgJHvPzYsN612vvvBWvX4nIclqUR4c=;
        b=ogi78MbWKjefhrIj7LdMzJcigNhVgYrpyF4C680bhxLH1zYNrnNmvArqNInckb2554
         zv403LsCo2UKM8SWPL4qqNaBXi1xRpwUrHHNcJ3OvPzql5EaziIE8Qu2BwgEtpXlIDQe
         wTjJ3AUAYAVkaiPgsiBWUgYX3cu/BGrjqWbxUo8SbbRidC+qb3n1m2oZBksnh7P66a7g
         fEgP59sPfugRWhdledt4eWzIuM86wQcORl+98fE45xQvplFlyUesBs+k5tjmDlArZ3SP
         GoHgrhxu32xe64k580ZWgTTaanroyU0hNiTY75FluKuM14Welxev5IHjm4fZm8p2vU2d
         URIw==
X-Gm-Message-State: AOJu0YzIQ0ygKgHZxtkEfeMFf2+urBXSFLth5XkePybdBaF23zxTB2QG
	2lgsamz65POGXMq9dHiNCmum7SbAoI5XVACXsaC0fvYnIZxP1wExRIAx9xhcsV4W5MAeASeW/pu
	OY2pw8zZeTD+nEOEgKgmKGvlnFABQAD0EVCGn2A==
X-Gm-Gg: ASbGncudh9Bua1wcsJgVZpHVaiTF7j2QwAL/Yyc7AQykLkFnSl+XhS42i9bZx9p4+8i
	SU3FllVAaM9pWE1CMzda5AivQKrmElWLaMffwwoM44l6kDh8vyS6QXJ97b7+O1kFvKSFlDFnR6G
	sczZl5WdGCBI4n5JBXIB3T
X-Google-Smtp-Source: AGHT+IGJSpy7epiqldES3L6c8QjtYlkI0pJaazs49izFIq2HBHFJpQh+40j+jHPXU9QQ5d4Hor2Nbp/iL+Lgxeoel38=
X-Received: by 2002:a17:902:d4c3:b0:220:e1e6:446e with SMTP id
 d9443c01a7336-22da3011aa9mr5556345ad.1.1745368850975; Tue, 22 Apr 2025
 17:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416170154.3621609-1-csander@purestorage.com> <aABFAg563W1g_4QS@fedora>
In-Reply-To: <aABFAg563W1g_4QS@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 22 Apr 2025 17:40:39 -0700
X-Gm-Features: ATxdqUG4dCfLiInXhfwaydYJoA-6CGyEwQKolnRYogRcmd98YYBUl6gNWqb20Tk
Message-ID: <CADUfDZr_HCXHnDUDf5bcOGkBqcfttzq+1qqmhFSMvyCqcF4TBQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: remove unnecessary ubq checks
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,
Would you mind queueing up this small patch for 6.16? Uday and Ming
have reviewed it.

Thanks,
Caleb

On Wed, Apr 16, 2025 at 5:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Apr 16, 2025 at 11:01:53AM -0600, Caleb Sander Mateos wrote:
> > ublk_init_queues() ensures that all nr_hw_queues queues are initialized=
,
> > with each ublk_queue's q_id set to its index. And ublk_init_queues() is
> > called before ublk_add_chdev(), which creates the cdev. Is is therefore
> > impossible for the !ubq || ub_cmd->q_id !=3D ubq->q_id condition to hit=
 in
> > __ublk_ch_uring_cmd(). Remove it to avoids some branches in the I/O pat=
h.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index cdb1543fa4a9..bc86231f5e27 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1947,13 +1947,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_=
cmd *cmd,
> >
> >       if (ub_cmd->q_id >=3D ub->dev_info.nr_hw_queues)
> >               goto out;
> >
> >       ubq =3D ublk_get_queue(ub, ub_cmd->q_id);
> > -     if (!ubq || ub_cmd->q_id !=3D ubq->q_id)
> > -             goto out;
> > -
>
> Looks correct, ubq->q_id is always same with the index passed to
> ublk_get_queue().
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
>
> Thanks,
> Ming
>
