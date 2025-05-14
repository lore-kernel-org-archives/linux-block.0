Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927A2777F9
	for <linux-block@vger.kernel.org>; Wed, 14 May 2025 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226437; cv=none; b=DlbA3jTsLDjcksnrpHAVtO5NzwdbKiQqJR11pZEC1cFtOSUd8Sdm71gKDp3y+Mf3cRDQVOC+lTk0TR0DNxv76z4EiccThllL+oChsqwxIwVAjoR4vjj9o8ENOAkCatxcNdHqKNxR/8fQpaizHSYJcaRpdGP2/oAqgpoaGXWIEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226437; c=relaxed/simple;
	bh=l4VZADMEVJnFAQXvFf7wgOzQJUelFDiQAhhzyWvjj6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUfMohErGAFH0/vryw++OMkBIOrd/au33uO52A4WOkMjWHCQR9182+Ak/bikTqae0k4v/bgg+E1L1WjKHaZl/Vo7jj7hLcTQf434kQESS9N+IHtrRhBd4T9dVTLER/GZTW8jHunuHrg4aYZxfc+z/yEQlNqG8RW8XM9Cx24pGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9t8gw9/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9t8gw9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747226432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fw0llZnGO4F7e+OkKHs7xd6962MpvChnUrZgYDDb9I0=;
	b=i9t8gw9/jRIxZUg5E8dQEBfurTXN+hd/ga6gWOO+djgPKwPgiE4MMemQYjXRkoad+dHC3r
	T0uvteG2WjF3OOBmQhYtd6725T+eYviiQoDEFZEBhqZ0ugqMq6RN0EOYrPG5P6ASRIVWcg
	muXr2QYLG8PtQJHo+lLQKtBj2uP7IGQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-qbpL7V0FOYWdcEwedgII3A-1; Wed, 14 May 2025 08:40:31 -0400
X-MC-Unique: qbpL7V0FOYWdcEwedgII3A-1
X-Mimecast-MFC-AGG-ID: qbpL7V0FOYWdcEwedgII3A_1747226430
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso434232f8f.0
        for <linux-block@vger.kernel.org>; Wed, 14 May 2025 05:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747226430; x=1747831230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw0llZnGO4F7e+OkKHs7xd6962MpvChnUrZgYDDb9I0=;
        b=Y7N1Z2W1QOKj5yy8jMWewdPh98yBI4kdHlzqpnCcUiDg1aJrjEYxcAcECy2JT2bYa3
         37yQtFpSMbUja+JAoOPwjQtuKJLuqv+EajVfzGj93BUzHk1blyfbxD87LaNYpPXqcGuM
         TDuU1FlUzyo3wlMh/cfsajz5yyNq08Mf6AAP97qx5rpev+5rDp15x6v6hsRDILKLI5zw
         hn0gf0PDmTKslzAHZTXDScFXj/IRAiyTX5QQRbpxo5YF4uixgBeqHJUj5U1GiuKUXEtG
         GDet7kTqdSb3V+4wBNRl1wEQWfLX9WqaZ5RyczEh6sN1QcoxhCdpiTp3ifxWxRpwRkQR
         DRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQCFEAMzr1ZN0MZPE5gcgABUuY3Y1N0oMnmmLT6y5CRy2kF+HF5AOXndSY4+9KOobiL5l10d//+CMepQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvagXW0QlHS9KWbWqnwyLczX4vVDCNp7/PVeH8ZVezSXD/QcO
	wCQXsqoXLOa+he+bXRlAHP21UwJfw+PjBYNrz7Vlue9DJ9w4xu/ubFzKTjpsHo0JMa/wyT1Az89
	HaVcs3XdQ4fHubbYttZEVBKIM4I8hoTiRYAvkHV2DX8Pg3dUceYFKwdKRyop8
