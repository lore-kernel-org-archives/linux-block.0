Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B9A275870
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386731; cv=none; b=T8yCcc+P53XP/ETUiBKKKyJ8yXLHujVxsg2HqgZnGCdX9w1jNzGO4+DfGtl2uun/FpNBHek/AEUvCNH3ocxNKaU0XOoI1vQ97URsKdRPCaBOqdM6jFcTC3BmxbZzTRCHoqLbkstwW0rsWVY8acJ5qW8anXO4wFh5gKiUDgL5+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386731; c=relaxed/simple;
	bh=q+2G+U6BpJLX1Z/0Jsa39HPxOnPyaRSQ+Uck+sOSfns=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UziQjuKnh76vVEdoNg0TOfqsMveXtzrMccS/u/jrYc6IPnW4RKubsfukickSxwTIY+0ftZo3T40m7hgqxtCRXimNB/mRSH0DDpOs/QtIADj/NxKCGlKr+mMlRdzn7pSDqQqKOMLFbQ6WO7xH1SxhBNLR2V60wEVRyI65OJ2//10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gj8NJPiP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hm3ORAX8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gj8NJPiP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hm3ORAX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765386727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ajtU3yfJbX06BLmikcUePQ/6Tt1KKMvvS1DqwC86HA=;
	b=Gj8NJPiPKDfH0N5FXvbMQb6AeFJ72bg0PgYvBXPSt7mFPKX1RlsEZKEgQ/7g6hMLqJLaQC
	pXTmzoL8JAatgNfTyAvg4OoDXl2ZUU9dAHHMr8qlDyu5kH0b2PSWdG3fJpTF8uwAYJD0qj
	jHR1OAynO37daDTuD4mKzBGg5p/vIj4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-vreb27YFNE-Z91Pa-JOCAQ-1; Wed, 10 Dec 2025 12:12:06 -0500
X-MC-Unique: vreb27YFNE-Z91Pa-JOCAQ-1
X-Mimecast-MFC-AGG-ID: vreb27YFNE-Z91Pa-JOCAQ_1765386725
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42e2e2389aeso3632434f8f.1
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 09:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765386725; x=1765991525; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ajtU3yfJbX06BLmikcUePQ/6Tt1KKMvvS1DqwC86HA=;
        b=Hm3ORAX83b2gAf9Iv+MF2aWUCiKptW6P/UVQIqgTkXnjnFyr4fdxXRY54Y2UIfspjy
         XYWXUyAybfguOFfYxC4Loe3D7HhERF+1Wjl34XTjzktfxQjrbpfZow8/NaW8UOZCYBmx
         2nObyV5KWCl3nGLtx+IiFC4oWglGUuhxnSnJpVI4J3v1fj0BsSHRuDObXwrpK7Qxf0+U
         eD3CeH3KU0ZZF4Ig3ojMXagdbLCFiWPqm+0C6GjLf18Uqb/pLqGdL3Xbrau4YFBjn7nk
         Uhur2EQpG7tczTJjLoJQpK/pXcV/cX0LWFXJfY6bAMSld2hYIeXiRD8GaIqVqB6HG50f
         pYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765386725; x=1765991525;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ajtU3yfJbX06BLmikcUePQ/6Tt1KKMvvS1DqwC86HA=;
        b=BuC0XnyH4mRIfSDQviPMttPgX6GJdGKSgd2njam4fhDjTvkTze1pxySz2vLxVa6tm8
         Yr7WUPKK0pApKyKCnlzxiHZ15J/a5YzBDGf/UsQZXmPs0wCUYY95zR1g6e6HaqZjdNWM
         ARkTJEQ3smnyJyGDYDOQdu2cBfUBKhbwVowzkTNm0KCDNNQe0IPpqGPsnTW2KIkcKaVU
         nxQsarKx4JDPEYKO3FmW7wrpbm5mETK/n4l0ACqwqJa7BBZr2f5rwowTjNKak03J2Boy
         SGKTr2vCiBEnrXwPjR5u2EO0c6P5RjDnHUXtNFsohUtdU6yW7P6/JVExj+ZqkKj1brLm
         8zdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGHGMC8uvv12tblk95gJOrEvQwm4z8WLd6QJFsHbfhiPXGuMo8uejLkBPIocfGRHe/34PzT0pVlro/Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7MYOxr10Ue0YfvmdzsczqOABEOsLLw1JKf0/toDJPS5f71iot
	NkUI/do6DDgQP/P6FR6TFmRlrNQCALeyf0quHkNET+BYInayha8PAd3w85uai24/ka7zlwfJXCT
	ATcIFmmynLSPcRmp5nmjJ9S5KY90oyRqfOk6OPr9nuTqnezDAQK51ytqDniRqMxHj
