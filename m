Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC42DE6FF
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839500; cv=none; b=JlWmlLmQIe6oZwt6V4BIbAsQWQJeL6OeJFrMlcq3Hv3wfGEOV1fMELUW5kjdx2L3x+Zwb1HMrcgQObeRX0p6NG2n2GAnyL+XHPxgzy6y1rbHGFfPOHwLdcaC9/J+l2ay6u7C9RIMjDj6g1kTsBpYIj+CfSf5HAkusRrdcfk68E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839500; c=relaxed/simple;
	bh=0Alswmfe1zq7N80PnOB6XtFxyNuFoZwrMxHbgdTZfVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rE2MQIIoy8/+VYjRVhK1BMrJTBX+/PyQXL2WQZfpx9XMJ4h4rBGoIxqRsKRi2pRhCe5QaPqo5Q/mjFyW2ydn3xzv/ksS8D/XpQ4mZXlW2Z4mN7478gEBY7EuGw2uDVyDlB8447BYDCh1ZBVdU9cOamXA/Cbp7FHyFj+cSoRiqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X44MwjAW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X44MwjAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758839498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPGBYTkBK6lmMsctQg86rFzc+ubUYRnHqSeaFKAdA0w=;
	b=X44MwjAWo1LMrEV1YfazjVhrWp6iX//uYamFV2BR9SKe5uSMeIG2th2y3Ot0a1S9SWmZPg
	EOynsZYgNn/2Jwsa9SAQIagkZZOYxpfWDM+QT7RloQHv0QMUREWvPEsrZ7Q6hn/IIyhMTV
	dY0Qu/ePr3MIEP9UlwlwEm8AfS+pU5A=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-DA4JYZ2AM7y_rmQxicTqog-1; Thu, 25 Sep 2025 18:31:37 -0400
X-MC-Unique: DA4JYZ2AM7y_rmQxicTqog-1
X-Mimecast-MFC-AGG-ID: DA4JYZ2AM7y_rmQxicTqog_1758839496
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42571642af9so5015185ab.0
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 15:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758839495; x=1759444295;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPGBYTkBK6lmMsctQg86rFzc+ubUYRnHqSeaFKAdA0w=;
        b=UvbwbEGS5kg4GM7z4jmSKiZzLsx1OqdqOpDQwEu4V6gmO8VSz/DhvRjKsfjjPYQDtS
         kYaTZEbXY1XItSdeeAveCepHL9Dn+M286lL5hXezOprpaBZ4UPF92w+W7uPixTmS6a04
         jHV8anf9xSgEh8efCEj8u9jYtlnobpsuuozz7dfN3xJd/ChcaRtC6ipmwUVcmL4SRjSV
         XJnUk4JIYZtL5JZbVHykShYMXQ3GIYWme2XrAF56EZ4kjbaRvzCTKSgd0c2XocMYBoZG
         LaFHOp3NRYDGZCJRw1znI6FKodmRQrgHS6yJ1w3oPfFjK0Js4xAOY/B1voBH+nNh9Zac
         Hf2A==
X-Forwarded-Encrypted: i=1; AJvYcCXNbA53j3ZXIU5Veqia3KDL7kemGkaCEYFzUf5dnAyC1TUdTq3hZnBYZCsL500ykg5uL3K7q6LGL3rJtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzho/pXPSs4KP9397hEutW8qjJQgXUWvtO6x21YZNs7xg5bA9u7
	KR/XiPnFX0rMY3WuS+lM/7J19iYqYikwVeVBV6e54TePFFzlEt/0e6+MQ8JdNevpWVAtXI7wEX5
	634XUUcfvbn+3/pAB/swqRd9EwXdJmFMlb1gxLd11Cx+zrLrZNZ6JgMhpaoNaVdJoqEtAucTV
X-Gm-Gg: ASbGnctuKZDskvndGs3P4iKIijgZI2pbng+JMXdm556WYvpFTifWnllJoct1ktRDBVs
	wgfbOhc3qctgXLrP+bd5+thrPJb4Kxp06BHAXnhKzFr+FwfgYELZEwRD+UsBGBYPU+aGzw421//
	EVRAXCmOIOPgBhWZ9N3gIRrb4LmpXhNc60DSG5n02o1ycznBO2tjrj22/iQ4jjusj672xxs5qSI
	mtpklCg/vwmSLqFn0Oda3OiPGZcalYc0mkm+QihYNclrXefaLouSlESaFTQL74ngfTS8vdo83uc
	QT/uOi2Pq0eAvBVAGPjkdrETIEV3YcezHIOyVsc7hFg=
X-Received: by 2002:a92:d987:0:b0:424:80e6:9e8b with SMTP id e9e14a558f8ab-42595661562mr24720155ab.7.1758839495370;
        Thu, 25 Sep 2025 15:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBjWzVlsd5kVvaGcIPZVt9Dy5vtGZ7X7lNybnyhnS6f36pgd3Q/xbJFuK0zszjvTKZaW8Iag==
X-Received: by 2002:a92:d987:0:b0:424:80e6:9e8b with SMTP id e9e14a558f8ab-42595661562mr24719995ab.7.1758839494991;
        Thu, 25 Sep 2025 15:31:34 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a69a1c574sm1211405173.40.2025.09.25.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 15:31:34 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:31:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250925163131.22a2c09b.alex.williamson@redhat.com>
In-Reply-To: <20250925115308.GT2617119@nvidia.com>
References: <cover.1757589589.git.leon@kernel.org>
	<1e2cb89ea76a92949d06a804e3ab97478e7cacbb.1757589589.git.leon@kernel.org>
	<20250922150032.3e3da410.alex.williamson@redhat.com>
	<20250923150414.GA2608121@nvidia.com>
	<20250923113041.38bee711.alex.williamson@redhat.com>
	<20250923174333.GE2608121@nvidia.com>
	<20250923120932.47df57b2.alex.williamson@redhat.com>
	<20250925070314.GA12165@unreal>
	<20250925115308.GT2617119@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 08:53:08 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Sep 25, 2025 at 10:03:14AM +0300, Leon Romanovsky wrote:
> 
> > > It would at least make sense to me then to store the provider on the
> > > vfio_pci_dma_buf object at the time of the get feature call rather than
> > > vfio_pci_core_init_dev() though.  That would eliminate patch 08/ and
> > > the inline #ifdefs.  
> > 
> > I'll change it now. If "enable" function goes to be "get" function, we
> > won't need to store anything in vfio_pci_dma_buf too. At the end, we
> > have exactly two lines "provider = priv->vdev->provider[priv->bar];",
> > which can easily be changed to be "provider = pcim_p2pdma_provider(priv->vdev->pdev, priv->bar)"  
> 
> Not without some kind of locking change. I'd keep the
> priv->vdev->provider[priv->bar] because setup during probe doesn't
> need special locking.

Why do we need to store the provider on the vfio_pci_core_device at
probe though, we can get it later via pcim_p2pdma_provider().  Ideally
we'd take the opportunity to pull out the setup part of the _provider
function to give us an initialization interface to use at probe time
without an unnecessary BAR# arg.  Thanks,

Alex

