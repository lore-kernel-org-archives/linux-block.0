Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8E2737E0
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162773; cv=none; b=Rwsc45X4wjwJ19g0ZfmHsSD396Dv2M8z7lZw88eck+tuh6I9ClNkMYNqq+vuLNCbN4EMOTk75sMM1PfhUBGYVY7q4RiZOU7nraVfyx0ljL1mog9/9k6F6GTCyFcRKI3Bo9jYSYEkDds5l5qQOBlIEJ545/xIi1EzwOwAL6EP7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162773; c=relaxed/simple;
	bh=Jo1hwBQ1OAKjPw3AJMr/P9Kbq4e9sCgCina51O06nNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=finB+m5AvrhPK93QVwXEehGxz1JtKFJvslV8S+Vs8wtwVZBfr2nEpc5Yw9qLIKf5r7utxJTBrEsoA223ym5J6YNB6pwUsjgE1FPVnMv12BUob7xmc2nVAGXiATaUBAYmYEnIFDDcJ5MXcfWJRplJbrp/B3w1GjDsrJEvxSf4SGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNffL5KT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNffL5KT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2980343d9d1so158365ad.1
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 05:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764162770; x=1764767570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7j/p6bUr5Xuh7DTD99aQLTt37H/gN4j/r6C1+HVuuw=;
        b=dNffL5KTXy9vmcr7Dvl9zEXcTnC1oet8hlQpSQcJkPBVCZzGG6coWdrCyxxnWQtK3l
         Xhv3sYAtIl4jfSNszMDmJvkCrdHCcevlkaEE3+QKISZnkNh239hTj091qTKAeLRvIzej
         oMcow5HB11eBD3t4BHi+XiGHi+4k9hU+tLW+BxjKSrpjVziaFbx6vybuWcSsannc//Wk
         SiJn7azY6uCF6D0FNRoIRbztuq0QXQ9ZEYRwC4l47yoqw54dRJDAX77jE/MxAIAgl0tT
         dypc0gwY/OKSAKJRoOL5J4+x7Jb4hVOS8QGdL8QndejcmzHeVZVyI1bgusnEHVdhZkVd
         jOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162770; x=1764767570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7j/p6bUr5Xuh7DTD99aQLTt37H/gN4j/r6C1+HVuuw=;
        b=epz8Ut8YnYaLw/ZNtCDDcr1P6Z/39iZ3/U8SxxQutQOlVlAkTXF8X09uN42lfR136r
         JRHC8B2IR22sU54lfuEFr/IwMVq9lQkiqITyiwk+f3W6bTXCYkjMEaWRBjcWHk4DWvuX
         7MdyjGhwLcBJFk7Yke3vhTbz7mByFd8PMYfUMI7QdylbEcpmHP7U3LUHJfBexZGZZiCg
         KirvZAMA7qOwyG+SQBDGgDZ6VFF0shqbvBkbKm8IBgst4FBpE3PsyP0tZswOvD9IwyMD
         nxnmv3/YUK2TpN3AFfA5UPN+5Bh6/qLO8+IqcqQvSbaGsL+9wGHX5m7HZn+Pinrc14jq
         IuQw==
X-Forwarded-Encrypted: i=1; AJvYcCUGTTOBYKRQr0UWJxIfm411FxFxvZX4PYFscgs9P90cxVQRkK0ob2Cl3NVuDGQ+5me3dBMj1ClEZ6XKKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YznAL/7+HWPGupg1inYhFsNJCbLKldFQErCY/3ywegOZI2GEIX7
	OTx4vA9KFuMVvVuxUSA7nnUhMXwRFfL7hbluVXJ/zQW/Fx/8cK9o0pDK1/QLvj6h0A==
