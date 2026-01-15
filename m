Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2C308F28
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486848; cv=none; b=m0CYcr+sdhL/pnyDLsaOAPYTz9jO7gd7/+UVfs0GxHqXD8tHYDwjZFKB4CLw48Q0jyVkqdCIg/tYN7FXe06Wif+UJOHiUetdTOg4LE281kwVrEHbeqnqKvbKbzyOPrtypFXX2X6/ceWs7vMjjjgOffUMlO5iy8ZCbTP5AEZbZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486848; c=relaxed/simple;
	bh=7Axx6qLU+OR1zr6kdqLPt3T8v1gnRULkQ6J94nLPYkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thj1+XygbBJnm9iiON0/BW+Nc6n2VqVtkuuNRPr108m7CIx80pjeuVp6A/NLK3MBEtUe/zzexVboX890VEcpYO18/9ckoXpo40Rs9fpnnkw0EbjNbmDzNTBoGzG2MGYgsOqfvFwUREWx9YXtkxzM5K3FzaBiCE0e3G9c4qg28nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dYpntBcA; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dYpntBcA"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40427db1300so548874fac.0
        for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768486846; x=1769091646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cf8B8jT40BQgRqVi+k4MJAXnmeH8H8nOEYwkHoCMjF8=;
        b=dYpntBcATYQldoOPdvi72OfbAChORfGUGxLNSa4RxX1Umal+21xT2+Vm11QEUAC3rp
         bY9wXs5pIuFg7EF0cLYMpmTjNdNmYhMouMxq/N9Tc2jWmQmOZZA93eVOdVp1lsSRniAN
         /CZ1+ONDehGJdtG2SFh48buKyh/DolcOsMkVUNShV5rOT5HndLeMLc6koOfTg0TwYT7V
         heYoEZLxDfN6P8iHd9kKVOonlEaMsLQ/2mUqT2HMBOwaNNF76/PuuetmpNuKzffiCgld
         S1Z4m821zuCuz/HvwyP0OixpHe+gUPGsPblfMe8w2GWYvXIFsjEh4tFt2Qr3xob6MG4y
         I/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768486846; x=1769091646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cf8B8jT40BQgRqVi+k4MJAXnmeH8H8nOEYwkHoCMjF8=;
        b=rNtxuH195knKje584E8y3u9J42gQExNkbZ56FfF8zRPM/qeRv9fM8Ks9vaY1M6wMyS
         pMk/10HlptmsWrp+NHEh3UK5cRfbOtBhQYeIaXGtA3Gvuix7z+yhMtLhJQmhmQGwxTa7
         hETza+n+dFvaNg76oj2ZxeQw+9NpPrtj3ZTSqn0MahSJQyiPMEhA5FuwuMht6th0o1Dy
         PQmEkQNHoC55SI0oOK32GjN/8lMdfDvyHpqaX/ISCnaFDA+ypXk/Yqs48aC+buALuI7X
         dDE1t0AuKPhd+rT7FHO62si8TVu7gsbwXO0WaU9VqubkCtmnG2CMb15O19TcTLlp02n6
         C5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXZN7zs7XWmdqSZDxtvSBeTj7peBqjmmHsQkmkKZjrAPFcH0wPIP5p0AoTo7utuhedglwbRho8xBQli5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YymSrrEIgNSm+Q+RFvi9lwIS7s0BbmE1xYLpWh6LaRYA90N7P8B
	aZU3UHrxylIcnK/w1pyDkHAel8egghcumGVihM2AIiTl7wnq7fWS9O0s+yuMbAKi5hs=
X-Gm-Gg: AY/fxX4bo9GDvp53usDFXHGg51yzfwXfhoxD3twjeCE2jKe9lr0lzyjFi9aLXcISFOo
	7KiaVXSNuAjH7qr40mhphn8ZKx4xrLQB2f9OUwsmN6D+gd4NUZD0omKsRQpxoclzyTWhv3kn/Mr
	aAtn6QjqWnpLMQJu54E3/pjczCFrp6/CHTP2EKLg6Ju+FyOCfjmDfrtbFNgbCO4aAAxDzGZyW0l
	iZzshELbyWR0M08fcWJtRJ5XdzOXHBiTeTAIPCJQ6prsoEMkseCz+C90y5n5B/lx/lS2m5k3aDQ
	/Npc44BCScL9MyWjB8CWIJOCjbMpORDlus/l4ytCOORDmAgiIRvq1OlrRyuS4f0lrCXng4Vx333
	8jjbsgyiH6V3AZ5AhgvOmgNLTwos6MI6V5K4RqsA7/xTPW+E9c4DDzL+sw6kgMxXo1Kjn238VMU
	YKe9RFlN8=
X-Received: by 2002:a05:6871:7a4:b0:3fd:a31d:104e with SMTP id 586e51a60fabf-4040ba2a031mr4079312fac.11.1768486845740;
        Thu, 15 Jan 2026 06:20:45 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa50721a6sm19193920fac.10.2026.01.15.06.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 06:20:44 -0800 (PST)
Message-ID: <e7fd9926-4e67-4396-ba84-c9749a9c7d1c@kernel.dk>
Date: Thu, 15 Jan 2026 07:20:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Jinpu Wang <jinpu.wang@ionos.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
 "grzegorz.prajsner@ionos.com" <grzegorz.prajsner@ionos.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
 <CAMGffEmPCB4j-SfufLAdnBo=x-5HsM-vkzhu7o1ocHwnc0=jVg@mail.gmail.com>
 <bc5b7643-8f6e-4801-8d73-06e869318cd6@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bc5b7643-8f6e-4801-8d73-06e869318cd6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 6:58 PM, Chaitanya Kulkarni wrote:
> On 1/14/26 00:40, Jinpu Wang wrote:
>>> This follows the kernel pattern where sysfs removal (kobject_del) is
>>> separate from object destruction (kobject_put).
>>>
>>> Fixes: 581cf833cac4 ("block: rnbd: add .release to rnbd_dev_ktype")
>>> Signed-off-by: Chaitanya Kulkarni<ckulkarnilinux@gmail.com>
>> lgtm, thx for the fix.
>> Acked-by: Jack Wang<jinpu.wang@ionos.com>
> 
> If this is correct we will needs reviewed-by tag to apply this patch.

Eh no, that is not correct. What I care about is that it has been
seen and acknowledged. Whether it's a acked-by or reviewed-by
doesn't matter one single bit.

-- 
Jens Axboe

