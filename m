Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15523370F
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580711; cv=none; b=d0nHnHeNDPH3wp1AsdomGvwM/AwmwCzty47T8236AFVs6PY5ItAO41pDeDTl/4fsSRm8V8ZzNWLBQiKSs5WlVClrj/k77wRed4u+KV9l10gqOMg+CqWk/RP+RfqrR97VJtgSW8CWDzrzzFhlQp6RwD4eck/ybFrrfAqO/VoI0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580711; c=relaxed/simple;
	bh=xNZG4kFoGbGB7pheqiYG3iEXKZBGzv6hERVCUWp27mQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNQUxGi+9UiaTAoVm4VRd/iDFVGhX9DY0p2u7ZANv3cQ4eni7tLRndV6LH4O73qwp5oUVMhAoE1B9BahgZ+uDPfHkM1nalsSP9ZIP6AftoU+Lem/QE+X1cuI5j3idiJWXtqRHya8XrX3rB8zv2Sv/Pn0tP1K/zSkajyTqpXiIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCrw+/qy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCrw+/qy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743580708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNZG4kFoGbGB7pheqiYG3iEXKZBGzv6hERVCUWp27mQ=;
	b=GCrw+/qy9jjG9WfZJ6ZetWEFlSmpu1kH9nw3fDIoWmZGc7llmClIA8v3XdFSA+xE5xP4/X
	xYQ6EMveU263xvM4CHHY2NXcLO8Vm7eugB1ypnnJiYOEOnc0TVjdQgankW4ED8B/o+y+2I
	OB0j72ZagP5fo6O/SDatwd+PCWV2nZY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-jgAg7H7ENGumXsdO6LI8Qg-1; Wed, 02 Apr 2025 03:58:27 -0400
X-MC-Unique: jgAg7H7ENGumXsdO6LI8Qg-1
X-Mimecast-MFC-AGG-ID: jgAg7H7ENGumXsdO6LI8Qg_1743580707
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e6a64bd1ecso5220055a12.2
        for <linux-block@vger.kernel.org>; Wed, 02 Apr 2025 00:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580706; x=1744185506;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNZG4kFoGbGB7pheqiYG3iEXKZBGzv6hERVCUWp27mQ=;
        b=kdg6GuL3t//vdy1ef8z/YFCkVqeAvbOhTTRcKMXkdaRhVaHhY+Ht6TJuguqxhoOHs7
         ZTbvfxD8HRo8gWlCEAQTMsvSW7U6VnjOx0maL7bB8xruutIQIpbzgXr6pMkNudiA+wxK
         2v/wfEmA/Dlfaa1T17Xn2RzYNZGItvH+Jqw5ub3cXYep/zv6jTlQXXOngHMNIFXykUvU
         ssPGfQAOhbocVa1cjGaZaQCrJICkYftlVM02Vq6RIdt+VHqNSMGhAGEhDFRt2onB1O/z
         47haRMZtyu6QLJwD23g8xrfZo+5yiUYkOKzcs4JR5Z2cZjfzvKCj74ETWSsuiMkIJSQ4
         zUKA==
X-Forwarded-Encrypted: i=1; AJvYcCVQtvhNdKZusWRa+7DUMuSjqPWWpHevB7VADPR5ZKJ5raIZEeb2XAlA3IepFKP4bZjxKzF3ZSWQryzITQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKEh0sjuNtRDKFrtw7BjkuHyAuMeQWm6AEjZU3wD7eJGU4E68
	mJaqYtCsLw72emC2JFjcVNP06L24Af2DB3LuhG9e7tCGJuQ5Dxf3SlgDsEhTj6kAJf4foK8B6gX
	KnPukz6XwFLwxQRZWt/+ucNbXwrOtlwc9+P+VzQ3cG6b2XE3Nd983ezuC1Xud
X-Gm-Gg: ASbGncsVMIjc+MMWfWQdxKBo3UdxrqmWSs8GCazo2veLHKaRKaep0sEtPiU/mLokI7Y
	tlX174+CCPc+8yXhYqCYjfwm8L5HH/o8L1X5HzRFdfyeKHl2vA4kGVGq7hACvTdFwwnJrIbLGGS
	lNvqoEV1aIvX72VnWNnNeq5XYwXfp6hjWodfu9tvw3uJ48HpeF5odrsXGyZkqpIP85aorHMtfHf
	xYIVWl9pVN0KA4WXyJJNdf5BixFPTiUf7FnBL+fOPzpncxCbL0Qx3UN9OuwgmxxmYdnZEfwRyt7
	5ERpwGqkW8KKgt/AiySdKamKTv3p1y2k36k6DQPxtTKyrcGkuDMst1CBh33hU7Hxa7/CqhGcHYO
	N0ld285XX3B3bK+6wlLMEPIv9eVRwz56MG2rA/8NvUGirvi3kpPQ=
X-Received: by 2002:a17:907:7215:b0:ac2:c06:ad9d with SMTP id a640c23a62f3a-ac7a16c1267mr109993866b.14.1743580706558;
        Wed, 02 Apr 2025 00:58:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYj6cd0a2ZmOIrY2+9xoa0kFQ790CUzhth/mn7wiW3bHJ2mcwrNEVMrfPgd8xSJJfNJC6BBQ==
X-Received: by 2002:a17:907:7215:b0:ac2:c06:ad9d with SMTP id a640c23a62f3a-ac7a16c1267mr109991066b.14.1743580706042;
        Wed, 02 Apr 2025 00:58:26 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2d97:6a00:6929:a9f6:5863:aac5? (200116b82d976a006929a9f65863aac5.dip.versatel-1u1.de. [2001:16b8:2d97:6a00:6929:a9f6:5863:aac5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719223e1esm877349966b.7.2025.04.02.00.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:58:25 -0700 (PDT)
Message-ID: <323da53fe2ec06c9cc5d1939a9e003c5bd2a0716.camel@redhat.com>
Subject: Re: [PATCH 0/2] PCI: Remove pcim_iounmap_regions()
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Bjorn
 Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Damien Le Moal <dlemoal@kernel.org>, Yang
 Yingliang <yangyingliang@huawei.com>, Zijun Hu <quic_zijuhu@quicinc.com>,
 Hannes Reinecke <hare@suse.de>, Al Viro <viro@zeniv.linux.org.uk>, Li Zetao
 <lizetao1@huawei.com>,  Anuj Gupta <anuj20.g@samsung.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 02 Apr 2025 09:58:24 +0200
In-Reply-To: <Z-U5vIbVDZLe9QnM@smile.fi.intel.com>
References: <20250327110707.20025-2-phasta@kernel.org>
	 <Z-U5vIbVDZLe9QnM@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-27 at 13:42 +0200, Andy Shevchenko wrote:
> On Thu, Mar 27, 2025 at 12:07:06PM +0100, Philipp Stanner wrote:
> > The last remaining user of pcim_iounmap_regions() is mtip32 (in
> > Linus's
> > current master)
> >=20
> > So we could finally remove this deprecated API. I suggest that this
> > gets
> > merged through the PCI tree.
>=20
> Good god! One API less, +1 to support this move.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> > (I also suggest we watch with an eagle's
> > eyes for folks who want to re-add calls to that function before the
> > next
> > merge window opens).
>=20
> Instead of this I suggest that PCI can take this before merge window
> finishes
> and cooks the (second) PR with it. In such a case we wouldn't need to
> care,
> the developers will got broken builds.
>=20

Normally Bjorn / PCI lets changes settle on a branch for >1 week before
throwing them at mainline =E2=80=93 but if we ask him very very nicely, may=
be
he would make an exception for this special case? :)

P.

