Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543339CD13
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746798; cv=pass; b=Qbta4qmrNuan3z/xwpXNRX80tuN6SEKWzsQANjiEqEHC5be56D5TXFWjsQLYGTiBT8+20hHvatUBlBWnDlqS9uI/RkjTTnt7+hSp02QY52/6D0xsHCenimKrburSADO1Nl0NunXYh4IEul00y5uG6ygo3TkDEa/36eKGeHwTXQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746798; c=relaxed/simple;
	bh=OR8lGDmhaAeDCR6cUrkUghEFDERBizZRwyMQlhX/9RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf4/NOMdTjB+SXVzP0/ijrUHJyRVn78CM6mTQzelQG2ei8nMMnNoj3vSvgr3jORzvFe/DcSffO8vdUbLp/XvazaT1yn9qR2w19tIiOll2McLG01OBmpCt6KO0KrvFlLZlrvCOBSf51wtjZcoI9HUYpdVcpnR6T4bPlIytO8q4Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=GZRDblSJ; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="GZRDblSJ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so8401384a12.3
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 11:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784746796; cv=none;
        d=google.com; s=arc-20260327;
        b=UNFWTdaLO63n5IyarboO1a7m14ncUMDT3Khm4dFcM385R0nKBT/IUjNAW9heiSBvJm
         IQfxoIUwvlKYQHI9HgGvCeLVtgiPBbH+UdYx8H/T+n+XoXIjjPDFpytfjoAMiv5+zV4Y
         6f6sfRAfUqo7PeZlTpl0IzmcTWHwMUDsdw8FwmEdwFuhXo/DYxbjnjGMYFWUYxKIGl5f
         I13JTI+7LyPnK2IqXPxcG07TrQqx5LpieZb/3fcZioPInh+sgaTDU3DaLqpa+XcYHt+s
         NQoEFbO1ob3JWa3JC836eiTTqzVCAxv2M/ZXSACebUqHBtqpAieuoq+eybAKVSZideOO
         W8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=;
        fh=pHXnAkvmliBX2Vq7hCvnDVgt3D5x4JqJVoGb49s3n1Q=;
        b=ERvcIWGUc0ANOqqIVvTBZE6V++OsmxVfeYZ3JrLUX5VnK/e8CSBCfvQRKLQOBfudAE
         Or+w/sGJmu0MxhQfbHxIdOAiKYE3lxGfG9FKL/Ff/jTom6dqN4s+pavAel8gJ9pqYRzi
         JkSF9ChXtlOgRNZCNu+NUR9o3e/e0RhUm9nayCQjaASAZyG/LvgMubAP5iRDdYBoIKid
         bTceUgLSqb4xwqLKEq9W4QV3PTB5XWZek9rCZsmHGbAuaLOv+L7DtTsAZVxOW7rTEs8G
         JHVwX+bAAoQf9/NYRaBlnjDsNNdzHPBwItsP7bc8nKRWm0Afp3WSn9x/wo9bIJORapgc
         TPeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746796; x=1785351596; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=;
        b=GZRDblSJxpfkVu9OGLvPcpIF+Kx0S/dsdjtNVu12StBiM7IsmYk0fqos/LFja1aYKI
         tKYDIun9sCkcalPO1n1bkURwucUBbDwX883OP9/S5tABONs5MQanLk+jOr0Q9paXm2iS
         nQi2t2d5DbK3i3t9+McpUf5NlC4diEkR7GQYVe6318h3OWfb8X4rHgEAr/Dt67rw6xQB
         3d8YXlUNTab6GEEdyHMkfxiL03YARUCqOgU+QOuHHyMEeBSdGvwEPF0NeW0l9f8tVjCd
         S2SkWby3p7TMdwgOgvbrjH0sxNwW/CKTnDRF+0yrt5ukgNkMTW+AX9/qX8ZybTy3srwx
         zk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746796; x=1785351596;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=;
        b=j1CqgEhIYbOZgo1CKkzHcDYpLzTLLjUErS2EOtpB4VbrAnw7Cmu73iTxp+1zsTgdhv
         gLHl311uh8xLzY/mBAkEFPWaKFyJkCu69bxKrJ85mVIuWP0T1YXDRiPRblPfZBwUm5mH
         ci5dSqejVGEEs/66Y4kteKHg4XA1ekQ9iLUpZ/YV8Ii8cO75pBR/eKkM5sebgNRR6lss
         +ZC/bExLcWP3r8SSQ7uITURzsLv6llyY6jtOooGbvxnZygiPNksoKolGsHf0XDQPDLab
         X5DdM5yIUMKL9KnJml4CYCZeWycnxdAwRBovIeaZoPvoPfxaXuvrKhwtdtC8qnJ/YhIr
         z+aQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxT0T/sEXTwPZjAyEybCmsv5fJhbnBgDGFohHPSvK35LbiYvQjgsaRY7vyg2tW5hMYopwiRbNJ52bP3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzASCnMmGd02UNggKevb5ZUREEJgWQIETC6ExZBYvTwpJ5jkInR
	Eory4RkOM/MYd+MfdiMW6RgvTP5Q4et59llQLwwYMq3wAL18X+NR7tkGtmynLgACYD2u2kAqu0C
	vMvclOCsbtHuNMCd/vgNvYmaeu5QM6CY/81bm6Y4u
X-Gm-Gg: AR+sD11z7+StqNiQyWvNv3jCcC6VterburSfTYO9/Ka+YMajmEIn7r59hdUO0TspUQh
	jYu9viOuWXtC8XU5dt3mjGxbHLLsHffIaOO3sDG6hghQKp55YIOfSGfn4/CHSzgBqJGSHFI7yqr
	SM9hSq4L1OIARGZRrkidD/Il55Uly2s57coqo6XcEzMyg0gZ+OPuM9FuXt9F56RkeTOt+QCz6td
	aBQJfqDuMvdiB6cAQfEr5FWdSZJwWpY77bfifMAbSyZPuxFKPDmtSAhcf8KLj2MRZobUD4XAh5U
	+NDLLKH1io0bIqMK1ulWsCDgKzcRu4B6XL/oJWqbs1nqf2tJ2tA2VJKUegCToqzyshsktbJgrkW
	IqTFtHaSIKUU9Blb43bO24/tEQcNa
X-Received: by 2002:a05:6a20:c70b:b0:3c3:7427:5ed8 with SMTP id
 adf61e73a8af0-3c3ad5fc1cdmr27667795637.8.1784746796289; Wed, 22 Jul 2026
 11:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com> <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
 <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
In-Reply-To: <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 20:59:44 +0200
X-Gm-Features: AUfX_mwIJDNeayLFRjPiK4AAbt3mZyBzoLHgFDE5c__6SI0eByKP37ZQz-8Pukc
Message-ID: <CAPzsNDvv9eavB73xZt+LxjqLkah4CfiCJsAq-4vxDrhW13z6uw@mail.gmail.com>
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

> Instead, I think it makes more sense to introduce a new BLK_STS_P2PDMA
> error and use that. ... simplifies patch 6 and 7 significantly.
> https://github.com/lsgunth/linux blk-sts-p2p-err
> Feel free to run with that.

Thank you, it is much cleaner now! v4 is built on your branch,
your patches kept under your authorship.

Two things I changed in them:
1) read patch reads bio->bi_status after bio_put(); v4 moves it
   above the put.
2) for the narrow_write_error(): a P2PDMA failure is whole-range
   and deterministic, so v4 records the whole range as a bad block
   in the completion handler instead of retrying block by block.

Mykola
