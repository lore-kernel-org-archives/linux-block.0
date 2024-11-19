Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200221D0DE5;
	Tue, 19 Nov 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035188; cv=none; b=ntkbUdB+fCdSdJvSEdFjjUxZWNT9P0xb+OJ9uTOSTmA/3zMZWF9WBKIJzsQbR9q2cNH0ep6sAO9muIHeoapBf/wbIS+SHdBqHAMNvl/EFkQnoYZ30o0RcsLVYoJuxSWGbL6D9iqtE+rPUrKfgjwA+n2HIIhsdy+UoFmbPNEMDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035188; c=relaxed/simple;
	bh=fXbQ+sTDfae0/sA53nV7LRM3LwW6fRpxjcYtNtSgcKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSxsJFzFGITNznQqsFFZct3rZ4fIuN6480+ppto04hibICJ8wX/zCmefvrP7cEqpnA+4L7FDP+YxMSiNDXKi2LaJuY4CvOmwGgq8ell1RQwzpBOy5QwXmC1V0hyXbm+YJ+aejurZyfAzb7ZhuDzTf+4/JC9lgWri73GsYS1aEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKI2Ba0q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKI2Ba0q"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21262a191a5so5159985ad.0;
        Tue, 19 Nov 2024 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732035185; x=1732639985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DV/IxUG/5c+HAy0GIa65hguhql0hPamy6BPKU6ya4bc=;
        b=mKI2Ba0qCLUV7Rh8UWrLpcn29R/N69c8rTdcF8AGtjLPf5apHDxWTDUVM/JgoC+blb
         B0ftjQn9Fw/k8ikOZmx3NtlpfiVKlVEBaBVJGBB+iNSM4O7DOVUYZYS8ldzHKEDad5HN
         GHmSKeMUSLmF4EQdCdTZISYAAY1NadndcLmCzQueWyKXP+yfIlpPzutjFjgB8eOA69Mx
         GdjO4Bcm+I9SR/RIZw8iZGQAEqHWqqBqRkLKwKW8lvcCg0kRAH5W2al4gENR24RoMwuU
         jCEVnew9xYNGeRv33FOkLwFuhFOZ6mzYr9sczd0mHMKb32VNZq3b3JYIEEEozvHC6Ali
         y4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732035185; x=1732639985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DV/IxUG/5c+HAy0GIa65hguhql0hPamy6BPKU6ya4bc=;
        b=P+dKchO3ABXeCYXhVV9mLP3PrWMQcvoHKkUnzEUhuH1FMPikLqiqkYGkFirjq+lKmY
         c5/ocxMYvAmQKXL9LxByM17zaOmmoT1tXAPyWHVh/h5iy7i3gyPkJ8vnAqRMEaLtoxiF
         NBzidI2851zcGxIdhvA18c6d+E7kFPXsBqA1gyiPP9xq6FdJ9y8w0Jnr93zEU4PEGqPI
         S4Sg+/rfW6QaDoboAKA92Mltvql8Nt/U8Njnl/zqc5ylkwcS6JniB0pHziESNf5Yyd6w
         T2RnWRyYLcjcIohFMZFQgALZurHFN93rHnZnsWTDCrdi7XwYoCtmp3BcIwdLtYZAdpWq
         TTwA==
X-Forwarded-Encrypted: i=1; AJvYcCVBW/QljWpd9sTUqrmEuvQUa3yZGUYU6pDIz0f5MZUQ2mG0m1VyW8uEBboG/kg6QoIOIUm1qx3FtWcX/Bxc@vger.kernel.org, AJvYcCW273GWQj5j6f4kHUakr3M/cm2nBOEo95VCUpRPfrd4TJA9PqRncvHky2BX+5f1BSXZUrCUa9Wh678O5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUQ3Ygis/BMzYyatl9cTgPqdpKE2jIMBkFjp/kG9ZHsWZHbZ4
	p9g3nNFjAd7engjdzsY99vc6kS2btuP/rJXvm/TlU4xY8WjkDnt5GEgk4/cZx7A=
X-Google-Smtp-Source: AGHT+IHEyA1o1dSsEXDaliBc6WDoznGYd1+Iv9GN6TnBmFUXfso4m6YCqMlFVOUALt8T6boReHIZLw==
X-Received: by 2002:a17:903:2292:b0:20e:55b0:35f2 with SMTP id d9443c01a7336-211d0d5f504mr269379275ad.1.1732035185261;
        Tue, 19 Nov 2024 08:53:05 -0800 (PST)
Received: from ?IPV6:2409:40c0:11a2:6510:4555:ca08:e78d:a9df? ([2409:40c0:11a2:6510:4555:ca08:e78d:a9df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f555c1sm77259785ad.268.2024.11.19.08.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 08:53:04 -0800 (PST)
Message-ID: <2feebb67-09ce-403d-8e46-6217e32b44c9@gmail.com>
Date: Tue, 19 Nov 2024 22:23:00 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008175215.23975-1-surajsonawane0215@gmail.com>
 <70996029-be8a-4f97-88fc-a27cff4f5df4@gmail.com>
 <f6a50924-e3f8-4175-a97e-4e77ed24b72b@kernel.dk>
 <f90b485d-a78e-4bcf-bb77-94f68ad575cf@gmail.com>
 <ZzreiYfmoG-s5127@infradead.org>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <ZzreiYfmoG-s5127@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/24 11:58, Christoph Hellwig wrote:
> On Sat, Nov 16, 2024 at 05:02:57PM +0530, Suraj Sonawane wrote:
>> Apologies for any confusion earlier, and thank you for your attention to
>> this. After further analysis, I realize that this change isn't necessary, as
>> bio is already set to NULL by bio_alloc_clone on failure, preventing any
>> real case of uninitialized use. My initial patch aimed to clean up the code
>> and satisfy smatch, ensuring better readability and error handling.
>>
>> I appreciate your feedback and the opportunity to learn from this. I now
>> understand that no change is needed here. Thank you for your guidance and
>> understanding.
> 
> FYI, I still think the change is useful.  It makes the code a lot
> better to read for humans and machines, and fixes a static checker
> false positive.  So I'd still love to see it, it just needs a better
> commit log.  Feel free to contact me off list if you need help with
> that.
> 

Thank you for your valuable input and for encouraging me to improve the 
patch. I have sent a V5 version of the patch with an updated and 
detailed commit log, including a thorough explanation of the changes and 
a summary of the discussion so far.

You can find the patch here: 
https://lore.kernel.org/lkml/20241119164412.37609-1-surajsonawane0215@gmail.com/

I appreciate your willingness to review it and provide feedback.

Best regards,
Suraj Sonawane
