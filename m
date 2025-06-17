Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB582DBF44
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168700; cv=none; b=ECCt6AA7Vtlq7FEjHYyc2lTaEsi1GurILA7Uos/wQGAG1br/VrhXaYvmvIFhB8ZVWEh3P0U/dWrCuPDDhIF9pGh/c6YvIDTRmEJ0m+ejhDwORcysgcsgOK731vRml/dV07/1DbnXBUbAKi3gkSQ1zNf566tbcizYSiCzOph0iL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168700; c=relaxed/simple;
	bh=8KOI5xyxym04Su+Y1cshyyjm3OqlNZRmsZPFqtfguek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZmQAJmzW3CIVHi3aGJJ0YBpyrHicbTN+hF3gKfT4L2fnpbCnDEjiaw2fgIKz1Ewj+rlmugF39jXUbD44JhBOIA4P7qvctRKbV0VmC2bvHM0CjUjRbZRIJ80NJ/xuDGYGcLHtoMnIksCLMJ0hv53t90CtG618upBP2qdOUD0iw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0DY1wyS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0DY1wyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750168698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bENOsIRAxg+jMcMN0GOm+0hWN/lXpSKL+NP33siNQU8=;
	b=e0DY1wyS0k39iv4vALFfoW5EJ9+XnqPZRNumPKZXI8CY8LspVB7gWOkZdkVqcjDQu6POHY
	AWJ3gFu2yY3SwAEfwku4qHh1x9hnBrcuvWC1JEJ+RAZCo2UlpYxxujnuLDPn09SwjYcUfw
	XmAhTTiH0fyY2NjqSndabTdz80eGZd8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-XFpWAuuRMLuOoVUz2C3pqw-1; Tue, 17 Jun 2025 09:58:16 -0400
X-MC-Unique: XFpWAuuRMLuOoVUz2C3pqw-1
X-Mimecast-MFC-AGG-ID: XFpWAuuRMLuOoVUz2C3pqw_1750168696
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7111c6e53a6so81153657b3.3
        for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 06:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750168696; x=1750773496;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bENOsIRAxg+jMcMN0GOm+0hWN/lXpSKL+NP33siNQU8=;
        b=SuFMRI2l20BzOEtFaJZbRkBpFX/VTXm2ZlToygyjrKmnumzh1g36hGSp5J4j5JouzN
         DNcjR4XEqsp+qY/FCH83aklPw7J8jbcdTNLzf1dozKHKxdbaGdqjtPBDblIiaVWGNICh
         /dAzscmhiLHqp5l1DLHyR5X4SnZn/Jo52LB3BFNXi7KGNcmjyw8H32YQ5YcV5aeSE3Zm
         AYNzO0beT92mshaK1nfuSqhFcSxiZe56eJTZL4uQyiNgTDELtVcwQ9iHhRTxF+TiZR9K
         4tfiO4AXfiTichmWU5GdCp+VcaQojUnzlkOPsAq4VV/U8r14FYVcKt3H+C6ZYnPgYYfg
         uo6Q==
X-Gm-Message-State: AOJu0Yz3dpJxWV6hIdJdXNpIWTxmtSKw1mOAo/K/yzIkwOKEIA9pPrUt
	rTC+wH5q5c20a0efQyff3sMDAemDdChRvzM8Q3yNy0HhIZtN5b2xHiiwtXtUYrBfc0NAnvvsmXU
	qylTcF3qA2S9c5DVh0lhGRQWieLYSCWWEHg4VOlh2kVGuTRiJ7MGggEOEcgXBrbHf
X-Gm-Gg: ASbGnctRqKGFcukW0Jk1iLyvyC1xnAv+CRTjRZKf9rTXuNhSexk+tbFVHzhu72nCo55
	zZqertL6AkX+1mXdW9E5PXn1cRn/n7vuQPlMMqyBk8WA9usTPaDcXsw0PQhU5Uk2yv4Iw86uWxN
	5QKTJMOaYpaHRiDbx5IR4rFnw8SZTdyOHitU6eurkU1u4lwmM2p89Al2lBA7At1IUfKwaLg/wyD
	O55pQXwf3t3Fywwd4JTt5B0ZUM33Pmh7aSEC/6SuKo3JmBoU9T3nBCoFctfaBSFzkbMdIS9SLIw
	XMVN6Zc5rlsHxDmlhj0+EzyX3RM8B8HMgOrEFc52Sfvz0tTYTR01xF2Gytssq6pO+ILvB4OM
X-Received: by 2002:a05:690c:688f:b0:70f:83af:7db1 with SMTP id 00721157ae682-711754dfc11mr196238377b3.19.1750168696135;
        Tue, 17 Jun 2025 06:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8BpLzZz4BKXDeh8JDK9hwMCQUTeKIwgrAeTc5hbfFEez9niTNWRIj2BpaXVbdmcugQvSmfQ==
X-Received: by 2002:a05:690c:688f:b0:70f:83af:7db1 with SMTP id 00721157ae682-711754dfc11mr196238067b3.19.1750168695804;
        Tue, 17 Jun 2025 06:58:15 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7119e3758e6sm5223547b3.101.2025.06.17.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:58:15 -0700 (PDT)
Message-ID: <aa8e177c053a91452f6dde4b31b876453d481077.camel@redhat.com>
Subject: Re: [PATCH] scsi: storvsc: set max_segment_size as UINT_MAX
 explicitly
From: Laurence Oberman <loberman@redhat.com>
To: Ming Lei <ming.lei@redhat.com>, "Martin K . Petersen"
	 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Christoph Hellwig <hch@lst.de>, "Ewan D. Milne" <emilne@redhat.com>
Date: Tue, 17 Jun 2025 09:58:13 -0400
In-Reply-To: <20250616160509.52491-1-ming.lei@redhat.com>
References: <20250616160509.52491-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-17 at 00:05 +0800, Ming Lei wrote:
> Set max_segment_size as UINT_MAX explicitly:
>=20
> - storvrc uses virt_boundary to define `segment`
>=20
> - strovrc does not define max_segment_size
>=20
> So define max_segment_size as UINT_MAX, otherwise __blk_rq_map_sg()
> takes
> default 64K max segment size and splits one virtual segment into two
> parts,
> then breaks virt_boundary limit.
>=20
> Before commit ec84ca4025c0 ("scsi: block: Remove now unused queue
> limits helpers"),
> max segment size is set as UINT_MAX in case that virt_boundary is
> defined.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Fixes: ec84ca4025c0 ("scsi: block: Remove now unused queue limits
> helpers")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> =C2=A0drivers/scsi/storvsc_drv.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 2e6b2412d2c9..1e7ad85f4ba3 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1897,6 +1897,7 @@ static struct scsi_host_template scsi_driver =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.no_write_same =3D=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.track_queue_depth =3D=C2=
=A0=C2=A0=C2=A0=C2=A01,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.change_queue_depth =3D=
=C2=A0=C2=A0=C2=A0storvsc_change_queue_depth,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.max_segment_size=C2=A0=C2=A0 =
=3D 0xffffffff,
> =C2=A0};
> =C2=A0
> =C2=A0enum {

Hello=20
For what it is worth, I tested Ming's patch in our lab and at our
customers and it fixed a very serious corruption in Oracle REDO logs.

Tested-by: Laurence Oberman  <loberman@redhat.com>

I will test what Christoph share dbut our initial way to deal with this
in RHEL will be the point fix in storvsc as its a critical issue
needing an urgent fix.

Thanks
Laurence

