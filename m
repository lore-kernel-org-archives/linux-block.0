Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE81BD515
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396635; cv=none; b=S3MLuoDQ4yEb3pxI4dqaJvUECid02n9KmBkQE8J45hBeiw7c4HaNPqNNQXrU57yh8UOnCv7toMof5L/MEKn1qoooqFErwYOc44iWEK/EWvaUg5MfTXjSKQtIusqS0xV6k/9aDSXU8LBIZLGblV0BLHAPdy9WIrAzcpEqNXHrqoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396635; c=relaxed/simple;
	bh=mhTsv1ygiWFnjDiVQe/E1G0vEfNsEKPKJTElZp6SXYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5drMGmat1IvtdmmbYJEJsLYns1OyoXbQk0RrPsNz/6OIO6LaNlZIabqJkwhkJS6CBT/YO741L29H5q6KfU6cvzUW0XfG+0rlq8TU72z/2kTt47wDfhE03fT/F9I1ScH/FUPmwscZ+9YX2CKPIyFE3+yh+rKELK+CAq7s183xMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dZqBiU8D; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dZqBiU8D"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83a9ca86049so44376339f.0
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730396633; x=1731001433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJN1S3OA8zjlhqH9iA1Z8bsg9GoFf4IOEEdKUROgci0=;
        b=dZqBiU8DXpQWfL+3eDl4LNW0W8j+Gz/J02RI+YIltmvo+mXJ8sK+GXmVmFZki7saWo
         EiOfNKfrdJx3cH16jzNPC4J1UW6Znf3Fl/LOGauWgtG+nlV9MvRTmmWSW6AdlRhGm/jV
         PruJ2QGCXMvZiFufP41oXDueGWmKZx5GRxOMoWb0ks7naLXT2NhNcFb42vJMO6j/oPYs
         sF3gAAC6PSuY+vA3Fy9x0bAH+9iJjo/A832nbSe1ZHD2UM/UnGW26frMvAhMmeuGc11m
         XpHb/8EJldScXIeKUKhsgBZlD+JolvOaJA8QEP8jb3Jlp4Rr0giiK4Jb9loOapjHOiFD
         oB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396633; x=1731001433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJN1S3OA8zjlhqH9iA1Z8bsg9GoFf4IOEEdKUROgci0=;
        b=DWoS6jeTBlmFFCvQIkwqMBT4Q9oioLbfj/4MIcf7f4DEMvflD12i53jx/SUGMjkeL0
         tKsFt/dOuEum8UVOjXzOWT9u6wIM4uxL1V/pqUiOFAONH1fdzJPYVtHxNst7qVMYxDpf
         1DZK5RzN3UnDzIkj4+/axUmxzRnuBJgzTG0FTsnU1LKRyYpfXtHC7UHLMZtCeydCpsV1
         r59fK2PvM9oazB/Q9sgaMtjjjcFTHXj5f2RAf9hQcK7tyd1EWXwbgMYrgu/D6pRJqv1r
         u1fnUbLm+ut0AZdxlDdPlMdW5cZOMBFnjYc3/rZXNXIIPPZYZYK26x2osWTrWiaG8LVY
         bgYg==
X-Forwarded-Encrypted: i=1; AJvYcCV2L5oxZHulVNWL+4rPss5shA9eMT8X7ToOI62FOL4uvbENhuRlp2VQXpqQQOXHvqAGEeYEfNxE0fHfFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpIWlaHtSuql8lpbbklPNBt9Y0IGY2WDdevISfGf2Nk+NYcXV
	kXnGI+lYbKOnT7qdxXCvMPng1aL76BVAw53CchOqZ7qx5lQWHpNusGnmmPnAOCU=
X-Google-Smtp-Source: AGHT+IGqvDPac4jMToI9PP3ppL4bi2ob+amIyOKddZ0fGQ56qF7607m8ktK4Ur1sfUjByGfZ1fMmYA==
X-Received: by 2002:a05:6602:6d0b:b0:83a:a9e9:6dc9 with SMTP id ca18e2360f4ac-83b1c4c27eemr2156317139f.12.1730396633080;
        Thu, 31 Oct 2024 10:43:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048e3736sm379375173.81.2024.10.31.10.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:43:52 -0700 (PDT)
Message-ID: <8b4500da-4ed8-4cd2-ba3b-0c2d0b5b4551@kernel.dk>
Date: Thu, 31 Oct 2024 11:43:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
 <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
 <20241031083450.GA30625@lst.de> <20241031090530.GC7473@unreal>
 <20241031092113.GA1791@lst.de> <20241031093746.GA88858@unreal>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031093746.GA88858@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 3:37 AM, Leon Romanovsky wrote:
> On Thu, Oct 31, 2024 at 10:21:13AM +0100, Christoph Hellwig wrote:
>> On Thu, Oct 31, 2024 at 11:05:30AM +0200, Leon Romanovsky wrote:
>>> This series is a subset of the series you tested and doesn't include the
>>> block layer changes which most likely were the cause of the performance
>>> regression.
>>>
>>> This is why I separated the block layer changes from the rest of the series
>>> and marked them as RFC.
>>>
>>> The current patch set is viable for HMM and VFIO. Can you please retest
>>> only this series and leave the block layer changes for later till Christoph
>>> finds the answer for the performance regression?
>>
>> As the subset doesn't touch block code or code called by block I don't
>> think we need Jens to benchmark it, unless he really wants to.
> 
> He wrote this sentence in his email, while responding on subset which
> doesn't change anything in block layer: "just want to make sure
> something like this doesn't get merged until that is both fully
> understood and sorted out."
> 
> This series works like a charm for RDMA (HMM) and VFIO.

I don't care about rdma/vfio, nor do I test it, so you guys can do
whatever you want there, as long as it doesn't regress the iommu side.
The block series is separate, so we'll deal with that when we get there.

I don't know why you CC'ed linux-block on the series.

-- 
Jens Axboe
