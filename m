Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBC61FD7
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719983794; cv=none; b=tLc1XVaW6qympPwoh6kXUDw4riC0x+haXYZYrOlasdEYqbyiBNQ94IwPvEatYyxah1CFa5E7iWdbNFT09V4yZLjJ/aKmIkv0vzaeWM/x2VR0yTtvyfSTMAjndrgOeIeNnzr4KYZocKPEXuT3zWcG1rkV0wRRqBzlr8FJie0fUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719983794; c=relaxed/simple;
	bh=1iRsK5wKghnVwQ5MLuylP8wp2Ct+1w66+SRKexnyb3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKDL76HIY2ZhLkc11TLXn+NYlhOrt/UeBLubFT20xvtdXpgMnYAYX0IfAdaiZ675x3q22WAdEtw8ZaiewW2zrGb7xrjnojPZvgrPCIYsOPlwDUooTrlXHCNDLEzOGDlT7F6WM4EoY4/u2/v+PmklQscPpa9lVx8iy6EKfj9N2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSmO55uA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSmO55uA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719983791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DM2lxXhIGPvBUDRpPfQrrICAY+fcIRO7Wr5as3F5yM=;
	b=QSmO55uAXf86VPjbzKanUeFvK65xz/cXOdirwjP7AMHH38dNS8KwEJ8/Sp2cWjKfRhA1kA
	Pe6yxPgRdDY/qgi3ICIiN5QXx0cvktCzDiWdK6LCKt/EinWr8iTqUB3x0OU5GjKLtENq77
	VBdXU5xB9LA0PIQSc8/jhFWrGDKym20=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-wMGli5vkN467VORQ11pZgg-1; Wed, 03 Jul 2024 01:16:30 -0400
X-MC-Unique: wMGli5vkN467VORQ11pZgg-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-48f3c35695eso509862137.3
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 22:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719983790; x=1720588590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DM2lxXhIGPvBUDRpPfQrrICAY+fcIRO7Wr5as3F5yM=;
        b=nVNQaPH3iOlcg2lxvX7AXDEayQjQgTFZXc8HUcygkQgMvJDbcoHjyv5Sphm8NRJExS
         ZDPtzhea7lTIf02RL5XbLswkapHQnGlFs32C/23E4w/q14+IkVtaW+6w5Lc3KZDzzXUp
         MsSg8MY0Own3K2XUvJLmBwT0CGDAybiUyNlwYjo1nL/sjALGjtGh9oKFBmBQ5S0cm05J
         yr/5w3xBpd45+FcZn9lW4RT7WbnpuKSb7pdZO26yBjfqqB4r4hZ58gW+VB1bsM4m2RAv
         uYjmUNWhzHAPYEmBp6ADD2YtDDDCmmKLc+4xSlTtetgrs0wQT5OingO4AsLvCT7I+iAZ
         FVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5byLQnKg8IwBclUVvwObbPI+AW1GRhjE8RdQstTy/ZQrksQj71iUAoPJsjnDW/8dZxzHu9TdNDTcbYQAV/MHHeaLF8XY7/ZZA8kc=
X-Gm-Message-State: AOJu0YwR7SYQrn23Gv08F7VZpHp1J94iSRLEpeIpUL4weou/TKByjpwR
	DiQRIPukpVVX+NrxCmEpEP0BezcZxo0ge3KUP6CRQDxT7ixkHC3jnlzCuxM5PeFXGRTkr8s2vew
	GaqMjzAkHzVX02f1V0ZBVD5MahBtRoKuHz+62HG5Li9eR61MhyGUV6ZX1ASg7MYDNNFHI+aq4Kp
	fhuIg5G0YrGcwTnvFz39w9ld/nvCT7KF+ho+w=
X-Received: by 2002:ac5:cb63:0:b0:4ec:f2b9:65c9 with SMTP id 71dfb90a1353d-4f2a555e9a9mr10654115e0c.0.1719983788370;
        Tue, 02 Jul 2024 22:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR+V7b5cumHjmFkDvwITdhjJ8X1cOggg4b+dFbhVAbfi0ZCkw5pr059ZvqsSQhx0L+P4lgy1AgNDo1rpcSzTI=
X-Received: by 2002:ac5:cb63:0:b0:4ec:f2b9:65c9 with SMTP id
 71dfb90a1353d-4f2a555e9a9mr10654097e0c.0.1719983787543; Tue, 02 Jul 2024
 22:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82@epcas5p3.samsung.com>
 <20240702100753.2168-1-anuj20.g@samsung.com> <CAFj5m9LcpCbdy4Vim3R+=KOnyM_AwevGM1ye5NSY4HRt1XS06Q@mail.gmail.com>
 <20240703044635.GA24498@lst.de>
In-Reply-To: <20240703044635.GA24498@lst.de>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 3 Jul 2024 13:16:16 +0800
Message-ID: <CAFj5m9J1d=hnAMWQ8zchFhvVXAfLYrNU3M5EZ+OQiH3+aLvEqA@mail.gmail.com>
Subject: Re: [PATCH] block: reuse original bio_vec array for integrity during clone
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, martin.petersen@oracle.com, 
	joshi.k@samsung.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 12:46=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Jul 03, 2024 at 11:08:49AM +0800, Ming Lei wrote:
> > > -       bip =3D bio_integrity_alloc(bio, gfp_mask, bip_src->bip_vcnt)=
;
> > > +       bip =3D bio_integrity_alloc(bio, gfp_mask, 0);
> > >         if (IS_ERR(bip))
> > >                 return PTR_ERR(bip);
> > >
> > > -       memcpy(bip->bip_vec, bip_src->bip_vec,
> > > -              bip_src->bip_vcnt * sizeof(struct bio_vec));
> > > -
> > > -       bip->bip_vcnt =3D bip_src->bip_vcnt;
> > > +       bip->bip_vec =3D bip_src->bip_vec;
> > >         bip->bip_iter =3D bip_src->bip_iter;
> > >         bip->bip_flags =3D bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;
> >
> > I am curious how the patch avoids double free? Given nothing changes
> > in bip free code path and source bip_vec is associated with this bip.
>
> bvec_free only frees the bvec array if nr_vecs is > BIO_INLINE_VECS.
> bio_integrity_clone now passes 0 as nr_vecs to bio_integrity_alloc
> so it won't ever free the bvec array.  This matches what we are
> doing for the data bvec array in the bio.

OK, thanks for the clarification!

Reviewed-by: Ming Lei <ming.lei@redhat.com>

