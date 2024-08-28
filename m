Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC618030
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851165; cv=none; b=DIXSWzHCPoG4OuLoymyErbTmCa7bhlLGlcf5UxCR/WRdIUsY2qnfCMnvac2bbpJohE8yiIIlWx0Mz1iSRw/3Pz3mNT2gr2qBZtFm4VoKhydpDsc/Xhf6zbm56uUiS1fWBcuJZrLikMr+57Pjsr0YFpVFG8zGsUaVBnFzP5qvFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851165; c=relaxed/simple;
	bh=CU5Qhhpvx7cFRmdTALiWh/VuoMb8wsVyhSKuEd5oixY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SN1rL9CH0uSae55/iY4s5oSIkxidBQoYlUi4gowNJttNNgCL9HQEV7n1eHL/PF40qNt/XwivJBd5pduMTvQPDhgOEGFLZtWrj3oH4noEjax62tLGt3rAC7Uo8/jOq79SyWQSUrqokg8eHfrnzNppm92z6ELqmDM99/b/2zrm1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Slu0+Zxk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Slu0+Zxk"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f50966c478so36495551fa.1
        for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724851161; x=1725455961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfRcpJQkRR03CtIHNNEqO/lgAvHGNDAjw4dNJiA09aA=;
        b=Slu0+ZxkUGiaup6BQBFEgBsH1t1VPH30WI9jdY21TsIlSLTp/GNXIK0CnpIXdnKZcf
         LV3EugCiTp9Fe536MmXAHFAq45Tje4CMNoyxptdTOx/hS69avcnJUKvXuI8T8uUsM8/V
         zx5StmHNgkKAtQjdWQU7fqyhpj9ujaUsAFPphkCvj/xTQ6Vy2gU1Gqlr7KhBU5T4ca4y
         lmNwOlF1NoVxDachbfQPUX0hIXcDJa/fbsywZ6C/3t8nHVh4vfwaG4/WpIp21vow4wnX
         dmiKyKPxRswh+8iA7g3KxffKmemW0QSijViCT52xJ1ffd+QVrmKHUh2Q5+Io2QrydtSn
         7cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851161; x=1725455961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfRcpJQkRR03CtIHNNEqO/lgAvHGNDAjw4dNJiA09aA=;
        b=bli/x08Dw65R3blAHlBX17Bo4JsSEPJ1uSZPDK71vpwr0RDIpLknqNoL1HyKC0oHYF
         Ds5V7XYQvKnkNDgkmTuELUM3Jy4//QoI0tPQiDaR8PrWoqiuRQ+kto1wJGUQojBB6bYe
         mbaZ2rn1XMKcSQQbeYWMFxTV4ySyWOGqf4+TDWKLTi1/hN+Lr1b8W3VB3wnu8lqxBbyX
         apIcNYIzf0U66+XemL+X4mm/dtj8YUScE3v6ld0o2szdFR3hlfC008vZd/QoAQnKmWsm
         eoeBVLqYrgR9clNUgxUABfwDDrmLijet/jIlxy/PeuPcWWO7pCj96PDX03kCmNaqfAxb
         rHhQ==
X-Gm-Message-State: AOJu0Yw+Dd/0GOaCbfvqSF7qe0TxPyP4G47gFcKPyfzL8WwnUZ/si6dq
	ptcTOaIIH5PUCfZgfLpW2FRwOhmI6rkk3PAcz+wz1wVSV6npw8kqbHJAM5IY1/855Hcq+k4Cmt4
	1oRiXT6DD6QDGFp6nnVS0h1wuzGPV5o+harYJqPjzFFLuq2WdvAg=
X-Google-Smtp-Source: AGHT+IGdThGtPCbXl/LZCZkfl9ZU5WugqJ14vZzK1KybEESOr8lglphQeJOs+kYJEDqR1WNxn4ST/h1llq4GH0+M9IU=
X-Received: by 2002:a2e:a552:0:b0:2ef:2ce0:6ac with SMTP id
 38308e7fff4ca-2f55b6be0f5mr16324461fa.22.1724851160299; Wed, 28 Aug 2024
 06:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809135346.978320-1-haris.iqbal@ionos.com> <CAJpMwyhLMNJYbuLT4h7g5PM9iWQV072qc6fWUSP3F+s4-ypO0Q@mail.gmail.com>
In-Reply-To: <CAJpMwyhLMNJYbuLT4h7g5PM9iWQV072qc6fWUSP3F+s4-ypO0Q@mail.gmail.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 28 Aug 2024 15:19:09 +0200
Message-ID: <CAJpMwygij1UJMP7zvoYmGduHJK7DfgLfMTLjmYz=FsFwux2M1g@mail.gmail.com>
Subject: Re: [PATCH for-next] block/rnbd-srv: Add sanity check and remove
 redundant assignment
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org, 
	jinpu.wang@ionos.com, Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:25=E2=80=AFPM Haris Iqbal <haris.iqbal@ionos.com>=
 wrote:
>
> On Fri, Aug 9, 2024 at 3:54=E2=80=AFPM Md Haris Iqbal <haris.iqbal@ionos.=
com> wrote:
> >
> > The bio->bi_iter.bi_size is updated when bio_add_page() is called. So w=
e
> > do not need to assign msg->bi_size again to it, since its redudant and
> > can also be harmful. Instead we can use it to add a sanity check, which
> > checks the locally calculated bi_size, with the one sent in msg.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > ---
> >  drivers/block/rnbd/rnbd-srv.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-sr=
v.c
> > index f6e3a3c4b76c..08ce6d96d04c 100644
> > --- a/drivers/block/rnbd/rnbd-srv.c
> > +++ b/drivers/block/rnbd/rnbd-srv.c
> > @@ -149,15 +149,22 @@ static int process_rdma(struct rnbd_srv_session *=
srv_sess,
> >                         rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KE=
RNEL);
> >         if (bio_add_page(bio, virt_to_page(data), datalen,
> >                         offset_in_page(data)) !=3D datalen) {
> > -               rnbd_srv_err(sess_dev, "Failed to map data to bio\n");
> > +               rnbd_srv_err_rl(sess_dev, "Failed to map data to bio\n"=
);
> >                 err =3D -EINVAL;
> >                 goto bio_put;
> >         }
> >
> > +       bio->bi_opf =3D rnbd_to_bio_flags(le32_to_cpu(msg->rw));
> > +       if (bio_has_data(bio) &&
> > +           bio->bi_iter.bi_size !=3D le32_to_cpu(msg->bi_size)) {
> > +               rnbd_srv_err_rl(sess_dev, "Datalen mismatch:  bio bi_si=
ze (%u), bi_size (%u)\n",
> > +                               bio->bi_iter.bi_size, msg->bi_size);
> > +               err =3D -EINVAL;
> > +               goto bio_put;
> > +       }
> >         bio->bi_end_io =3D rnbd_dev_bi_end_io;
> >         bio->bi_private =3D priv;
> >         bio->bi_iter.bi_sector =3D le64_to_cpu(msg->sector);
> > -       bio->bi_iter.bi_size =3D le32_to_cpu(msg->bi_size);
> >         prio =3D srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
> >                usrlen < sizeof(*msg) ? 0 : le16_to_cpu(msg->prio);
> >         bio_set_prio(bio, prio);
> > --
> > 2.25.1
>
> Gentle ping.

Hi Jens,
Could you please pink up this patch if there are no comments.
Thanks

>
> >
