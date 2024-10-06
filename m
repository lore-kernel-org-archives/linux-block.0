Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6556B8C;
	Sun,  6 Oct 2024 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728198702; cv=none; b=XntGVOogruWO0s4aX6jrsV5joTA5hM9BCdbm82zJoml3oS1FGInbp4RrJa4XkkJUwQIrlXu4ql15GdCPXppUCFvi6wVFEXXqhPZQa3a3R8hbg4UPaoRGq1p/CE8gyeLI2SJxlGs/MsCu2Eq7MFpckvlbyfjP9N/QH7Kw8GhQMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728198702; c=relaxed/simple;
	bh=Q8X2cXpOFDXgqj8xEO3D9HK9yIZb5U215hVozMFfn0E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r1McU6nphmjK33ce+TmRUt/sYr9IsnrUuXiueu/bmNVfw0PSu7VHW7A40Cq7ZG8L4ahbyQ6P2DUWC8OBDp2zQCeL22IQpwb8+H2nDR9fEhM15hy1p0VxeB0tSJS9Zun8wUXAtZpTrPdcuh04K3aq63BBsL/Bwf3/IEa0kiMZcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jit+XWwf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jit+XWwf"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e075ceebdaso2500674a91.2;
        Sun, 06 Oct 2024 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728198701; x=1728803501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CHcfx5NNAf+4HE7foxG0QIWac6K3h+hjnp0dKiKJs8=;
        b=jit+XWwf5MYg3pe4JvxV9ypR5gfFycMEMBh3XMUkrFJ5p4+VR42pbgopHTsRcXa6FQ
         QZI1bLBiOm3sJATvBYVd7g7u7w3rkusdI8+1HEieEg1sYnsDWmOUiBB05wS5phyVbMQ0
         RcNcyN8O83tPW42cmd7oJseQfJ56j0T7ONBjV/otSvV8l7ICbV6PBdwPhElYk3sqoQqg
         QynFzXJ+0jYmyRzIP/8AN8w2ClyPXSo++bVSQ3rhAWur3BCxFzw/3AzWNXzFXTg18YIn
         msFLo0/QJAcDa+GwJ6Txd7vypSwcjJOXJmsQ52V6la/D6qO+9uC8yUmkbW3TRpgGasIo
         m6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728198701; x=1728803501;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CHcfx5NNAf+4HE7foxG0QIWac6K3h+hjnp0dKiKJs8=;
        b=vJ5PzNgQXFpyr3/BeQxUBoDrwQrVfgCH9EEoO1ATbAcCtfVeE/hQdklbE/aPCaFYo4
         FjABqH8zSeH2T75IICq7vt6hd16QX5jNX0vMKCTDTHhB7ku7mtPb1LaReaB3zwvKQReM
         soJ+adKuKLkeqbc6VW8579tw2O9PogxXmOw0YzEHZtgcOp9mHCJgsi7T6kfVHEGbXwrg
         P+HiTIaQlGbG4IXZGmFhBX0m8gGpqOQjnXG7ErwbHkVt5Vj2yz++38/KL3fptyklw191
         FjPkptrmaL93+RvPiGv5Cz2N6CwtqxgtShop34XYFQtX4AhXsF79/j6VhC2M+ye/zZEj
         avVA==
X-Forwarded-Encrypted: i=1; AJvYcCWSvlD1Rp6yi0zLquqWTWPCgyTXdnMiLNWGIA8xhaRW7p6Q5m5QrRNLuPXQRwxGLiUMGxWEgEM76A2RoPqV@vger.kernel.org, AJvYcCX9ZcmQUugCrOhJuuiacjHzo0eKRz7wDPT2cNmRCBuDZxbF1vZSuSeYgih/RCNJhuk1zQkSoj8yZ/Fxng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTswUWTh+PsK93zRWSqKLj7SM0g/7eFxENSvDmWD+fNrC3eCe1
	e2y0R2Cc2Qam2XTE1mR4iPWarwIzwLSftMmfmER0UPlHinugBo9w
X-Google-Smtp-Source: AGHT+IHtSJuC2dsxoZ9umAPcDZFLdzy6yiDtDR+Fxn2rvYGjnMDS1yUYrgu0T0vWfScIb50XMB0LTg==
X-Received: by 2002:a17:90a:4805:b0:2e0:853a:af47 with SMTP id 98e67ed59e1d1-2e1e636f93dmr9416777a91.33.1728198700798;
        Sun, 06 Oct 2024 00:11:40 -0700 (PDT)
Received: from ?IPV6:2409:40c0:230:2966:8a2:4c2e:bb52:a9af? ([2409:40c0:230:2966:8a2:4c2e:bb52:a9af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca284sm4634058a91.11.2024.10.06.00.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 00:11:40 -0700 (PDT)
Message-ID: <759193c0-c831-46bc-8194-9b3525eeeae5@gmail.com>
Date: Sun, 6 Oct 2024 12:41:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Explanation on Uninitialized Variable bio in blk_rq_prep_clone
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: John Garry <john.g.garry@oracle.com>, hch@infradead.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Zv_eFIjstVns-ebG@infradead.org>
 <20241004141037.43277-1-surajsonawane0215@gmail.com>
 <6a0ec577-fba1-44b3-87d8-3a202df19d8c@oracle.com>
 <b22f1750-c53d-481f-8233-12adac30a807@gmail.com>
Content-Language: en-US
In-Reply-To: <b22f1750-c53d-481f-8233-12adac30a807@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/10/24 12:28, Suraj Sonawane wrote:
> On 04/10/24 20:03, John Garry wrote:
>> On 04/10/2024 15:10, SurajSonawane2415 wrote:
>>> Explaination of how bio could be used uninitialized in this function:
>>>
>>> In the function blk_rq_prep_clone, the variable bio is declared but 
>>> can remain uninitialized
>>> if the allocation with bio_alloc_clone fails. This can lead to 
>>> undefined behavior when the
>>> function attempts to free bio in the error handling section using 
>>> bio_put(bio).
>>> By initializing bio to NULL at declaration, we ensure that the 
>>> cleanup code will only
>>> interact with bio if it has been successfully allocated.
>>>
>>>
>>
>> What about if rq_src->bio is NULL for blk_rq_prep_clone() -> 
>> __rq_for_each_bio(,rq_src):
>>
>> #define __rq_for_each_bio(_bio, rq)    \
>>      if ((rq->bio))            \
>>          for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)
>>
>> Then I don't think bio it get init'ed. Whether this is possible 
>> (rq_src->bio is NULL) is another question.
> 
> Hi Keith,

I realized I mistakenly addressed my reply to you as "Keith" in this 
message. Apologies for the confusion. Thank you again for your input!

> 
> You're right to bring this up. If rq_src->bio is NULL, the 
> __rq_for_each_bio macro will skip the loop, meaning the bio variable 
> won't be used at all. So, even if bio isn’t initialized, it won't cause 
> any issues in that case.
> 
> Thanks for pointing that out.
> 
> Best regards,
> Suraj

Best regards,
Suraj
