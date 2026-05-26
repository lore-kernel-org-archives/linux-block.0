Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C763B4E9D
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832304; cv=none; b=DXci9L2JYuD4y7bcnNzVb+rsosB71rDvvUnct2B8Bq7JzrRZhtrZWg1DfVbrQ16rQS6nYqnFky5GxR7fXxu6Z/qslvHAxmZ/MNHNBoaS1FElMMJChqFl29kEfnV6oOenHqrKlD0l1HGtX32Aa5RMxDIW0L/CaRb+hoX4rRWmcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832304; c=relaxed/simple;
	bh=/JQM2OwPOrXvBPoLMhF6DhSJJg9UVNCh2Y3F7mDsZq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bjk8ZHL4BZKI7pLttJGQ5xjxeD5oSV3/ChgHMCxV3V2a3V7WYfthQ12F+VvSpgAziNZJiqQwulv1L68HxJ7p3D9nYa0fpGX5/Ody5n4K6wHFVu+forrlxk9SUw3NyG05A3GZz1wpBN6jXcZehRwoezFzrzYcYTX9GBrnSO25uv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ner3lzy2; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ner3lzy2"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69d8b7aeeecso1388462eaf.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 14:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779832301; x=1780437101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RA7cD0bS7vuj5BqYOqhUb3Pso3HctOE2AcDFDnLY8ug=;
        b=ner3lzy2tdEv1Y/7W5mtK5dtfav0oSsR9OiUqlPJLcC0O+ywc4xMZQoNHax44doTKU
         Zdlc26o5D44p6HTSABZc2rgkjd1RWgyYQ4LIgv+quzMV/NAtMg4daffhdr314hu0TJ2i
         lNSWVpZsBWv8H+BbyY78yhYdAc0k8KdvQMLNYCeFgAcwL9o+8NwKekcl3m68UBWxERJg
         u1jTbf6YjO2ViMIP8mzSgd0djfNI/y0ljXHug+j+ss/AvDqTjYVakEGm12KsmCWxHp+n
         /BlxxIfeEQDgSOg0bByHMHRw71o1TuVyt9g7QuHkTOYEQpmzIdXxHHbyqDDHtlWeyn4c
         MGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779832301; x=1780437101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RA7cD0bS7vuj5BqYOqhUb3Pso3HctOE2AcDFDnLY8ug=;
        b=PrJTPmCM0tKY1Sz6wdEHeIJCefiUbvzZrmg6uVPEU2H6dxeJALY4MHaqKfbdClxITI
         DxEHerchAgY4C6T8cJiVsvRajwUtkhYG0UQMr7htiexPkty4wsz7QY2mQ7XTsl43YQqe
         Cpg1hs12Aan9dcldkwG3wTXDQ4fx1cosHzWjpJCZxONRCbXXNCXKAq0E+eZm5s98SO2v
         TRhzJy5OxB8gjYqxwqmXWjnU4n9YUN6Jlqe995eviuK0zhMHPQ2qYBxwhMwdRYOOIoND
         HdL6WEqT9Sdzqn1Jkhn40vuCrx0SoXD1n8IDUjH+U5h2slTa5jq1spsmk/0t9u0ZVQ6N
         xUCA==
X-Forwarded-Encrypted: i=1; AFNElJ8sbwevL3UME8nAaz5ILtmluCoPplvE97bZ1w8VWuu8G2wTIEQzGqgKNw+fx1TD+rwOrTPOto2048S52g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QbxKUcnN/diYlVheln+ZJJEBdH3tSeN6mqxRQh3y9t2wR7VH
	ZJDhRHvi55i05EnbiddW0HvIV/Jf2Mwtbg8OAASbe7znY+F7EAxXltkO++eV2LOGlBw=
X-Gm-Gg: Acq92OEC5iW3ll2QP80vpB/O1jE0ILMvJ7gmh/3IdMtHh7wrgvtvvDc4Kbui9zQGpe6
	+Of2Y4dIHp5gHxGsNAeS3scKTsWGCBFd90viieIT7/lYpaYLSYpLPVN0rWTRNx3E5HaOhyWez5o
	xdoOC31EinkP86KQK3pzJ9N/xCjuCeWV3Ju0fNyu7Vp9JMHSM3KAtpnu1bMAAS89q52Fsfpx9nQ
	OgTl2zg4tjgK/KKNfj0Xa6It+5I3AOClNbKpc8llxN3+kUBhgNFO9vBYO41gFAEKE4q+HWsw6zV
	253bTFqRuCm2GKZ8PRDWTlNXGWTRIO8jT+TS9c3iGaX+EJEx2CAXgGu+inDTH12Wj+HuCOsn2XE
	yA6/LU4yx+LqkbP36hv9L21ZNdSshCd8rPbA91diPADCF8dScdR7PFWJzRZQXjR/MJQ4xU3rPnB
	4w2mFipSeMmbXoYpBI4wTU7XxGdvCqvuNAvE3qSNxlYj7HOXNUS4RMcFliZA/AhAF9iV0ajyQP4
	CY8QKTE4kPk1ZMn0hE=
X-Received: by 2002:a05:6820:1995:b0:69b:bf80:2db5 with SMTP id 006d021491bc7-69d7ecbfda4mr11748930eaf.52.1779832301111;
        Tue, 26 May 2026 14:51:41 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83aa422fsm6396077eaf.14.2026.05.26.14.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 14:51:40 -0700 (PDT)
Message-ID: <b89e372e-3068-4c26-9552-13e6853ba000@kernel.dk>
Date: Tue, 26 May 2026 15:51:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/3] md/nvme: Enable PCI P2PDMA support for RAID0 and
 NVMe Multipath
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "song@kernel.org" <song@kernel.org>, "yukuai@fnnas.com"
 <yukuai@fnnas.com>, Christoph Hellwig <hch@lst.de>,
 "linan122@huawei.com" <linan122@huawei.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Kiran Modukuri <kmodukuri@nvidia.com>
References: <20260513185153.95552-1-kch@nvidia.com>
 <20260515043535.GB3756@lst.de>
 <4ed83782-04cf-45b5-93a0-05a08e61b82e@nvidia.com>
 <053b99b2-c994-42ff-af63-6e63ab468557@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <053b99b2-c994-42ff-af63-6e63ab468557@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 11:09 AM, Chaitanya Kulkarni wrote:
> Jens,
> 
> On 5/19/26 17:11, Chaitanya Kulkarni wrote:
>> Jens,
>>
>>
>> On 5/14/26 9:35 PM, Christoph Hellwig wrote:
>>> Still looks good to me as per the reviews.
>>>
>> If there no objection, can we merge this ?
>>
>> -Chaitanya
>>
>>
> There is outstanding work I want to send out based on this one.

Out standing, outstanding, or both? :-)

> May I please request you to merge this patch series ?

Was waiting on the md parts to get reviewed, by I missed that Xiao Ni
already did. I'll queue it up.

-- 
Jens Axboe
