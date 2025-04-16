Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715520296E
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816237; cv=none; b=pgYGMLve7BZFT2+37EJK4B1KrrkNFQAYmBTfmBZ+Jdv7JE+ze66/WSWOAQ8dDHWTD9RRBrRbZRrkC6L7aL8fn/5z/+kgRF9bDdDG1hiEIjF/E3wimDd/HmIhhBsvf5NpWm2HZJwiT2I/1w0pWwo0VdbY1MNveUBAuqqDC5Hngew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816237; c=relaxed/simple;
	bh=Ide8UYFDeeWAs1T/7pbZuBK8NGXCkQz+pW9bPws632E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkY3MVsa1hZj0iB0Qv9KyoN/pOft9vlJeyE3Z7Wd3parAtLiRlD+bXKc/kwpm4yUmvVICmoSuwN/1re6/RNA7PIMq4JCTNWm3WNxkMYkn1URejH79kifeInY/sXSWUl1yJ3WYwWKoeVn4wRVXEKGd017sti8KUZvfYsMOgmDRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CnPjaQs8; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CnPjaQs8"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e751cffbeso516697939f.0
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744816235; x=1745421035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0/VAqjkF1TxpYnRhzPRlf8Ce1qx0Jj3f5VBhpm09qo=;
        b=CnPjaQs8v1ri2+WVSKVVXv98MygiHAkQzAirhP8FmKogh13uREmw1MhfJmSl9ujtCR
         V4AdODbbSq1Fzg80LJHIeHwSBecFERYIvjT6ZxaVr4drJZhrpUg1pyIlQ/8LjHpXWA3p
         sk3900V9k0QOa7LFMI2Bp/ElzE1A65Fal8XdEhIEMNRUItoQw3iNH4OOxwqpnJQUEGRN
         R3tfDjRj/Q5363DEZhNsx0hlbyflEWbCiam4W0fyQKso9SGoaVOnx2hYovemL0CpsEkY
         +slwJn4f9duRv66PXNWK28ii8n03Wrrgp6wpgRUrggke7MxKe74O2TtDW6tDEOzg9fx0
         EIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744816235; x=1745421035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0/VAqjkF1TxpYnRhzPRlf8Ce1qx0Jj3f5VBhpm09qo=;
        b=s7j9pasiSiOG5+SPnvqmEWTBreYcu3lcV57cak/bzwSNIfaGNAttlb7A/v2xcfrdnj
         /9PMonpojtbyrazeNNxr1v6rhHNaun2MUsw8q/USF3LKxXKHjtTZI1zVtcNV2hvw/zln
         p5gRXdm1epoRG+7m7jyNOLxDkMCXFfzRfkJ5xfUdszM/y0ViJYqAsNSMYFskVEK6MkfH
         lrjBtxIwk78TllyvUBL9Z+t4N7p3lnFtSosbtsg0rZ7xOLfbGCN8qxkyZhzEoR9lecKJ
         Y8oWfr1Lk226AzuBbXupwoKFN9Qcv0g44h21v0HHd9CeCOunBVrtIIuDD8p8hpb6itvd
         uZXw==
X-Gm-Message-State: AOJu0YzZvq3i86Odi/Vc5rSUOd06nnZOqQpuZEwMUF684+hzRYte7EhQ
	fCAKisS7G5hOGu0xlHOx3Z6GO7GSTsoKHFVglFFTs8FKpMfiZ1N3v0UAmnLi11I=
X-Gm-Gg: ASbGncvM3HbNBjkuuSx91c/8mx8XF1ZIgDxhEigK+MTWWVXPfiSQvXWmVQxf5PPR6xY
	82xedL4q07tFyr2zrWGimGK34jzsraEd9tsP2xHBkkYFQcL29e2x6hUtjJiJq3/cp9vqBMKV4ra
	OgasxhEA0E1jtziuiqMgU2KEAVaS2+UfQjbzhD9jhu3ZU/wGEcCvIvuQqpS5FSuWMgn0zWQEV9T
	fOBJU9XpCBuYTuPZJDKIgCPnj0DpLwj59RtWPqpeuwOfBy2Z+wDlpmk+/3w2FLD8O/P/U7Kf07T
	hLZQBtDyQ/aLReLWs+mBioqaislrLz/CrD6V
