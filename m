Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466DB535D8
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450913; cv=none; b=QeLuDvBW0gddeMWpMBLp5HTQnruB2fdizWGk5gB4Ac8XXPxMqwgjDKCcZOjhluBQJT+JTZ0GjCCLf1D8uW4p9p6go3t4wmWtQpZifQmC3HuNCR7i5VfgZBYpmQTCuRzV986jVFrXSBgO/IQOCEGRUd5LOHwsWMj63BN1Grc0ue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450913; c=relaxed/simple;
	bh=a/m1kWZ0mMaRN3QIj2DGTgl1rk+XNi+SIx+XcpVWSeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=allkhwKxv4wAIXGZtPZpuui//C9/eQAKjXV6RzuqWGnafZrkYE0n5qHXXy0XgEcaKteEV895KnvP0G8dtz4ONT42XXxlsGz7E2wWRIRojKDV5TpmeJUcPYUXeKNyxKEfFTJbqdVVD9DuhGYzPsFvoE4Vu4dPRmEX2L9qgLBNrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V9t8UuGX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V9t8UuGX"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5f720c717so178628885a.0
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745450910; x=1746055710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Go7qZaXvLQqCMqWTP9/Yf9f9Qu/B9pFeocBe+GrV9o=;
        b=V9t8UuGXDFmTJrX2GuNBpF+35WEPvkVNvWY8r1L9hjJapeb+jb7Ce88japOM3vnENz
         3RwZrf657MtShlvVnMrGuC7cZcKU8ofbe7YGWOVvN91vUualRrIH/gRseGCvdGkj9NG/
         Ouh4B3Kf/ageHGydKSIQu5E4Ne4rxYQgQmsW8gojTKaxUbHSyTUGCmhEj1Or+XTQhcN4
         cxLKHyHSpA42e+eoUA+JjP0yQSOGnfyrqmBZZumfsndKzCQ6HbTG3ahQv812gpJDwreu
         eB5QSugKVOAWTM+tZ6x30M9o8jgtjt8moswwujXVwmrrloZkzEmh5UCv+a0Y8CpCAvud
         VkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745450910; x=1746055710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Go7qZaXvLQqCMqWTP9/Yf9f9Qu/B9pFeocBe+GrV9o=;
        b=QNSBCW1hWHxFpoFQVtHWqAgtAXc6OiYNdndfKVtwuFi558aw9LLNsS6vggkTGyTqQV
         /Y4a8eF/Q6fQtxkbX5J6H/802GKhDmmOtDSU98+ndrzYl8ZxqnMArXJ9vnmeKb3vMdmW
         FwAHxp4Gdr6PAetNCSC2BngIVqyAd0KYBdQHVA7HoHTlQhGxCcq/TeZ03LCub4qFc4db
         0/CAYWDT17h/lN9v9KzyWrS8MLw3O3yEJoSwdiWbDgDXAUoJxcDW1WTGW+7K5PYahSAT
         oQvOSNiKhCjzoBRk2m62qyYPri58EjTkwNbmDpS7DeSEkaE6MJNQR+yu3Q3+XEbBvzPD
         mlBg==
X-Forwarded-Encrypted: i=1; AJvYcCULTEbfw07awSacHBJ9cLfhCxez7n7TDPapwbHLdHeq28cANhU/X7JhrLrLhEHRfk7Hi+Gl4H8H1oc7HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDGQXi2p12D6Kj/cBXJ/ugpFwdjqWzFDTdpUFsLX4oH/T3bVX
	MMvWuFG+IjNmT+z6iS5TJkM27t3TmX3pf5+Xc1PRCNUY5uo+xryDDDHJ/DJkr6k=
X-Gm-Gg: ASbGncv7ZrMKc1IKgZHeLBpfIbCFOIF/Dzoyw18kdoXb+5DjBY0yNKfmGOByk2/HvCS
	BAtpK0BnyJ0GbLNapofnTdG4iXU1XjaTJwTJfAzVLR3s08TLPbW23pT6tcDxfSGFYJxwiIZDY4Y
	BGlcgeVyJoKm/IwZDdP8hWQiDVc9+EXcgRC6QtHopPQn3Adm/z7b2C4599YeurYS+xy037H3IUi
	RBeBRTtxtWtaeCdtego+nt+dsaaHemwgNlHvsicG4jeV2+vh0r8htsfXbP+jJ/mx0M4ovlM1wcV
	G05ixO1B/3/ArZ1sOS5Z1204oUYcAqf3bgB4t5MlZjKChhFaMovjuPpkfmgJUhJPtFoCUAi8QJc
	l3+MmTUGeCB5TsPWj6Qo=
X-Google-Smtp-Source: AGHT+IHQwoUGFyqXOFOgVitrB4+AxVC8d+UTNu2w6OYf0KswkT4EXsvYxHqs0LgYSSaBSDPbedDu/w==
X-Received: by 2002:a05:620a:2887:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7c9585c5877mr36268185a.11.1745450909829;
        Wed, 23 Apr 2025 16:28:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958e7f154sm2581385a.76.2025.04.23.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:28:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7jW0-00000007PIX-0JOv;
	Wed, 23 Apr 2025 20:28:28 -0300
Date: Wed, 23 Apr 2025 20:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jane.chu@oracle.com
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
	willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
Message-ID: <20250423232828.GV1213339@ziepe.ca>
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>

On Wed, Apr 23, 2025 at 12:21:15PM -0700, jane.chu@oracle.com wrote:

> So this looks like a case of CPU cache thrashing, but I don't know to fix
> it. Could someone help address the issue?  I'd be happy to help verifying.

I don't know that we can even really fix it if that is the cause.. But
it seems suspect, if you are only doing 2M at a time per CPU core then
that is only 512 struct pages or 32k of data. The GUP process will
have touched all of that if device-dax is not creating folios. So why
did it fall out of the cache?

If it is creating folios then maybe we can improve things by
recovering the folios before adding the pages.

Or is something weird going on like the device-dax is using 1G folios
and all of these pins and checks are sharing and bouncing the same
struct page cache lines?

Can the device-dax implement memfd_pin_folios()?

> The flow of a single test run:
>   1. reserve virtual address space for (61440 * 2MB) via mmap with PROT_NONE
> and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
>   2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the
> reserved virtual address space sequentially to form a continual VA
> space

Like is there any chance that each of these 61440 VMA's is a single
2MB folio from device-dax, or could it be?

IIRC device-dax does could not use folios until 6.15 so I'm assuming
it is not folios even if it is a pmd mapping?

Jason
