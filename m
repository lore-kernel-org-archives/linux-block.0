Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A61E98F3
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252653; cv=none; b=E/PfLZPvnai6b3ve5veRib31kGsgGfaeZ6qoxbCEDy+Q05Pbkzt0F8ZFONoOI+tF4TkUD/Q9xzObz1p3VRIGUc3tW+8Iem+dhK64lppWVDllPWpyEdlNI0lnLqZbdMdtdZcFoHoLISWPWxPcLLYrkcKQaUZx/W84S9U9wI4OV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252653; c=relaxed/simple;
	bh=G2KWCKxGBBnMxM2TX/y2N4+aloxOeEzYQkrSkO2/u8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXCD7znDs66nsWgt202c/x6unsQdV9vlpYc/4IW01dMb/jl5Gt8Kbx0hxrZwPJAxJsBF91Uw2t7odSaLD7R0vpKhf5trftXDLeuplKcTu5V7BEJ8ytPNJqZxP92vKtuyeMJFWg2tMtOGLV2q6BZxMR2Nil5mOVo9LW/bjOPkNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgiVo4+e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgiVo4+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738252651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OfIfoDV3TmglxAm7xSDzWNpXN75A+eqXicgT0bWuM1E=;
	b=HgiVo4+ekz5zONbWgIGDT2vWAV7mH9kly2Agsa/PneyHRxZhZXSrVOecYnU0dJSgpeV/7c
	oAwXtwEQ+hpZJ/sOqoJwnkroWyLe1pnE79xT9Rfous26R9qxbjSnEpvvD2j3C3tD/MIWO3
	rf5EZURVRco1iReSY+Ndi+UeuToMC5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-TbNIxIG4OpWr0bB-GqZ_gQ-1; Thu, 30 Jan 2025 10:57:30 -0500
X-MC-Unique: TbNIxIG4OpWr0bB-GqZ_gQ-1
X-Mimecast-MFC-AGG-ID: TbNIxIG4OpWr0bB-GqZ_gQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361ecebc5bso4958865e9.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 07:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738252648; x=1738857448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfIfoDV3TmglxAm7xSDzWNpXN75A+eqXicgT0bWuM1E=;
        b=OFifTueSr4tqHVTrs1r6fjWp+sqApiYxKXukMqbg8B3PcSp6mzwaHIDGmDmd77EmAV
         VLzu8JuMjo+qwRPfmvOK4855+tYuCKiuC9SRUMJAg5chw9tdtjpZlEtvxvT1+Xej4bey
         4eM4vUa1cvBWV3TAxCIrDSykmrlckvOtGoI1BDkRaIL1BKnERjA6GDF2WPLpiyiBysip
         e71OuGfLXVsXkKGFwuHTzGFHUYJWlkMPXA3TyEXr1hILdLpGTbspi/l+TfRnpHtHmWer
         WL++Hw2x3ZFM2QtcV6zwjMZlRubTMO63gCAuUg2O/Jpc2Pzxw3pH1ifyNoj52NXhcKcg
         Wa1w==
X-Forwarded-Encrypted: i=1; AJvYcCV+E3YS/l+Np74likUvuEbUcFVSSCPzrJXifyhLHh1Ea6wOqBy5s/Sc66P+JtVvaS7uRb+lce66Y1TkNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVy9yrZLxOV7xEp8WpIaFEnSx7VgAEs8ooaljl1s5Lvs8Kmbdc
	z9zwEYb2NreMAh+s7INAG7FUmW0ejH5BgddAjUvnrTSd2sPE5tGm1I3N5Kw2HnjFvma1GhCWz1s
	6b9PwtjpKIqadVaVmxIdEoqtrMhFr0s2cKOqU0g53vabhIH2+9j28DDfmpcR4
X-Gm-Gg: ASbGncvbtdY4yFpYTt0rYWrfnWRusRr+ogUSuWKd8BqM2K+kW9fCX8jzAwxUel+dvmm
	zgcDjWcw08ihHDFWHOsT52NkPX8Zqa/BwnQh4Xdht6euL1JfBuMV+0XoxQ2rW5Ucp1DCgG7rwcL
	6ZlvPxLtPc4peklsjYTZrXS/IWlyYy4tq2iZuGfilxlNE0WpYS2VXHnVJgBFyAIMDWGH54dhbgr
	8uDnARtGatULZFEWe6kHqXlQBVvO1IpQjgiXdXubCdRyEtOGB4/VagEyVvxXS8CAXcUXafMlPXm
X-Received: by 2002:a05:600c:198b:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-438dc428740mr61154855e9.26.1738252648690;
        Thu, 30 Jan 2025 07:57:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpsduzY13GpiVBA+ILTsmN21ZsHEQqq7w157Dzff267xbbLPcjTMCqC0hm/7ck3TRq9eaZoA==
X-Received: by 2002:a05:600c:198b:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-438dc428740mr61154675e9.26.1738252648348;
        Thu, 30 Jan 2025 07:57:28 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:25e:64cf:ae20:59ee:ed31:b415])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244ef41sm27952285e9.32.2025.01.30.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 07:57:27 -0800 (PST)
Date: Thu, 30 Jan 2025 10:57:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Israel Rukshin <israelr@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	Linux-block <linux-block@vger.kernel.org>,
	Nitzan Carmi <nitzanc@nvidia.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio_blk: Add support for transport error recovery
Message-ID: <20250130105700-mutt-send-email-mst@kernel.org>
References: <1732690652-3065-1-git-send-email-israelr@nvidia.com>
 <1732690652-3065-3-git-send-email-israelr@nvidia.com>
 <20250130154837.GB223554@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130154837.GB223554@fedora>

On Thu, Jan 30, 2025 at 10:48:37AM -0500, Stefan Hajnoczi wrote:
> On Wed, Nov 27, 2024 at 08:57:32AM +0200, Israel Rukshin wrote:
> > Add support for proper cleanup and re-initialization of virtio-blk devices
> > during transport reset error recovery flow.
> > This enhancement includes:
> > - Pre-reset handler (reset_prepare) to perform device-specific cleanup
> > - Post-reset handler (reset_done) to re-initialize the device
> > 
> > These changes allow the device to recover from various reset scenarios,
> > ensuring proper functionality after a reset event occurs.
> > Without this implementation, the device cannot properly recover from
> > resets, potentially leading to undefined behavior or device malfunction.
> > 
> > This feature has been tested using PCI transport with Function Level
> > Reset (FLR) as an example reset mechanism. The reset can be triggered
> > manually via sysfs (echo 1 > /sys/bus/pci/devices/$PCI_ADDR/reset).
> > 
> > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > ---
> >  drivers/block/virtio_blk.c | 28 +++++++++++++++++++++++++---
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

Sorry this is in Linus' tree, I can not attach your ack.