X-Gm-Gg: ASbGnctwsIxL/+6ezFAe9skH7Iju7Lp50sWWrteakp2ShMzKAmfnROuFz/rcBLJuuJW
	8Mwe7tmWONVRJCguvcmAEkB0U8WH7OsgCQoPpVmU6maCGZW1+9rIokSUS/c6Zc8WuTzs4d2crZH
	HwsixD7F+pJGOHcx+G3qw18I3Rn2WR5cycLw8Ie5I/znq97CS6oc8zyaae4kqEmP+NkT52m37LL
	d2X0oItV/RQdFJQ6/Il5/woshpqcd9HEt825Pl20JkcZA50ajGL64MWmyGnI+iBhJQSM8AV/O3X
	DBMPpeyyFrftH3zb9EZXQpKpTTHy8Cv2tAzSX3STbYjrecueuBP71q/vgXINQAGEeeVhrIN4I1g
	eKLDV8ySPZC49MJ8JstLZ708ZdYx6aiiljkWAzKAEicQMNqpbzhk5NolE7v5IidHKE5pW5cxRE6
	n+LfacFWWHil799SUEXLyzlmYoACgQd7hRehJo36R3kStlFFC3
X-Google-Smtp-Source: AGHT+IHJIOBgKlL+CS0ZpKtYX5Djx07PEo4PrDI8k+TVBWbcqpi0p7MakMMReKQUlItaKRJKERuBaA==
X-Received: by 2002:a17:902:cf07:b0:26d:72f8:8cfa with SMTP id d9443c01a7336-29bba9e8a00mr1709325ad.13.1764162769984;
        Wed, 26 Nov 2025 05:12:49 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b105e4csm194769895ad.2.2025.11.26.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:12:49 -0800 (PST)
Date: Wed, 26 Nov 2025 13:12:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v9 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <aSb8yH6fSlwk1oZZ@google.com>
References: <20251120-dmabuf-vfio-v9-0-d7f71607f371@nvidia.com>
 <20251120-dmabuf-vfio-v9-6-d7f71607f371@nvidia.com>
 <aSZHO6otK0Heh+Qj@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSZHO6otK0Heh+Qj@devgpu015.cco6.facebook.com>

On Tue, Nov 25, 2025 at 04:18:03PM -0800, Alex Mastro wrote:
> On Thu, Nov 20, 2025 at 11:28:25AM +0200, Leon Romanovsky wrote:
> > +static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
> > +					 dma_addr_t addr)
> > +{
> > +	unsigned int len, nents;
> > +	int i;
> > +
> > +	nents = DIV_ROUND_UP(length, UINT_MAX);
> > +	for (i = 0; i < nents; i++) {
> > +		len = min_t(size_t, length, UINT_MAX);
> > +		length -= len;
> > +		/*
> > +		 * DMABUF abuses scatterlist to create a scatterlist
> > +		 * that does not have any CPU list, only the DMA list.
> > +		 * Always set the page related values to NULL to ensure
> > +		 * importers can't use it. The phys_addr based DMA API
> > +		 * does not require the CPU list for mapping or unmapping.
> > +		 */
> > +		sg_set_page(sgl, NULL, 0, 0);
> > +		sg_dma_address(sgl) = addr + i * UINT_MAX;
> 
> (i * UINT_MAX) happens in 32-bit before being promoted to dma_addr_t for
> addition with addr. Overflows for i >=2 when length >= 8 GiB. Needs a cast:
> 
> 		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
> 
> Discovered this while debugging why dma-buf import was failing for
> an 8 GiB dma-buf using my earlier toy program [1]. It was surfaced by
> ib_umem_find_best_pgsz() returning 0 due to malformed scatterlist, which bubbles
> up as an EINVAL.
>

Thanks a lot for testing & reporting this!

However, I believe the casting approach is a little fragile (and
potentially prone to issues depending on how dma_addr_t is sized on
different platforms). Thus, approaching this with accumulation seems
better as it avoids the multiplication logic entirely, maybe something
like the following (untested) diff ?

--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -252,14 +252,14 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
 		len = min_t(size_t, length, UINT_MAX);
-		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
 		 * that does not have any CPU list, only the DMA list.
 		 * Always set the page related values to NULL to ensure
 		 * importers can't use it. The phys_addr based DMA API
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + i * UINT_MAX;
+		sg_dma_address(sgl) = addr;
 		sg_dma_len(sgl) = len;
+
+		addr += len;
+		length -= len;
 		sgl = sg_next(sgl);
 	}

Thanks,
Praan
