Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154233067D
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149114; cv=none; b=Hh00PaRmvefyPqTKSGs59t5cwf0MXcWC5mo5DVPyiNgYAaRqavixJLkokWtytcvYmTpAQey04W58/kAfeUjmC/cjSIrOgCEWrSoTmuvodYFOTHlV0aUp334379MHiZkJtfQb4T0waQSENGA4BTAFo7Q/8Hr4Dbdrv/RVnKVi1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149114; c=relaxed/simple;
	bh=uC7aiyhuUJUmZaGZ1u66NknKDlFxu+Nn2BkTPOoqtQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huefNKOwW1ha5CjcPwx6h4qb2OSkASRIMGPnDExCeCEPqz7x614oSnXJIFl0ZXxceFUWrC/SQXHBMiqRKOeLXzSbIMQPayM/zjXkl0Ap9i4uMWkrDY715hYis0+cLVwUtfEEANDh5IOJGk4CtP0I1IJTuo3Y50h9a8mzuil7u3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPESGMYc; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPESGMYc"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-126ea4e9697so1629c88.1
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 15:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772149112; x=1772753912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6aVatOQZhnn3/l3DG/K29SIadSoM5JJykVYfBXclQE=;
        b=DPESGMYcqw7kqD31vMzSdAkOIV5l+tlRHGE4vbTrNKTPRVfUDpNn5bxNk6Q/VtogW+
         b66wK33FtjHxY9g7MLThM6/FsZI5xQNcXElTIqupYFIt3Hb78olS9AGpRRkz2ZDXKWU8
         J6kOF32riDkjHn7hBdvM3T+eQ9X/jUJ2hLrgN5Ox8Iuvx9B5ub+BX6h5ufaH2RCnMwqS
         yt2z6+IzLmul/d96bcVPYtSfbr8GI+xCrAZp5wWZhLWNHnpQHuJZcUiorznaBAHt9j9m
         M8IdzqRJnJnDpie8QNvz25ySYymWkILXYYwYG+9k3NQsGUvVjG/34iejDMkxnb14tgDk
         rmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149112; x=1772753912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6aVatOQZhnn3/l3DG/K29SIadSoM5JJykVYfBXclQE=;
        b=MpsUHOwh1+Dx/I1dzRCkABDbEZHWt5QwZXkkSNaKVTdKpl6e7KqZfZe0XBoyIPxuUy
         7gLdDsoRBBeN/Nj/7lIYRVXRqX6Q+QNnoqFaGvbt7PCJo9Bp0jLlo4R02gbi30VzNGMx
         sv5phQ6R6NqwWfqJuXfgwxNbaFdahH5VSGidPqUg1dX2DKFB+bnzATbWn7NMnyypTjz1
         uEaxfRt9bMiby/GHjPVOUKFhMBbf1/62TyT8OW7Ka8gNegyRjiavMB6kXckYX0ISEjYy
         nelfhh1eaqLYWSK9C4MWgwRqEplKXzVhMNOdJKtQnLCSFOj0Jckrx3Zt0MozjBHZ7ci6
         Gu2g==
X-Gm-Message-State: AOJu0YzKZzxz713uPaD9Pygtswp3JDAgbutxQA6Jao36M1L+kYPaibAN
	PmKivb3O0J3atikmKxeCIfusK9u/PrKbLGnm1BfmLPyRD3QLpqAv+KoiOTaMhfI7/LEZTy2KBSt
	VxQvnAEPx
X-Gm-Gg: ATEYQzyme53EgBFxASVklDe8UGWmiGEeH3lCEYvO5//18mIcHVBBJyNSchQp5c65KXM
	/6wdz0aXp3Ug1IYwj2QAqWL19T7qAJpoGFnRT6zrfOP7DE0lx0x1jbdjnb1NvNP9tmLgixW996c
	Wi/RdIVCS6HKUJLFNYbB7CsA4GrrSkBDdrGESrg8ppPedxSKJ4qJJvpEx/UMo8A739jNSyHL4uR
	bVubghsxr+rlRQyHFPk4RFQrtHqdVUruKoAcXf7bnKqYqnjBVyt0nqO0P4mrBlZcDKotf3D80Uh
	PHEwqRMjLJwDSrwQ3jB+VESUhqKfJ7IZf8m6UcpGlwnqWT70refxMxXx7lru4v4Ufo/DA8rJ0vb
	XRw19dsAUkTM2kFE1NKMsn6CLmXq7aCoc1ydk3sEXl63Lnzt/8dp5F5q9r3OhnKJbgZZ/PC4cEL
	UGn+XdXLbp8d9FM0x4NIGDaf3f75HsBItsnzsaLzIfqt8lZ5Ymc3SLPWp6FK7com74
X-Received: by 2002:a05:7022:f10b:b0:119:e55a:8091 with SMTP id a92af1059eb24-12788fe0b17mr248037c88.14.1772149111311;
        Thu, 26 Feb 2026 15:38:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2e51:8:d9de:6ece:634a:85ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c3csm3225980eec.17.2026.02.26.15.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:38:30 -0800 (PST)
Date: Thu, 26 Feb 2026 15:38:25 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Gohad, Tushar" <tushar.gohad@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Message-ID: <aaDZcZCwIqTrE7Z1@google.com>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>

On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
> Good day everyone,
> 
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.
> 
> The proposal consists of two parts. The first is a small in-kernel
> framework that allows a dma-buf to be registered against a given file
> and returns an object representing a DMA mapping. The actual mapping
> creation is delegated to the target subsystem (e.g. NVMe). This
> abstraction centralises request accounting, mapping management, dynamic
> recreation, etc. The resulting mapping object is passed through the I/O
> stack via a new iov_iter type.
> 
> As for the user API, a dma-buf is installed as an io_uring registered
> buffer for a specific file. Once registered, the buffer can be used by
> read / write io_uring requests as normal. io_uring will enforce that the
> buffer is only used with "compatible files", which is for now restricted
> to the target registration file, but will be expanded in the future.
> Notably, io_uring is a consumer of the framework rather than a
> dependency, and the infrastructure can be reused.
> 
> It took a couple of iterations on the list to get it to the current
> design, v2 of the series can be looked up at [1], which implements the
> infrastructure and initial wiring for NVMe. It slightly diverges from
> the description above, as some of the framework bits are block specific,
> and I'll be working on refining that and simplifying some of the
> interfaces for v3. A good chunk of block handling is based on prior work
> from Keith that was pre DMA mapping buffers [2].
> 
> Tushar was helping and mention he got good numbers for P2P transfers
> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
> previously reported encouraging results for system memory backed
> dma-buf for optimising IOMMU overhead, quoting Anuj:
> 
> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS
> 
> [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/
> [2] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/
> -- 
> Pavel Begunkov

Hello,

Thanks for sharing this, I am interested in this topic. The io_uring
bit specifically, as it might be helpful for a usecase in Android
for loading a file into a dmabuf.

Thanks,
Isaac
