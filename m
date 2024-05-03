Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D6146D5B
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721587; cv=none; b=RjEIvIly5YH7YyyUVUtT8WkaeBqouNzFl9jXfLL5a6s4Qw32DYIuy8fSFKwuh5qEzv6BhnK6qcyzEPV8gvgPmgTELjnge5eck+fidRsAeudJFKi3AlinpfkX0QOAwsj/cOzEnfDFXoiNEBDsDANRttx//zTd9QIOD42akPkCyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721587; c=relaxed/simple;
	bh=b1XezOORzd5b64d7aiFf9/we/iv9wMSMM7sbsyhJrRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoPCj3zTKTb8LHr9As65vdw5vcpdLOoNjSghDOkJELyu/PRHO8Rs4ezOLWeQFvuHxdImgR8khk6G25iERYFGMxi6zi7mnPas08D+UyR7aqb+UrJsHqk+pVYnH5Y6jbePPZzpxtXBw5yEkQ7Q5O73y5L5bx58lJxtAgYcA90AlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34cba0d9a3eso527149f8f.1
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 00:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721585; x=1715326385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHdTuzF4WpCRrGciBhyi5PVxTiUH0NEDczsrk1P37l8=;
        b=lW1v+wAlWIvMgzMz0c1+qnZowkhCqJSHzzfqXQGlu//KY9PqBxKhJSsrHyc7wZUmI3
         RJzRPmGV630fJFlPVjgfGRmY4G1Y1neKqUBqpxaocr170J4gDkGHe4ZTTqu/QNh4Gz+F
         mYCQTPhXdWAlu3iTeNX6XsYuW4e9nqYnEuRytwI1JoNkVfDfWd4KuI8i+cGHwSTaIabK
         0Laulw3wUnC2rZ0LXnHl3S7z9Gpayvmk10fj724yyCtebghZa1zSwBZbJETfe7fuy90w
         YPkX7Yt6i1pdZdYCRHTN+HzK3rLXqQfNAaG/xWas43HvRPNGlV+Ixu2iz3Ooy8FtmBba
         P1yw==
X-Gm-Message-State: AOJu0YxP2wLVePaqm3N7GO+APxn6mZARM6y5rdF2RTeloyk9Dc+P/6O+
	h7N/fhyqlpYlMUl9qDZOxhJyYC4he89bRZqPDLprG0L0f396bM0Y
X-Google-Smtp-Source: AGHT+IEYrDbizELqBNPGXfUq4T1W1asKlzoGEoXMAPvPSrWZk7SozGy90kvbazf1CUeajndZ3QJnAg==
X-Received: by 2002:a5d:558a:0:b0:34d:7d77:36fa with SMTP id i10-20020a5d558a000000b0034d7d7736famr1225974wrv.5.1714721584470;
        Fri, 03 May 2024 00:33:04 -0700 (PDT)
Received: from [10.100.102.67] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d588c000000b0034cfb79220asm3081074wrf.116.2024.05.03.00.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:33:04 -0700 (PDT)
Message-ID: <3e3f0cdd-0eac-4463-a659-0d0ca9430658@grimberg.me>
Date: Fri, 3 May 2024 10:33:02 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Daniel Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
 <6b55293c-0764-4922-b329-be393c9afc81@grimberg.me>
 <36jinbbjhzr6erpfpnfqmk2jebf5tlnl26skuak73krwyyu6zi@i5qtgb4bqqgy>
 <eeee5574-f4de-45a7-837b-74589dab423e@grimberg.me>
 <sb3syw5ysqvkxvvn7mubzk3n6pfsivq54ownkyju2sgagesxpf@ktfn3333dmt2>
 <0a21ba7f-4d0e-4368-a215-2b81a8cf562e@grimberg.me>
 <bxklo2o4onybsamatf2nyhecnkl3wuoz66p7nq2dyndnfc4vxt@hkokvvx4c7jy>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bxklo2o4onybsamatf2nyhecnkl3wuoz66p7nq2dyndnfc4vxt@hkokvvx4c7jy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> Another question is how it is likely to have more conditions to add on.
>> I expect that people will want to add more flavors moving forward. For
>> example
>> ADDRESS_FAMILIES="ipv4 ipv6" RDMA_TRANSPORT="siw rxe" and possibly other
>> features that can grow in the future.
>>
>>
>>>    I guess
>>> such many, multiplied conditions will result in combination explosion and long
>>> test runtime, so I'm not sure how much it will be useful.
>> I think that running multiple flavors of a test suite is a capability that
>> is bound to be
>> reused as more test flavors emerge. But that may be just my opinion.
>>
>>> Do we have potential candidates of the third or fourth conditions?
>> Yes, see above.
> Okay, the candidates look useful in the future. Fortunately, I came up with an
> idea to make up the condition matrix from multiple set_conditions() hooks. Will
> try to implement it and respin the series.

Cool.
