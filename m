Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C2C142
	for <linux-block@vger.kernel.org>; Tue, 21 May 2024 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253552; cv=none; b=L96NoM90VJQKSLXGGE1VOPfb1VOr86T4PsiBGoO+w2+tgEwyhb+Zs2YYps2BJEuJpTVdUngscKUaAe+5Y8H01tbjAy+AFYXGMLS/5vo8JqVTB4mnoYmDeOjGlD+xH+vF14hp5RPWfrBjwu2lWIYs914+5iS8eZdNZMFFqc1cAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253552; c=relaxed/simple;
	bh=sODGnfmKfl05kirINZM0ji46vr8FOdY8tSVDyJHhRbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a30KaW1B2xRJSaZSAz6xQr5itJ1D+arGACZLB+gPWCrNj1lC8HrAwqnM2ZouTAtIa7XmL2Cm9dCMlitgYUpkytNPznHN2nHChV3U68AFkkJhTDXyiFUu8O8y90Xk1DVBGrX/0Iqt+DM3X1iANdzWA5//GFvOfOdQBijGpo6fej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGajbfxS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGajbfxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716253549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+IRLtr3CD5713sw58Oz9jeFDrRIoC1ExmWuiRLK+04=;
	b=RGajbfxSPXfvbh14ygvqouF5T2dKcjTG2UPrGCAVQAlCL+3kexT9WMB2OWaU1wdwMlFevB
	LomW6R8DDrctkHEvy9qdThmwnvna/gY8WfwOrqsAGPFLT8VelP3FA//eXrj+daL7qn31xY
	6VtnW2PCU5nulLU/bnx1HBrJu8c4Cr0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-yvDATvB8O-eGjGfgmP3nAw-1; Mon, 20 May 2024 21:05:48 -0400
X-MC-Unique: yvDATvB8O-eGjGfgmP3nAw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a5a812308daso511573366b.0
        for <linux-block@vger.kernel.org>; Mon, 20 May 2024 18:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253546; x=1716858346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+IRLtr3CD5713sw58Oz9jeFDrRIoC1ExmWuiRLK+04=;
        b=Gaogh0Fn1b3hZ2xx8mQoUEj051iFtsJ+3YhMMGPMWCtWr9PKpBUqJhnwoYfmO8qkUx
         yeEGU5vW6L4Ux07HT24GrKudg7s+4iNVLDcX2nKC01Z50D0azsP0vGgyj1DnIVOWO7qQ
         bi8GcrldXMj/rsRrROj4hcecEC5YCS0pF9WFawIKOmArKKZXyqthlvtl/mlhArZ8KXET
         1bDIQQMZ7n01OmEmkAddMQynuYQ1Cci7kVKacKVKx/WhZ+hHkEEmFpCsQ81zn9awF2Cj
         xnOYL5fqceZS+5NsFJN8nlw8t/t79tWZf71gQuI89AARTOd28Eb/Uel5Lx0Ble4cQIGJ
         EWIg==
X-Gm-Message-State: AOJu0YyVn06KVvunoavu76YyJmTxZ7FUpagwb8/2EnS6aHbgg9nR+yJy
	eGJZWE4U90QjkJ8MNf3ywlQB3PUgxDdPSz5shUj0Z0WsQNVqun5mKnzCuOVJggBL/txfcEyXGi8
	XtSxTTqj07l0/S0/QmC+XRDpEOHgwAbtIPMBdboW5TT9BTV1vt6EJPDggarEDjca6LL72S/zyww
	1eAcTvTrelqR98GECVijM8y0OyCMZwnSfIBWJmIf5+LAgbBpKD
X-Received: by 2002:a17:906:eb52:b0:a5a:769d:1f8f with SMTP id a640c23a62f3a-a5a769d1fb5mr1326814366b.68.1716253546267;
        Mon, 20 May 2024 18:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmLA8Se8SsEJHpWJGihreHRU2FyfqBzUvAldKqKbqZ3YYcBppqSSpDm5brTkI9ODNGufLxUVJm562I8U/37oM=
X-Received: by 2002:a17:906:eb52:b0:a5a:769d:1f8f with SMTP id
 a640c23a62f3a-a5a769d1fb5mr1326813166b.68.1716253545613; Mon, 20 May 2024
 18:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGS2=Ypq9_X23syZw8tpybjc_hPk7dQGqdYNbpw0KKN1A1wbNA@mail.gmail.com>
 <ZktnrDCSpUYOk5xm@infradead.org>
In-Reply-To: <ZktnrDCSpUYOk5xm@infradead.org>
From: Guangwu Zhang <guazhang@redhat.com>
Date: Tue, 21 May 2024 09:05:34 +0800
Message-ID: <CAGS2=YqCD15RVtZ=NWVjPMa22H3wks1z6TSMVk7jmE_k1A-csg@mail.gmail.com>
Subject: Re: [bug report] Internal error isnullstartblock(got.br_startblock) a
 t line 6005 of file fs/xfs/libxfs/xfs_bmap.c.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, 
	fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yes,
the branch header info.
commit 04d3822ddfd11fa2c9b449c977f340b57996ef3d
Merge: 59ef81807482 7b815817aa58
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri May 17 09:40:38 2024 -0600

    Merge branch 'block-6.10' into for-next

    * block-6.10:
      blk-mq: add helper for checking if one CPU is mapped to specified hct=
x

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 23:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, May 20, 2024 at 07:48:13PM +0800, Guangwu Zhang wrote:
> > Hi,
> > I get a xfs error when run xfstests  generic/461 testing with
> > linux-block for-next branch.
> > looks it easy to reproduce with s390x arch.
>
> Just to clarify, you see this with the block for-next branch, but not
> with Linux 6.9 or current Linus tree?
>
>


--=20
Guangwu Zhang
Thanks

