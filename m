Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150B2571B8
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412570; cv=pass; b=aIlkEKYtNibKAIZsNwcPjIQWekk2Yma4GfvFdK8k4CrKL6kfuFDrnqT09ZsErVoDCiJtwJ3fvJLd5DIsnTPUfQwxqz1MHcSm7rm/vDQg5sHIeACFQVehaRRvVKu4/q9BEGb8HjYO1rZe6oYha1CovQ+J0AAgPcZ2RlZ+azQZJas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412570; c=relaxed/simple;
	bh=ufun1Wcths+rb07VUe3k8d704B6RETyuxyIo09gQ9pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWoM9U0kXWViSGzoNJgoAnBHDr4pgOt9/TJZpIZQlw8n/ZSF1xnoGwAAUcQexVfs891jnbz1xSO93VkhwFtfN1z6zal5nu0FI938A2/nwf8c41lF3CMjzypMQumDPQqYnDayU7XSf1h2FtTDAUzF3Bmw1SO9+rECOtwCqTrWPGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6ZXGJTi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHtN0vcj; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6ZXGJTi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHtN0vcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773412567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJMneynKGatLodHqYQuBMM3+if+Rl1AvLNuNJYWpNo0=;
	b=Y6ZXGJTi753gPM/nt0f6JeBWBlrzyg1lHgAMsAqF0v7Sta55Lk8e6juo0cVe05CGr8Uvgl
	QnoWefYh8y8bcnXi7STTlt1Lt54N+7s8z2F0ZeIyl1GwY0XhsJryiivKcb7IjuSvUodyOR
	ZKXse1NAlIHbJ+/RzUGD3844KYxCvNk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562--9BTC6idNmSu1JfjzUP4nQ-1; Fri, 13 Mar 2026 10:36:05 -0400
X-MC-Unique: -9BTC6idNmSu1JfjzUP4nQ-1
X-Mimecast-MFC-AGG-ID: -9BTC6idNmSu1JfjzUP4nQ_1773412565
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79832285fa1so24540617b3.1
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 07:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412565; cv=none;
        d=google.com; s=arc-20240605;
        b=TTVmRIx4GkbFcdlIGuAdrLDG9t+yaLpZH+egr14ID0Q9ME1WY8CvE2VsxHSP96h2yL
         0AJ45tPA/2Yg6FmNSNq8xIGe+5pbUkUh+daXhf4gQU0XsQoDbeO4F5SzAyuLb63gMDhX
         CRZp4SJp1RP300dUnBFuHIkLcDtQEDjE1Z9TXEghhk91JA+b9zje+aViix0OMtqqHRGW
         y168JCW0gY8bnyh1XOoyXZTdLwbWTukw3pw0CaJsSnaToDjQah5lGF/adCf07ys7Eh0Y
         BRuIk1GskRBqy2xjuS+bNDnXB1qtCSepBf/lTfhE/LBfwiyWzjcKxsN+CRyx3T+l2Qmp
         bhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bJMneynKGatLodHqYQuBMM3+if+Rl1AvLNuNJYWpNo0=;
        fh=fx85En6Y/9pWnsuXRwxZTPJrePGzwmgjLpHJ4A2ZAmw=;
        b=PkdMglAgKn9MK1yzdYxgEursGJcyPprXmbhC5ZyZIqLfW/KCGs9Q5RwPnmpQ2kam6/
         e2MDaIYrUEj7uP20+VCrJYYEJKH+8hn41wttuKN0bLqvrmXdstzjgXuTtxuwiNX8ugHv
         20tadU7yR+YBGtCjHKOUCYcdPd7/ZuxoN9iJU5jFPzYhlVb3Q0Xlm2Y2Uto8H2tNY0lv
         fpEiutguKySuhJuA3d4V2yttR8oxsz8+gmqDZ2LhDtHc+qmNyuGz+tNRqjS0qBJfhC+1
         1A6QDigLp7Rv9ktNf2dAy8B7fOWnd7oYGK8YNiIt4ZUGCfXk9qnSKJIdZ9VNJaePnY7u
         No/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773412565; x=1774017365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJMneynKGatLodHqYQuBMM3+if+Rl1AvLNuNJYWpNo0=;
        b=OHtN0vcjn8vPBoEPCjRNNwpd/v8rJlIfe1bWU3iq3Ii3pNBGXTD5NNgSkfQJPsBkbn
         XXx5vHbj2YB4kT1Xu7AmgtvUEaSGQbjvGfykL/VUGzfCJCoLjF3RC+LH5O37/TcW0fes
         nuY5qWLf+Dtkl8w11W9YrCfZMjmTttNtL+6v+ub3djxT8TIMhr0HumayysblADnsDOj7
         aGj5xRdz+j86PGM1Ea6hCLo6cuH4CONejZ2rPIxrlDRG0kUGzFXpulFHawBPJGLhYSaH
         tj3zy/SzlY/xUXYEPVsIdz/k8kJyrTBcWc9F7pq0Iwh5Se7Kz3VLhp/qUBLm0asvz7ea
         kgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412565; x=1774017365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bJMneynKGatLodHqYQuBMM3+if+Rl1AvLNuNJYWpNo0=;
        b=iiNvCCioV1ijOIlZ2TOUeZlWFf+9yo8xNqLMMM6UXlBIbFdavy/86JBNDxtZgmIBZa
         RxgFoJ5Lvu4EXFs8EORhz0nQ+gTYZCeBVA4GHqSf7jLRunhxLvivOYUwHBeAtqTPr1jF
         CZv06OqdDDuRqcgdx/YMOCIbWSlAjOGGxhNNXMJDBfMCitFAcO/gSfS7rNZ4WlvqMIze
         BNsF2x1dLzC3deSs5kzDDP46oy9Jyv1pDYjF+YoaCPXdQIMPpRpVYeS1Zj+b14ATKDNJ
         p63A36kVDE4HsW0vC3cEuNYbdu7HRkeTwbVQ4neYLxYixkCeYaoD5KrJCNM3JpWL8/Eh
         xQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCXIUzUh2NIfXfoHLvCgtSnlCZ7PvMhtfH46dCqfNkCn1JDFpk21cAL9V1PWo1s3iVEwiUNiwSv+WXnmng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDg7u+H5gYDCoEHPqFWCAxo0e2YpAyWQAdcg6Z4x49OEOXUgCq
	4xhHsKudJpM67sMqstUrQFAoJR9YF7Fdl5J39q4fgCT2U7dS6hBOLnG6Uypjd97npjvkrtfk6KZ
	luW2jnCZVTcvJGa7aHMpzZ0VkHZXycOCZA9imVABH8CMTTyNAh0MbyECn9LQjlJ6+EmTscWCn4J
	3OH4W+AE20O2qCdBLngW/CL7fZB1QxypHSZRDOfCr/4Emi1twUHw==
