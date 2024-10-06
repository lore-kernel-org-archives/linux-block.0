Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88216D4E8;
	Sun,  6 Oct 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197944; cv=none; b=m7E5VeFOhOcoAOsbIYiVLiHounRxaO2Yw4fd8YJkNqPfrp5XIuHK48E2ZrsD5bdQJNw5oCunaYGUOuc1BQP6xGPiVXAu8X5sWhISUBEBgQnwnoEhomZSrYHCqUhfMoyLsmk5C8/WxcGCD4s1NbLDrB8zCFG4IKJ6qqjF/sybueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197944; c=relaxed/simple;
	bh=/ZJ7KmFOl0EpI21Y0KEtqt/Oqi3/GZoai/I0cVMf/YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLDEXV1Ufb9+9nCvz7rPBGIj1EmgKJ1Si8DRRdK6fY8QII4qCSSHkFpI+MKy0kHS04h/xpMyuTKRxbPtF+5MovioASHJcHEPgwckeWtleakcBkRcF37LE6VUYw8LdrAtwSg+/rUTkiZUcw4d97jOpfWbHOvvClrs11Msa8XCraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PipkX5Ft; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PipkX5Ft"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71b00a97734so3183553b3a.1;
        Sat, 05 Oct 2024 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197942; x=1728802742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6i+cth8VkyIuhVRMhBqiNkopkDZ/SGnIu+dJ7Vv/9ds=;
        b=PipkX5FtxhgMs8ue/n96FPR5CZAJz77gOrAt5VJblPd8gGTVFcR7XL+0JjIAMnlfpS
         pbKeLgsl/PDNIa/iaglODn/vHCSJCGBIUgPlTtpNNzv7Kg1D9Ldw9QkxSlv63sfLS1PN
         vKRYI75VmTdhjiunoi+NZEHIr8fULPENCVc4N+/b5YxVnUe3i9y1MTTFSDXb2Fc3sSCD
         e04l4ae9LwrMAm6zFdOGaru3MwWMpqrUvVnRpU4gAlg9hEEeTmPrRtoSbfkWENxj1eW1
         ha5CsE8X7wMa6mbZw7/goFJuFRFvfaQ1xXppIH91fee8djvFbgwVq4XXHPYF6OMGXmTT
         xf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197942; x=1728802742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6i+cth8VkyIuhVRMhBqiNkopkDZ/SGnIu+dJ7Vv/9ds=;
        b=IY6Utg2aCwnSGlFYHSUiJw1jjzdXytQH4H86THh6A9EMuJ7wk172wbz649k9+HLjMX
         jXskcEXZdOHbEQeNL+ULZZix1BxWI3yUlD7XMctYNO8nniV/e0S0edeVn2Cen4QAvhJL
         63OhAOXWxQ34w2RfhJJzDGGh/K5WkcEvjPyaNxcva8qAYZXKptIxzDh7/bFsAE35BfG0
         JNv4gVVdJd/iXTA0MO1QtGB7WurBFk+GajiTE3Je6UlBUO13D+wgH0/PWQ7kzXdHbrqd
         QnbScE/Oh3GPwrMsgBOvVYHvHHN6eUeRnILTr10VLXDycX0PsZIZnRB1/X+jc4gvG1M0
         14ow==
X-Forwarded-Encrypted: i=1; AJvYcCVn89FB4+c3efqIFPpEyCD1PEYyAGN4kIygLSFhMPmrBb532ZijY+RsO7V9y1OwfMIb2VYuk2k57vtb3BRX@vger.kernel.org, AJvYcCWqu3aniGYztJT5h4W+JEA4NzperWMmxUC0H16Ql9fK5ZD1/e0z1FmYxUyOlVrfwaTdoWGrsS0jePIA5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8k3Ebw6r6joyvXZ28Oz/Ym3FFJxnR73vNCtSJwhwjXkVevDZk
	UEeq8J0oQp0ytK1MmVkNy+nGW7HfdFpeFTWDT6b4HTnWu9DlgK+6Fw1FYw==
X-Google-Smtp-Source: AGHT+IG9vz8p5FUmnO6dAYjAuUD+uETY9KO4Rrxcroy4S/nYfi9f0mZ4v5TkdZzJoYa6FVs+Y961ZA==
X-Received: by 2002:aa7:88c2:0:b0:718:d7de:3be2 with SMTP id d2e1a72fcca58-71de23df1c8mr11603943b3a.14.1728197942007;
        Sat, 05 Oct 2024 23:59:02 -0700 (PDT)
Received: from ?IPV6:2409:40c0:230:2966:8a2:4c2e:bb52:a9af? ([2409:40c0:230:2966:8a2:4c2e:bb52:a9af])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4a278sm2438134b3a.140.2024.10.05.23.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 23:59:01 -0700 (PDT)
Message-ID: <b22f1750-c53d-481f-8233-12adac30a807@gmail.com>
Date: Sun, 6 Oct 2024 12:28:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Explanation on Uninitialized Variable bio in blk_rq_prep_clone
To: John Garry <john.g.garry@oracle.com>, hch@infradead.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Zv_eFIjstVns-ebG@infradead.org>
 <20241004141037.43277-1-surajsonawane0215@gmail.com>
 <6a0ec577-fba1-44b3-87d8-3a202df19d8c@oracle.com>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <6a0ec577-fba1-44b3-87d8-3a202df19d8c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/10/24 20:03, John Garry wrote:
> On 04/10/2024 15:10, SurajSonawane2415 wrote:
>> Explaination of how bio could be used uninitialized in this function:
>>
>> In the function blk_rq_prep_clone, the variable bio is declared but 
>> can remain uninitialized
>> if the allocation with bio_alloc_clone fails. This can lead to 
>> undefined behavior when the
>> function attempts to free bio in the error handling section using 
>> bio_put(bio).
>> By initializing bio to NULL at declaration, we ensure that the cleanup 
>> code will only
>> interact with bio if it has been successfully allocated.
>>
>>
> 
> What about if rq_src->bio is NULL for blk_rq_prep_clone() -> 
> __rq_for_each_bio(,rq_src):
> 
> #define __rq_for_each_bio(_bio, rq)    \
>      if ((rq->bio))            \
>          for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)
> 
> Then I don't think bio it get init'ed. Whether this is possible 
> (rq_src->bio is NULL) is another question.

Hi Keith,

You're right to bring this up. If rq_src->bio is NULL, the 
__rq_for_each_bio macro will skip the loop, meaning the bio variable 
won't be used at all. So, even if bio isn’t initialized, it won't cause 
any issues in that case.

Thanks for pointing that out.

Best regards,
Suraj
