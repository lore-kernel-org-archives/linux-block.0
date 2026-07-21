Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1C415F16
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656268; cv=pass; b=O7rR85pHiUsCmAxEkEPdbxBtSWLbk38xchjDpj4551F2NkbHaDeMGKzOWw/tN5fs2cnD1q1HRPjxJ2aRtZf+DPAHfgVW3a8ijkSAP56vvnQ+wgYL3hwxFyKHeFJ3oFyBp3r1nCw/v0Y8FV/1u3Qh5SmdILcm/F+vrcU7n/4QKX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656268; c=relaxed/simple;
	bh=fk82OUiWTbfj+Bj8rJw44IZWjsVv95l8951dHoMMtw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU8HGdxbHFipaR7DSz4+0I1OHl+LLL9h+b6crfLUsgb83iFMQDndu47RDUw1lEiZPSiDpIbCjbLiBORYD6OZx0t5MNANkPw1Yy9tUypKvNKUncO4GNS8zvh6+Y05zQlXmgGuY3ZM2YhHc7lTm5dg1wGKMYaWe1z2YIoujXCvZMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=B2YpB9l1; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="B2YpB9l1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38759bcd877so10392655a91.2
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 10:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784656266; cv=none;
        d=google.com; s=arc-20260327;
        b=ZQ8Gfshpn+33bkuEW24i9u2eIFTHKA/xc0Nyo8qbr1HOxA2VRAmxa7LY2MhB3KYyiW
         qLH8QJF0M54Et/0tskBOJWVHuZrTQiiLeq0OQpifK+2EjisvVX0ulFj5SN8n8Q0RJWjU
         tJKueWDm74rnhRtQwP+xFuuAx0eY31Xxp54zmjO9TXwhEKqFQFVgN0+SqXllhB0WUtoQ
         5/fNBEcfEO+pXPkyr/YOcGpjw/3QtDiHsQaWqd5s9xk/Zna6o+IQxg/9drr2Fd5dU11m
         A5YGqVazORboieRAXU3ixCVESoUWXxd+j2DW7zUK6xKW4POKwdLaK7VQuTDgwCKxVj3p
         bIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=;
        fh=NaFzFx74akd+tsPFsw4KBPP3WIONlC1FDmh36VOWKVE=;
        b=YGVwhPAANC+qbgawc5wWh9e4hs0dN5IZu2PNBY4dXqLk++h9biaJ+GFINaOhYrtxNJ
         MQJ8KbukLI61qavbPc52BzGH9rDwbKz6et+8y1NChkhxdIZbFcSTpeRBZqV66Cm1RFWP
         xte8pYWkweUdvMFwVN3ZClSeTLS5mtRsAsYIsGKVTv/8Q6b8gSwafTtXW9un1vQhWtpY
         Yj1e87Ng4vjEDrdLgTRVx6yakWgXJOAxL6zoXTwDyzvFCdx3y/zRALrOBCERQD6m6ey2
         jSG3BRO62NO8GdnIBtwyvm4VvWZ/82DzDkaXi/L4kUU4YsMX6QAY1JGiRvPXiGwX+ddK
         q1Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784656266; x=1785261066; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=;
        b=B2YpB9l1/TObhAYO5TnNeLkPfQxNXrt4FLbJyfF4b6YsB+3mtpbrLC451fbUEPr63Q
         NGNBLAOy40rqXGxxjmU5vU/QmC+jmwpBDFL6ttXHav+6+8uSI1bxu2+SDcUQKocYcmeU
         76hn3dxT5HBpSSNFeebJZejdZ4Of6NVZvekz3E/0JEmzyUg1uVZOoqWE3ozRZIz7Yw/g
         aV4g00IZWHMy1bMsdWmPSGpXeuw4SbTJR+fwdbgnVoKtSm6mjyNQNMkQF2BdW73TrjIE
         HHlteqCJSX2KsaZYaghGCnm4F7hyNlV4rp1cwqBvLgVdBAGiQxXY+zV1e3E7rOuSt15t
         wBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656266; x=1785261066;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=;
        b=otoigTfE1da1Vj9jKz75J4UZ9Jk7Pikwe5sUGgR8JLLP/z2RY8PNdVErJ4h2nB+GRb
         7wU+jnLyPuOk9/ShDyP4ZaIpPBlOMszWURzuIX+IfKothd3Y7CWof6SRv0LTQ6dq/vhv
         Decu5A542rZHQDOtutwfsz99pV3PwnkYwdL/NSp0TmG+zUao8s18Y44B8U2diFhZ5sEf
         nvjAk7eCVDL9SBJAOrP4oWqEKbckIGjNJzTlHrlSTDKOhK5H8SylP6wpIMhjFAILx3e+
         Ne2ajfm3efF0iaHaqiu9etTYWZfA8q+qd6sNaE2koaMGnEU8hSHBe/kXTvpHVtUPs1Zi
         pExw==
