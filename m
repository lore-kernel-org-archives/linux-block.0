Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03B1C36
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352401; cv=none; b=PxysEaXB4JzTwef8ddiRmF7x9/HPKmUDyib/uAccKfqaMf5Hy5h6JInI8YSExSxvSb+zDsNoZCDObXMYZFcefayNc9+DkmOkjR+HMn2dAL9eMiGpmmyT0BkgP1tiIRgcdXwUPRoTQie3T5E2pH9uZbA4TjJbtfSmHIUiUuoICm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352401; c=relaxed/simple;
	bh=XQ5nUcMfRmRQalpHWsKRjFp50DkC2S0mIncfUvueyrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CA/wFUDb3eSlrK7w/yMztI7pz2UakgaoYryPB+VNriI93JnnLbjGw59ehIXIi3Z3u3qYPI3LcRB5593sT4Wk/qnlJt3XWlDXJOQU5qzCVcwyOnjzRTTaq8+1wLlQvUG9Wm1M1ervmBHbFLlBTKoY4RC5a3U6uTzCHVuiUf1qncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gntKk2mA; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gntKk2mA"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36898a6f561so10189475ab.2
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2024 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712352399; x=1712957199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zYpXQy2TGLSS5pNTDHj6TsjsKi0t0WFWSeQ6Kjo3Ps=;
        b=gntKk2mAeG0kwHrQTvmpkoy5xH4V81Hr32aa6fwYD3/5x6zXP7at+8+NwL6nDsmibg
         Azf/6MOKNSit5TyJyYnr6mp++yzWzifcQSyw6Mw2o9GztBW2wSNZFMMiZ3J+MjF2WKN8
         B8IowjsPOyaoKGQ0thUuDaCLTgvylZZkgnjlXNjMm2y6iXVdftFr0byG9D7kT5WhiMPz
         4JsTj+/bY0UxKKriGeikesSFTSGhf2KEMLPZpqedfNEqaYbZyX8UD5No8lLCdNO0c/gi
         0Ci7C7fUu0OyNPPELHvmNvbxsnOHChe/UC7bRl63lkCN1hlKsK+uo1D6C0Fgfz6LhzGX
         oy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352399; x=1712957199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zYpXQy2TGLSS5pNTDHj6TsjsKi0t0WFWSeQ6Kjo3Ps=;
        b=EZTi8DMe32sS8wjLL9s/BEwT0IQeChwlYoHYNqRBynJc2lYe6ewBe29ONkISZ6z8NN
         TBsprffuluR9oDLVjFr3XEH6ONa+4t2sUGxb1Oy3LkHSVOV2ZZ20JNdxTBYj+1xwrKfp
         1ogSqi6UpDQji9cPkOKyFERZQulQiXnofLg+Ida0q+uXPX1rfEMAm3UInenyaPHMe7h5
         mMy5dzvD51WlDVjXlMow1Zi7oxKLqTJ+d6URw6WaLpmubORHzwD9nGrjtYl9OjXgjgiy
         ltR0GuNSQwPBJSZHn2my4XXwj4yo/MCIgwPlAg8o9DlqaP/nYJfLWDIDIULmtdIOL3jQ
         GsWw==
X-Forwarded-Encrypted: i=1; AJvYcCV0UKo9BIiocFXDbSDWMnzP9+Dq31XBY1byALk16fuL1qqRsWC6eNg0WXerYAn7kOZu1r/uo+Zkv3FcRBSlPP/aZRiM8NvGoBAGwDk=
X-Gm-Message-State: AOJu0YzUy/6NX9QWZcEtYzlw8IwqSxQy86vV6yALXw7DitkL67urm0D8
	+Wu8RapEWwLbeV+X9/0r1WdAVQl5ZgNnBWQg6LmqHwaZQhM9fcykb6fQI17tsLc=
X-Google-Smtp-Source: AGHT+IG2OZR2zKKNyI7CYg8PH4fDx5bHUqAyZQE20EAq1R+MA+Cpa1kbreI6ycFBtoDH06OOGRPoMQ==
X-Received: by 2002:a05:6e02:1d94:b0:369:f0eb:439c with SMTP id h20-20020a056e021d9400b00369f0eb439cmr2310492ila.32.1712352399413;
        Fri, 05 Apr 2024 14:26:39 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:c6c4:352b:b00b:887c? ([240b:10:2720:5500:c6c4:352b:b00b:887c])
        by smtp.gmail.com with ESMTPSA id j19-20020a63fc13000000b005e49bf50ff9sm1944885pgi.0.2024.04.05.14.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 14:26:39 -0700 (PDT)
Message-ID: <d1b29915-1b74-4818-bab3-68d1f9a0456c@gmail.com>
Date: Sat, 6 Apr 2024 06:26:36 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: sysfs-block: document size sysfs entry
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240405165434.12673-1-ikegami.t@gmail.com>
 <be24545e-55b9-4fa5-8189-263f981f50d2@acm.org>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <be24545e-55b9-4fa5-8189-263f981f50d2@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/04/06 2:42, Bart Van Assche wrote:
> On 4/5/24 09:54, Tokunori Ikegami wrote:
>> Document it since /sys/block/<disk>/size is undocumented.
>>
>> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
>> ---
>>   Documentation/ABI/stable/sysfs-block | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-block 
>> b/Documentation/ABI/stable/sysfs-block
>> index 7718ed34777e..881049419054 100644
>> --- a/Documentation/ABI/stable/sysfs-block
>> +++ b/Documentation/ABI/stable/sysfs-block
>> @@ -707,6 +707,13 @@ Description:
>>           zoned will report "none".
>>     +What:        /sys/block/<disk>/size
>> +Date:        April 2024
>> +Contact:    linux-block@vger.kernel.org
>> +Description:
>> +        [RO] This is the 512 bytes size sector number.
>
> What is a "sector number"? Please change the description into 
> something like the following:
>
>   [RO] Size of the block device in units of 512 bytes.
Thanks for your suggestion. Just fixed by the version 2 patch as mentioned.
>
> Thanks,
>
> Bart.
>
