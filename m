Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343856B8C;
	Sun,  6 Oct 2024 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728198245; cv=none; b=SFnIFHLUf0hEPv8lfpHK2l5rrz+2wwqePMk+ItaxU6ekgwJdt4wPnRdPy+80NiQYkgjtoNAYzOF+VwtwI9VZq5Bn8WQYufZYO0yMPeJQky8bFczwIuYogJe9JkCMBb3L4RSEglOcJqTZAUQMxHZtFAvN5kG1/oJB1Ky6jGPTLuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728198245; c=relaxed/simple;
	bh=QE/gYYmH1NYWAnAdCGa55/OCwoLrR7JBzqdkfa33QRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPnyDG07WgghPXKNppENZHX+NeCk8/WlKDD4CInRUrTFWfRb2TPhPNL6i0p7gnvHP6eGmbXhJ3iS6gy+pZqBStDkZ8xvu/cMJO6yn94bqOdjNKDRGIcbjAJuCvzWkuh9k3TSxHPpudfyTrblAkmBI+p/vTfshWN/U/8rycopoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vrs7hDhF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrs7hDhF"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71dff3b3c66so109698b3a.0;
        Sun, 06 Oct 2024 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728198243; x=1728803043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tckbyZE/ry4Oad1LzSUnqMT9bRU9veKDtELrYVoCd/0=;
        b=Vrs7hDhF2ihObCCGVYZ9SdYlgrFlCucyEuOKEatBZTGGxdkQekHQ0N01WgDZsYwi5r
         s/uiKtThM7fa0m8H5MIgu6G/7dxyCzYgMHCnZgSvUcHbnaCkZAJDUqXgwLoxONOdKMKS
         aR0oh0CMLwG1+fI9AD0u8iLV2GWNzJfjXsYE5HfoHB8+/RdL45jS4MxtAx2/jDpJzXcx
         0w2sVga7Hk/YEXrkVd2IlXnMGyxx5T6XRY6ogEmNBFUfbEw1jEkNsG2hqlJQ3DjN+U9J
         BEtnxVoZTcfEuMnwDQKElTgKCKgZ+Bff5hj+hK7XqgvoTCtP+cIF4jVe8MqVZF4KZQgo
         r4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728198243; x=1728803043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tckbyZE/ry4Oad1LzSUnqMT9bRU9veKDtELrYVoCd/0=;
        b=mt2uDcJVs79MtMhmFlXUv11uoLq6KLbZQZF7pDxLzAy4LxBfIQetHqKzkaS8cPUyfb
         loh2Ep2JY4ygD/4BWT7pJI3x9qpbG8ddX8wIczH7zlM1Bky1dRJOyuKAyseyD1lcsw8g
         n/Knuznh9yxBTTyPiL2wkCsA6LdcKPf8ZGqatwaCvqkjvHSkIpX/bd5bOAKdx0lymcpd
         sHwOZUI8e4HVk+T7GBOFF3d+jJQpEo4fuy8V6053VtNsZFBmiGmvPlxZAnovjh0Stpu7
         q9NnHiiUow6MgJZ3N85zbwK5VLplr2MsmIIeuo9UZVYdI0W1tlgCCEvdzPovPDaENgiC
         wKcw==
X-Forwarded-Encrypted: i=1; AJvYcCUFryFpC7Gwn7OLeXJBXjA30WWORIp4hSuuE0XU6OmGO8+HTrHPaeQx+PHb7tdY8/pveT9Dls0IUZOieABa@vger.kernel.org, AJvYcCWzJ53E2kbM7p6m3WGwPy2mzIgKFVjwqc+FWyC5lnCrkBqILqFYcK2ukKyVXCvHZFPk4rQNAybln+TdaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQIdQ5IWxvnHsnJPgxXeTDh92QPqtF0PukVLzv5RUyXwc4PF/
	pXxByBXWmSsr4DO0HG7y6iq/Bap90hax7ytzzXu/NWl6VF3ymgza
X-Google-Smtp-Source: AGHT+IGW6364qkiD/cHu9+Vws4u5HGye8AxVjb25Ef9DEDTEnray4ndXZoXmnJuY3gK8qIHwMsl/ww==
X-Received: by 2002:aa7:88cb:0:b0:70b:a46:7db7 with SMTP id d2e1a72fcca58-71de23e8eaemr11940318b3a.16.1728198243461;
        Sun, 06 Oct 2024 00:04:03 -0700 (PDT)
Received: from ?IPV6:2409:40c0:230:2966:8a2:4c2e:bb52:a9af? ([2409:40c0:230:2966:8a2:4c2e:bb52:a9af])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb976sm2377055b3a.23.2024.10.06.00.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 00:04:03 -0700 (PDT)
Message-ID: <d4463564-7593-4956-a598-c7ec8fa8f851@gmail.com>
Date: Sun, 6 Oct 2024 12:33:58 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Explanation on Uninitialized Variable bio in blk_rq_prep_clone
To: Keith Busch <kbusch@kernel.org>
Cc: hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Zv_eFIjstVns-ebG@infradead.org>
 <20241004141037.43277-1-surajsonawane0215@gmail.com>
 <Zv_-DSM2NhuiX3o2@kbusch-mbp>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <Zv_-DSM2NhuiX3o2@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/10/24 20:09, Keith Busch wrote:
> On Fri, Oct 04, 2024 at 07:40:37PM +0530, SurajSonawane2415 wrote:
>> In the function blk_rq_prep_clone, the variable bio is declared but can remain uninitialized
>> if the allocation with bio_alloc_clone fails. This can lead to undefined behavior when the
>> function attempts to free bio in the error handling section using bio_put(bio).
>> By initializing bio to NULL at declaration, we ensure that the cleanup code will only
>> interact with bio if it has been successfully allocated.
> 
> I don't think your explanation makes sense. The line where
> bio_alloc_clone happens:
> 
> 	bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask, bs);
> 
> If it fails, then bio is initialized to NULL.
You're correct, bio_alloc_clone returns NULL if it fails, so there’s no 
uninitialized bio after that. My initial explanation wasn’t fully 
accurate, but initializing bio to NULL is just a safety measure for any 
unexpected issues later on. Or i am just trying to solve this issue by 
smatch tool: block/blk-mq.c:3199 blk_rq_prep_clone() error: 
uninitialized symbol 'bio'.

Thanks for the clarification.

Best regards,
Suraj
