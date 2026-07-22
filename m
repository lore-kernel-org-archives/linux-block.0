Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E541459AC2
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746831; cv=pass; b=sZAKjOO6xqWDIg7nJheICzKg/QPJV2jI5TpxMTJ2W8NJ7m39KR8YAmqnUWbYpsJ0i7IZMKa0qt8eMT5ytJ4ZFot6JPw/o2VJhiJlBbm+6AmPMvOtsU0CgpUPaRxM0AIgLLEEpuaMmk+jVPRMMCUPBBzEhnWpA1KZCIVn++2go3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746831; c=relaxed/simple;
	bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnN3JTmg7JKcLLX78fqwAn8uNcsYdKRUCtThSonApV2lLlfTgZUVz1vCMhgkjJ24GndBg6/UlRlHHTfPBfMFoNxzHIa+/bC/R19rxY+RbCy3xqfMiqY+PFY4O9Uc7gtIH9JbNaA/R/ILYlqETFf8QcP9rnDNagYFhB2B183lods=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=P7+JEm1/; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="P7+JEm1/"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e58034d05so5088371a91.2
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 12:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784746829; cv=none;
        d=google.com; s=arc-20260327;
        b=SDqu4u/RZsoIUxozYkDJ1xiJK0Zi1nVkUknbWifkV451qC+ZxlMq9cPRnZrFTWTnhU
         vi61sLZxkoN/x1kwBdhQ/zybqRT4cnG8CYjttP0LsbpHQaF0Aqq95o5pteQrC54/2EzL
         6802nviUrg0Bt9Y7gzOZjCkdkXVrkMS3tuFRlLE+7nxNTWnrOMkOTN8dSMKkGzBgmL6S
         NJ+arsIU4iP3HhvddLeT8adOxViIt76Ffy/P0oSduhKlivQgv6gc613txrbddMttzocF
         tVSFpcSkmG+nq4tFKLIM8CaIo4OegycElp0d11sNJK0ZQm8VU+XD+1/eMt8C9OphkEIX
         8MlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
        fh=3965CDyUGBkUOJ5/CTf42hnqp0x7i+6DPrHW8o/hbC8=;
        b=Ro98vW9JsIKTsaJ6UAHkIiEz4tn5PiC8CQG64gu0SkdaIltb7hiUT8Xz9sb53L9dRr
         hg4o9mgG2q5QdUgUA3TdDVpfVANf+Q4XH09k2RkvS+5MQa0lA7/YpC/HiNQepd+eqygd
         ivWMyKCjlyZYX65E+ySTNiznS+pkHzXD0PpFilCLyBHF7dgVAo/a2nYJkR6eM1cIS/OJ
         lkfkcaOwYs71lmXG4v4ipaQdSG4De5quFW7l/vfJmAL2eIjjtF806MU6Tf/J7yP1/wOd
         p/z4HRRKDZi9Jhbp1vxBX69R3C0WyZS/CthzLj9aqklpmcFBf8afRulBhFak5OHOLzX7
         YUyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746829; x=1785351629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
        b=P7+JEm1/x9IS7g2LaEdPDjdGNZZDYpKx4UI0BjOZFMdeDQMhP0nBuztbpVw3tj8ZiB
         oP2pe+8tUkpH8t68bZUpn08J7ECM9zvNoV2LdUz5V19JhsKhrOzOmSGA/a2XIq4pEyJ2
         EtOiKyiiVqxrMWw+7j0lX+m86IqAfwVAGtSa8Mj734GEEmPseB8VpnvECQ2b/whmldNo
         6Kyj6KGwg2qL/H+jtt2bb1Gg4WUgv5j1OGuPeu0bhe8W+b3x4Ye5lsGxwx3rjgwGv5qn
         nwhzl799LQuCTQl/mGTzQf/F1dbsP0bQ4HhRFg9woPt5Cm89eEdcbcPrlXbesLkTeJmU
         8mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746829; x=1785351629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
        b=T+1Y56jxrOBJ1uKQN2lDs/LfA2eWXWCfn1Nl++vEuGEm8cDstMiPU4bP1Gpf48nRE7
         OUO0zRPAoa6635M2nYs8Hgj8fvn0ohb32A0mRh7UJDpG7UQ2V9+ILV955Bvyngo9OhH/
         yuZp3f08E+iHIYk4WZ7PqZElqoSb9rPimhaCRAeCzyBx7hOl+WuoQsWUjfoNDTcRlG71
         6gSP3WLhjEU10C4myRgg0RR7j/vFg06C6j5NMfPh5LmrEaL5n/nIl9uGvq9TW/7LEEQp
         lHHl6wRU0qElNNn+XpuLZ8sWYOIJhw+h6hLpdElRb/BTRMAONZFUNz5vZtlKy+qNKXtq
         vFLg==
