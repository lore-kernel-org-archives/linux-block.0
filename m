Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0E3B893C
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702175; cv=none; b=dU4vNjb4tFKAEY6HkVmZ+sAt7hok2MrlGZ849EGSZUgAcTikvlhhlp8O4GomU1b++p4xFGjuEjTBjDcIXe/+9XK60iYotWlGg431RArNnaTHc7d4M83UtaqTvlYn2nmPF9KgGz+YzlEryxM0QypTi6d2euc8Bav5rYUgfIqp8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702175; c=relaxed/simple;
	bh=DZwcPmH+04E4hEMYfZxmWOphebXi2TK5M+0gKLhYoho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oFYG1IpBPwM31AFyUMXNT7dcVZ84dbIN1jBbiMEV0WxBob1wdIeeYWULBCN67i6jC2kZYz6w1pH46y4DxV0zPYgb+NRzsbJrYEt11fZruSkagobp+EDbcY0D92exmo3G8MpF0MvnnvNc/i9GE7OagxessYex0aEgAcyLBuT7MD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=f6Pt21f3; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="f6Pt21f3"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbccf6a23dso5866190a34.2
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778702171; x=1779306971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=krbyiVc8jSJdhIcgAt5f1amAPCSUW93oLBkGCtEucHU=;
        b=f6Pt21f3Ba14Ughj5nW6FhvEeVxnfyxR9Hfd9N7qfBD4kWEcfzBLegRro2xaxCtbp1
         4TEoU78u9kP28JeO9U0b8EcJsREKriT3MhAY0wmftebymQVxymEiXhRfPXSHFih4UZ0v
         NKdxQz6d/Gcpy1N+ZW++VET0zyzI8kGSKr0chlV0oQCAGSlmfIRglFiX3+Q2QuiyoiA/
         YzfcMT3DtoJcyUtulPMnUF7dCBTrkTklahLRCYunTq0esIWG+yJ14TQbHoz6U2KgOpUC
         mBWxUlVHn2a6ztPjnlaFqb31OFSIOAgBZs9PPmQTBx0tJ0uZJO81Y1Bh+1IiVQA+kjsQ
         jNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778702171; x=1779306971;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krbyiVc8jSJdhIcgAt5f1amAPCSUW93oLBkGCtEucHU=;
        b=dCwJ77addR+AuCKdk2fkZjhE4E/TYNhq6Dy7iXqgcMIfJtkvwIpPw80luZV77Ig8ML
         Isl9gnycb5eFOs+KHYsVoqlIBtqFX6/EZEG49qejo7kLtpMareviKsY/+dQ1fGrO3wwU
         DtLcZzi4UDMsy7IJQzBsI2q8h7a2RDl4/C8jau9yPBiPrHl3h494EfCJ/8xEs+0e+Qgr
         LIl0GU3v+/i3HtCux+pMU1K2ZoCZl6UPBUuQvmthFGmCnpSoVAmKS69WSRLJ2l+tor+z
         u6ROOviTFhIuCkAI994035bykyOMP8lg5V0k0Z4DULi6aeMbedA2gW84/OVCCKVLostH
         jCOw==
X-Forwarded-Encrypted: i=1; AFNElJ+IXIVDfREsgUuy19PJdl6ugxeRDJckHOXJOksTLSKPkqZ452dptxeJdJDgdEEzyz5KUsZPw161qiJ9uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkhFw1UezKwJ3q4oKmiPzumfUpMmW3wiFzMYkVv/kpbmil6DAL
	mGlaJjRh5MMzakVymt1Q+vWA4kf25aAPThQ7Qt6ZAu4JD+MxXjp4vGJDLBCdXsbgn4Y=
X-Gm-Gg: Acq92OF3+4xudSXB3tzouRONgrCsc3GnpWPxyi/WLII1E1dIVymIvurzZWRV+TRN9+d
	XfjuUpoYDWvR1nfmYt2+bM9gD7Z7J00sZbP4qz1s2cOR50ySlINRMGnXJ4/6HCMU6T+juO9q2nW
	tXXcguU4rYQJ6OUtTp8yVCYvh0VFLkf35tZkhFGBZy5OHETLHeNbNjKAYchZERF8zZWd0bwf0Ye
	chv35cTpIzrkn28eyLmQ83CtoF0CAN7qNzFtcx4j+QNdUOCAJO8RPigdnK7XareBe0r1b0n/6Cs
	kQraiUa8e5OHnnDZswwYoae6pvyg4VWjIDQQI6/MZBA3pj5gQAmJsLqyCWsrcKM/05csFI1QB2E
	YbCzumkrvGFcVw9Y1cn5wAHCw7l7H1iFuuhA/PocvccXGk8f2zscdmel3OCTut97jTXNJzvt6B8
	kA/KC3z3nC/sl/3ZvaW9hMRHaO99FsBv/Uqj3+7lRgDzoxI2agpDrVwxhkEVon5fBSVz77Vwa0i
	ZjXGsbY
X-Received: by 2002:a05:6820:152a:b0:694:9a67:edf6 with SMTP id 006d021491bc7-69b78d81c1cmr2797284eaf.17.1778702170672;
        Wed, 13 May 2026 12:56:10 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25cb58b2sm10339019eaf.8.2026.05.13.12.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 12:56:10 -0700 (PDT)
Message-ID: <30acedd3-e994-4810-8952-613b7d0bd9ca@kernel.dk>
Date: Wed, 13 May 2026 13:56:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fix block layer bounce buffering for block size > PAGE_SIZE v2
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Pankaj Raghav <pankaj.raghav@linux.dev>, linux-block@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260507050153.1298375-1-hch@lst.de>
 <683792db-32fc-4765-9ba6-3712af01676c@kernel.dk>
Content-Language: en-US
In-Reply-To: <683792db-32fc-4765-9ba6-3712af01676c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 11:15 AM, Jens Axboe wrote:
> On 5/6/26 11:01 PM, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series has two fixes that make the new block layer bounce
>> buffering code work for the block size > PAGE_SIZE case.
>>
>> Changes since v1:
>>  - update a commit log to better describe the applicability
> 
> Can we get some Fixes tags on these, please?

Looked myself to not delay this any further, both marked with:

Fixes: 8dd5e7c75d7b ("block: add helpers to bounce buffer an iov_iter into bios")

-- 
Jens Axboe
