Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6514922CBE2
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027974; cv=none; b=Ljl6yW6xrEO1/stmRgQcGUspml8ue5LJkQ13ACgVP/mf8pcZr688GPds2jWRQ1zbB6HLYH7Lzy2+00JnsVHjlOuW6/3solM8VzdSxJLGY0qIKYy8V61YOJYtGRgIwhbyGGeMT9RFGee0CE0auCYe8Ds7fE7OKacK/Urt41sGRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027974; c=relaxed/simple;
	bh=EEHOzN1yvkeJNVbqDiG9R8LT35ZSToHupj+aYVx7ZSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz7OKxXfqz+Ci4+OOBYX6ZaOA6bL09LIlEuH1rwBkPoztrOVZPqyYoCz/6NE6PNrGS0UR7V12Dahv53n6gFL6sRBsr8xEObXZDFU8hgDDaujcMTrj/4ssB4H6iHOS8j9yjRb3UTg/cT4ofHkV83LUlMbIiPHMA8NzCHQMKum7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTX5kNDY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTX5kNDY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so30780835e9.3
        for <linux-block@vger.kernel.org>; Mon, 03 Mar 2025 10:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741027970; x=1741632770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=En0oxqXlRiSeNkHnrnvwTl/qmG9ayLdWdL5GpexyKBw=;
        b=bTX5kNDYl9QKQmtrcNktJCAYM2KTy/a5+d0w1G8uKl3f/hLvKh7go0uLKOzDRz8lx1
         oSXiXCaGc7zgGAC46CtOitPT2tuYSlK/O0hv+NMnVIJRhixoDaK2/IIva2u3l1dM/Dla
         bs8YsNWF9dI/SmsCQCBMvbHpa0CWY+Sc3PbPLXe4Jh6TXNxYFgrNn8i3JXUHXI40mhJS
         H87ssHJ/I7zXRK0DuLcyMB6PszDKc/3cwglF0kSulVqgFT5qWTxAbyPKe2Yx1qYic/Qt
         vEo9Ifk+h902Kc474OeMFiEfhwKX7yWpXp0HurE2gCpDfMyhoZDoom4DoUMrExzC3SYX
         Lslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027970; x=1741632770;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En0oxqXlRiSeNkHnrnvwTl/qmG9ayLdWdL5GpexyKBw=;
        b=kF4kw0AvQocp5/XqNLUf1k9jRX3MZO1qUrIAhgB/Swn1pukJfWVLk37ZkBSppcIHuv
         cnREc7l+mCZ157C01LLLqBXkRt+8JhD/bAt6Bc+S3tYVUK5yqMMedTALoxVl2kR+bbAN
         x1MBzZiqXnVeNdvFoxW7adQYzIOxl7Xk7sCEvwowKfAgpWjIsnQyEHPtDySHYQtTbGia
         w1SwLrMIZO2pDAMPt5Nl5MnXMQI61KKQWO6yel+/YtuUlD7UbOmUmhlY+LymhdKP5hzo
         578RsNFkwuddkwL7QHbirDaZnzLRDcbOJJVnR1SHkVsj9M8LTNXndSlSqY2txVQVzolZ
         4ZhQ==
X-Gm-Message-State: AOJu0YzR5y7GuqhcWIQk77B+D2CrmPeUflfUTOtB8s9fycXZAjHQ0Fnn
	s0aM6OoMeDkdIZ/ePktdcrvlzFxvpinwrogvyZiWEdv5J6KlUE8U
X-Gm-Gg: ASbGncsHdwqagzFYQRDZe2wXSzh/AxLWmAG0AaD/DfuMP8VSzBs2PPlZz+2zqjbHSLE
	VEg5SBHFxCUGZywJ/7BgAbZ7I0Uhp9fZBefga6GEV7YGqXZSJxtFY655LL8k/sc4hzMafC4WPc5
	FQAYc3Wld1mNZCJRjAJRhcRvplCK6AeAt+nOis8fGleMmJuurNj5do/lU6cOdJZ8GYpkqctiOyT
	Mhsm15kwo3qAMXmb3YkqGXF0RocP8XlEYNFEWSZP/NK3MnJOfIo/M6z2tNYlCrAkcx4Fc3nIbZs
	tlqrtSLylOQVmaxaSNBwOGMw5gIgYASGHom8viyacADLN3w3aiQyE6ykXCFs9MSKLEivUA==
X-Google-Smtp-Source: AGHT+IEHAHV3yhhahdkN+fbfXE+0xaIPzDYDyUqfhMAF3xvpXZhjHl0ZUk4Bo7KnuXlSZGsfpKCZZw==
X-Received: by 2002:a05:600c:1550:b0:439:9f19:72ab with SMTP id 5b1f17b1804b1-43ba67583ecmr107929015e9.23.1741027970245;
        Mon, 03 Mar 2025 10:52:50 -0800 (PST)
Received: from [192.168.2.22] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc1b5db02sm46717345e9.19.2025.03.03.10.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:52:49 -0800 (PST)
Message-ID: <8aaa0b97-ef9a-4bd8-8f8f-7c6869ff4c26@gmail.com>
Date: Mon, 3 Mar 2025 19:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: sysfs-block: Clarify integrity sysfs attributes for
 non-PI metadata
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org
References: <Z73kDfIkgu4v-c9W@infradead.org>
 <20250227144609.35568-1-gmazyland@gmail.com>
 <yq1mse2xdlk.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <yq1mse2xdlk.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

thanks for the clarification, should I just update the
patch and add your signed-off line?

Anyway, some questions below:

On 3/3/25 6:25 PM, Martin K. Petersen wrote:

>>   What:		/sys/block/<disk>/integrity/format
>> @@ -117,6 +119,8 @@ Contact:	Martin K. Petersen <martin.petersen@oracle.com>
>>   Description:
>>   		Metadata format for integrity capable block device.
>>   		E.g. T10-DIF-TYPE1-CRC.
>> +		If the storage device supports metadata but no PI
>> +		is used, this field will contain "nop".
> 
> This field describes the type of T10 Protection Information that the
> block device is capable of sending and receiving. If the device does not
> support sending and receiving T10 Protection Information, this field
> contains "nop".

There can be "none" and "nop" here. My understanding was that "none"
means the device does not support any metadata space (no T10 profile possible)
while "nop" is that there is a metadata space but it is not used by
any known T10 profile. Is it correct?

What I need (in userspace):

  - a flag that device supports non-PI metadata (is it that "nop" above?)
    If not, then there is no way to check for non-PI metadata for non-NVMe
    devices (as metadata_bytes is present on NVMe only)

  -  maximal size of usable metadata (currently NVMe metadata_bytes field).

...

> Wrt. the size of opaque (non-PI) metadata, I think it would good to have
> a dedicated field to describe it.

I think that metadata_bytes would be enough, if supported for all block devices
(note we emulate metadata in dm-integrity, so it should be set there too).

Thanks,
Milan

