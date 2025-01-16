Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A61EA90;
	Thu, 16 Jan 2025 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736993509; cv=none; b=SJB5TEXSCKqGFOqDXEKwgh+yTRAJ8Dm4QXNKPflrjNyrwKS40yRjM9I14AP8al+orTl8X3o/wISX39IEq7oG625S0nGXINCEQUehGQxX4xcY8B8QnAhzHfPLiLxrO6QR4GnK5KlDjlWBZ/EoWFBTm+tCXmu3J41nzeRao8Pg3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736993509; c=relaxed/simple;
	bh=PA1DXVARjqJJFLI2ePpc8ilF8IQ+E85vOlbWDcXFCaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJi4qV4UwER+pvkuENr6Qycu61jxSeQ9hcKsq1DAM6PlGiUuOPGJ+IHOz4yCdxPFwcwy2a3UhEUsaC3bO25ydo6ytqt33lPeLiraoRDGEPZVVjPjuJmw31PtvVrqaRGzKdzVUif4k+xswY5o7cnhj0OdmX5cKAJK5HLX7hHiNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic+mNCCN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic+mNCCN"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so666771a91.0;
        Wed, 15 Jan 2025 18:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736993507; x=1737598307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BoaBUpRpUubqD+tM/F5e4x0FQyJkK/Ce/WA2Bx67Y0E=;
        b=Ic+mNCCNRmZY3IAWZdARducgKVrvhluVt9KMnkQf24d3cIvR+IZeQXPLAFUuQOKw+/
         tA4AfIxhzLToah/+1cURkMTmiuVgrl1ZJcLGEo3fWmfjTyfnzShcVgf4wFGt5hmTqbGi
         f4SlQxJvcnECR/vgHQsij9py49+HZGUWtaBtpkd3tVTBaX8QlgUkKWjjdz58aWqfvT2h
         L4m2fImP1Yba8U4VJPiOSzUshMHf/6WTuArbI59WFYLi4y+MjXodCkSAEl/RwiORKrOt
         OHOZstqrG6TfOqW63TPO44GkiCN0t7PoRf0H3dyl294qSQSNx0cbewjVFgPrf2a2KO5u
         FFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736993507; x=1737598307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoaBUpRpUubqD+tM/F5e4x0FQyJkK/Ce/WA2Bx67Y0E=;
        b=U2ol1+AR522JYc02HSlLjoe+9U2sgtuX9MeTdSkZkOq1KzbYWyn2khjVASlYuGSQpK
         lufWi7u/XXWjiyEANZaP+I0+fkihEaB07k4EGmWchT9SUpxuVh+Oatj3Cmq0gOhc+xPi
         cLPXKSYJ+l91h3YXZnlO7bOsteFUML0iTuNwM8kcJIkV93OofNIU1baLJ3vSveROsfnH
         YzqEh6IEvfzuX0mn25RvWlInEnb7mw82iHhmzRSG93mBqIiuJ8eYkf88dURu0CJa9zl1
         ay0QExDOy1gn3LCKIzPcu+bk36UZ42OK+DcWPR+qeq9flH8qZy2Q7ybPowFDelWF2Oj2
         liBw==
X-Forwarded-Encrypted: i=1; AJvYcCUSiB0RbqVlCAGJfDelYtzzO8cXV1du1Xs5BBQpq7BxNeQDPcdcybWjtk/IKKBDPHaP9LZgcYhF7lV/mw==@vger.kernel.org, AJvYcCWl1KpdkqV9EybyTea/AvMG5YOOSnanhFoB9rAK3K96/zUwz7GO7kqRPTyXQuqK7WFXFoS878Y7SSSXUyII@vger.kernel.org
X-Gm-Message-State: AOJu0YwRF7q3xTncvOwUCBAlKChzh3z/t8Tc4V+BxsnQGbTPEUCc4qGI
	N7mfImmPFrbcEljyZQdc+3Jdeh/OuqwbuJGmYiRTJAaO4aJ6Kr/5
X-Gm-Gg: ASbGncuIAz4ytsxlniGBNgapqQcIV2XlNLOc3m3RTEvjrEXsAv72pY4x99lt5uZtiVF
	l8dmUfm1YU68wG/G/HVDX05mk88oNjdmZ2L38o80cOPkB5mo+MA+T2ab1WkNOCmLi2oo6Xjl1F5
	+jhgvkZqJwmtbCQ92jg49mFvgWO3HPItMGiyywJgYBqcIYYOPsuO9ahO2hl/Jr6s9GMeuPalgtz
	/xAymiD0G+J9WCECUGUogSiF23Q9NT9lh7TBYeplXrQHdR4LzmDCKOs+CmHR7lYzKwdJaCZ
X-Google-Smtp-Source: AGHT+IF6Gd4CTfNYdhiTeZ+4wPQj0hmN7n2N/3zk3WhqsOGJBgtobC50NwQ0kB+q8OL4BKoZ6u2unQ==
X-Received: by 2002:a17:90b:2650:b0:2ee:d7d3:3008 with SMTP id 98e67ed59e1d1-2f548f33b37mr54502241a91.12.1736993506592;
        Wed, 15 Jan 2025 18:11:46 -0800 (PST)
Received: from [10.234.9.0] ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c33172dsm2065870a91.47.2025.01.15.18.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 18:11:46 -0800 (PST)
Message-ID: <5cc90e64-4f17-487a-9ab6-691de00c4cb8@gmail.com>
Date: Thu, 16 Jan 2025 10:11:42 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: cleanup in zram_read_from_zspool()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20250115145545.51561-1-haowenchao22@gmail.com>
 <iiiqdmxebni4sfal7rguy4me24tgmzym2v4oz5hzjv624vavr6@kida3yjmoecs>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <iiiqdmxebni4sfal7rguy4me24tgmzym2v4oz5hzjv624vavr6@kida3yjmoecs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/1/16 8:41, Sergey Senozhatsky wrote:
> On (25/01/15 22:55), Wenchao Hao wrote:
>> @@ -1561,11 +1561,6 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>>  
>>  	size = zram_get_obj_size(zram, index);
>>  
>> -	if (size != PAGE_SIZE) {
>> -		prio = zram_get_priority(zram, index);
>> -		zstrm = zcomp_stream_get(zram->comps[prio]);
>> -	}
>> -
>>  	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
>>  	if (size == PAGE_SIZE) {
>>  		dst = kmap_local_page(page);
>> @@ -1573,6 +1568,9 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>>  		kunmap_local(dst);
>>  		ret = 0;
>>  	} else {
>> +		prio = zram_get_priority(zram, index);
>> +		zstrm = zcomp_stream_get(zram->comps[prio]);
>> +
>>  		dst = kmap_local_page(page);
>>  		ret = zcomp_decompress(zram->comps[prio], zstrm,
>>  				       src, size, dst);
> 
> I think you are looking at some old code base (or maybe vanilla kernel),
> that function does not look like this in the current mm tree (or linux-next).
Yes, it's from https://github.com/torvalds/linux. Sorry I did not examine the
latest code, please ignore this thread.

Thanks.