X-Forwarded-Encrypted: i=1; AHgh+RrFUYqsvabsdcdEfWi2FvBGoiB6w06SdyJn6BfgLSUS2Zxq0w22xvocv5C01PMmGbAzIDEq2JX/cbMT7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YygF1raquFfbSobate77FgO+z8njklBY0P4kSeKakBJMaeOfj73
	oafKXkmkkprFyO1Rn9SMhedGJ4giXgxXdkW9c/3V+PF/J/OUm8TqmjmIRXoiiwwKzu0hlzJoqGY
	rXjZbjsYCF7wSoJMGLKPVZBXTxIoRMGwtQe+gQAnV
X-Gm-Gg: AR+sD13XE/d2YcQdgJHo6jtwRnFqUvsVUBO7O9tyCQum06kpcMfPC0mR/Rv3DUpATOC
	Af8WWUDZ+9+Cre3sqkhZ9cpfbQt109TrNyNXsnjUeSkjUyVsZTZ1N+IacAk9UZa2UHhH4HcY8TH
	IJSVOE7sgdcuDoS5WQWqFe1IWPzZIpqs/1tTqdHhZ1snNM5YU6W2BY3IOybfE16z7S2ncj4d4OJ
	kKYKppSTjlYqm+RqdSXguoaCwIa1JYr9oaFGZ6NKZXPlU3uywly4VzEZB3A8+yt8uVncl1EsDCJ
	mxdBsSpZGsX4dd2zb8on+k+VRftmqmFDG1rb70wPIObEe5rhGKv5NYKh4yqJ/vxZuHx6XlcLNuj
	RBbidZIAoI0yPGDrbeuZ2NgdREQiOWnql34JNy2s=
X-Received: by 2002:a17:90a:d40f:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-38e4b430c6emr27167946a91.14.1784746828497; Wed, 22 Jul 2026
 12:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com> <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
 <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com> <20260722083015.GU110966@unreal>
In-Reply-To: <20260722083015.GU110966@unreal>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 21:00:16 +0200
X-Gm-Features: AUfX_mx6Cta37C8DCF1XHW6rVQfC4bnrtxly1T6dzUQd_16ovjA21XsyVTPdIOg
Message-ID: <CAPzsNDuGfneEmx_nWqw5vYLyPyK8krfWChNRcsxO7icTEDDX5g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
To: Leon Romanovsky <leon@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I had thoughts about this series too. It seems best to avoid
> the P2P path entirely unless all legs support P2P.
>
> Can the md/raid code determine P2P support in advance?

Yes, and it already does: the block layer ANDs the P2PDMA queue
feature across all legs, so an array with a non-P2P member
(e.g. an nvme-tcp leg) never advertises P2P at all.

But that flag can only say "this driver can do P2P in general".
md cannot see which HCA device does the DMA for a fabrics leg =E2=80=94
and with multipath failover it can change at any time.

So the up-front gate covers what is knowable up front.
This series is about the remainder.
In mixed case, one local P2P leg plus a remote replica, with it:
1) a failed read just redirects to a capable mirror;
2) a failed write records bad blocks instead of retrying forever.

Mykola
