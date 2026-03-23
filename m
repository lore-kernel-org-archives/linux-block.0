Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD53C5DA3
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286871; cv=none; b=XMy6P3IOFto5oasXAZjGUHew+yX3OvSQYDnQjAe0pmFi1t74gVWaEtjNCHzwxBoR0UCgr/UYdlMNaL2RxPllDFOnTspK9iG1UmDwqupNjSbUC+7iyPwzb5zzCIjTNohEZgzpfzLorWu4BdtfDOiwQ20qvR8oE3sfB8K3p+D2qcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286871; c=relaxed/simple;
	bh=DSR27dCEXwCgimFW8SKgR10h2oeR6mmMacJJieSe088=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWAGig3Y6zYwAF04tNcxH1T4WlAso47KkSR6VNSmAhpXRO8l2PRE3/YjU3N34olIXy+mmPMMJd0Oi65Pc8lmjNqWWiaUO7gQtQjr592M548RAdrCtsgQpOG+SHYz5oKwCEiNUihho09ClC7WUrMDIP86FNvV1yq1HPpuWgIoWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BgIA5tah; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BgIA5tah"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so259605fac.0
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774286868; x=1774891668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVaavBgYqYRKt3FZC3Uis6jy0tbahM2I28juuHZO50g=;
        b=BgIA5tahFwThf2SWW7d3IdjqvR4iWEhzv8vn1HeZHmZJDZAGMl4stuSsRkvqIhVI/u
         v6x+79jiQQOWslK7pH6KmKUXX1KupxnwmsR0XU1DXJSoeJ0oh4KGrTmhk7zEQg7Ykw8b
         qNE16TE8y4q3V2kenftwSI5jLTusFcqw/5KKzthFTNbn9c128RzDWG1WIoulpH4DsIYd
         1kAXmHFge0UPiTj+096Ve6WXLoJNgLhxq76U0NeqOoru/agKBxBNIYGWobwLRo6qfwUG
         BTNBn9rp0b7z3ZeVDu8MNZYraSf/3bidPLvoYmJzIX7yy9wKH2BNAt/VoaE2welJ8W00
         Si/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286868; x=1774891668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVaavBgYqYRKt3FZC3Uis6jy0tbahM2I28juuHZO50g=;
        b=mUdp1+bQ8zkz7yU3MYhXNANVHrFfNclZBwn+u4fENvoJy//8Qv5I9Hcb3C8wz/heLS
         YahMr5KH2ZMSNBhi5YpAaPxiExOWU1Y4eLENYFV6rmpxyvHyQ+QeBt0yhLPGeWxmzZ6M
         f+W443lxo6Nuz9a59+8WTXPYLhgOhfrVAdIw+vt3jf1I3unQLl9UsO80Oeu/LZ67OEMK
         wzYCi+1uFVbkYgqJkQBhT3BPXzxX+/kyQDAjck84TLVunBcNrR7rA11mMUyHstTxWfxJ
         TrNXKPJZzmdlzNFf1/LBPVCRENwesNLl7fEWr3+VCeugjgZ8wd1nZtEyB5zB3qzYomhf
         pOtA==
X-Gm-Message-State: AOJu0Yzrnd+6y0kKp7s9Sac3nrMDKjlKuPOihPj9/ziNQqq8hgMDFSFz
	XyHsz2nvLMKjK3qzurYjs6b/tlvjG9eDdvIvnnQmD7hSI9oLv4K5RkmQdRbMzEuUrGM=
X-Gm-Gg: ATEYQzwLXakJeRNRLQjmNMmaQxzcHovqgrUVQAwM18L1mNd6Tz/xbifNFAx6xOABbPT
	q0RqGkhP7r4C6rJ3pFvExNInG0tMRWwKlZbcm+ZcvoTmchErsQmzAy23osnToBj3KnLGN39ks/C
	cbmPWNfLbHLsWfO8pFvB13PeQyC6c7fSaO+kPQmwlM1w29n7yKuc6Zd1R6lMMxSep1TW8/cD6Pg
	DRYsTsZaahVTtw0KwYVYMYHflUV1k72DPQdirlkumhqp2K9Lpn2Vfv3c0a7UzhoRUu6BwKIbsYY
	70cbh4yjxTDIHj9eWty5eWXUU9LPGA4xj+tzxGEbQOrrog8Hz43Lo8AUCgAPR154xc/E31BMOdX
	52/ftzi8G5SDBmvvbxuo8545FhOBcwMZKirmanVp4NN0BLAIHFRfRYPdED4tCR8Of5GvY01zWgm
	GQ33WI87V28T54hNp6niM0RzevAs9EdJ+rBu+H9FGVfJ1wniu2kTvEMFzaET2c4Th83omJ1xODY
	8O/QZC6
X-Received: by 2002:a05:6870:fba8:b0:40a:5f51:c9e5 with SMTP id 586e51a60fabf-41c113127b9mr8465259fac.42.1774286868049;
        Mon, 23 Mar 2026 10:27:48 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c57bdf2b0sm4970040fac.7.2026.03.23.10.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 10:27:47 -0700 (PDT)
Message-ID: <448f5768-ddbf-46f0-a838-67ad8aa4854f@kernel.dk>
Date: Mon, 23 Mar 2026 11:27:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 0/2] block for-7.1/integrity rebase for mem alignment
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>, hch@lst.de,
 martin.petersen@oracle.com, csander@purestorage.com
References: <20260313144701.1221652-1-kbusch@meta.com>
 <177349768999.37164.10048861817413145882.b4-ty@kernel.dk>
 <acF0aJa-GXGYPqS0@kbusch-mbp>
 <f348e3ae-1def-4728-b8c5-1b32e1e980c0@kernel.dk>
 <acF2l2coqz2K3j-V@kbusch-mbp>
 <f9c32e5a-ea3b-4a69-a269-ba1ebf474992@kernel.dk>
 <acF31yX6TyTprnyY@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <acF31yX6TyTprnyY@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/26 11:26 AM, Keith Busch wrote:
> On Mon, Mar 23, 2026 at 11:23:35AM -0600, Jens Axboe wrote:
>>
>> You're looking in the wrong place. It's not in that branch, that branch
>> only exists to have a merge point with the VFS. If you check my for-next
>> branch you'll see it, and it's in for-7.1/block as well (that's the
>> origin).
> 
> Oh my bad. My local branch was pointing at the vfs one from the rebase,
> and I assumed that was the destination. I'm making new stuff on top and
> was confused about the divergence. Thanks, and sorry for the noise.

And let's please fix that nvme list link too!

-- 
Jens Axboe

