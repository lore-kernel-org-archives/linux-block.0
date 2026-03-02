Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103F2E7BD9
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468666; cv=none; b=ivNxMuolLGym5VdgaPxfUckfcFvl8sxw3vygf5ey9sBaH/wniO2sRuQaJFO3buYwU6gYyKw2kGKxF7yXzWIXF064khagIguJ1x5pfK2XhnRmC6L6B8ssXmqPkN7R0eywEyKoCBRvX0OiNFLStYX3Cvmm1Ypr5t/yy3sfH5hxyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468666; c=relaxed/simple;
	bh=OvCJeUR4m9MaKYpumaEfnsdViHEDwMCETJfbBD/nWUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYbV8i7noS/WyU2Ux7RsafEu/6i1aB3xo82W+eYLkNQorAq72L5S+fGKVc/XtJbvDt/II2tuyj1ljPhtOmu8l/CM6E0GBRJ9DKrNZSrwg6dFC4tcN2bWkganxDPqxXMSKquM8jQzgKod8DR9/rBkAms9TFVxhL1J1XBAwTqB9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HdR2uJTs; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HdR2uJTs"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb40149037so482499685a.2
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 08:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772468664; x=1773073464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUZwWykBmAprlFeNlig77VsPLwf8pInXaTxsIjgJr44=;
        b=HdR2uJTsBFgrcJFA4MGLirIFxmVORUfZ1OJzSulKK9KMGWgqdc7CDPHnnbdJrHM8M2
         rPFqIIcMzOJwXuBsR0wCOgsZw7B16PI8I+2cPqGeb1e8pITTcRZee5RndykYuLdza5Nv
         qhfwXnoJakpY2FvqUwH1VHbA7G+K4OxiQYxhZ9iMARMJX0pE0WHpvDDTyHoNE9zvUTaL
         U+kUxyeE7deZjV8KxZP5VJVkVlGeY0BRm8cdU7oXho3b+nRCLo5V9fyo9W40lEcIqLsE
         QHngcP2rQREe/D/S2DgqD5+VmrDbeIHOyzKEqCDQY5IyfZjzlZ1Fgv0XZhKgqZT4po4O
         ed2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468664; x=1773073464;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUZwWykBmAprlFeNlig77VsPLwf8pInXaTxsIjgJr44=;
        b=JuNLN0W0e+rz2AmbNbo8cR1B+gdcyC1GO4lBNAEp1u81A8TV+U8ZpR+wCOA/f9G4T5
         ztsoFv0jOmfaigWx+ffLzhfQ7mUpRNiTriWTbD3IqilEbtAFDRGGi9NBZ8VxGjFG8oWk
         S3gg3iyEHAqffuuY+PHb5H1lnIhUyv0owLhoVNpS69mMFLoXPsYYVDCdxt5wp7jqxlGr
         vM95pwrCIYdTSgVtgC4T+T8Cb1SCMWlkDu1UH5sA89yOTR4kaeTmWWp15/nOzBZoLavU
         3NwhOybzmqAVBdS+4cgV9h6S5qVb1NbZ3LM44mI5UnTGMKSa90ONWsRyz6QpiOmyhB1f
         XV8w==
X-Forwarded-Encrypted: i=1; AJvYcCWtSOtZf+8wPW8RKEYvWKA6Gr8Ll1c/ZXuGSg/FU07MSTpsA+b1phAcZpIwWlPcP2aKSL7EDtJvujq5xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJv3v6GoezLU4T4BmxL6nEeP/af/0DFTRfGNS3GnwoKiUKg/X
	InJIlYMp+LYKebJ7X0Y883mMkkXnHuU+umSCta4AN0YygXidRE6HTCcioYeiU/G9rr0=
X-Gm-Gg: ATEYQzxN1P6l3S/pduWLyzB1OsjP2ZkE6/iCSWFm9zQCffwWAvY75cjUE8qPKOFpnGr
	RI3DRTumDo40l8sJqWTu8jXRkAvrYi+6o8aobck7k6BxUfqM2yZFsLlBV/WzoGJXOpb11/z8cpE
	mUL1IMKwNM2Svm2lwKR5ATfP76bz8iHTRcsiQm68ngjvTax5Hohf0wy5H84BlvtWFvcIBMW3JS9
	Yo6MlRTAvDqsO39ILMB0DiiY7z36zGJ5+2lIBaus374R7lNtYEpFo/EQ399vXlY8+ZVUMJVQAQ4
	vlv9d5OO9aJKP/d+3H7ZyBkefgleiP0odnIDR/o3hpXo8UghOsqcRESgwe932ZBJ5aGGLUUylug
	o5s+Hvn92cI2csdLRftkXBXvzlyUwfY918/CoLJlLkaCCqUxnsIHQr4WG+DogrMGmIz27An31Ce
	5DulT8jRTzn2aRU+1BWKBmQwoQEC3aoE7fYArSbH+Bu6TCmbNCFVFbISEBQscPPQHtlU/Ca6n4R
	pBM3S1Z
X-Received: by 2002:a05:620a:7118:b0:8c6:ca70:68ac with SMTP id af79cd13be357-8cbc8de8389mr1487730585a.46.1772468663922;
        Mon, 02 Mar 2026 08:24:23 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899eed12615sm43997546d6.8.2026.03.02.08.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:24:23 -0800 (PST)
Message-ID: <f83f7246-dad7-478e-a3b9-491a54e5443b@kernel.dk>
Date: Mon, 2 Mar 2026 09:24:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: break pcpu_alloc_mutex dependency on freeze_lock
To: yukuai@fnnas.com, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, yi.zhang@redhat.com,
 shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20260301125951.582690-1-nilay@linux.ibm.com>
 <8eaab53b-6525-4a9f-9a4b-94ce7e7fc09f@fnnas.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <8eaab53b-6525-4a9f-9a4b-94ce7e7fc09f@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/26 10:11 PM, Yu Kuai wrote:
>>   	for (i = set->nr_hw_queues; i < new_nr_hw_queues; i++) {
>> -		if (!__blk_mq_alloc_map_and_rqs(set, i)) {
>> -			while (--i >= set->nr_hw_queues)
>> -				__blk_mq_free_map_and_rqs(set, i);
>> -			return -ENOMEM;
>> +		if (blk_mq_is_shared_tags(set->flags))
>> +			new_tags[i] = set->shared_tags;
> 
> I think usually we'll keep the braces for if branch.
> 
> Otherwise feel free to add:
> 
> Reviewed-by: Yu Kuai <yukuai@fnnas.com>

Indeed, I fixed up the style issue.

-- 
Jens Axboe
