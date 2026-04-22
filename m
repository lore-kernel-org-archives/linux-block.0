Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F901096F
	for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817915; cv=pass; b=iN1f7ozGVN4Tfq/z6+JGDyA7OYlo3wVr7p/vf5cq3dGkXmZG9hZf3c3lXB8UIqtGnlcimtfrr9GkdT66s7j+tlPoFhk/EpNS4kkfIF2hWEZEK9JnPlxnmlxfVPxCIm/hsasj0nHGsbx0vjX/d02Nzk8RchZe28yb7vcHxNcv7WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817915; c=relaxed/simple;
	bh=EDBXLy8UQI0j58mwWuFe1M1VHDvjlrsST3WJoz3J/No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws9yQqxOu9Oq06gLa4bMsVNnN72f/fF5W8J7y1uOw+ikED/34GD+uZx+zYdPS87erO6caf+oRQrc3AquNDwltdPp3xRoI6rdVo1IbM/Zvdx56ra7aWFPf6qQ3A3su9idt0+9Mq8lpQSG9zPvOCP5S1oOyvCKKpj/0hXF4VciVS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L2N7ARJj; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L2N7ARJj"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69489e55b7aso191917eaf.0
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 17:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776817911; cv=none;
        d=google.com; s=arc-20240605;
        b=YFo1/L7yJvvSY2KXMmslMNXNDHUYFPREBNi/RZpG6BqCTvoiE5+XlT+8flK8MCPMiK
         E3bvEv64j0pOj1SibxW68F9KocjXAbHGQ6/Bd/ufKs8l+1AwQT0lap6ZaU1kw/U8TzoM
         HPOQoUo/E3OIaxjakLZBBxJUofo36t21tyHLe0aCXFZaZ8wFShmDnPOPaQuz7sTA6PUz
         jOYUfrTvZ3ugcj3Tbed+aQVB3aEnUNwSlVhcdcTsDg8aPpJXYQZgQ0809m3fCF12DYnW
         U/C6GV0BYBgM1o2R4aIj7O9i6sGMHcabtCpeuRmcMB1lJRTTux/sBBrHZdRgFII5+D8u
         RTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n/JpS5x7LAqkNMSEc/+P1ooLJ8bUzXkHfGX2YeuluD4=;
        fh=bR9cnqMcRCMJz3euFxnmV3rrf7L56e/UnJo452sayWQ=;
        b=e+M34tpeiMU/5cLdyA9KyxQrhLawGKkHE1Vv/61PxtfrecF8Ekw1SI8fN8mPeGnvzI
         KgWyMtpElBt5S58kzrkJeQGNrhpfJkCnYXmtJwkpemiTqJBbhRl3bQ+WoQzSSfzY4uot
         ujLmY+taVYrefpfOSXwNrpiLHUB1WonpZ2DdY7d/uQxD0r49CX5NAqAmeqoYZo5M59Z+
         w3oMca6KFZovvML7VgRxcl+WeGC59Lv3W4bLSKOjJ8Z3tU4JPEgsVbMcHnErdkpA3RE7
         lthplTGU57piuKxLrQADc3YneZHUskaOXXuH1hVmEc9IoGi8vc4484uONwqRXHScC2Nd
         rhHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776817911; x=1777422711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/JpS5x7LAqkNMSEc/+P1ooLJ8bUzXkHfGX2YeuluD4=;
        b=L2N7ARJjA0f6Ge0ICoJMuUO9BIhtrcpUlvDS+5XmxEmPA1IsN+dHQC6QGQSCb7xDVn
         5EgzYizWmFn9Z6gkP0v+O/TlgkYOPfEIzFRX2eKfcpQHefSsrMNSwvFiqB+K75VxhUSK
         gXnpfiTK02N2NhVinYbOegboCeoNzPz5YlLF9TZGFdcWKJuJhnLRvqRWyeDHQCw/E2id
         GuOGtVTQX40ranJPyU9gmFg39Kdthzm1D5hEA1gD2vE+FKiVjhaDssj5fk3ubgFe1OpV
         AmFLXh/no0rLF3sj+9oR7GpSLIqD3JbmHwLzimsbfeUerfrQmWvryM7ZKPVucYOsCq+q
         f7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776817911; x=1777422711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/JpS5x7LAqkNMSEc/+P1ooLJ8bUzXkHfGX2YeuluD4=;
        b=j0fOOg/5ZNHnRYYADPuNHfjGe9KnDVThm4Eh1eTO970EcvUBFYU0ZSoKwRs0J96VKF
         l8m79Mc4s/8nEFqltI7597/V+G1bkaQOAb6CJw5VM72tJIqfWktXtyVhkppbq4QKYdOj
         tQphh9tirTQxf2v+zLww+UsJq5vGkx0uFy1ZIxYAwwvkS/3CyDZJTPpxF91jETyR1JM1
         AbrS1PlZDj8Ys7O/fKBhlmQjZnFPOb8fPit+bG8IDpy1IL3lYBm15/aBGIkYd13zOvsu
         XUvQHwNXYceCqynRD1k/Zac1mt3/vTFmp6UlbPWoE4GN7VGfTCqDz1oKn5yFUA7GaPhL
         eLEg==