X-Google-Smtp-Source: AGHT+IG9lQIK5sXneDabYlnfRgSCtZ39ELSyEdyUKJIaRYq5uFV6x1HjDv9FC0Ieo/MZkxOXm+Y0Vw==
X-Received: by 2002:a05:6602:398c:b0:85b:35b1:53b4 with SMTP id ca18e2360f4ac-861c57e6f93mr262149139f.12.1744816234774;
        Wed, 16 Apr 2025 08:10:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505dfd731sm3641805173.88.2025.04.16.08.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:10:34 -0700 (PDT)
Message-ID: <d3231630-9445-4c17-9151-69fe5ae94a0d@kernel.dk>
Date: Wed, 16 Apr 2025 09:10:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] pcache: Persistent Memory Cache for Block
 Devices
To: Dongsheng Yang <dongsheng.yang@linux.dev>,
 Dan Williams <dan.j.williams@intel.com>, hch@lst.de,
 gregory.price@memverge.com, John@groves.net, Jonathan.Cameron@huawei.com,
 bbhushan2@marvell.com, chaitanyak@nvidia.com, rdunlap@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-bcache@vger.kernel.org,
 nvdimm@lists.linux.dev
References: <20250414014505.20477-1-dongsheng.yang@linux.dev>
 <67fe9ea2850bc_71fe294d8@dwillia2-xfh.jf.intel.com.notmuch>
 <15e2151a-d788-48eb-8588-1d9a930c64dd@kernel.dk>
 <07f93a57-6459-46e2-8ee3-e0328dd67967@linux.dev>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <07f93a57-6459-46e2-8ee3-e0328dd67967@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 12:08 AM, Dongsheng Yang wrote:
> 
> On 2025/4/16 9:04, Jens Axboe wrote:
>> On 4/15/25 12:00 PM, Dan Williams wrote:
>>> Thanks for making the comparison chart. The immediate question this
>>> raises is why not add "multi-tree per backend", "log structured
>>> writeback", "readcache", and "CRC" support to dm-writecache?
>>> device-mapper is everywhere, has a long track record, and enhancing it
>>> immediately engages a community of folks in this space.
>> Strongly agree.
> 
> 
> Hi Dan and Jens,
> Thanks for your reply, that's a good question.
> 
>     1. Why not optimize within dm-writecache?
> From my perspective, the design goal of dm-writecache is to be a
> minimal write cache. It achieves caching by dividing the cache device
> into n blocks, each managed by a wc_entry, using a very simple
> management mechanism. On top of this design, it's quite difficult to
> implement features like multi-tree structures, CRC, or log-structured
> writeback. Moreover, adding such optimizations?especially a read
> cache?would deviate from the original semantics of dm-writecache. So,
> we didn't consider optimizing dm-writecache to meet our goals.
> 
>     2. Why not optimize within bcache or dm-cache?
> As mentioned above, dm-writecache is essentially a minimal write
> cache. So, why not build on bcache or dm-cache, which are more
> complete caching systems? The truth is, it's also quite difficult.
> These systems were designed with traditional SSDs/NVMe in mind, and
> many of their design assumptions no longer hold true in the context of
> PMEM. Every design targets a specific scenario, which is why, even
> with dm-cache available, dm-writecache emerged to support DAX-capable
> PMEM devices.
> 
>     3. Then why not implement a full PMEM cache within the dm framework?
> In high-performance IO scenarios?especially with PMEM hardware?adding
> an extra DM layer in the IO stack is often unnecessary. For example,
> DM performs a bio clone before calling __map_bio(clone) to invoke the
> target operation, which introduces overhead.
> 
> Thank you again for the suggestion. I absolutely agree that leveraging
> existing frameworks would be helpful in terms of code review, and
> merging. I, more than anyone, hope more people can help review the
> code or join in this work. However, I believe that in the long run,
> building a standalone pcache module is a better choice.

I think we'd need much stronger reasons for NOT adopting some kind of dm
approach for this, this is really the place to do it. If dm-writecache
etc aren't a good fit, add a dm-whatevercache for it? If dm is
unnecessarily cloning bios when it doesn't need to, then that seems like
something that would be worthwhile fixing in the first place, or at
least eliminate for cases that don't need it. That'd benefit everyone,
and we would not be stuck with a new stack to manage.

Would certainly be worth exploring with the dm folks.

-- 
Jens Axboe
