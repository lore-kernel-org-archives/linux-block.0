Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E33A7F40
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749829; cv=pass; b=VIQGLz9ZFzdSKO6lxxW9TrBOn8E1ZdNOrZUylaVre1//I9qcJ89We2zwBJcH8rtfdXRFB8Nqe4BImatyTzvSF4qf66/hlSCB9vOJZjHodPTofSnNC1lzYbFaPx5DQ+QMo4G4WsVoHOm6TRidI3WKsWZ/WwK9WTrYgxeWqW/tz34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749829; c=relaxed/simple;
	bh=oCdr0VyYuWFniik+cq5m2m8gRYzMe6MoyKAYOFWNB4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C04VhQy94vlZ5/N9a24EjC8Nl4hqr6IrR/DaSME2vFbcrc/o0dP//41Dud9jpYvdsmBNO2m3iNY339K8o9FfAOfQwEkQsNYBhQ9unSBlwPAbK3jGWR3LtX56W31o7lbW3byTrISKcYTrezmhRN6EoYooACC2v1Kl3BOoXjbUFpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=YeIXLrM4; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="YeIXLrM4"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e08baf860so10691397a91.2
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 12:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784749827; cv=none;
        d=google.com; s=arc-20260327;
        b=Rxz4NxuSMrFbw6jHlcRCr0Soiw5chFLzlq1lDnlHlZF6MOAgiLsjc6v8N06OAgKtwd
         3M0zlec0tYuMtRycPcVBJ9h0MO1DYkzLN6jy3/kEbn45nolKcLvnKhcqVDU3gAc1q5zx
         o8YKPJ//U+8U+7JdG7W33DZ0Q3fP6s8o7Sn5OobD3yA5EavGTBuK1XR7LmBjOfDcWGbA
         7NnKQUc/NX2o6mhrgn0vjEjPLA7euvb3wbowkjzzbfCnzJScaqrwhzNFlQFeSKlV4LYm
         J09eK84YUsN+IsiA+1tLUBgDYnRxKQQPT4eZCjA4hRt9Mgl5xYh2IzIiArsg8Y65AHqz
         Tk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=;
        fh=i2qInDgUPB8v4fsfWxfpswX3d9/rMszwy2BsEs8Gweo=;
        b=DodauRT68688a1mMQu8aPwOQ6p9IlUPf89QQ91srliPl44Pu7sfVeJI6JUjWXoqNFG
         02misZSexlh2WgrpIs56bvTbTDstb8gGWZoEsme9zuWR2RtDlJlD+Qt1MlA9sMZW27VZ
         TDWHfiTkEabnuZXyGvDC/tc9HwtPhW3gOylSIBEWrHcSKkaB+jEpq48fl7mF/Dgyj+Bz
         KzIBmZlB9XOI764xoe1ax2AF44eqR4z9CVZFAItGNPXpbG2RXIbIkVDfd0Z31c6PblhD
         FMJsuZrsZHUMPaX6y0+wTGNv0iYl+M/RFBPHr+rq9bFSMQT+3MDrYaJXQWFwsQbWd6aC
         gATw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784749827; x=1785354627; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=;
        b=YeIXLrM4K4HgxBCvURWc8JwUoFLnuTm31u0ZBw1QqoSyqXcCXd1B/ilcUDzWDg5437
         qjmIgvAvp9KTAatdM4wTzp53MVqpI6Iptu2xH2fvHG1DdIej/dRvcM/RCnWLDC/9KOuM
         1jqvVvWr0EcNNv9ol/xRweVpHmQO38bdcXge+wQDEYGrAqDjX6goVP/IyBdSht0NdeTt
         p8wiKX5yH4XTkKkZ96PP/zLgXuGb6N2J2Jrg2rMJxbfZY5RyQOwvpINnQIn9D8DGaDMf
         DK8TgMX1Av8WtyC7nH+87La9CI4wxSGfOh1IkBiAlrrbmA6kCXVtqYIREDD8aUaDidPs
         diqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749827; x=1785354627;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=;
        b=sQzSN5QUTaknLB6o9wOqFBp05dUGl/cx5d4a+4FXVfnJoK3EQx+sm4ExrdCh0EhxbZ
         Lwf/7zfRWycNVbosVSSQEUv679/71MWW6j80jXpYa9exU0tV0RhdpFkju4tJCQedAUA4
         vTl8n9Xobl2b7RRAYvzAeklfdgUXkcccOmB8AnAQ8tmfRAoSEG8PGx9U9GFwBrBQqKOQ
         BsyKflxPTx2vv4xlGlLtEYH1ZJYvR3gEA11hEIw/RS2b+FJ40a1Es4G0CK+UhQwZBfnM
         gQ271Loi2RkQ9i2+I3b9QvajpfD9BmBEGvmX9XSI01UEbzXO1IcCgbD+7pWisoxi2cnM
         yo8A==
X-Forwarded-Encrypted: i=1; AHgh+RowqBQXQovt2Luii49RNRQrmYFVcyslcR1O63SIrvXNNWAxTEDYlhRpB8/fzQ5FBnHEDZbFEzsfg2iVfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMuCbrO6wdtSTrOH1hzMSpv3UcMD0y17bzU/U9BrhmvcuxikWi
	JS63SNjInYqeNwFVX/UhA3h+tu9iNc4XTmD5uImILEKVRZYZaQdL+b3C+9VDcgspOOVi4noYSDP
	xJc430/oa4Sfa1zdNFOddPe3YWW+W1ZziC40gK1Qc
X-Gm-Gg: AR+sD12qOGpYmhFqiCgxdAWuJyl18YPetrBxRs6AUa+Vh2gXB8BqWDDKIXIqyxV5oIC
	wFjJP3ynZugWEk9N4kzdLIFypBfHXVtfec35vBGzju9WVJs6Mp1H3nbMR6vjVnj94XBj+rp6oGc
	LF9hTtJaVL0G7G5fZC3bpOesND1LUc0xqkzxNY72IcqWIwPg3aN+UbRYgtYYd4Ud+p3VQP9TJrs
	M5WUhdIrqAZdPLq44ZC+1Ldr631vV4yjVcIpA4Nn81EECSJR1hrgL2oaylrZKFRhmpVNv7g1Q9b
	yruZlCWglKvIX36/U6/fTNItN1hpRtuBmr6bsauOgDMzttzjjWYq0IOZcMlrZEGXA0mbW7YGN3X
	hPta60b4U3yW+nXaesBr74RZb9c3z
X-Received: by 2002:a17:90b:518c:b0:38e:b3fd:d582 with SMTP id
 98e67ed59e1d1-38ec6657a87mr93881a91.39.1784749827092; Wed, 22 Jul 2026
 12:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722185841.449934-1-mykola@meshstor.io> <20260722185841.449934-8-mykola@meshstor.io>
 <38c44536-51c0-43a1-b83c-b94915890aa2@deltatee.com>
In-Reply-To: <38c44536-51c0-43a1-b83c-b94915890aa2@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 21:50:14 +0200
X-Gm-Features: AUfX_mxD5xjrC5SGVG19NWXUUrwiVViRlgsz7kddupZQwNnofwkXgV0KRRHwCnM
Message-ID: <CAPzsNDtmEFf2uyJr+gSs4iw_E+LYiH5+3uojxhGMYKYku+fw+Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] md/raid1,raid10: skip futile retries on P2PDMA
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

> Maybe drop my authorship from this patch.

I will do in v5. Any other changes needed?

> I'm not sure I follow the point of this new comment here.

I will drop the comment; it means the failure covers the whole bio and
won't change on retry, so we record  whole range rather than per block.
