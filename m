Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF24221FAE
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496108; cv=none; b=TdJ9JsbCSr+ddb0RY19on2uGa1JrF661vq0er1gr7GuCRODYL+HqRxYJ7fonKE6adeb6+bwj/c93Rk0WmCDcWEnwj7zLpCEuOeClZMSP6FwRQuwZLPZx0MwafDdQcynGgfHl9gOrLzX0GxFDmm8aBV6COpp3XJdESwepBI1kxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496108; c=relaxed/simple;
	bh=t4m1Gy9zsGjSppvDn/a5XRWg7SvRp/w7DgqplM900q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLyhVhGYM2H+RZ6uaug2HZulH2M7iDnTaId7IGalLKWIifVc58RWPsEMTZ3RizXQOKTHy6OuOf330ERqiuC6bu8xMOs/kyBgbkcp+lWMCkRelogT+O4mtcxwN0lGdxXy3yI28IXRDh4pI0c7Zy4verH3PnrkF49n11Qnnn0J8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mL54jm9M; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mL54jm9M"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso9648706d6.1
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745496105; x=1746100905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZL+E3RNHbpFWOEVEZ+vdGqOh3AavrEOxiuPbcP0VN0=;
        b=mL54jm9MipqZ/go/LHdmqJ9r7pUIZQdAXLW1m+lC+JRETYnPFv6f6FWwkTBBNK9keN
         IbRXkDkcfMSZMzZnxqbpHiqEhUY8C8EWvs4t09PkgUUt7TvmgHFyOhAs/JIhGj6xW9ij
         HelnhQXrAtkhfws/E7z5ouE8XNB68fgK1gGrE6Cl5joljljzhaT1bjFfkWJtMM9o40y/
         kyvVPsVGufx8Jkj4q6WTJI/p+HHH9EFbDkts1ixEwrkjidi2wiDBkOM1fG6EMzAXOsUU
         wsC+H5Wb7Zcb2i4Q6WXsvYkif+kmEMdAF5cpBf7hOzkomnR/h0ZX7pDpP74TibpZl2cA
         jN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496105; x=1746100905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZL+E3RNHbpFWOEVEZ+vdGqOh3AavrEOxiuPbcP0VN0=;
        b=CsyudtvE5MpAXt+cVkkCDw7IS4FGRdXOdjivjBbh3zWMPqfJaipS0HBoX3rRycQO9L
         NDPeoQujfTtPIdMfpj2intE3lCzbrymrolDz2ia6cVhlHxdbUjFHdrdPAP0ZJBofdjmF
         8boFvrAaZfDiy5GC7mH8sEjfqetn+S0Cp11bpT2DZmIZVia422HIGHqeTr+2oynQqT+H
         R1Fe78KrLLRzmeRECO2DF5LkDtsoVh0dFNT3jCnDASjTicTJzLf4UDG0+A9owL/1cGOi
         D/9tzU06X9NEGH7Ia+UVaoJRdFV8Poz4PoG52T50WIcjfPHXC0xOsdH2sLMaPZF/frG3
         iTQw==
X-Forwarded-Encrypted: i=1; AJvYcCVFO05jrzz2JE5jjvZiIgTQq9epqmq8YP0dY4NplBN2HLHhu2ZDwrtJwaWBcvuzwb7H8qWHQFJLOw1nSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwql/eGEL1aAzdSsphpPbR6ffLkOYPzt/g59XeWgqvUXYA2F4
	aq8ShjAWK1wox2r6LW7yE8SC7ILb9y5uJIe3c43YfMtyF7RY+wKX4EbJe5oRMC4=
X-Gm-Gg: ASbGnctGnUoAsJFK2uj6MwgU8tXWG1FBGzrTBs3ViB6eyMJc1ZhzPJoiO2jz2hOr+Gf
	In7PC5vfvW0/XBz35JivXXmBnyTTaJwDbA1CmDWqTtclbmim+RQqrvODGfc3eYefe8HqOgAjbDF
	SrQpL/g0YbfBID9sxXi3I1fv7THcw7Htym6ApG4skOWOqaqduhXVM54iVzs9A2lnpZxhTLUhBNv
	EpImD96doBYM81gUui1zMibaVY0XbmYJZ/DPgQyUiPcB8Y8Xx4P0VJ/1ZTRUo+dtmnBgL+ZNfCD
	QYED3pyRv/CF91t+yuvUxmLxYJyyi1VVUPKlqBZ6UkNt9rgVVqO6tRdQLCz4lTBMG6mCpBcSbLb
	rBX0FjWFSsjViyIUY7E0=
X-Google-Smtp-Source: AGHT+IExjEYw2YciNBoIdkd9/pqHrN50d+y5G+B8wJfJbAXK4p9NBvT5uybfEubjkC+mcuj7maAkHA==
X-Received: by 2002:a05:6214:d02:b0:6f2:d260:b2f4 with SMTP id 6a1803df08f44-6f4bfc95a23mr43959916d6.37.1745496104857;
        Thu, 24 Apr 2025 05:01:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c093870bsm8528646d6.45.2025.04.24.05.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:01:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7vGx-00000007T99-2aD0;
	Thu, 24 Apr 2025 09:01:43 -0300
Date: Thu, 24 Apr 2025 09:01:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jane.chu@oracle.com
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
	willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
Message-ID: <20250424120143.GX1213339@ziepe.ca>
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
 <20250423232828.GV1213339@ziepe.ca>
 <84867704-1b25-422a-8c56-6422a2ef50a9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84867704-1b25-422a-8c56-6422a2ef50a9@oracle.com>

On Wed, Apr 23, 2025 at 10:35:06PM -0700, jane.chu@oracle.com wrote:
> 
> On 4/23/2025 4:28 PM, Jason Gunthorpe wrote:
> > > The flow of a single test run:
> > >    1. reserve virtual address space for (61440 * 2MB) via mmap with PROT_NONE
> > > and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
> > >    2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the
> > > reserved virtual address space sequentially to form a continual VA
> > > space
> > Like is there any chance that each of these 61440 VMA's is a single
> > 2MB folio from device-dax, or could it be?
> > 
> > IIRC device-dax does could not use folios until 6.15 so I'm assuming
> > it is not folios even if it is a pmd mapping?
> 
> I just ran the mr registration stress test in 6.15-rc3, much better!
> 
> What's changed?  is it folio for device-dax?  none of the code in
> ib_umem_get() has changed though, it still loops through 'npages' doing

I don't know, it is kind of strange that it changed. If device-dax is
now using folios then it does change the access pattern to the struct
page array somewhat, especially it moves all the writes to the head
page of the 2MB section which maybe impacts the the caching?

Jason
