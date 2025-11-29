Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4C1534EC
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764381049; cv=none; b=d/9K7mp6Ll4WEchtYv15DBDUpUEwovKlp+lbu+bYsasTUPm0ee/js7yfSIaMubEj+fpcr4DMNj4Pk4HMlNI22tHwTfTalsmL38Naren8Ih/gKw1GhQZ9tFA/8H7fQTcxyHUt12t26YRvB00C273LXzQtKPQr6fO50VboYrqLsoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764381049; c=relaxed/simple;
	bh=NaSVgYTQZj//T0kXBeK5L/YqRjV2JfM4MD+L1BQ61uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCnGFyEvbKRgejSjkw1FHJ9i4/XEePdXAdA3AGyfZSFF8201oUZUZb3HivtO68PaHFj5tc7ojRJKoZhJMzPeUC6VVbw65Alq/ZsJq0UEYuhqVK+hzMZczuY1lT5pdWRoUBX274ZxCDoU4l6V2IRTEE2k/LAyELbVtmERkaBP1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJaomsKU; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJaomsKU"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso21932781cf.1
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 17:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764381046; x=1764985846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXq5BoozcLEtMZPipx/4wTBGFkZq8n4VHxCYYlUf+vY=;
        b=RJaomsKU0RFImSp0lKj+tCXDBYiRDR6Ym99JMqbxsanbLdacTBoZI8afLEDT2XVHyL
         jf3qT2d6hBUsHJ5gr1BWXz72DX7Eeh0gSdtMFoGa4c1/4IT5gXrdHr/Bf2Sz7r2L+N2J
         FwvVZ28GXeKVQ6swn1L23xHmOOM5aYMwQKGdMVkXQ4vNWUK8cKrp4RBAV1T1yzjhHEaY
         JlC05worradVWjm1d+w107iZ5W+cSmrxuUCoC1aEfktG+Rf4xdXwXhpBtR6hLZefwp7r
         nnNsMjNvUSCpqDmgskmxOc4n0pqDHHVWxf1Ixq2XvuGV1BmEgaxtZgPJbiYVH12ISwgS
         hd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764381046; x=1764985846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXq5BoozcLEtMZPipx/4wTBGFkZq8n4VHxCYYlUf+vY=;
        b=nsRqtIWsVj5MPlbXpUx+h6bKWwEkmIe8G0gKtz9muV2nf5EPafKilU9672MesOA8eF
         WncKX4Y4FIyD3J5X8Ya7yw0sM1YTA4F336hn+gKWwyZK+hS19Ldf25l6+q8N47b3e87/
         ULJX0/mpPVJQaWQrVenirq6FtxxIH2JF2TFNr99kfohDJISTQ3nCihc3FSC/0pTGfSlu
         /TgPbCW3t8KWYYUt37Z9wW6bAK+hhVDCzR7e08eUySfhTsukHwARBrHYvgWtk6nx14Qy
         ez8F5jbEuF5ljvTbtfeCpld+QWlNmohGhDUz23N2Ah97nvEFcS44Y1rUrWDpfsG5DcQG
         qwFw==
X-Forwarded-Encrypted: i=1; AJvYcCViLBD8s5pZjyTQmekmMBHo7s8GR//3nEFYZdeDHhl1j9c4H3kxMuuW/aJEaZGugflKmqmJw7gFE52nVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqm5WfP6IakRBOe00R9N0hbhCr6W8SL+Zuxdbu6iPXCbZTKZU
	pI/T8NZjQtCy7lYmc0UyAU55dA0z5Ko/63eWop1usxfqmHZ7JTf+MojitUGm9nqFvEu7Tfwzvop
	2xquOSPPRgDkW88V4QMhraieIv2LFQ5c=
X-Gm-Gg: ASbGnctRH2VUSq6jRcRnAQKBFTXok0N5hO6C0b1ibewDDSkSNqWMlPXrlXoVNOSX+gK
	tvvo0awVWZD6T1HEB/ZzxpVVj8Myp/RAGTAPkycCfx9r2NRTCt63a8pg7CRmQvrx194hbZcHYMG
	4kuGbujzrp7DbRxBB9+MMyYSSoyl4aLvMumQHqQ0lfUBSjuPXnIf4A1dOGCmMnZxVJF1M6mARrs
	X/aQOEBGyVtWibLzfK9OgyeFCHZBitSIADJGB4gGMp5szH9ASNbcLRS+65BcJTOMiTP+In45T5M
	JOep
X-Google-Smtp-Source: AGHT+IE+Tw+9Y5Bub3lN6sC4Pj0OtdTK9knmaYL6GikYTYtgwTjW4uUHcZO2kGFVdLFpIVKdsMHQoOJ3Bk1wdK27dic=
X-Received: by 2002:a05:622a:1909:b0:4ee:2942:c4fb with SMTP id
 d75a77b69052e-4ee5882d9d4mr417978631cf.31.1764381046350; Fri, 28 Nov 2025
 17:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-5-zhangshida@kylinos.cn> <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
In-Reply-To: <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 09:50:10 +0800
X-Gm-Features: AWmQ_bmFiM-2nj0DOVO633rnw-D1LMnVAvls5FZ2mk8-RJDyk4i3to2si2g7WjI
Message-ID: <CANubcdW7FxbtSRzePgO4wQwUFBpgbSYdL-GR87vUXKq7tAPsJg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=88=
28=E6=97=A5=E5=91=A8=E4=BA=94 20:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 28, 2025 at 9:33=E2=80=AFAM zhangshida <starzhangzsd@gmail.co=
m> wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Now that all potential callers of bio_chain_endio have been
> > eliminated, completely prohibit any future calls to this function.
> >
> > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index aa43435c15f..2473a2c0d2f 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *b=
io)
> >         return parent;
> >  }
> >
> > +/**
> > + * This function should only be used as a flag and must never be calle=
d.
> > + * If execution reaches here, it indicates a serious programming error=
.
> > + */
> >  static void bio_chain_endio(struct bio *bio)
> >  {
> > +       BUG_ON(1);
>
> The below call is dead code and should be removed. With that, nothing
> remains of the first patch in this queue ("block: fix incorrect logic
> in bio_chain_endio") and that patch can be dropped.

Yeah, that makes it much clearer. I will do that.

Thanks,
Shida

>
> >         bio_endio(bio);
> >  }
> >
> > --
> > 2.34.1
> >
>
> Thanks,
> Andreas
>
