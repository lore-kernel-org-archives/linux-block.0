Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F80221729
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614181; cv=none; b=RIXAWjqbKroFRz8GNpSYDqP9ggT1DxZA1YQqMdAYJ5jQTU4OjFES1d/Q9gmbzcOLHeG1DRbTlSu75O/ShOxjzoed+e/0MCga/+xBP2mm8Y+xZnO16SR7ClqHzPC0TT5REYcmw3oe5s99yw/x5XhfMpq2dXEJ3bOmIUlOgIOESvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614181; c=relaxed/simple;
	bh=ePpI5r7ai9kjlwrxAN5W3wGdQWudCw/TieHKITaOmlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6jmC8gxHHrMVhSrNADJxwa8hFxM+UY1a/azXkWtPehpB8ZQJC9bJ265IE/3dib7P6I14KOLUzuFuVvtk2eMgYug7HjEH4z3t/qepiKphszgiSFrdzqyFo5hDmXHAEYtAQTv33QxF6fJ9KwSKwjAfeIc1bWkaUE+CcSVPSlhB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P+dq660+; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P+dq660+"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85ad83ba141so398561939f.2
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741614175; x=1742218975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=stHa8Q8NyWzcaYemh2RSpVoePqJWdSd3fJKwEv1PAeo=;
        b=P+dq660+CzFjViiFhnwJ2rxJh17QrRRv38O1sA9r3nBRJGqz3CxRV4EDXM4AvZfJ50
         pbtLcS3wU6Clv2Amt/55Sg5O/VRjT5133kmTWNJLe5mgqYXDueSZpLTASSjgFEpel9w4
         2sEbkxLfMTRP7Ukqmcj7/FOD5V6AfFWqtwIlmHlUlYf7izyEBp/vj05JG3/YTUpI7HYR
         cYPDdLuRkUA0090EENEwEKE6BEabSmL0sb3b++Uw4jTF7YJC95fq1nuolhLAw4cSLq32
         PKoM0ZG6OwZc8v0qu/X04mPHs/0onjxBY6O6xi/LrKS5O0qd0YBavYCas1QI4obLFhn1
         OrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614175; x=1742218975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stHa8Q8NyWzcaYemh2RSpVoePqJWdSd3fJKwEv1PAeo=;
        b=TjeBjRO/pmw8FdwZaStIxVjx777NnQlWDbwioQdUdSOp22YBqhZbwAhsMWBD8G3zuF
         XLpStaSIFuLe4obRH1w5L5D1gyJEVcWrFKozhXzDTWP5zoSniOX7g899lqjizCKSvnKi
         YWtMBnpMoxMazSkZXcnhBBtDMcz0EPSQM2SeXDgLyIhtNS5CYc94vICgmPOw8PooIiF+
         Z/nPQoi7TQesX+mVgJ7JqYNB2qmQufILQ20nUEmc/h8MYY6DDbgQtBC+l6coUmmgy+OQ
         07Q0kB2W64rpKHPf8QgXHZTz99GQWJBgTUFMqDV7OSJUSjyIUKGlzBUEciTITVcSZsot
         fs1A==
X-Gm-Message-State: AOJu0YxwXyvZCfhRESKIj0ICj5I6Dk+WjiDhFHSBwrKuHg6zWdVH6+4z
	SpI0sXj276FeXy415lVatzkXhkQCftB56FBUhxJg/FKZVNmuW2+kYB6x59gbT7M=
X-Gm-Gg: ASbGnctQrmT67EnUDkdM7EQsvcxP8MgJj2UjvkFhx52d0hXoksyGxKiBVQpgD5hiIoX
	b22daZPzVMEhdYm5s7GzQLCch//02sCf/5fdyNZZ0Wer9xg3H3/ZKZG3mwWxBkwQE0mG+ZdJmrA
	+ZDBDjhwgVnEIoCVeqN7edWuAsKIQeFR1b7PH7TALWq+xLXH5Qa3U/GANgVFEN5Y6+wthBM2vRF
	wYtHNW7EeZq3ruPipiBJqe9CTbViTFPOyA6ESnuOiSdItVy3D7iVryd7+2wyKxNmH9RdhblWwox
	EDfue24Sfgm/e7Y77SpD6lglYo+OpsD3R8zvzda9
X-Google-Smtp-Source: AGHT+IFrVd2OKUQ3aKu8A1Lc3xlpS9KEsyDxEwl+qVr8/7Q1zVtgVOGAJE/HYQkasDYxIu7PR+TwvQ==
X-Received: by 2002:a05:6602:3a16:b0:855:a047:5ef8 with SMTP id ca18e2360f4ac-85b1d03fb7bmr1650354739f.11.1741614175452;
        Mon, 10 Mar 2025 06:42:55 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f22edef008sm969073173.57.2025.03.10.06.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 06:42:54 -0700 (PDT)
Message-ID: <de3a5313-b0b5-432f-ace2-f6859eeb4436@kernel.dk>
Date: Mon, 10 Mar 2025 07:42:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH] badblocks: Fix a nonsense WARN_ON() which checks
 whether a u64 variable < 0
To: Coly Li <i@coly.li>
Cc: linux-block@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250309160556.42854-1-colyli@kernel.org>
 <18D3673D-575E-4002-B5A8-FEE56A732EDC@coly.li>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <18D3673D-575E-4002-B5A8-FEE56A732EDC@coly.li>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 10:12 AM, Coly Li wrote:
> Hi Jens,
> 
> Could you please take a look at it and pick this patch into the for-6.15/block branch? The patch is generated based on the for-6.15/block branch.

Just a heads-up - you don't need to send these emails outside of
just sending the patch, I do get the patches. If I didn't, then that'd
be a problem. If you feel patches need extra context, then just do a
cover letter for them.

-- 
Jens Axboe

