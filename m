Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A423F294
	for <linux-block@vger.kernel.org>; Tue, 30 Sep 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251175; cv=none; b=AHR0011le6Ht534HvIsfzBwGu9deuoS66lMgBFbsF+47V/EbDUAw4hpKms+vdeeXa3RsH2WNoyLQ3X0MZEYyuaKoFlXh1JZxkDE8FPZh7WF90FDiQpC/A6/p5y3Giy+yT4k/J8/BfiPFxvpvDH/2a3RWZooMmfjbKNqXCHPv73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251175; c=relaxed/simple;
	bh=XRHExvG/tHB5daSSKAmQDIMiwtytKVKqlEgrmiHYtGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYjgNU3rgwZ1iKeTFe6+Qt8DWlSYgHhx/y2kH/ifcCbLDKEeyB72GmyecVsvdMjJ9AsIW52oefKvve1EKa2JTlinykZJmbPS2sbmdRHiQtGDVE5zAar8Utz8FNtYmaxBMLJpSLoG4YEVpdWIpJ7jedZVkANq1sVM9HnVdy5D6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G02T/CxW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G02T/CxW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759251173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JryoONnZtvrch8iWe5kQa/bp3US7CnLH1VFoC2oPQRw=;
	b=G02T/CxWdFzdWNfhlIFwdrUzUnNBxZAHRXbim9H6o7KQF5KMS4DNUuK0/q0tS1t4VDHqf1
	GOfXb5jTCrqx4i4h3f5VwHtoD6hlai8QA77ya8Sck7zGbs4bYIpeUgCs+aMFoPl2guGAKD
	IxWFGeHTQKPEyMC6jJaM17C6FhYIod4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-5Y3xkPyFNRqAjjcDuuy7oQ-1; Tue, 30 Sep 2025 12:52:51 -0400
X-MC-Unique: 5Y3xkPyFNRqAjjcDuuy7oQ-1
X-Mimecast-MFC-AGG-ID: 5Y3xkPyFNRqAjjcDuuy7oQ_1759251171
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7aba0808204so1557663a34.3
        for <linux-block@vger.kernel.org>; Tue, 30 Sep 2025 09:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251171; x=1759855971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JryoONnZtvrch8iWe5kQa/bp3US7CnLH1VFoC2oPQRw=;
        b=iM0r7rfcWSQ4PoTyKDoxq3aTXLJNqkwQ9KywVx/l5f4S/j/EQfcMdoadBQR4wPEdwu
         QjR4j89mnhBmTiYgvuNBwj1QbjHCFnzZvWrWsmfXW1CLenBGRBpEiMbzuwF2KuXvagiZ
         aDpei12MJ7X+HeEOumDkRfa+i8Wo8Xw0NztdghgS7Uew5I6rofcsl84KtBIl8+GiI6ig
         GwP4APuy9KHWfP4F3AJAUyeV+jR3XPklFRMF8EaPH8GlUUQgbqM4E0rGpiehJWOMW+kw
         qelB78cxYqtocJ5qGh3oiudrEQFX+Sw9GUr/bm0RHs0/OjxL8Gf6IPPxD/FZXwMBRzYp
         XAsA==
X-Forwarded-Encrypted: i=1; AJvYcCU3zl8Z7q6VU909idS5KCSFzihML0ay1tqYYak/OVBlXp5hNzkD9TXR5/mr0dmhObr+ruQNX5L61uaSBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv74ULGk9cM5NuCdwo1Dh2m/YxIAPY0EJz3tH/dLYnLS4vaJ4B
	/BdmmG2SRARxMkRnBoWJLZeelGRSmj77NDJBZ2+8Bi5LzXnmgut6SnIuDPI5QeQjnwNJTiRRdHU
	06KR3XYuGAPnlK41O8i/8IF0dUfReMKnHKMkL9hiMPr+X9evE2yE0XErX1EkvVq8k
X-Gm-Gg: ASbGnctdKLRFVnDneX0JfSymZzSyMeXMbNCfZziV3sDuIe8FSg1FfU7e54LBD0Yw/z7
	708cqN5ARtwXEeRX5k0DwkKEpYoVP92UoKWfN18hQ5gBLOe/3tRJKyhurXUX8dv3ObUpSQ0CzWK
	cNfGdKJq3cvC9GwbAYxAso3z0qrvwQeNRX6yulpMzSnmtd15wgMglWzucQ/EHjTa67q4zXYOj78
	/6/bJyG6DdHfyPbBTHIfwmI7YKIbih/E1ovjeGfPlwsc0osUJ/aCMHAwnWm8aMSDr0Z5po592BL
	WsQP5/6Am/pzE5f3sX4KaJTpP7qyBYV1qLY6E7ZEDaAnABhC
X-Received: by 2002:a05:6808:f86:b0:438:33fd:317c with SMTP id 5614622812f47-43fa41bd61fmr82467b6e.3.1759251171045;
        Tue, 30 Sep 2025 09:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwZ3/lKZz7Fdu2TvHNlTbKRk5qveSl6rvSejYaxAMAP02EZ6HQb/uugFp+9XcOcN4obhcZxg==
X-Received: by 2002:a05:6808:f86:b0:438:33fd:317c with SMTP id 5614622812f47-43fa41bd61fmr82463b6e.3.1759251170626;
        Tue, 30 Sep 2025 09:52:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51238c63sm2746753b6e.22.2025.09.30.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:52:49 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:52:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 10/10] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20250930105247.1935b553.alex.williamson@redhat.com>
In-Reply-To: <20250930143408.GI2942991@nvidia.com>
References: <cover.1759070796.git.leon@kernel.org>
	<53f3ea1947919a5e657b4f83e74ca53aa45814d4.1759070796.git.leon@kernel.org>
	<20250929151749.2007b192.alex.williamson@redhat.com>
	<20250930090048.GG324804@unreal>
	<CH3PR12MB754801DC65227CC39A3CB1F3AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
	<20250930143408.GI2942991@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 11:34:08 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 30, 2025 at 12:50:47PM +0000, Shameer Kolothum wrote:
> 
> > This is where hisi_acc reports a different BAR size as it tries to hide
> > the migration control region from Guest access.  
> 
> I think for now we should disable DMABUF for any PCI driver that
> implements a VFIO_DEVICE_GET_REGION_INFO
> 
> For a while I've wanted to further reduce the use of the ioctl
> multiplexer, so maybe this series:
> 
> https://github.com/jgunthorpe/linux/commits/vfio_get_region_info_op/
> 
> And then the dmabuf code can check if the ops are set to the generic
> or not and disable itself automatically.
> 
> Otherwise perhaps route the dmabuf through an op and deliberately omit
> it (with a comment!) from hisi, virtio, nvgrace.
> 
> We need to route it through an op anyhow as those three drivers will
> probably eventually want to implement their own version.

Can't we basically achieve the same by testing the ioctl is
vfio_pci_core_ioctl?  Your proposal would have better granularity, but
we'd probably want an ops callback that we can use without a userspace
buffer to get the advertised region size if we ever want to support a
device that both modifies the size of the region relative to the BAR
and supports p2p.  Thanks,

Alex