X-Gm-Gg: ATEYQzz+x8yOZbSbo+HGTdIj0x9/iv6akKk41E1kfJiVVjFv2DNhb0febm1lyB+99TP
	o/GgFFYv7+hDEA6hbgJ8v93vTpOYJ7a0CGwUUBbKyEPmBL3rr3guJxYzkRs4YnSrQr4/v0T928b
	d48UMxdIDU6KHM2tET6aEJBqQ2R7G6w+XHL0aS2Znd5i9rfGOOPqcnL8FVyV18axS8h0h0vL3ca
	B67GMr/pT+NxAYnNNIUopQac78spG5MbxPHLU2ZPumppS4xTF2Eal1KzrMMpf3wpg==
X-Received: by 2002:a05:690c:c1d5:b0:798:711f:a0a5 with SMTP id 00721157ae682-79a1c10febemr31150427b3.29.1773412565245;
        Fri, 13 Mar 2026 07:36:05 -0700 (PDT)
X-Received: by 2002:a05:690c:c1d5:b0:798:711f:a0a5 with SMTP id
 00721157ae682-79a1c10febemr31150237b3.29.1773412564819; Fri, 13 Mar 2026
 07:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304190424.291743-1-agruenba@redhat.com> <abQHNzJ0FR1EF0NX@shinmob>
In-Reply-To: <abQHNzJ0FR1EF0NX@shinmob>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 13 Mar 2026 15:35:53 +0100
X-Gm-Features: AaiRm50KyYlBUXDBLdnEEHXDx37wzlGjPP-UmRDDKX74QQoo2rYJKifETYROgh4
Message-ID: <CAHc6FU7bab0+snOVBog-FZkn_sy3AHoEP2SNFxdZ-n13tAE5Ng@mail.gmail.com>
Subject: Re: [PATCH 0/4] simple bio cleanups
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>, 
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, 
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, 
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 1:54=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
> On Mar 04, 2026 / 20:04, Andreas Gruenbacher wrote:
> > Jens,
> >
> > here are some simple bio related cleanups.  Any thoughts?  Can those go
> > in via your tree?
> >
> > Thanks,
> > Andreas
> >
> > Andreas Gruenbacher (4):
> >   block: consecutive blk_status_t error codes
> >   block: get rid of blk_status_to_{errno,str} inconsistency
> >   bio: rename bio_chain arguments
> >   bio: use bio_io_error more often
>
> Hello Andreas, during blktests CI trial runs, I noticed that this patch s=
eries
> triggered failures of three blktests test cases: scsi/004, scsi/007 and
> throtl/004. Do you see which patch triggered these failures?

Hello Shinichiro,

thanks a lot for the report. I now see that patch "block: get rid of
blk_status_to_{errno,str} inconsistency" is broken in its current
form.

Andreas

>
>
> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out comm=
and) [failed]
>     runtime    ...  3.855s
>     --- tests/scsi/004.out      2026-03-12 15:23:54.664435639 +0000
>     +++ /home/fedora/blktests/results/nodev/scsi/004.out.bad    2026-03-1=
2 18:13:40.059747989 +0000
>     @@ -1,3 +1,2 @@
>      Running scsi/004
>     -Input/output error
>      Test complete
>
> scsi/007 (Trigger the SCSI error handler)                    [failed]
>     runtime    ...  115.385s
>     --- tests/scsi/007.out      2026-03-12 15:23:54.668435644 +0000
>     +++ /home/fedora/blktests/results/nodev/scsi/007.out.bad    2026-03-1=
2 18:15:55.054944537 +0000
>     @@ -1,3 +1,3 @@
>      Running scsi/007
>     -Reading from scsi_debug failed
>     +Reading from scsi_debug succeeded
>      Test complete
>
> throtl/004 (nullb) (delete disk while IO is throttled)       [failed]
>     runtime    ...  1.643s
>     --- tests/throtl/004.out    2026-03-12 15:23:54.710435695 +0000
>     +++ /home/fedora/blktests/results/nodev_nullb/throtl/004.out.bad    2=
026-03-12 18:20:46.314368581 +0000
>     @@ -1,3 +1,2 @@
>      Running throtl/004
>     -Input/output error
>      Test complete
>