X-Gm-Gg: AY/fxX7AAANsp2tYt53WnlwXxDw0jHS8XnQlhfSFiKpSf5iqPTIv7J45P1T0a2u9myp
	tq1Oy/Y1nxddEMpgyK+NpJXTGKYMHVDmX7snewzpi1cWQcAaJUT7Vtlp29UVIb+2QG0OtbGZbmx
	i9vljco29W72tB0h5aLnRFlLW59nRwKyer35eNVvlplkoZgSROs7U3xlecdgZjRHI5cJ85+yZh3
	qzRIkw45ZzWriG+r+HHsU6F5LmQ6//mPsKF2Rj3Apu97nge1j1HiNz1QXOUtnt691/WONHW71QW
	mIyEecWLwEw1c749cWU3mZDgkTXeq+ZddrDvQaA8XP0Bl9k4Z30NfibuCgVCLqnvUNW6r6c4P0x
	melbGVIiyZaAxg6FwKJ5xbN8mfp5WQi+3b9SOneqHZn45GX91NFCCmoZFN/M=
X-Received: by 2002:a5d:5f91:0:b0:429:d1a8:3fa2 with SMTP id ffacd0b85a97d-42fa3b17092mr3315989f8f.48.1765386724825;
        Wed, 10 Dec 2025 09:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExCXlgcWY7yBdco5ZpK1NFXlvlTRlygsYWJNZD8Qo0xz2z2qNLT3h+7nj8AJhe/t1VfpQnNg==
X-Received: by 2002:a5d:5f91:0:b0:429:d1a8:3fa2 with SMTP id ffacd0b85a97d-42fa3b17092mr3315940f8f.48.1765386724378;
        Wed, 10 Dec 2025 09:12:04 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b20dsm27930f8f.38.2025.12.10.09.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 09:12:03 -0800 (PST)
Date: Wed, 10 Dec 2025 18:12:02 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
cc: Keith Busch <kbusch@kernel.org>, 
    "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
    "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
    Robin Murphy <robin.murphy@arm.com>, 
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, 
    Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
    Will Deacon <will@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
    Leon Romanovsky <leon@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <2fcc9d30-42e8-4382-bbbc-a3f66016f368@nvidia.com>
Message-ID: <0eec3806-c002-54d5-95a9-7fa201c6b921@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com> <99e12a04-d23f-f9e7-b02e-770e0012a794@redhat.com> <30ae8fc4-94ff-4467-835e-28b4a4dfcd8f@nvidia.com> <aTjxleV96jE3PIBh@kbusch-mbp>
 <2fcc9d30-42e8-4382-bbbc-a3f66016f368@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Dec 2025, Chaitanya Kulkarni wrote:
> (+ Leon Romanovsky)
>
> On 12/9/25 20:05, Keith Busch wrote:
>> On Wed, Dec 10, 2025 at 02:30:50AM +0000, Chaitanya Kulkarni wrote:
>>> @@ -126,17 +126,26 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
>>>    		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
>>>    				vec->len, dir, attrs);
>>>    		if (error)
>>> -			break;
>>> +			goto out_unlink;
>>>    		mapped += vec->len;
>>>    	} while (blk_map_iter_next(req, &iter->iter, vec));
>>>
>>>    	error = dma_iova_sync(dma_dev, state, 0, mapped);
>>> -	if (error) {
>>> -		iter->status = errno_to_blk_status(error);
>>> -		return false;
>>> -	}
>>> +	if (error)
>>> +		goto out_unlink;
>>>
>>>    	return true;
>>> +
>>> +out_unlink:
>>> +	/*
>>> +	 * Unlink any partial mapping to avoid unmap mismatch later.
>>> +	 * If we mapped some bytes but not all, we must clean up now
>>> +	 * to prevent attempting to unmap more than was actually mapped.
>>> +	 */
>>> +	if (mapped)
>>> +		dma_iova_unlink(dma_dev, state, 0, mapped, dir, attrs);
>>> +	iter->status = errno_to_blk_status(error);
>>> +	return false;
>>>    }
>> It does look like a bug to continue on when dma_iova_link() fails as the
>> caller thinks the entire mapping was successful, but I think you also
>> need to call dma_iova_free() to undo the earlier dma_iova_try_alloc(),
>> otherwise iova space is leaked.
>
> Thanks for catching that, see updated version of this patch [1].
>
>> I'm a bit doubtful this error condition was hit though: this sequence
>> is largely the same as it was in v6.18 before the regression. The only
>> difference since then should just be for handling P2P DMA across a host
>> bridge, which I don't think applies to the reported bug since that's a
>> pretty unusual thing to do.
>
> That's why I've asked reporter to test it.
>
> Either way, IMO both of the patches are still needed.
>

The patch Keith posted fixes the issue for me. Should I do another run
with only these 2 applied?

