Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00065281525
	for <linux-block@vger.kernel.org>; Sat,  6 Dec 2025 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765013210; cv=none; b=mP45jol7q/eimZWgK4bZPqxVmJt7n1WXHow4vU2dPWfGZCU2rFHm8tCpLZsr9Zb0/574ps3KBA6jxV4b8IK7a/qTE3sLPbMgpQIpoVuzw7MVisENqQoV00I5T8pAuRA5bwf1EC1js2F+nc3k/6zbIg9N9Z/VwLvyy0pRyEPNkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765013210; c=relaxed/simple;
	bh=U2cyg0CRWB2HshiXhIkvPbUF9ckk6zfXQWgmnUX/HfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZvbWd7UcaDHrrqtsCAqzBOTWqqPDNQ0IOKgPC4oIAZ9C2LZlQu48OHPHNfn1bNpFWH6py6MsVn1Th52E7TqwCx7HiYu2Ucx+7Yr3CbZWFqNt79WA+P0QhXD1ETVI3ZlMJb/hOBMFTCJBNzhqkmPI1T4mpzzpsv0FlMcjN6anv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq1zBoTv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq1zBoTv"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso27205971cf.1
        for <linux-block@vger.kernel.org>; Sat, 06 Dec 2025 01:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765013208; x=1765618008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFq0oc8pMr+gyKPI+JedBdUGzF3CFNc+V/Wsq4FQfLE=;
        b=Qq1zBoTvgsNqJtmT3SC2qB+68Tbq4CbwcqrUf8BBun5ksjn8GfDP0hch9RTBb83bTO
         QWmrMY85avTTy1EijiakUxqgP4NipvADUUerJCT+EQBT4uUsdHx1JR9z/AIKKEsl8nWP
         U6UYUT9MFw+TdR+ieyTrsZm0s4q4xMAdzPka2bn3hzPGtdopIOdehLJi5Fy5uE+qlvGG
         gT0ulQrxA6QYrgq9Seq/faInKGFp1XneQGhyHtPKLx4Y1nKPlUvFj7IGy2gssGEZjMI7
         EtavdMOvUQfYIcrPDjom2/uoXBkg3+XN/uEYcwZzIGCHMWZaXiS0DCj2THTRz47TGcXh
         tMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765013208; x=1765618008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DFq0oc8pMr+gyKPI+JedBdUGzF3CFNc+V/Wsq4FQfLE=;
        b=XNk82SDRdLwd98xZMdhYknr3WtQpKZeI/71x7CIDaAKeu9v9S5jY4eNvD34qHuiE2E
         h6y0aVd1gRNkKhsU/8Sdya/nCmsG4XEBuVaafU8OnIvdmxAeNg4ltQ2hkDa+mkPwPYNs
         aiJjOHdI1P9uG3kexyFTUWP5P11m6j6YWcWoCdgLkTPTdjPfhTe7balqWV8IuN6Bk58/
         +NKGT/VhTj1oVUonD4ok+asEMhxnKktdvDWpToYQ0KwPcjMjKAvXWuEwXdpj3/tcD/OM
         L39P7JrGdw2iOjcvLc2aOCR50UiKn/SRhWX7vaGlv/eJSyFWxm+/l7v9c3PX5m+M1wkS
         ZlsA==
X-Forwarded-Encrypted: i=1; AJvYcCVcHt2cX7fYOfUIbB+N7qQA0ArP98SENnp+F3BunxhV2vIdqJgfwv11tyBd98tlVg2oFUFpw+LR1SeNsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtaNCBu7ErRbx0YjXtPsrgQML6/8/7RX5NbTYvd8j1PERTh8wy
	nS1ZTx7tDclV455mK0OgqG7wEw19coRfVpxYUu6OWaHaBLZSLCGOe4H5ZQG0nlpHMjYthlpiu3m
	/3OfvfPNufban2hHOYU3YEXPJwa5bteE=
X-Gm-Gg: ASbGncsPtprBWeibtX9n+rpa7ychvZCGlh8RCIt/n+v2zJXifqiv+xpF+Ucalie1+PT
	efU2MZkedtUdcSeTjXeJzFPJp8ewp7Mwhr0HgMFpwb1mRz3zlA3rIOxylMO0AaCAhfdI16if1Eu
	f0zFUnEyfCLnYZkqcM4WDNBRXAGm8zig+SCq/PRM/Kn77OGSOfkFjQTtO8vDvgeVj3gCHQPKK/D
	F0g42fGIlhJehsuqeV6ndZUaOCbVa7Q5kNYAOfKNvrYa/dHVwfm4EsS1FreHtODneeIGRM=
X-Google-Smtp-Source: AGHT+IFspZZ6ukZmncarZXsvudX/fTFn7X4UqQQLpC7cwpKhlBQrJVKiC6JvXdnBKnL/BP0NqWEJAP6XaakAFwO/Qk8=
X-Received: by 2002:a05:622a:40b:b0:4e8:a413:bb3a with SMTP id
 d75a77b69052e-4f03fecb7b0mr26065551cf.46.1765013207871; Sat, 06 Dec 2025
 01:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204024748.3052502-1-zhangshida@kylinos.cn>
 <20251204024748.3052502-3-zhangshida@kylinos.cn> <aTFW_gdWmXmCP5fd@infradead.org>
In-Reply-To: <aTFW_gdWmXmCP5fd@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 6 Dec 2025 17:26:11 +0800
X-Gm-Features: AWmQ_bnus57zLSjJ12Ea0wTIQU-JiJap0bH-CABljQkrwQsCmNED2Krc5F7dwk4
Message-ID: <CANubcdVyvXTo98cOWLXr8JuEmo7P3H4kq2JASBURwZZG5oSYXQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] block: prohibit calls to bio_chain_endio
To: Christoph Hellwig <hch@infradead.org>
Cc: Johannes.Thumshirn@wdc.com, agruenba@redhat.com, ming.lei@redhat.com, 
	hsiangkao@linux.alibaba.com, csander@purestorage.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B412=E6=9C=884=E6=
=97=A5=E5=91=A8=E5=9B=9B 17:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Dec 04, 2025 at 10:47:47AM +0800, zhangshida wrote:
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
> >  block/bio.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index b3a79285c27..cfb751dfcf5 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -320,9 +320,13 @@ static struct bio *__bio_chain_endio(struct bio *b=
io)
> >       return parent;
> >  }
> >
> > +/**
> > + * This function should only be used as a flag and must never be calle=
d.
> > + * If execution reaches here, it indicates a serious programming error=
.
> > + */
>
> This is not a kerneldoc comment and thus should not use /** to start
> the comment, otherwise the kerneldoc script will complain about
> missing kernel doc elelemts.
>

Thanks for catching that. I'll fix the comment format in the next revision.

Thanks,
Shida


> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
