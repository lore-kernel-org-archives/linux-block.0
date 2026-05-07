Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE33B7B96
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156298; cv=none; b=ulgWybjXtzFuJSaHGIBJ7xKrMyuOYjkTTMYKpwyIzGT4/C8hTzCC8P4edOnvRwvqH5A0te/0LlQok26ao6Yc1jpwOzkoWrasAiUh6yGKfKNsVrNfOje2ytnKbjpad4vxknGAKEvVPUNyhbvgZ7twzaQL80fZ+G3E5N4VHxnVfhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156298; c=relaxed/simple;
	bh=WYBODy0dP9MainSsLW9UdoM/2x1G6Kv2VZus63k/mww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcBFxGV+Hfgg9LIKJqSgPFUVozlxVqSVTmvcvvI/UKaf3QYuZJWJZ0/LSDBYa7UvVdBBqOQk7nWFWnnUGmgcFaczNzdYyZHNrA6HgthQ7WOChcKh7eEeXdcuj9VNM6y8YDBv5w0bJn8J4pskWDv+XYZhVZSR7gBqCX6raE7Ut20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=N6L3cB62; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="N6L3cB62"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-434d9df81a5so441152fac.1
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778156292; x=1778761092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14z3DL/nBNIh/yMOhIuoyDAHi25W1vZFIT9vQ6HZfzI=;
        b=N6L3cB62nVrNgPNZZH0Bvo2rSMTtSv7gK1MX+wYU7R2vFk3j+79hytvFJsSvem57as
         6xUA7h/Xqvd02JsRRvTvFKvemPKVQnp9sIHYOWfvofhtW/tDCs0ywOAVk3SEnOniFmhc
         r3lz3e04h1LYzpGaVJ3MetL3mpGv/Isll58FGp0cxYaQhGP3buzHBoj7p78yIYB9K2Bu
         4s1SuYX4KiOeG/1xSRiaeGhr33VXom7Wz+UrIEEa3jCUwSc7a+8LT+HsZ3gQIuD6cUtx
         4SXzjW6JfOKOligzffUJEKRHBU9GHoiicsis6OP93qVQbke1LgIakgPWbF58t/g+9kKP
         p1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156292; x=1778761092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14z3DL/nBNIh/yMOhIuoyDAHi25W1vZFIT9vQ6HZfzI=;
        b=VEGFCgSk+psp54G4sLzn55VuhDD8IUM9w7eS11cGPptRkoH0IxRuV6FO55ZuDfp+eT
         +Lvo2B7LYNduGpYbyceiLeknyl7YrssoPdxvWYeSn1uxg2/cwyovh+QY4/suAiGFG7gH
         v1FXfybDaSsHyRIwwhO5jAUchhVhcLSQrpjAoGEf8ec8uCooT9/cNM07JU9IupfYCj8u
         esU2sJrNiZFkt2suygUMzGCD+7+9jhJLMenuouWHy5QLtqGpbsm4p2NNQpKYuoARJUZQ
         NwUK/iGwF0kSB2fpNMk3H/sVKnPn9q2pPQjMQF5BzzHWcvC7gReM1cs+8WTV9snDyFOR
         jXNA==
X-Gm-Message-State: AOJu0YyJsRzOKG1ldYbk+Xc7uBJ/hFlcgOJuBGKXYpEOrdBsXqGQP9HO
	eqV8yoG7L+LOyYx1szqbeiaDsqqubSyOwsG56+ffVWvQSrSV9b9BYNWZM0Q1pT8vCpX3WO+gmWL
	XI5uCC6mljg==
X-Gm-Gg: AeBDieud+3BxRGBbUF4m/OINvBCsfpKEHt9ogpb2vHI1OS92RYx654cHxhmE7Ok2bE+
	6nGmv+POpxyeBDeSbVmkoXa/9IIwfyTDZZftUfQVxXNnbZOH2Xc2nIyvpZ4TxgwCxCDivjUMahv
	SwWA9vEqGy/6M0pJVq/1CUc6oKomgaQebH7fM2JZYY4Hn21T4DoFOdT+VCZ0qEkJVR0qtlkwfat
	rjD+JrIDFk0PG4hkXB6LiIl4ATJsjBAXTTbfZXqdHxYDEGCwMrsRkE4cUp9VcKsOeElJbyRvKq4
	N36ymLBvFHSp8SLHc05IPclcFH3JFW1sX/n4QvjxjnY2xhLZ3WHELs3NkUaBYXAj6HESi6ekvJ9
	wiNHT/Z6CZ3FbKU1IZ68cCoVGXkL+MtPh3ftEhJdz4kRiShqol7155Py7LxZIKdTgC6vmb9TUtA
	b3f1PpMIhrI/vRBrIhbvfB+kKSbth/c1ed4ImJMp/tIyHTWINOthviNK40ewSuhA==
X-Received: by 2002:a05:6870:5a8:b0:41c:b538:e19c with SMTP id 586e51a60fabf-434f73a98c1mr4686913fac.38.1778156291971;
        Thu, 07 May 2026 05:18:11 -0700 (PDT)
Received: from [172.19.1.202] ([99.196.129.181])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4347294b5afsm17142078fac.8.2026.05.07.05.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 05:18:11 -0700 (PDT)
Message-ID: <e192ec6a-7b77-411e-b2f2-dfe2fbbd87d6@kernel.dk>
Date: Thu, 7 May 2026 06:17:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: blk-merge: Replace == false comparisons with !
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507121056.25801-1-shofiqtest@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260507121056.25801-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 6:10 AM, Md Shofiqul Islam wrote:
> The kernel coding style prefers the negation operator '!' over explicit
> comparison against 'false'. Replace four such comparisons in
> ll_new_hw_segment(), ll_merge_requests_fn(), and blk_rq_merge_ok().
> 
> Also fix a typo in a comment: "occured" -> "occurred".

My previous reply was not an invitation to just add more unnecessary
churn... I said "with a related fix", not "with unnecessary churn".

-- 
Jens Axboe

