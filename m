Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D371494A9
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040306; cv=none; b=D95GUJQ/VX+caaIqqh3WqNVfH6RqoBlfTMvr9hxNxFefIUbctzVEU6iGepxeV51VC5c/oNFbt/7HrGXU8FVxqqS2nb1uCsPRODCqlRAkuTMSUWVbFm31PX6IXCe/LFdnTJyrVCHp/YMYx7WwKRkLSy3KlcPbCb0xF3tSVr0PjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040306; c=relaxed/simple;
	bh=mTYg2I3WuTkpyh/+o64UPh2Y+YNRCZ3wV9gBi8Zm0Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsxR7ODwwKT9/m/UgKl47RmJirwxJBZ5RPkT0QlrMGcP+3bynBMimLMB095/gtpiYdFBAo5r+Q3lqP9Zl+Emd1JFoXaBYNbkMOXcT3wqyd022YhpbAO2JV1dvtWxFI2Odem2jhRbXpi+a8UPDK2PNq8DGsyiQfI7GFtCpimMEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S+TKeib5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S+TKeib5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7953f1dcb01so7277685a.3
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718040304; x=1718645104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25m3KIGLmguUC8/pQLLfTfUUYokxVK5unna2aPd6ENo=;
        b=S+TKeib5I+1Dkq43acjA8a7FUUSahJRBvyI1FIbAZUhYFHySf9FerIeM4YULmQ1ara
         9DLhZxEzHbFUJwT7vlqjva+4TupaEfrc8S7+8Fce/VJifBnfg0vC6DM7++mXeUxS6rLb
         ZnunedLMoKK3aiBwdBuPDB1/Fyu5+DjSKBw/ePkoBhdxm+BC84meFPlGaEczdhhO73Ab
         Pn5pIy/wIVUepSpk/reK4qYuYosNezVLoQhBcm69YeCim9DxhJBPSb6b50TtnhmhrH1n
         iaA98DDKAnmDiVbFTsr+VsRP8mhavrlXXGovRyFOvGmGMTq77owyS6goh4dZEOwMBJjF
         hDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040304; x=1718645104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25m3KIGLmguUC8/pQLLfTfUUYokxVK5unna2aPd6ENo=;
        b=EHQWxO4WneQ6OAX8NyYV6uVi6BI6/8x97lhKaM/F0CmpL1zWG6P2jdLk2SjBuL82V+
         cRYimHzK5O3TNBADS7/uTGGVXbG/943qZKU2P3IHKd4vAzDSxDH7s3mEJcWdoegGxgNQ
         Q0ZCzlTjxA+L9zkA5KShi0hjbNcQKgKNy968uGQv84Zq00O7EXEmY74KTBJYd+LpbCJf
         gwSgqCbNKKo8aaTLCDu63nPYm0gKIut9ovup75yRyWaMc9A5E0tHfRMElWsca0HyZcaT
         PuFZbKvPgj6SLPJp4PTgQaufk7499xa7HfIUyi9f3DcylFn50YZb7YT6/MMg+VPpOQKj
         R8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW4AFUBCREOPscnZ7aMxjLFf2AseW84A6aSAPLQKvRC2ZsWMb739Id2MaeQaJOuxfWgRBKJyo2CqBCXMB8tc9zxaQHvXdM0lLQWnk0=
X-Gm-Message-State: AOJu0Yzw6jvmZuZkgaXtZPCfjaNpL4LjCiRTTn+n1ATkxZsD6pKArpGC
	WDsPASPtiOo7SpB6vhzwFSRcAz66Ooj0dQhFv/tSnn2OonXAqkcsiHef6uOZLFg=
X-Google-Smtp-Source: AGHT+IERiQrm9SUSeQMdKlpq1AJrD/6cpiXXPM5R7XiNqEGctS72ZsZ7Qn7LPR52HM49FztB2xw/bQ==
X-Received: by 2002:a05:620a:2949:b0:795:60ba:76a3 with SMTP id af79cd13be357-79560ba7949mr495154685a.12.1718040304159;
        Mon, 10 Jun 2024 10:25:04 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7958e85b6b3sm134283285a.100.2024.06.10.10.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:25:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGilR-00EocS-4l;
	Mon, 10 Jun 2024 14:25:01 -0300
Date: Mon, 10 Jun 2024 14:25:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zeng, Oak" <oak.zeng@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	"Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	"Bommu, Krishnaiah" <krishnaiah.bommu@intel.com>,
	"Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240610172501.GJ791043@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
 <20240503164239.GB901876@ziepe.ca>
 <PH7PR11MB70047236290DC1CFF9150B8592C62@PH7PR11MB7004.namprd11.prod.outlook.com>
 <20240610161826.GA4966@unreal>
 <PH7PR11MB7004A071F27B4CF45740B87E92C62@PH7PR11MB7004.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7004A071F27B4CF45740B87E92C62@PH7PR11MB7004.namprd11.prod.outlook.com>

On Mon, Jun 10, 2024 at 04:40:19PM +0000, Zeng, Oak wrote:
> Thanks Leon and Yanjun for the reply!
> 
> Based on the reply, we will continue use the current version for
> test (as it is tested for vfio and rdma). We will switch to v1 once
> it is fully tested/reviewed.

I'm glad you are finding it useful, one of my interests with this work
is to improve all the HMM users.

Jason
