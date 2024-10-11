Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4DA218D68
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652370; cv=none; b=eKDAKTkBP9iLBeU+6M3n3rC9CvnjPx1KTcqzSQOdtL15NuRwRUcSFR6C7Z8PutqG3siLneR0i+UqwcZ1HZDLo28bcYKsx4Q3d9fCs7JXMPy8Z1W5hptefNz/M7QXYKZpVjrQGAsrqhpMZnIyRtEm7mmTnB8mRsRQAccVxQD1ik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652370; c=relaxed/simple;
	bh=my2VxRQrXUGJdn6lj6aDPWYkyYR/YcYNoSYt8mDZti8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rys61Di6DlQONm+xLFHx7Wk5Gbo8+lYhWXJCsDI7kUCh/++ZgPdIdMzYcuDJRPmHm4oRnGEUosYlGrER8j67mB7b0AyK4fmSSUN+arjM+R1KS7p1nxBqk7Z35IDWdzA7J3UqULfDTLgAM19xTfEio0LhWNn1DDma4+8LBqPoc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qa1B0Q94; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qa1B0Q94"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-835464abfa7so66965539f.0
        for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728652366; x=1729257166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjBvdCrJy9AjzpnGvNRYO/januDKQlvw/jXh8GXjiJ8=;
        b=qa1B0Q94tEZmPXciEeIRUzIKUDEUfbdJyESpg0jA6inM+mEY6PLdN+8Za19dpaBbds
         pl9Pvakch/lQFyycOeepF3RKQ/6q+eGAWrOoRN1MQWEU4ZHVM7dR3nRKZCYxbHKSUH47
         H331aph3ryzG1dQZX13uhypzul2Vv8XuB6d2RfVLCKzfNl/CHnxCI29UvJ9Da0WPWQPE
         lWjhkIFd6UkERtmwC7RgBqtJhK7GOxpZwjYpfO4Vtdk0zym1VXyR8bfWVXgCbR3LTOA/
         LoBTLQ/KaTpO3KJKvZdNhd8XawF6xySLlkZQ3vfjOKxOAyR5j6rVXw1RVUpPGruB/Nf4
         zYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652366; x=1729257166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjBvdCrJy9AjzpnGvNRYO/januDKQlvw/jXh8GXjiJ8=;
        b=n4vnt8iNB+W3KPLcBlrF1rSuzNcNv4+gOag6/BCjJtBS9ZXR4foNPHvZU5VYAwynWr
         HABhOITRLV3cbXXqoeIWI8JAX+Z9/jlrwUDk5WpfK1MqWel21MQmMtHaYodVsglBpdqP
         7B/s1v7aFNGcg60l4mR1LuWvgnPKbGCyW+/KUHfbpqP9sBTOrn3tf3EGYrkndyBD0fDa
         cMPaby0BKjsBzGLRXRjh8C0kYyWgcMcy88OjoseUAJEfaqLLKlCMOOTVQRBSJDSjqDds
         KEX32/eEHk5PNBjS3JXakXAtnIRNWtT70KPc7oxY6jRSX+ngGr9dOZcq6rQCtKXzVxXR
         BuVA==
X-Forwarded-Encrypted: i=1; AJvYcCVhQBs9H9k2Fb/nJ+at2gTgXABX4Hj5/BnUMOWddmSqKyt+UFICbbWunDyQ1nZRT7tksXm22AbVeU4KZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPOd6uRcdDWcAUS/7xCAkJtNR/OdXr5Ws4q1MBmKWLEevgdgI
	sjfZG5Ge42dbnmKN3xCh1tu1JGqbxxkmOfgYZN6dQ6KATOLtr0JiDdlsmG1vn6c=
X-Google-Smtp-Source: AGHT+IEtFfHEv9wmZhEEa3otACwtmvnXlmBWNr+mm/Vzer9DqTyJNJvCgM0xkf3v0OQ9WdwaWhkU+w==
X-Received: by 2002:a05:6e02:160e:b0:3a0:4db0:ddbf with SMTP id e9e14a558f8ab-3a3b5f5cd14mr15928995ab.8.1728652366239;
        Fri, 11 Oct 2024 06:12:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9b11c3sm634588173.10.2024.10.11.06.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 06:12:44 -0700 (PDT)
Message-ID: <1b4889f3-3140-4855-8c74-f0c9df7318ca@kernel.dk>
Date: Fri, 11 Oct 2024 07:12:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] elevator: do not request_module if elevator exists
To: Christoph Hellwig <hch@infradead.org>, Breno Leitao <leitao@debian.org>
Cc: kernel-team@meta.com, "open list:BLOCK LAYER"
 <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20241010141509.4028059-1-leitao@debian.org>
 <ZwjgrwSw2vUVP2cp@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZwjgrwSw2vUVP2cp@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 2:24 AM, Christoph Hellwig wrote:
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 4122026b11f1..1904e217505a 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -709,13 +709,16 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
>>  			    size_t count)
>>  {
>>  	char elevator_name[ELV_NAME_MAX];
>> +	const char *name;
>>  
>>  	if (!elv_support_iosched(disk->queue))
>>  		return -EOPNOTSUPP;
>>  
>>  	strscpy(elevator_name, buf, sizeof(elevator_name));
>> +	name = strstrip(elevator_name);
>>  
>> -	request_module("%s-iosched", strstrip(elevator_name));
>> +	if (!__elevator_find(name))
> 
> __elevator_find needs to be called with elv_list_lock.

Doh yes. Breno, I just dropped it for now, just send a v2.

-- 
Jens Axboe
