Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED12765E8
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648650; cv=none; b=tysUPvBeCtf8g+h4rFiczA0tJWOiXO7VQiBhA96PNF+a/dAguiKezQBTRsUqdxvCG2ji1s1pa1bEhmixAoPYitcrY/ZrXn/yH9a92qjL5QJXFBkmqUVuKjSkbCjexUhrFIq1eigmHVQfI69x6UKn0vri8Xh6c4LTuMz+wnR20g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648650; c=relaxed/simple;
	bh=5WraoSFUp6ajvbI3o5JH4FWFS36gY332T+fZ2BSIiD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVNvblOYCmeQI8trVqkQi8b6vWfsXvhgRiVnn6wfY9RXUEa2B5FLO2eBoibFzuLSJBciLNM+tmunxUw3BCEyC3Wi0Q7p2/5LKLvk00wfTet/r2r8J9oRLPgKenU8lLN4VfvCNlOYwg8InBcUowWKOJoc/a6XsoLKZW/qBJiWfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fx84UchE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fx84UchE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758648648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFNQwbdODcls1yBrLTyCkOTsxOyxsNLxzpt49nq+oT4=;
	b=fx84UchE5XWGDbgsBjUAn89A+FBHOSEMeydadGw0L1BPHiRmLGsd4qVQFYS0NsCs2D1YDe
	kS7yoAGxIdSN53ZIVjXJEiCwZF6XgWpimqdwmS/xxDiTo8yQoLeiIafk6MMQS1PG6btk5R
	zaPfqt046G7wO/dQB3FQdlxjKRw8Q8I=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-0M-FNxeFNxe2XeGuyOIRFA-1; Tue, 23 Sep 2025 13:30:46 -0400
X-MC-Unique: 0M-FNxeFNxe2XeGuyOIRFA-1
X-Mimecast-MFC-AGG-ID: 0M-FNxeFNxe2XeGuyOIRFA_1758648646
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257fce57faso1571325ab.1
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 10:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648646; x=1759253446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFNQwbdODcls1yBrLTyCkOTsxOyxsNLxzpt49nq+oT4=;
        b=vLzn2iYmyn/9IaCK43O9/4MfV9kvSeg2nFcwPTArx7iL3K+KawT9zpraaiYUvyDZqi
         IpviIbe/4lcJroTOA6yuSgNDLk5aqtHiSsVh/lYz51EFYO8K9lAdGr4kDM+cnyrWQz7C
         4uebHyg/vc3x4rRtvTxQ76/wDQ4w36+FkI4B6YguT1u2eqYs9h9d51SjmaHCCM7vEeKR
         CDaTAHITb0hFpEoi+0y8hP0J1wQoUMLR4QyD3voPWXcOXT5RUMJjSYdg3PNY/UsJBlur
         C00a0qB6BVIZUC9tQWWaGO5nHJqWJKYxNvt6J8H3lLpJruTOVBywae6Uvka2V5rastuc
         0ANA==
X-Forwarded-Encrypted: i=1; AJvYcCUTO6TEpY9NajR1fjU1g4fbRckEB8Ygi7NUPACKgxIpn0SJttD6QemVPmIrzJyFSqzTINm8Rr36i5OmxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx214PDWyxF36SEpZ3b2LhFbPp6rLUUCxDmDh6t1ie4xEypbB7P
	aouEf0FbTahSeCJb6lS+Mmvkjgqtm+fK85oNjNIdyOQwdkystSJww0tboU/96sWjHw/9MwkmbzA
	ydoPujLpRQQ08hBpCb2sYvd6eL8ogAqMRd6+FmKr2UvQQr1vI96/InAniqyi/9rUq
X-Gm-Gg: ASbGncstI3z3hFIfOhBOvNL3tBMGKcrCLd/L55a7zGuzEkX5/UDVlg89VBWC9E9wevS
	i+CkvIPU7sZtWk/oiazNNRu51VK/wnCsUGkDimyNdtIe8l4Kglqco6Z/LaXglfTyCxXoiaWCe6f
	lgZMZrC1/Rrs4nTV4yoaEo5OX5cSaGIuSkAa6hYsCcgIxwGTD30sUP/Ls9KYlwsjSrNaQ9CXM0X
	2KKQvwfrU4FfOvjtz1vCxJ0t/kujg6h9dGOVG2eb275qHgXsm9dZKGaZ0UYpVFh9V9f7BUZrivW
	Fnary3P/u2V/c+M+bSjG+Ei/ByNwZYFusKGCLZISILI=
X-Received: by 2002:a05:6e02:164d:b0:400:7d06:dd6d with SMTP id e9e14a558f8ab-42581e09c50mr18780865ab.1.1758648644599;
        Tue, 23 Sep 2025 10:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNobmhXZYu8wcE6bAQtE0C6wCF0m0+GFNpZFLyv2Bpb6JP547FE77pkIiIGw0EG9S0P84Gyw==
X-Received: by 2002:a05:6e02:164d:b0:400:7d06:dd6d with SMTP id e9e14a558f8ab-42581e09c50mr18780695ab.1.1758648644175;
        Tue, 23 Sep 2025 10:30:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-566127693e0sm275326173.30.2025.09.23.10.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:30:43 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:30:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250923113041.38bee711.alex.williamson@redhat.com>
In-Reply-To: <20250923150414.GA2608121@nvidia.com>
References: <cover.1757589589.git.leon@kernel.org>
	<1e2cb89ea76a92949d06a804e3ab97478e7cacbb.1757589589.git.leon@kernel.org>
	<20250922150032.3e3da410.alex.williamson@redhat.com>
	<20250923150414.GA2608121@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 12:04:14 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 22, 2025 at 03:00:32PM -0600, Alex Williamson wrote:
> > But then later in patch 8/ and again in 10/ why exactly do we cache
> > the provider on the vfio_pci_core_device rather than ask for it on
> > demand from the p2pdma?  
> 
> It makes the most sense if the P2P is activated once during probe(),
> it is just a cheap memory allocation, so no reason not to.
> 
> If you try to do it on-demand then it will require more locking.

I'm only wondering about splitting to an "initialize/setup" function
where providers for each BAR are setup, and a "get provider" interface,
which doesn't really seem to be a hot path anyway.  Batching could
still be done to setup all BAR providers at once.

However, the setup isn't really once per probe(), even in the case of a
new driver probing we re-use the previously setup providers.  Doesn't
that introduce a problem that the provider bus_offset can be stale if
something like a BAR resize has occurred between drivers?

Possibly the providers should be setup in PCI core, a re-init triggered
for resource updates, and the driver interface is only to get the
provider.  Thanks,

Alex