X-Gm-Gg: ASbGnculx0Qe2x5Zh5JvX2/Ffjj52hMGepZq1LpzaJA7hs9qeBBcVYjrTVCmV2oWVYU
	16ZBBBU9/3lwUujZV6BS02XFnANe2EriUJJNt6lKqfXPNexpyDhi0gcrnR6RBoBqqlMXsKRGiV6
	/zJhIHm6TWQgK2PwS/rLso2Uf9wuXNXp1iCPkuwAUmxLI5uEgvTKDIjL8FxbSTeMJ5uB9efQtKZ
	0uPmeL25vaa44QaJUcA40MFpFTlNcIzzI0tUrACuduNFXN6eBaDacjMDWOPLrUWTIF7ev/JUr+C
	kamt8g==
X-Received: by 2002:a5d:5888:0:b0:3a1:f70a:1f65 with SMTP id ffacd0b85a97d-3a348ac78demr3422305f8f.0.1747226430085;
        Wed, 14 May 2025 05:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/IcHyOtPZThhQmfsHZwZgx5RVpTsWbFQFnsQ1d9kN5ycuPeVc3HAClS1rLwLne8I1m0Er5A==
X-Received: by 2002:a5d:5888:0:b0:3a1:f70a:1f65 with SMTP id ffacd0b85a97d-3a348ac78demr3422283f8f.0.1747226429725;
        Wed, 14 May 2025 05:40:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ebd6asm19922424f8f.35.2025.05.14.05.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 05:40:28 -0700 (PDT)
Date: Wed, 14 May 2025 08:40:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, israelr@nvidia.com,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	oren@nvidia.com, nitzanc@nvidia.com, dbenbasat@nvidia.com,
	smalin@nvidia.com, larora@nvidia.com, izach@nvidia.com,
	aaptel@nvidia.com, parav@nvidia.com, kvm@vger.kernel.org
Subject: Re: [PATCH v1 0/2] virtio: Add length checks for device writable
 portions
Message-ID: <20250514083313-mutt-send-email-mst@kernel.org>
References: <20250224233106.8519-1-mgurtovoy@nvidia.com>
 <20250227081747.GE85709@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227081747.GE85709@fedora>

On Thu, Feb 27, 2025 at 04:17:47PM +0800, Stefan Hajnoczi wrote:
> On Tue, Feb 25, 2025 at 01:31:04AM +0200, Max Gurtovoy wrote:
> > Hi,
> > 
> > This patch series introduces safety checks in virtio-blk and virtio-fs
> > drivers to ensure proper handling of device-writable buffer lengths as
> > specified by the virtio specification.
> > 
> > The virtio specification states:
> > "The driver MUST NOT make assumptions about data in device-writable
> > buffers beyond the first len bytes, and SHOULD ignore this data."
> > 
> > To align with this requirement, we introduce checks in both drivers to
> > verify that the length of data written by the device is at least as
> > large as the expected/needed payload.
> > 
> > If this condition is not met, we set an I/O error status to prevent
> > processing of potentially invalid or incomplete data.
> > 
> > These changes improve the robustness of the drivers and ensure better
> > compliance with the virtio specification.
> > 
> > Max Gurtovoy (2):
> >   virtio_blk: add length check for device writable portion
> >   virtio_fs: add length check for device writable portion
> > 
> >  drivers/block/virtio_blk.c | 20 ++++++++++++++++++++
> >  fs/fuse/virtio_fs.c        |  9 +++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > -- 
> > 2.18.1
> > 
> 
> There are 3 cases:
> 1. The device reports len correctly.
> 2. The device reports len incorrectly, but the in buffers contain valid
>    data.
> 3. The device reports len incorrectly and the in buffers contain invalid
>    data.
> 
> Case 1 does not change behavior.
> 
> Case 3 never worked in the first place. This patch might produce an
> error now where garbage was returned in the past.
> 
> It's case 2 that I'm worried about: users won't be happy if the driver
> stops working with a device that previously worked.

Interestingly, when virtio core unmaps buffers, it always syncronizes
the whole range.
virtio net jumps through hoops to only sync a part.

So Max, my suggestion is to maybe try a combination of dma sync +
unmap, and then this becomes an optimization.

It might be worth it, for when using swiotlb - but the gain will
have to be measured.





> Should we really risk breakage for little benefit?
> 
> I remember there were cases of invalid len values reported by devices in
> the past. Michael might have thoughts about this.
> 
> Stefan


