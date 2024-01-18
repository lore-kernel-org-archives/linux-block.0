Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0762E40B
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705611183; cv=none; b=GATrfdgZAYD5G+HFdRQBB2TiWEqw+C1yNpZfo6HtxU5rLfzcHxGZmbpq4LGYKJ056FOfvnZhmkZb4JmiFicQO/+m0JBHT7coJOP2of5Ve8LF/jr4WN3IOPRUEMdXJeoZnzd0VodoB4A21F7t3sjQ9L+YJFrOv9//04Wr78nUiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705611183; c=relaxed/simple;
	bh=2WuKa+8wuLUCmvLUVK81MWB/4XONu2HxYcwi0ijNhSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PMNHr94Mah0V4LQbsGlsUUMXjSHuPEQCr3UMvhgKo9KKb+QIJutfwZZ6IBZKEp2LmaymX7saFbOoHcRDnjSWAfkTuW2fBwsX8vVrXiSTtEHULxY33E+Llhk4PjrfW1w/+0FHko7tRIY+6wwIT7/mI4NBe1b+zqRuNfW+/s+R4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aLM4pnqj; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aLM4pnqj"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so1439939f.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 12:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705611180; x=1706215980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4Dy7CZDC+qgW2soI8VL1gi9PMSzhSCNe7SXJ08/Zz0=;
        b=aLM4pnqjmjdJfgEWTIshC4sDzj/eHz24D10ybqeauuSxwg5d0ekf8E/Z8XO6O3PESZ
         APnmwntJL8FhgcUb4fAwZeMVFrDSY1RSwWBM5sYntx5ozxXKdcPUJXnLdPTluWuBwjDw
         QpyKo8jl7rNQC04t76hmw6CClebu+9yyHivj+F9l8hl9jee44cXFqP4JfW2kb9IpHfnC
         /pPF0wXGp9xi5RwRXUbn/YmjOaNo3J8M1FbCegtEogTTpKLHdbiOth8mrP6S1t/h8nki
         eZbWMhY3nU5EWOMeMxOhpsucslP8NWQw4apdM0S3NOzyrs51eqL82Sx8Ly5E0AIxQsCc
         ghcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705611180; x=1706215980;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Dy7CZDC+qgW2soI8VL1gi9PMSzhSCNe7SXJ08/Zz0=;
        b=wbXMInfOwWKr1afFSHSyaZmR9Bkd0a/eiNNaGiNArF1GOPaPVNsxZoZByKYXXozmNM
         tMHzCrwdxYx9z47Mpr3IxhbWYdf63/VUctzBF6wnCJ75Jo8q8n95rrYF9WnW6+PxIcII
         ugScU8yB4k0fiBTTmy4IegTbjDjuvNOKktdl3S1W6dzpjKNmRH2aJ/VboLBazleawsHJ
         wFsaQESsCHXVPF7Rho66TAqMSqt0Tw0b3udYkuPprnnJzn+482WIuvA1nyPssUSzDSPb
         0MQAQojLtkH/kY8vPc5dCKwXTDVby/kcqVF2zoY0/iD8zB+vx1hDLnFmTX7dpfiSNBvJ
         cF1g==
X-Gm-Message-State: AOJu0YyEuCPsmrhFz+3Ht8tNKYvqxHWfd6F6gXH15d2YhCj+8IKC8RUA
	O20lRDceUttLyWOFHNzoRcZZthCs2YyTEfz+oNuIHH+PU+YdkOjXQtaxAZ3b9sMq+wDacs9hezm
	hKhI=
X-Google-Smtp-Source: AGHT+IG7WD71Ielj7wNBWjtZccbvKSCO+NSqNCCdIecUFZFlTx6zB2MfoqXYIQ5wc1rQ9jVysov/jw==
X-Received: by 2002:a05:6602:255b:b0:7be:e080:6869 with SMTP id cg27-20020a056602255b00b007bee0806869mr593176iob.1.1705611180006;
        Thu, 18 Jan 2024 12:53:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d980a000000b007bf45b1c049sm2294794iol.0.2024.01.18.12.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 12:52:59 -0800 (PST)
Message-ID: <6f27bf5f-0d12-4bac-96ff-5b7824d8bd8b@kernel.dk>
Date: Thu, 18 Jan 2024 13:52:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-3-axboe@kernel.dk>
 <0ca63d05-fc5b-4e6a-a828-52eb24305545@acm.org>
 <c9f1b580-2241-4415-aa48-e4b7e1bacdea@kernel.dk>
 <e4892064-cdf2-4cd9-8033-901d8db07cbf@acm.org>
 <248b7070-a7c6-456d-99be-c3fff6f94f5e@kernel.dk>
 <239455a4-7e58-449d-9450-8297473cb441@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <239455a4-7e58-449d-9450-8297473cb441@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 1:46 PM, Bart Van Assche wrote:
> On 1/18/24 10:56, Jens Axboe wrote:
>> Do you need me to link the cover letter that you were CC'ed on?
> 
> There is no reason to use such an aggressive tone in your emails.

I'm getting frustrated with you because I need to say the same things
multiple times, and it doesn't seem like it's getting received at the
other end. And you had clearly seen the results, which means that rather
than the passive aggressive question, you could have said

"It'd probably be useful to include some performance numbers in
 the commmit messages themselves as well."

which would be received way differently than asking a question that you
already have the answer to.

> In the cover letter I see performance numbers for the patch series in
> its entirety but not for the individual patches. I'd like to know by
> how much this patch by itself improves performance because whether or
> not I will review this patch will depend on that data.

You can't really split them up, as you need both to see the real
benefit. The only reason they are split is because it makes sense to do
so in terms of the code, as they are two different paths and points of
contention. This obviously makes patch 2 look better than it is, and
that would be the case even if I swapped the order of them as well. As
mentioned in a previous reply, I'll be editing the commit messages and
probably just include the various performance results in patch 2 and
reference patch 1 from that too.

-- 
Jens Axboe

