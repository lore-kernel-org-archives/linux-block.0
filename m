Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695522F26
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715426582; cv=none; b=MuA3YSSRwIXiG3CxHoHkFdNokGy1xRbokwEeLybt0npLTMueMsbKkXlaVLXyVAInlPIxtEQRl6VNJpkP9oK26ViCojyDWZZr78W8PQyitFAGpfzadJJ6Btt3c6YQaGbfrLqTh4VTDzAeWBLPkzvcS4sPGOjGmGQc2P6J5OBw+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715426582; c=relaxed/simple;
	bh=369+5Y5ZfAYrLv4dvA1m2fLag/QEsX2o9h//8hjl7h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cw2Td2b61JitUDvaAL0x8511RZ6q2gWMHwWXlYA/+B2I6SPbDcWCUMjJQGt+KLgGuzkYPwSduOchypjHirkWXaINe6u9vE86qNFdSLcU1mlcuRloDXGhhbwrpOAQfE1Aj3XGtJj+Z1rsDXuOsE3T/yurUraHoF/nysU16H1VO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk9uhbJU; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk9uhbJU"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b2761611e8so1506726eaf.2
        for <linux-block@vger.kernel.org>; Sat, 11 May 2024 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715426580; x=1716031380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugYbuQy66dmJdHI5/jJJSz0mg+CSnItI/sgTs6dvk74=;
        b=Mk9uhbJUgiKGnmaiK1q1sG14cRmbdKElRDFv+TJwSvq9nHo3PgEEjSWUl5Ab9mIQn8
         ehO94e25f/K1+sSYXKcbMQ0T4XSgD4LZN5xRqlLjSa6YimOcqGf6JUx4LiVFOyShjbTK
         WEMcBv+r5GrgdRUe0JZz1aR2mVraLceEVVRLS9gpxeV+psmB7cP1HYwzwFXMf6FKq6+N
         xh+AwjmtWv9QFesK4gnlNTqyHug2mSgDfWLBN21qPqJZai36JbKTm1kOm+BPH5IoShiY
         wLHWwo59paImQXj2oHdyglMRz6gLOedlIXpRaAJcgxTiwcJcazJTXd/O/hfIRhzZena9
         34zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715426580; x=1716031380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugYbuQy66dmJdHI5/jJJSz0mg+CSnItI/sgTs6dvk74=;
        b=M5nV47EhEo6KZzCprz7Nq+l0LRpaws9E7ZQ4qFs/MRmZgXc1PSsFGGV/tYQEZweDYL
         5l32hv9fVUMbKXgEr+PzTAkaN7rqDWozfYHIaCqocRTiy9ZKr5qG+6eDl8chSiTKtgaZ
         99yCNxHlFcYSogivuSqxu9ADosbVY3zSWlu3TVzAI+Yp2JoIOslPslBD3MkPVN38hoFj
         MPgwML+06d1YUR3GBT3Kx6Uks/vc4ovOKB7CRnzIcWY1s3IhE+zhtoVmH50YlmeWgjWv
         1j2ddFKjDWOnpAfAmbnVdU4h4EtwaE6xuG40weZM1Tgxkf5DqDZuvO7xVzOIU12Igyje
         UwDw==
X-Forwarded-Encrypted: i=1; AJvYcCUtdGRLuavi1itkKjm+8TX4OUiPGUyX8B+FJyQfLU7cro7RytkIG946u06ypzW9cthikOBUllzTaU9KyWgVBD8hqD495AwUDQ5C4c0=
X-Gm-Message-State: AOJu0Ywy3HevYn6jsnY6YJAE8+TNG1QCZsWUxBeeAHPa5QquvrQ14Ai0
	nYy1bKk1LKnNGIaLGOqEXH6/+Lo12W1uhAFdtsub1A9oGt5dQ0j4LTD3v8CudSXMQYlcs1GXUXY
	jtUcQvhB4H0mmukwgAkXaIBNo/w==
X-Google-Smtp-Source: AGHT+IH0HqrR5xD8T7Jda86pTOYxQRGn20hm5hY2YNnq/Ty4H5xyl0QD9Bv4dWHY93IlQ7AG63J7WUGrHGA8Zkd+O98=
X-Received: by 2002:a54:4407:0:b0:3c6:d9:2c75 with SMTP id 5614622812f47-3c99707215bmr4762818b6e.30.1715426580344;
 Sat, 11 May 2024 04:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240510095142epcas5p4fde65328020139931417f83ccedbce90@epcas5p4.samsung.com>
 <20240510094429.2489-1-anuj20.g@samsung.com> <Zj5t9TwrT77KGOyr@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Zj5t9TwrT77KGOyr@kbusch-mbp.dhcp.thefacebook.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sat, 11 May 2024 16:52:23 +0530
Message-ID: <CACzX3Av9JUPLeR5j++yvctgES4UP7M17PQZh37ByZyBP6BemTw@mail.gmail.com>
Subject: Re: [PATCH] block: unmap and free user mapped integrity via submitter
To: Keith Busch <kbusch@kernel.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 12:31=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, May 10, 2024 at 03:14:29PM +0530, Anuj Gupta wrote:
> > The user mapped intergity is copied back and unpinned by
> > bio_integrity_free which is a low-level routine. Do it via the submitte=
r
> > rather than doing it in the low-level block layer code, to split the
> > submitter side from the consumer side of the bio.
>
> Thanks, this looks pretty good.
>
> >  out_unmap:
> > -     if (bio)
> > +     if (bio) {
> > +             if (bio_integrity(bio))
> > +                     bio_integrity_unmap_free_user(bio);
> >               blk_rq_unmap_user(bio);
> > +     }
>
> Since we're adding more cleanup responsibilities on the caller, and this
> pattern is repeated 4 times, I think a little helper function is
> warranted: 'nvme_unmap_bio(struct bio *bio)', or something like that.

Makes sense, I will add this in the next version.

Thanks,
Anuj Gupta
