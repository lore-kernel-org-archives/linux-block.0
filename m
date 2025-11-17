Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3D248F64
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385797; cv=none; b=Au+VuX9hllSrZ9w4VYRSgN1sfjacEvkiqvhMkQAjtHarBZmr44httmG7qBdD4xhIQkoVuLnU0AHCLmnpvpXQsqCWgYWM77FH3++aMOZ2oqw0/imOc0+f3bwBxMKyVcumzAajSiPxQH1LDhbBd1KnBLWBsE5iRcbRqQedy4xamys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385797; c=relaxed/simple;
	bh=7+SQiYboLqUzU02PRwe3sOndoFYAcj86GWuLWmGAW50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q++etxrYrqUrdpCfTf3vX+GwLapHxVi8UIyzUDT0/NiFWLjipt1y6vR/g5Kh+2k6M2XiINXp41wLGjmPJfuXSVViBOJDPHHKLJs/rRVr9M11io8RlOyKT0yjE3uk/uYud08/10gRcPpLhkNk9+bEaTzsS2cj4SgT/4WmGB8eB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UZSXbCsg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UZSXbCsg"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9490a482b7bso39915039f.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 05:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763385793; x=1763990593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJlasoPNgct20UbFhWqs9XjquharNVN3bJkeKKlewxw=;
        b=UZSXbCsgQypZVlXje5UQgqEeKDPfKNGrx6X26BpKV7y0O5ImU7QFQRkHFAmKdt/JMW
         8m4VNV/fiYRTf3y5p6TZ60VYTrvtlA9GmBwiw9MvsIXaYIiqU0LjIBG8x1cpLRBv9RBE
         2UHhjhJiTl+m8o6a9yeMDJF8zAoLdahgO8hjU6kyV4yF+D0aOPOtfPIAMI7VJkG+NtK7
         VrKIBrVyN3F6v0k+5HLO4s0/hSp1O3REfdDnP3Fb5UN8PJfa0jmdNXxJJpejh0xwfEGw
         9gumvWTJ2xyt5AmE3bhuNfN5NU0V+fMBgbgt7K8Nv1nuHtPVQs8cdS+Sb01oh2x/i94T
         Q6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763385793; x=1763990593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJlasoPNgct20UbFhWqs9XjquharNVN3bJkeKKlewxw=;
        b=AdDDe0j+b97MTK+sCqrQ0sohLvNUcxjn7z1lZSu+JzgEXeuenp3RLhLPOeGWcpQLNg
         f3qn+/iNHtNWiwq5eKrHgoQ9M8oZDMAGpH+YxYJZ9iaswzT7uLsoZ2BwRC5bRbiLrbhE
         UKeXehMhwPjs3HuZv7ZvKSHR3h9Vi+2dUFWc7YKiPGdZgEDIwPIRpNTR29zsS3jFhnb/
         oNqO7mnjRpZquZipCftiSXrXYjRGfBu3dDxX4y5QwPSZPESWtO547VLu9QhWAFV7pb++
         djJtMxUa0MLWYLjq1cOg0Zlk0HX1O/qPcs4N3f7l7JSU8Z8vRDpaJKtyPRsLd+LwOLI+
         hASA==
X-Gm-Message-State: AOJu0YxAr008zol205zQLnOug0Le64Wj7KGQKKZfWX++W9hMOFNd6DKC
	1G3zcvw3K5Nor9p2WRx85wqj9ZBUUvtoCxT2MF5Zjsm3aeZGfvx8cU/ezj5iiTL7NYPuEXz/UO+
	oeFon
X-Gm-Gg: ASbGnctvoOYQrr5W9BAXJBAFq21Weeu497dn+Z3kaVyG8oj+Ek4K2/l1uU8nCtrYZ5T
	I7nassJkmnwOYhk0EKgECdsO8hHfBkNgLay0cDhrgOEiUeXaZ39XWYN9HW0IZNaB4cshv9vH/9z
	AxjT+juQcRNz3oK2iI2aOgYBjV3VMX0/Je8YvlHQktiBTGailbfXHfGNmBQa8G1ZWAlwiFrKd1Z
	poWmQ+YcfZHkBak3uSDavxvIR9JbZQeZBa3xw1npYlrxwfBPDqY7ERB4AgErRmvqKNaXmvAb99b
	k+0NAc8d5iZwEpdq6WUkugNnlbtX2nBvohrPdZPUSzYcDwmNM1PLC/wuCvRJvTcP4hXvxIOkaJj
	K7kkAOMd8pajnxZggudO0csMrR++eNiYwi1Gl1NzjiIA5pwdLswwdUAisyFTYeQgzTEKXBsHMhA
	==
X-Google-Smtp-Source: AGHT+IET++AjtZs4125CrwAm18Zh4YEYvUnmvFxxPjkfhWrKOVvHNt+yT626Iu5B5AZ51ofdZDDqxw==
X-Received: by 2002:a02:c490:0:b0:5b7:d710:661c with SMTP id 8926c6da1cb9f-5b7d71066camr6995756173.23.1763385792996;
        Mon, 17 Nov 2025 05:23:12 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd3301efsm4665248173.52.2025.11.17.05.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 05:23:12 -0800 (PST)
Message-ID: <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
Date: Mon, 17 Nov 2025 06:23:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: linux-block@vger.kernel.org, efremov@linux.com
References: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
 <20251114.172543.20704181754788128.rene@exactco.de>
 <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
 <20251114.192119.1776060250519701367.rene@exactco.de>
 <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/25 2:56 AM, Ren? Rebe wrote:
> Hi,
> 
>>> 64k is 4% of a floppy disk! But I hear you, works for you.
>>
>> Again, still only 8k or 16k for most of such remaining workstation
>> floppy users.
>>
>>>> But if someone wants to refactor this code some more, ... I'm happy to
>>>> test it, too ;-)
>>>
>>> I don't think refactoring would be required here, it's probably just
>>> capping that probe read to something constant irrespective of hardware
>>> page sizes.
>>
>> Well, the floppy.c __floppy_read_block_0 does:
>>        bio_init(&bio, bdev, &bio_vec, 1, REQ_OP_READ);
>>        __bio_add_page(&bio, page, block_size(bdev), 0);
>>
>> Is there an easy way to limit that to less than a page without
>> refactoring it too much? Otherwise we could just apply this hotfix for
>> now.
> 
> 
> Any chance we can get my initial one liner constant PAGE_SIZE fix
> for this over a decade old bug in? I currently don?t have a budget
> to refactor the floppy driver probing for efficiency on bigger PAGE_SIZE
> configs I?m not even having a floppy controller on.

Yep we can do that. It'd be great if we could augment the change with
what commit broke it, so it can get backported to stable kernels as
well. Was it:

commit fe4ec12e1865a2114056b799e4869bf4c30e47df
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri Jun 26 10:01:52 2020 +0200

    floppy: use block_size

?

-- 
Jens Axboe
