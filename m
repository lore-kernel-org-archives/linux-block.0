Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27305158557
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829060; cv=none; b=PBJzl613MqDu/ie7SXQInpOOvOFP2CTk/YHZPsaqi4TjzJhtO0bBTkJRavLQlPCJhbJ8OknsDd66imyAAn4B1i68DdSHuSthwGryncAdreF9ckn+XCYgI5tFCgsJU9IJNB9zSIO3ESLSKRxB8P6aOJoU04sBBJ5jNjA3UDWy6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829060; c=relaxed/simple;
	bh=hrdybWADZxrNOGDFQ+iblbPSFaRlDH4YMdydN364uxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDeZaeD4cYgt/GioTZlLcQQpxTrLd3/GpnnVajqcLNj9j+sv9O4nNk7ZhLCMM5XR7PXliNbpK17tW8/Pg0+4eLDSPphhN5AEgIUg8YZovcanfhpD6XcrGf+oY3qap8rrpmmdffxPMmRZ8myr4fA91fXDFwQQvFGT/iJ2cP7C7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b25dXY6y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b25dXY6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724829056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4exFj43hWLT00BAGeYDHEqubvTOHjaJM+W+ukum/0tY=;
	b=b25dXY6yCnFhBPxNzTGVXpsjAEJZ0nyy02OSQJlrxhjbd8L9SyTACOoQjF9JK/ADVFaK/t
	F68qNganpDe3QWhY+WI6wr03D3U7hNJ0T4iwLXnHQOqXpwcnf+3yri8KkoLKKGSDges3X0
	GWRAv47tfQHReADcb2Izs4/Xp2l5abs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Ytzp0OnoNdS-evkjuKKIdQ-1; Wed, 28 Aug 2024 03:10:53 -0400
X-MC-Unique: Ytzp0OnoNdS-evkjuKKIdQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1de7141f1so825964485a.3
        for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 00:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724829052; x=1725433852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4exFj43hWLT00BAGeYDHEqubvTOHjaJM+W+ukum/0tY=;
        b=Re4NUDJJGhjHI19VabiafYaSNmE4z4RhvnNloxwx9+7cUAdX2EnI493MRYsMzDACIZ
         /3rSWYsBR4QZ4ZkSwAYYRXjBuW7aM6Wqs9bKQmV+D+w6qPRJvTFafE2Crj+tRD73DKqn
         JICxehuYViIgjXGR8g75rYeDIbrsH1futLtviAyA4smn8ka55TyNPX0QmRwDWVEEygVE
         1Rz8V0a7ZJVENzhxkDEH/TDxef4X/RQStI0e/sD8Q42RS0tkoI1JdhHAWZUjCOgCwEC1
         vTXVXp/7aYytufNiG8fqSJJv14ohyFDJZVcToCIA9YXclSDz64g9AeNK0Yxe0do4npGZ
         jVqQ==
X-Gm-Message-State: AOJu0Yxeb6Suxyt4pO7Kq0dcLRt7/zg8PKA1E4mdClA1VfWZyEf4vPne
	HSd0H4IZxIVtaB8yoNbm6PjrjprTLYQJJlIeDhDNaK7k+++qSl+zrZbzESVwv9ffwhJAsI4BNDy
	UJMNmbKyKZyWDJfF4+lIKhGHA4Ie/54H8lNs6bK4YLeIUBV+oBp87h4PN+QU6
X-Received: by 2002:a05:620a:468b:b0:79d:6276:927a with SMTP id af79cd13be357-7a68970207amr1677961885a.22.1724829052413;
        Wed, 28 Aug 2024 00:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoJpkEEQicGfWPZT1lOW4zceJ6tHVmY2Rb8P+ysJBwyYwzs7rm3IwCsm6DsOeUMwreCEmk+Q==
X-Received: by 2002:a05:620a:468b:b0:79d:6276:927a with SMTP id af79cd13be357-7a68970207amr1677958385a.22.1724829051978;
        Wed, 28 Aug 2024 00:10:51 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f319050sm617950485a.11.2024.08.28.00.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:10:51 -0700 (PDT)
Message-ID: <189ab84e8af230092ff94cc3f3addb499b1a581d.camel@redhat.com>
Subject: Re: [PATCH v4 3/7] block: mtip32xx: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Wed, 28 Aug 2024 09:10:47 +0200
In-Reply-To: <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
References: <20240827185616.45094-1-pstanner@redhat.com>
	 <20240827185616.45094-4-pstanner@redhat.com>
	 <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 13:05 -0600, Jens Axboe wrote:
> On 8/27/24 12:56 PM, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the
> > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > In mtip32xx, these functions can easily be replaced by their
> > respective
> > successors, pcim_request_region() and pcim_iomap(). Moreover, the
> > driver's calls to pcim_iounmap_regions() in probe()'s error path
> > and in
> > remove() are not necessary. Cleanup can be performed by PCI devres
> > automatically.
> >=20
> > Replace pcim_iomap_regions() and pcim_iomap_table().
> >=20
> > Remove the calls to pcim_iounmap_regions().
>=20
> Looks fine to me - since it depends on other trees, feel free to take
> it
> through those:
>=20
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thank you for the review.

I have to provide a v5 because of an issue in another patch. While I'm
at it, I'd modify this patch here so that the comment above
pcim_request_region() is descriptive of the actual events:

-	/* Map BAR5 to memory. */
+	/* Request BAR5. */


I'd keep your Reviewed-by if that's OK. It's the only change I'd do.

Regards,
P.

