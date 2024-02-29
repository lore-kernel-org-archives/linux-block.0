Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18F2E405
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170542; cv=none; b=c2Mwu77Lx5cGFY1fWsT4dJMj9dFjrrmhBATb/vsUlYJjohXefhU6eRluZPQMAwyy1aom+0rURHehioesNOZmrz8j+Tb012Okm9aJF7xgjyXkdDUkxyp6G5euZJ7FJfQzJc9Y7nTafUXYO4AMW28EG/bpy87kS4PkkE/OotDUUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170542; c=relaxed/simple;
	bh=YAvGcgeniKGwZmpEierl98vR1/jyQoJx9FO89phksbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ARQiJIW1jC9+lncdEPCjECulQkv99QfFq+fRkeWtg0jWtOv08mkbCZvzwkUFpiSNF75impf67Cnz53njw3Z/RkPm0RsTrYfy7UzsDzThJTMYzb/WEczk1J1L8zL+UFfO/N0OU3BdtOHg7a1DID2gonh10HIsCjTnS3NTlXNCPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xxVEcHNH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xxVEcHNH"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-58962bf3f89so51583a12.0
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 17:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709170538; x=1709775338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QEoH9Blt3yBe4bvq5RcFxEHGAxzQEHc9mG6nn1vkWk=;
        b=xxVEcHNHVB/KXeLFG9j1s7mgw0C06Mp1VCKMloAOEyT9LFYqyqyQ6QL9hMj4uLYNVd
         8OaGWtGd+z8Ed6pqx1mJWUKzAmKn0zy+toh4akmJxDhoSZDEavyBPX2yikCVbbZowVu9
         YNkGzAy+dBd34dMfXKV4Ljd/gRfz+QDs3RnbJkxjIdnF3A5VEOZQGBKctrsm2p9xKnFg
         GX2xD28xbpYnZIM9A+5SGSA+qICI40asGVLUAGbbodUDRQ4m2v1uVR5LZ8xgaygVdVgV
         C9ezb4mdWPMJmhHnsvMtfkhxn9oLMgwfnfeNQkLM8d0z4O9FsmRhkF83UYvs0swiCF3m
         nVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709170538; x=1709775338;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QEoH9Blt3yBe4bvq5RcFxEHGAxzQEHc9mG6nn1vkWk=;
        b=diic590aWdLbzmeXRxdzaCBjsr+CzYgCUp22PIzrrMMrS67q4EK5fkQMtgketPe2Vn
         WjyzQ/NSSKoJ38bvwhxLvVejFD2/7jorvk8rakcM7adM/INjWoQNzxPmQrZebNHmyZqM
         88/vWM6lNaLVxkp2CcwDJWUh9qfWQ9c1Bb07RUSFRBfBFeU9Xw82u+wfM/GOvfSUeFs7
         1kzi+VbfvqHABfwv60MpkApeYCkYEjOH9SxbQSUYwwY0ClzOebqB9FFAbX+tEAYel2wb
         YHVqjNSITQJMLbPgU8QCzlOKFu1abhi+PpB0NGFk7rJ/Fa1Ap13FNdEYYULM4iu6BLwg
         4ZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcvw/ycm4vTSr953yu1uGLHEUoAPmZE029SK1ksAoG5+o8mJ/R9eGmGfUPKnuvCq8aqWOWwg399wR0qSP/l7O8uddc68mjH6wuoCQ=
X-Gm-Message-State: AOJu0Yxv9A4RzfzVe7t2s8fOpNKcsSRhcJR9n0Ohy8Ip3SHpvEeyBzPm
	bMnTWTBceqJAxyNXxEL9+FTJNqVj9pswBFgGfrBRGsI+4TTXGBrVU5J219iimyyf7jOxNV+21/l
	C
X-Google-Smtp-Source: AGHT+IGvWb/L/8ysIyOYd1A4dFc3H6VOCzkKnjZcUmgesl8ZJnNeiuOXqFo0kw7pzIzG8eBrAD8mug==
X-Received: by 2002:a17:902:7286:b0:1dc:6941:cde5 with SMTP id d6-20020a170902728600b001dc6941cde5mr651548pll.4.1709170538408;
        Wed, 28 Feb 2024 17:35:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id bi10-20020a170902bf0a00b001dc3c3be4adsm101061plb.297.2024.02.28.17.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 17:35:37 -0800 (PST)
Message-ID: <b9ee5cda-b7de-47bc-9379-07286395baf0@kernel.dk>
Date: Wed, 28 Feb 2024 18:35:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: improve ublk device deletion
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20240223075539.89945-1-ming.lei@redhat.com>
 <Zd/deJWmSDs8dxWF@fedora>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zd/deJWmSDs8dxWF@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/24 6:27 PM, Ming Lei wrote:
> On Fri, Feb 23, 2024 at 03:55:37PM +0800, Ming Lei wrote:
>> Hello,
>>
>> The 1st patch cleans up get/put device, and annotate them
>> via noline for trace purpose.
>>
>> The 2nd patch adds UBLK_U_CMD_DEL_DEV_ASYNC so userspace device
>> deletion can be implemented easier.
> 
> Hello Jens,
> 
> 
> All APIs in lib/ are built as notrace, so the 1st patch adds
> noline for ublk get/put device(slow path), and it is helpful for
> investigating reference issue by existed trace utilities.
> 
> The 2nd one makes userspace happy to not consider complicated dependency
> issue in removing code path.
> 
> Can you queue the two patches for 6.9 if you are fine?

Yep they look fine to me, will get them queued up. Thanks!

-- 
Jens Axboe