X-Forwarded-Encrypted: i=1; AHgh+RpF4AGERAA0ZsdobKzSzl+2KL8XLabWA1/N2GkfLoAlb/ItZ6FXYaGFRHPKgPIHvBIlHV++psaJ2ZT9+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwnZwIt525KkZ+lJGMaqqPR18AJQP4CMsHz/ZzRKTFqFVFiA7
	VtvGYP4hRrkymCCVbJSXPtOLfpAEqRVdwKPUJdyjiQbYY62bnKvDxDF+Ug1VgoabtsEB8w/UW/+
	OZ+vItSz7f0eMbXfmcDgOm4lRQ7RZfJW57IMmFAJJ
X-Gm-Gg: AR+sD115OYEirXEun5nU60QxYkXBZgYY4Xaw3BDhyoIzGSVRFbUeevOF6RnK6Iv6x4m
	YIC7ISuoJptMwceKEpErFAA3AilrlpYpi+yaOY6gRvAuNrdQ7dgogi46RIFuYeUWpudH0R7QwTJ
	2HMhrOFh6xyw2BR/4gyRTd1Un6zPxQ5eSH+UJ6SkTWe/IT6O0krf1zzsjcCatjM9UmbrFMy11Tw
	z3ofEJo+1dRMmRPixmSICGFLA5fELaoxhbjKdqRft57VkgzEZcvEzOO8IV/hBLkPqZOzOUxm4IQ
	kt7cuCBqaneOZu18z+/pBWl28Cad2twt0HiS+rWgJWw=
X-Received: by 2002:a17:90b:2e90:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-38e4b43c408mr19724564a91.8.1784656266239; Tue, 21 Jul 2026
 10:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
In-Reply-To: <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Tue, 21 Jul 2026 19:50:54 +0200
X-Gm-Features: AUfX_mys0lIoq4Q-xmicA-5OIV7AmcAZv6tYBswRu-bPoovrkHLh5N1N3P5Onu0
Message-ID: <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks you!

On 2026-07-20 10:49, Logan Gunthorpe wrote:
> My eyes glazed over a bit. But one point is that maybe this could be
> split into multiple patches: one patch introduces R1BIO_P2PDMA, one
> patch for raid1 and another patch for raid10? That might make it a bit
> more manageable.

I have split it in v3 into a raid1 patch and a raid10 patch.
I am not sure about separate "introduce the bit" patches.
R1BIO_P2PDMA and R10BIO_P2PDMA are entries in the two personalities'
with own r*bio state enums.
The commit messages are shorter now.

> Also, I'm not sure if it's possible without digging deeper but, instead
> of adding a !p2pdma_unmappable check to every if() statement in the
> raid*_end_write_request() functions, might it be possible to factor out
> a helper function and return early from it?

An early return doesn't work here: on a mapping failure the
function must still fall through to set R1BIO_WriteError, so the
completion path runs the (single, whole-range) retry and records
the bad range -- only WantReplacement and the FailFast md_error()
are skipped.  v3 folds the two tests into one branch now,
which reads better and keeps the fall-through. Please check v3.

> Maybe the helper could be
> shared between raid10 and raid1 as they look very similar. The
> differences between the two are minimal -- there might be a bug fix that
> was applied to one that should be applied to both?

I compared the two sides after splitting: the P2PDMA handling is
symmetric, and the remaining differences are pre-existing
personality differences rather than missed fixes.
A shared helper would be heavier than the two open-coded branches,
so I kept it per-personality.

Mykola
