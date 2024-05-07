Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE54A3E
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715048906; cv=none; b=hGu+mgKqTOOMAo1fo1O8Kcp/0b1CP7njItvYvmPUMqUmP5edz7Vfgl6rxpLM36L7K+Fckf/UQ6dFyghSmAPytcLBSrVwmP9QrEMnfasxZe3UrJyyBD7fmHzp/ruk2tbeD1P3VCTm2HAN/4VKKuxdcxYcDRhvibt7EdP4jpbAA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715048906; c=relaxed/simple;
	bh=8x76DuarRGDNbh4VSPXvCc7KctaXgSAwJaOlTqnPqIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TA/8mIFPmVKRRaMYsF5HaABet9fh+IExz8gCRKrKGJq+qZtS2O2eMjoxnEoQtPinD3MXp9BxWMJ5gIZ/5bOsvXnQLizuA2dajcSrj1YdE1GnF4P43WRn4vpm0vJc3lK07ikbfRDQX7V5VxJK9bSpzqQtkkGnvZukYx2gUKoFtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zHLjc/6j; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zHLjc/6j"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec8d265389so6750385ad.2
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 19:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715048902; x=1715653702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEszd8rYc09PdsNNr6xTGuOWi7FK729iJPG08VKTGkM=;
        b=zHLjc/6jNJSvzcBaCPBVstep+g4Ou0RmBo3HRpwx/9C3ecZMPr9mdIVEKZwpEsntgv
         8JIzz/ygzNOZMpE/1qxh7MOz00rqe6WkGlBRNSXB0yo2v6NcRNtlGslRkWDfCes+NlQV
         m4ZKEgfFhSNa5eSxb9AMcCd5OVZK+3NWjhpx7QqdP4JiJSioCTKWsmTEiRQrAMYUpp3U
         TVpAYb2DRyylFAmTlYu/cLWmqbWxqzW9JcLHwgKHAurjAm2cmr9R5XxedmAhrWTQxgTN
         6Jwb4+1dNzwaDVjWFrK+tuD+CXWdx9f5855kEP+V2tgh4IThsiUXWpG7HY7G9xx8RjM6
         0c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715048902; x=1715653702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEszd8rYc09PdsNNr6xTGuOWi7FK729iJPG08VKTGkM=;
        b=Famq4SgT4eUoXo7f3M1D29lcPxJ/yI/2u6RLMPqrI06XxlfvKfn/uNV3Xi1uYGlmYl
         HNxJPOjsEmazqOl4T62CsKaPQCu2+vPM+MjOKqo0Vo7e3+zNcXcIPXoxblTs0bAiV6Zb
         OUFCF4VksFMecFUX3bWwAhr2gxQSIPHJwq19LwTGCiUGD3DY+efYRav8DIsFEqlATcJZ
         CXGPs28M7YXv5q8YM9F3dlCCvX89quRpS1t5YhI0U2L6hlu17fgH4TqOqJ508S4Fb/pZ
         JMq4OuEaS0wncHHtTvuwdTzgAkdx7F+jn6H9fm4mDkfPiTJsvPNz5S4LHAohprij2qvR
         Jxdg==
X-Forwarded-Encrypted: i=1; AJvYcCX2jAFan/+KEfcmamAfdiGcDfCy+utOfJ90e0mkrIsjjW2CkdJhu3qeKtT+bKymr95WCXhHMJ9fcbM2DlY4TFNXkQkyZ0Y4wai8U9w=
X-Gm-Message-State: AOJu0YyiVKbOLrioz0IsJDR8ma1ke41qKeQTKJbaR/Kxkn0s4sxEKZhg
	GzP8JxCXrXpgPSGqLUvUR5Hjbfredc1RemPE5NFzio4YR6dKnezjls+/ggivxHqVIZ2ylB6v4S5
	5
X-Google-Smtp-Source: AGHT+IErB8yDgI+bdb76aVdH8sh5oVA8W04SFkmB0p8B/laBWuwZggRQ7fD+CSUzLtTsIB6J1+pt0w==
X-Received: by 2002:a05:6a20:394a:b0:1af:991a:d1a0 with SMTP id r10-20020a056a20394a00b001af991ad1a0mr11100307pzg.3.1715048901990;
        Mon, 06 May 2024 19:28:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id t22-20020a17090a5d9600b002b16d9ab430sm8783349pji.3.2024.05.06.19.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 19:28:21 -0700 (PDT)
Message-ID: <4792740a-0387-4945-8501-b2c240271ec7@kernel.dk>
Date: Mon, 6 May 2024 20:28:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: set default max segment size in case of
 virt_boundary
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20240424134722.2584284-1-ming.lei@redhat.com>
 <ZjmG0aFl1oU2OeDZ@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZjmG0aFl1oU2OeDZ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 7:41 PM, Ming Lei wrote:
> On Wed, Apr 24, 2024 at 09:47:22PM +0800, Ming Lei wrote:
>> For devices with virt_boundary limit, the driver may provide zero max
>> segment size, we have to set it as UINT_MAX at default. Otherwise, it
>> may cause warning in driver when handling sglist.
>>
>> Fix it by setting default max segment size as UINT_MAX.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Mike Snitzer <snitzer@kernel.org>
>> Fixes: b561ea56a264 ("block: allow device to have both virt_boundary_mask and max segment size")
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Closes: https://lore.kernel.org/linux-block/7e38b67c-9372-a42d-41eb-abdce33d3372@linux-m68k.org/
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>  block/blk-settings.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index d2731843f2fc..9d6033e01f2e 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -188,7 +188,10 @@ static int blk_validate_limits(struct queue_limits *lim)
>>  	 * bvec and lower layer bio splitting is supposed to handle the two
>>  	 * correctly.
>>  	 */
>> -	if (!lim->virt_boundary_mask) {
>> +	if (lim->virt_boundary_mask) {
>> +		if (!lim->max_segment_size)
>> +			lim->max_segment_size = UINT_MAX;
>> +	} else {
>>  		/*
>>  		 * The maximum segment size has an odd historic 64k default that
>>  		 * drivers probably should override.  Just like the I/O size we
> 
> Hello Jens,
> 
> Looks this fix is missed, can you make it to v6.9?

Oops yes, thanks for the reminder.

-- 
Jens Axboe

