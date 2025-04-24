Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F522AE48
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496427; cv=none; b=WJ57wjhYoQ25QYiFO0DdlwYPWoC3krCQx9MgMQBB8b+IKkqsYFkbSjaihAdIcbRz9ArtviBwSwxh+jubIBT5m7xcP6ee/GZiSDVPwD69u2ssl+h8zO3AJhMZmVvyfqLFkCaITrS40PmjLJDhiBnZfYp8z5K5wJsKUWVv7NhIMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496427; c=relaxed/simple;
	bh=nEDDMXWDWQ8vbMZ4RzV5iFaKUbMAXslQJ0AI2qRKz1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly8D1xwhrpK0c4uJvH4jU9KuBpyL0xJMcStPMSNpghKYVEtm2elAaZ6TohKl0sjut7Cr956Z3eFgAGfLxC6UoYmBSWvGJHiT5b8iE0AgNBNgM1MVfnDUXhsGOa0T9KVhrC6GSLMpOn/ixbIH8tqCfnIlqycD5Q8paGOsWm4I9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f7cJVsfp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f7cJVsfp"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8ffa00555so9175716d6.0
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745496424; x=1746101224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6hXpeFv17Go1fQZO2l00KUq0djvqX4j0LhOJE1RpTI=;
        b=f7cJVsfp4HZOCBfgkFOjS8VB5UTPsgQN5/v4PKJJdeYmvMHpeUUjyFBtxq625zmmXj
         k3EsNWrVm4OjvneO9B/ZGxtL/rpaonVPAAjjGFX+l5BRWixEkwxmCTZhWGhVjWXavZvy
         SR/X9vSe8/xbMouYwZ0dwG5aRWBzfCS3VEs2YuNNu7WhqNoJC87NmU1ITldY/q5keuFB
         UocYb0O5T6DZQQAxBy2eHshKKb6ic/dU+u02pKYO63/pAn9VmdibNn0xnBEaWsAUreBJ
         Z1PzPeTOw4bJhhuyXLg188k6/2/iJ0jeryJvUMqbo4ULLvgDt2S3svr6dQXCb60ytHgh
         QMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496424; x=1746101224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6hXpeFv17Go1fQZO2l00KUq0djvqX4j0LhOJE1RpTI=;
        b=rCx7u5mgMdIDSnO+2fGi82ENaR77vhMlbWLoyMhnZNtvGsUuDxfVynCP7teJvPdsaR
         m8ru1TbRAaiKFtSx1zzOMOSxkoV4Wj18UT5I8tsRCvCmQLg4QnhKcpdouDb3MYbV7K2u
         MT0UZgJNPmqiNZTyNPAWgkvYacbZF/kwaK2be5J/l/DjJpfddHDyygOk3jpN+bSCGjW7
         HO1zfaiB8BoAuYkMRUbFPbgWaugJjtDYoxbY2zw0eoY17w2l7hQAHyC8FnRnVixShckf
         4PbDAF9IQj6xMYJ76IOPUJDXrnHzEeerDf01ZAia8l5UkfXY2AYCg2KyX+SP7POW0uhQ
         XKpw==
X-Forwarded-Encrypted: i=1; AJvYcCVFazIvz7ZHH6ZOvbd1NTodQipy8A8NQ3+TqdQANb/IQe+O8ep6mVQ+2fdLA7PYM05ZPDI8nbn7pQCwGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWg2dbYjLgtEXLiTv+ZmpFV65guAnwZH01u2B+IynNFoKx0C9e
	pwc5yGzL7cZh/omWzDQJI713+a+8MABKy5HinhYPYPyNbZiLHSpRkHcjyzAd6qM=
X-Gm-Gg: ASbGncuQ43ChGNU379jsYyXAp25QLGNj77uXaO0LrZAVV+k2r5enMJdfPYwMS0+3UnM
	y+aDNsmMKspgC1UUFkMA54CvZ8fHTQ+PZ4t7bA+Qli5T9qMoOeAz/YWuu9R/dpqdzt8SCUJ0USy
	yIGi0nGw+E2Sb+Un3tIfp5ScmTP3fJ0pa3cn7NvGrvVIhUs4EuvoipzkrE1Tv+sOFJIdL/JAx5P
	hXJFmoiII17F68rUTAG71W9pTCp2Pa6+VG+YgwsUK7SemiLqhFoTuxFpfHAhL1e2JOkek8mMf8r
	OetGwtANIPr8iVMYee5XacHBGnqd9JmSm90ZEruJ5X4DcNykrrpwfdRHcEvf7BOVkQAs0ivTWhU
	Iz921EYOqXyKQFa4oM64=
X-Google-Smtp-Source: AGHT+IHFhKOxhA0o2WRAa+GJNDxvcX1iIXnEJwZa2QwM9rbiZA2VutZzFm82YY72gKJwza388e3Bog==
X-Received: by 2002:a05:6214:518c:b0:6e6:65a6:79a4 with SMTP id 6a1803df08f44-6f4bfc85415mr35084026d6.44.1745496424198;
        Thu, 24 Apr 2025 05:07:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aae668sm8460536d6.113.2025.04.24.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:07:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7vM7-00000007TSP-0PWP;
	Thu, 24 Apr 2025 09:07:03 -0300
Date: Thu, 24 Apr 2025 09:07:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250424120703.GY1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
 <20250423181706.GT1213339@ziepe.ca>
 <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
 <20250423233335.GW1213339@ziepe.ca>
 <20250424080744.GP48485@unreal>
 <20250424081101.GA22989@lst.de>
 <20250424084626.GQ48485@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424084626.GQ48485@unreal>

On Thu, Apr 24, 2025 at 11:46:26AM +0300, Leon Romanovsky wrote:
> On Thu, Apr 24, 2025 at 10:11:01AM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 24, 2025 at 11:07:44AM +0300, Leon Romanovsky wrote:
> > > > I see, so yes order occupies 5 bits [-4,-5,-6,-7,-8] and the
> > > > DMA_MAPPED overlaps, it should be 9 not 7 because of the backwardness.
> > > 
> > > Thanks for the fix.
> > 
> > Maybe we can use the chance to make the scheme less fragile?  i.e.
> > put flags in the high bits and derive the first valid bit from the
> > pfn order?
>
> It can be done too. This is what I got:

Use genmask:

enum hmm_pfn_flags {
	HMM_FLAGS_START = BITS_PER_LONG - PAGE_SHIFT,
	HMM_PFN_FLAGS = GENMASK(BITS_PER_LONG - 1, HMM_FLAGS_START),

	/* Output fields and flags */
	HMM_PFN_VALID = 1UL << HMM_FLAGS_START + 0,
	HMM_PFN_WRITE = 1UL << HMM_FLAGS_START + 1,
	HMM_PFN_ERROR = 1UL << HMM_FLAGS_START + 2,
	HMM_PFN_ORDER_MASK = GENMASK(HMM_FLAGS_START + 7, HMM_FLAGS_START + 3),

	/* Input flags */
	HMM_PFN_REQ_FAULT = HMM_PFN_VALID,
	HMM_PFN_REQ_WRITE = HMM_PFN_WRITE,
};

Jason
