Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7C28B50A
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428557; cv=none; b=LAXgtHZbCdBv3000PfYUJ5F22jrGn5Towzdj3AJenL2ddm66GRczNbWgTvGz/jhkoeAAycNMD4zk4roUaak+8TRWKtPRtEVJRL2HiPJZoVS/Dqr1VKWBvWPAaj4M2cYuDhji6k1OY5VBJLk/PEGMw3JVL29+cM+eylccwD7pBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428557; c=relaxed/simple;
	bh=vMXucndq2S6GHUftC4QAjKIvCRBxtQ3mQadyEEn05iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on30cp1LYW3RdJXvGBsQTHiVuxJLM1z6yzIHGVA4tkBjMcaNQSe0BhvW49oDaDAH/COBJHD2oRaYGCekLTxtavjOhgJZxLjRmZJKcpNSlfU8XvCRWF1Psf0LBO4cp97eUY5MFqTKXUWj9LCNkMNhYoXoC6MQcpqcincKjf/TOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=igc8GuoA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="igc8GuoA"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c560c55bc1so5671385a.1
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428555; x=1746033355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=igc8GuoAzkxq23x3zTwtP5oibqkeQg53VG0Iq7gad/MlX8rlFoaVwdhQ0apeqpKH2h
         U63IQo5nrNVr/aYRLNtMYNdCv4gydkVivRxSKp9R7pa6wsgSApmCtQMmO9kL+FNLuCYl
         X/+CooWu7xCeo0ATpiDWk+fOrcm0n3wgS7PLKA/bTH1rXQkbm6fbMji0uJQNUxm58yoB
         Rqu6j7oRTifpHPPn+9M3hN6fwsO7KeVdJS2pUvi/LGbn6oETIDds/1hWRCeug9xrcImW
         WzY6PYLDgjbbO+z5bnOFm9GEuBEpX2dZ4T7e+CqVXT1fnIfwTIv3FZayq4iQBioe8nnf
         CfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428555; x=1746033355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=nVs2mybj6pZATVjEQdH8aWhXSyrKxgJZu5uwWEN9a717FmMfdLhT9sibm+e3YUHPIY
         mqnFIDkdOIVl6cD/qUV2uydWuCFm49meOeWV1xXpwOoODGNWdk8gpvuT/ije7BvTJ+m5
         GRnHojTtGS9vniCcAbG90Mcrodi23DIyUn7Cb7UItwMVHLOjRNDIWlbAYfsYTcgd65DZ
         oYUsZC4IxAtnrbjdi4r38vvYpz7NyzZBICXZE+u8ICXdUfQqrEP52GahSuZ+y+vyS4EV
         w7NWMZtsNc38sSQIKF377vpik5ApgnmcyFYXzc9y/1S/3jdYP/K2QQEhWvOaf3eaCD10
         BqQg==
X-Forwarded-Encrypted: i=1; AJvYcCW3L0RM+M8kQxjmCWaieEeown/4lxIyGZA8iMhMV0Szt+C3lZKBcKJuZVmd4/kejcfp3SRhZzkPHm7k0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlBBzdBPvyCBSyipnT+QmiUwpechGImnw6Nq3fmC7ehjsQfl8
	N2NY5p5utxoOQfjfAuTgez3sit1CBDNLsoKVZnP+DyR9aWEod5TpXZYC8uAWSFI=
X-Gm-Gg: ASbGncvt9BeJKN3d1P0XBN3WQhqO0KSn8LTAbTQvg8w0N4B79PPuOVjNbX2ZVs7uUue
	4Z51I3T6Wd08ZZPO7/Vo7rkEt3sLeOcY5Xqze9hIfYWy4U9UWMoyN+oedM25PNBgmAv1NKWoy85
	Vd/Mf0LAfuvYbLqyTftgM4dETpQ1N4cdopM52aV92/lOJY5IFN/gDgSNVHq89ovotq51Ukz/g6c
	8TEmSK1WACEXJ8fu0lTA1dcAAG3oIZssnvds5J/JcVA+p2Dxt5P0lc6dwyxv2QBWTaBgnbgjwDt
	QeYGUCNqzbHGPeW8XMNjJAzmfQkCMMa/YszZnaOl/XBTgkPeawHP12UEdpPFa9qzsLjeV0h2GZI
	8T4CTn8ZdXr8+PvvMftI=
X-Google-Smtp-Source: AGHT+IHusnUQ6QwwVsDnvg+0qYOM6lcQLPltCEX7WmRgNJP3vwJodfip7PxZnn5pgy7BG5cQ6pnE/Q==
X-Received: by 2002:a05:620a:4456:b0:7c7:a5e1:f204 with SMTP id af79cd13be357-7c955e14768mr54555485a.56.1745428554903;
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4e93asm705867885a.70.2025.04.23.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dhR-00000007LQy-3kud;
	Wed, 23 Apr 2025 14:15:53 -0300
Date: Wed, 23 Apr 2025 14:15:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
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
Subject: Re: [PATCH v9 04/24] iommu: add kernel-doc for iommu_unmap_fast
Message-ID: <20250423171553.GK1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:12:55AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add kernel-doc section for iommu_unmap_fast to document existing
> limitation of underlying functions which can't split individual ranges.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