X-Forwarded-Encrypted: i=1; AFNElJ/VQZG7ftemJEOJWWpF5fw/uCr/qkPX6unxNR29d649dk1f7A9G48CeGlXJdtghLCt64cFfPi7s9P59Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLa4lFzQFKRKUMvcYkt21JeXTsGEs97UQ6rLPAOCW8ajHZcV0N
	sjpxr0foSUPhZXQXsoomCzOZLhGr1/yDOJCuke5Iuf2RZX4919vJZIoLGfZIEVxXOC/YuSgonsv
	nHEcVRE2+RjgbZr6ttQu4j0lGoQDsYLl3KxvB8AFASQ==
X-Gm-Gg: AeBDietRnu8It5HJJx86ezyZvUvoN0dbSC1/ClpHvZD6yT0X9H3mP2E9xsVX0/7G9jw
	4kUvGxAQUQ0wqogSqUk3DFm0gRdfotSNH2enqYr8tfMrr27QfDZjFczeIC7n2AXcVmeqPViZXRi
	ic3fzDEMHECkqBVr5t8yqwQhjrGhAfdxFYB6TRLv7GZtc+Yy6HRzG2ZCZua4i/DVwE40pJeUIik
	QTtVmgBcVsjqYAQTpepOSlzSj1y4hGc3oBOwlgfdDyOrkfYyNM+GZ38mrTxT2ohyA9ih4s7DmOM
	syBFnqZX3mmgX+b+T50=
X-Received: by 2002:a05:6808:1993:b0:467:de9:3ea3 with SMTP id
 5614622812f47-4799caff080mr8312816b6e.7.1776817911562; Tue, 21 Apr 2026
 17:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421194744.1524637-1-csander@purestorage.com> <aegNf5C5-0ccxBPp@fedora>
In-Reply-To: <aegNf5C5-0ccxBPp@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 21 Apr 2026 17:31:40 -0700
X-Gm-Features: AQROBzADvKxmcxiRfRvui7D1p5-LQsOkzBfOtBaxxMGQ4k5V3wwwVahU0c4oYnI
Message-ID: <CADUfDZq3yY2j3j+Jofqab1VLrm8jk+phF24BHPnVjv0hD3vyKg@mail.gmail.com>
Subject: Re: [PATCH] ublk: optimize ublk_rq_has_data()
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 4:51=E2=80=AFPM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> On Tue, Apr 21, 2026 at 01:47:42PM -0600, Caleb Sander Mateos wrote:
> > ublk_rq_has_data() currently uses bio_has_data(), which involves 2
> > indirections and several branches. Use blk_rq_bytes() instead, which
> > performs a single indirection with no branches.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index ef8a0705e68b..5f9b3c3876f4 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1172,11 +1172,11 @@ static inline struct ublk_queue *ublk_get_queue=
(struct ublk_device *dev,
> >       return dev->queues[qid];
> >  }
> >
> >  static inline bool ublk_rq_has_data(const struct request *rq)
> >  {
> > -     return bio_has_data(rq->bio);
> > +     return blk_rq_bytes(rq);
> >  }
>
> blk_rq_bytes() doesn't return the actual payload data bytes, such as,
> discard command, but bio_has_data() does.

So you're saying that on a discard, rq->__data_len is set to
bio->bi_iter.bi_size, which represents the number of bytes being
trimmed even though there's no data payload? I guess we could check
req_op(rq) here to at least avoid the bio indirection.

Thanks,
Caleb
