Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D950A64
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037291; cv=none; b=hnSqFBoeYnDfKmB6NjqIqOBC/P2ak4KJ/HjDVL0LcTsg3ng9WvSAbDnLcEAVwE+frUP/r3GSONsk3jta9+FgfOXRn6/omp7CD3vXZHBYj/+W2RbxUfH3hs+feMJRYsYYUzpWZcmfGWli2xIKfDwxoj/OAdVXtAh1ort9aSDxYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037291; c=relaxed/simple;
	bh=GRUtmW5DDTyaa9sa4M6VNFXyo2pl/IQKnJb55iswBnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OJZdCaP9Ju7VwNoaUTJWURxWxIFGPNNfd3B91byCDEEcDjMcJD7rO8HkiCIPlAuRAeVFGQMhhqUsSSOnms5gSQ1mnPzYscEdtJi51kNznMX0Kmm3Gr26EGMShDLgz4sBSpiog/i0XOdQspXzOvIsgGXjqLjY/TeQwpVD+rxyuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IUlHvCc7; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IUlHvCc7"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so53406439f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706037288; x=1706642088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQmD14o2i+RFk1Bbm2vKAG2qqUM4FFqg7Wme+8/Qmbw=;
        b=IUlHvCc7vKTppz25VUHbh/gpF2DHwL8FzAx34I/0z3bFYAn5FA/WysaO2m7FdmR3mH
         ye8pXFPfh1ik3CBO+3kZPS0Gb5l+E5NV5LiVH5PEZWWyIvl0bqzKSY2VJBeVXgHDush3
         TAz96E3RJLwKjysGJIGoGDRaFQuM3RFbCTXUwLnVrf7FSnykeq76e6dfT//YyO8fEcVM
         Bi/0VZlT0sbydT35BoLBTndJ/RVLMUPHD5CascYBPICqhi1FdVF75/YS8eYfHFqpLWgI
         +LvFOUUCgCF1iv4aBUtQmpRb/2Eod2hhxXw8FsqwkmIY5wvlz8ry5XPvOQmxm81Moy+Y
         ZL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037288; x=1706642088;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQmD14o2i+RFk1Bbm2vKAG2qqUM4FFqg7Wme+8/Qmbw=;
        b=oS5Uh7kdiYAi/E5SgPRH1vfSMRRw827xpVohpKuYH8XVNDDAQCE247LKm9KWovpCRk
         9P9fxMzEWxFzZCs4wlUGEfoi/FgeaLf8VP/0Y4P5FgyjflCbsEdnmzMXwimaoZHXZroA
         nc+45qkFPvhR8UkP+3VlkgqjkA5GqMTIeGteG48EzZRXZ5vWwNjLjr7uoWgfibFTCGF1
         heuq38kL6vGAsd5Lo2mVJaByAsI1NTfIYeTq6Lrxj/wglbVinbxvD6pv5dSxPxAkeV/3
         Nx8MdJEyNwJBBVpFlu5UJOJRoxAIIZqdI3GQH3dyAqWulUJcN9UsNNDbdvWshWEq0c2J
         oHiQ==
X-Gm-Message-State: AOJu0YyVzeaDiWtF4mUJQ9A1+gmjNV55fcZ+bPAmoN267+FNW1eYKuXS
	1H7YoPTKcPTapIvXC12+VHy7Ghzz7NOHbxuWSxG4GPsJWwF5rUbUcUMdDj6xWDeKiWBEmTSCbyc
	J5ds=
X-Google-Smtp-Source: AGHT+IF54bzrhzAGZX5d4ih2uHeHJVsqHiRDHwwlR0yqshJ/6GvVw9a4NXA/m1XJYUQ0JY56jBqCgw==
X-Received: by 2002:a05:6e02:1a42:b0:361:9667:937f with SMTP id u2-20020a056e021a4200b003619667937fmr201044ilv.1.1706037288089;
        Tue, 23 Jan 2024 11:14:48 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l4-20020a056e020e4400b00361a956a57bsm3445104ilk.53.2024.01.23.11.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 11:14:47 -0800 (PST)
Message-ID: <c16f98f8-f973-4a10-ab40-3a678d9be4a4@kernel.dk>
Date: Tue, 23 Jan 2024 12:14:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] block/bfq: skip expensive merge lookups if contended
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-8-axboe@kernel.dk>
 <43b9a943-45f4-4001-a68c-a68a7364f995@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <43b9a943-45f4-4001-a68c-a68a7364f995@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 11:44 AM, Bart Van Assche wrote:
> On 1/23/24 09:34, Jens Axboe wrote:
>> where we almost tripple the lock contention (~32% -> ~87%) by attempting
>                   ^^^^^^^
>                   triple?
> 
>> +    /*
>> +     * bio merging is called for every bio queued, and it's very easy
>> +     * to run into contention because of that. If we fail getting
>> +     * the dd lock, just skip this merge attempt. For related IO, the
>                ^^
>               bfqd?
>> +     * plug will be the successful merging point. If we get here, we
>> +     * already failed doing the obvious merge. Chances of actually
>> +     * getting a merge off this path is a lot slimmer, so skipping an
>> +     * occassional lookup that will most likely not succeed anyway should
>> +     * not be a problem.
>> +     */
> 
> Otherwise this patch looks good to me.

Thanks, will update both.

-- 
Jens Axboe

