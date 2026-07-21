Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BBB46E016
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656194; cv=pass; b=JobfUpSJeuI7yZjfcbsOUZeE0sF1QfWUwrvUZviazwknUdgimuKk9lgfgnUPGD324w0nyT+WNvhbOCgUHEANaZeZh18xBcv5fDvmzUIQLMH7RgdaNlufbvf0LetMs4TheMjxK9zj6UchrUYJK9p/soqRUrysklWYV8BX1ftNr9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656194; c=relaxed/simple;
	bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rzv9GAiPwBRPqrzj0H4vgHUulW/OsXHY7EwahK4HuQURrQo9LOGigDtSW77NvdNhpUSSMVAtXoY2Ax/sfi8UuNY+8tCsi7FwslYpDU6+YCYXUZ77SxORwr8XCg9jsApKS3qNAF7xiHS5ZvAXLEsLivyuaUoiGOHZCtmG3Wt3EKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=ZgMFuTFb; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="ZgMFuTFb"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso4368067a91.1
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 10:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784656192; cv=none;
        d=google.com; s=arc-20260327;
        b=olNObRgj7DiDwqJZM2ViveLCnOndOW4bV2aEoQOhY1+zVPIh/Qzp9yHuJ/koJv2yp7
         tHVkbOUYqIbzLya50i2zzLvkyrg2djc7IM+VckBFDlJPsGkLNvZgSQZ/kqER4icwMChs
         f3W4BzwfCQtXn4E59Xha3J9n5o7aadPD5danFvu5gCMbFis++LQdqJu8j0N8hZLXTfS+
         9SDI1U1viUMkfTd5wLbC8Z2kih7Ki4V4/r2jshGZqjYJPgZ4wWwx6ylnUYaIvh8hCvMn
         nkrBZV5ivwsA4bcQCSZ1kj4g88XX2AxoX3z+BBNy+nRARsiw8Q+0yPFq4NeGl0KCrW4X
         5auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
        fh=DrqEpJf+HAlzw2TvMgsnROX6+Z3ayrI6i54Ey3ZVpnA=;
        b=o0WG8R4u7la9hELW32A48vcPIsRj3SMdwXXjuB/GFz4mpTlJQV7v/g56Q38cicA4Pv
         HPeRldOIuO/NQMZxYSobZpLVGQQxhsgJsnrKEzxfnbIPdl3Gz5M3SCANiYVi81yBgMZ/
         /swEHQyxjp2lHNXcpoYQ/FRJPlWeQNPkFFdFzMCxu4w8O4bITfe6sZpIl5xtr8YDbuLx
         7MJ7J+m3a5vlKPpNVc3ffU1kUig3HSwM5cIJEw5TbkY8syGwPxtGcPPzJdkuiiLgMoL4
         700PzCf53LvwEAWmyArWkjUxBqq1RiGeekmdSMAvyX2D1Gre9WWdVJt0QQfkN/kGNmxn
         FPMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784656192; x=1785260992; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
        b=ZgMFuTFbW5QBVbDFT61DhLd/4BDvDw+gMzT8IBfdZZyGNH7U85jgysPP/UtOAsD8p1
         oQrDrEYYRQFGxDVWr2sNBrJ94LZZTjaHXd/7R8oX2iwvJ2yg+lcDGDggsUQgYcKMfty8
         asaPy468x4LdKAkguJctYH6ex+3gzJO74Lmj3b6yXxjL32RL6t4f6yW4FAaSzc70Aguz
         aUpyzzhfTxpSFH834H8daZ1SSFazWD69lfychzxJ0ve3AiiQQ5yCMVNtrB55MKE3D9yc
         bTJAxyy+rU7Of6yjIMIFJIBu0k1wJoK0Kayo1TjvTF1xxM5u46bPspr8LeDVN0niLMQS
         l/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656192; x=1785260992;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
        b=J5mi0/QUhcnWrEldSlJ6N/QtoXC5oM2rhN76Tqmut23zmG2J2QfCHh32WfQq+YRR/+
         wEYoS0LJiKa2UTym3DWM2L8kj2LR+MbaT1Uo5s5Dg7tKVyOnLVTq5J1e9wiAPeyiRxR4
         xQCAkmoxMOVszHtSMCkjtThA7kyBruatWuJ7S3wGV8AFckQpKiFKkrIU4JI3QKwfKOcO
         6hDxrehi1P+Uxf+6mxasFVLDm9IvUJUA3QBvJz7U2dAq51yphQ+L8h+kgv+CM7lCiFxE
         h2te2PBsWEF5aXQvIiUh/Ix9zicLneYC/adqYHzu/5bNA7KJYUjy4bbFamY+hkob2ZK7
         Y24g==
X-Forwarded-Encrypted: i=1; AHgh+Rrn3b71ZPUkAqnWsqGNg3TcmKr/A1pWN2txPwHN9FZSDQuq04TGUT+HUo3FxmF0qoao/ZZol4stB4Vsaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YtZH6qH4hWGgdh/NLeJVW3+uPezJsk8fjzYDyMbsLoAOKfK5
	290tdzONzRvU0lEYxwi2vkgrL0RTz7vDWoPdrQwQGwyUd5iBv46ljbMF9nAxw/Sfd23hk0Jyxwx
	HW710vBulxIAyFTVdkFhM/r6qCEDFNCHYNA19X/l5
X-Gm-Gg: AR+sD10YN6Vxyb+f3bZiiizSy+mlpjCsWfx/0tBnoyBLA+KJn9NV4v5FDsy8k+N57WK
	kxLIYRmUV2fOc3KdhCHIcBhkCCwlOcsHFxmjjYY+8AF2KZOsOKNyfZNRA/HHpzTWVPbd1oPm1sU
	ySy4Yxy7IAZYW1rokLiKCz6iXLxYdhw+8DRH0q09/62+roEM2jUUWfCaE0qDueLTIL5jz1KaP4t
	c3/WqDTQ2ZrD1jABTIZyrOXL5VTo35XYqgzgvR5QkvqrXtsHUYS6SVE2R881x1489xtAgLsN+nc
	cshCVgLOutXfO83sp2B7z+7zVRQQSOOgYHz2f5TsjV6oxS3VyYV/qg==
X-Received: by 2002:a17:90b:4c81:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-38ea37ddacbmr527514a91.18.1784656191610; Tue, 21 Jul 2026
 10:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-2-mykola@meshstor.io>
 <20260720144943.GA17375@lst.de> <CAPzsNDv6hUV3gHdaxuwjRcr4couUKq_M5DKObFNaYqCHnm7ZMw@mail.gmail.com>
 <b2c37f4f-79dd-428f-915a-2a862d20924c@deltatee.com> <cb297ebf-3731-425a-8f48-6be3c7944366@deltatee.com>
In-Reply-To: <cb297ebf-3731-425a-8f48-6be3c7944366@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Tue, 21 Jul 2026 19:49:39 +0200
X-Gm-Features: AUfX_mzYRDnXZ96aQ_20QUIhDQu3bcp65YEqla-rQQb3UzXkujG9BSCJpITYkqE
Message-ID: <CAPzsNDvKwg1SCDyd2Cf4SVeCMQicUPYRgBmq-0ZN9m6QjQQ74g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] blk-mq-dma: restore BLK_STS_TARGET for unsupported
 P2P transfers
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
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

Thank you for review!

> (Arguably it might have been clearer if the switch case explicitly
> stated PCI_P2PDMA_MAP_NOT_SUPPORTED instead of relying on the
> default).

Unchanged in v3 to keep the stable backport minimal.

Mykola
