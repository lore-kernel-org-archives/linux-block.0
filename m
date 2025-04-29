Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11B2C257E
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929800; cv=none; b=PJ1ccvfmgzTKhEQBbwpCNlO3rKSMjSWp9260FkstxIL/3KyayTHD0KcvhRtr5DvwYyKzL90KjtC6DJZBe8fxumoHbSeTXZgLnHWFdFveN6fSouII09QBSwgNZIacqe7x6Ez5hqsPLn8tIlLDsJvexE2LkOFyH264QkMpVDSnUN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929800; c=relaxed/simple;
	bh=fspc3DFcSox1gyyee1r9hEoJNZDYkCPhN2qCzyuWCLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnT9U9qUvdj/4YjoXIcoYke0AdsHnTtt+7CRXeuo2q4M2uq/1b7OpCCGClTQmQdwJWRY+xNWKm24mj26itgiYMjdim93gmcCL1lR5VpCbDQbt581qdCuxMzSTwy4zBk9YsSecPQvHocUd+h4zhtOWtX2bqBL9dP5g69Uapa/p3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GvXzxD8o; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GvXzxD8o"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so82475416d6.0
        for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745929797; x=1746534597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fspc3DFcSox1gyyee1r9hEoJNZDYkCPhN2qCzyuWCLE=;
        b=GvXzxD8oRwhhVzjNbV2jdHw0mz5JxM4ox2OE7i20JCyA2Y7XIoL7gYEEaqUmPEJKqg
         saoJXZI/Zcju6zbadTmNxI0neJ6pk9r8w6WYYmK1BTH4cfV0ExZFFBou0AP43PPZHmcC
         UFyALwg3A/XpUVS70ArqD3y/VAaOvYhYv8yJ47X6Vs4RanvbpdOYJt+RJcl9fhOvemjn
         AVqGfwM8C3RR7Q4GkSugy/vZ3CsqoHC/vaIyAdecNDl38PKY7b8lSlcicxyYjJhoH4dg
         +bu54vsxwVl+8KxE8KXDA6EnZSzd54Yn6U96gZFjg3WoXzT8S0qqTThFRnC2SJ5Bs5qI
         /tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745929797; x=1746534597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fspc3DFcSox1gyyee1r9hEoJNZDYkCPhN2qCzyuWCLE=;
        b=YlcVD/R+6qZjQtTGRtF/zY3WuIRVMAqGpEVIQ+Rzt0gOjnf6qgj6ryJyp4WUwi52NX
         g9udRuSXaLoRO6KlOpWLgoBpw56xoUhw1ExJ0sI3F3AlMrGbez2UvU131lfK5RjtkmlD
         Emc6IIDUJ/pLHC8RvbYW8t8zheTf9OwCrL7rKhbSCmZ3kmX6pptHHQztB13DWvbmyYf8
         58w1DvRpFabo/X6bQAHynalAZvzMApQLGwT/yo34iglStNeRuFu7/gtrcWgXBdjGJcvn
         HMK+/OhxIiyf09N37RThfD5qUAdVbIchhkCwt8ql0djzzzDROFgksVmXF1maAI+BT9np
         BYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO49UJoiGl4MSnVSmtV6cCuawI2ABGAKUWdFc1+f58ddZJ1wNz3MnkDIULa3UtMuN/ooChjKLpTruGaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydP5sDMMwZWqvzUDUSCJXR8qtom3J4KJw0SjUM933u1RxECVFo
	St/xzSU4W0yG3nOmFJfb/4c30Zwi/Z4k3T/Ps89LewpfgTbpNTc2ymz8Xb7drdQ=
X-Gm-Gg: ASbGncv/bq/LpuzOvfJtq0SKGQfIdAN7+z/INHSK3mym8e3tB9956E6W65sG06fMvo9
	lQCGwi6rwYdpwYZRWnGXubGt0pXxLyLq27YBJhC238rwZLVXiCeJuLSxgO1NbrgOC3PU7HUugee
	nER0vAH+usasopMUYA4wELpJCEgvXfZ97oFsq27NsldTvE4kjwg12Hj3DjPuzkcGgdMIuBvWUmb
	jS8EG8O/FinwP2tpFBCVUVMw/I99yPUUYeVZ+Gg96ew8fsvCTXjfNyrNR2SPjoF+Hil6Zbq2Y1Z
	wunyfE3Vzq1LqiCn9n2qoE9KClNG9I73hRiKozNY64nyi2oqTwZiAgOOotS78stFIVOGaGKnFD7
	G61691ELkP7/V11b0Odo=
X-Google-Smtp-Source: AGHT+IEgx9EB53XUdGV7vC29k/JxBvqJ89luumOzPRGbpdqAFnmUSowtG6tg8X/s0U1VWu7lyHl1sQ==
X-Received: by 2002:a05:6214:d6d:b0:6f2:d45c:4a1d with SMTP id 6a1803df08f44-6f4d1f9d772mr228245476d6.38.1745929797482;
        Tue, 29 Apr 2025 05:29:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aae68csm71890226d6.97.2025.04.29.05.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 05:29:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9k60-0000000A4cD-1RSJ;
	Tue, 29 Apr 2025 09:29:56 -0300
Date: Tue, 29 Apr 2025 09:29:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jane.chu@oracle.com
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
	willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
Message-ID: <20250429122956.GB2260621@ziepe.ca>
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
 <20250423232828.GV1213339@ziepe.ca>
 <84867704-1b25-422a-8c56-6422a2ef50a9@oracle.com>
 <20250424120143.GX1213339@ziepe.ca>
 <bab1c156-ed5a-4c1d-8f0a-dd1e39e17c99@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab1c156-ed5a-4c1d-8f0a-dd1e39e17c99@oracle.com>

On Mon, Apr 28, 2025 at 12:11:40PM -0700, jane.chu@oracle.com wrote:

> 6.15-rc3 is orders of magnitude better.
> Agreed that device-dax's using folio are likely the heros. I've yet to check
> the code and bisect, maybe pin_user_page_fast() adds folios to page_list[]
> instead of 4K pages?

It does not.

I think a bisection would be interesting information

Jason
