Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923182877
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400659; cv=none; b=ZSfocHUuCI16uNutk0b4q2LiJskZ02bRnrCbjW6DbyUS/sVdNMTTgG50mC42oQOatjTFVrkvDfnb48uTaZ1bl5RP/ulEQdjzJdCTyBI9BLqBxdyG7oV0bzVPoDJp3diZjwIPQmlk9Yko51Qobt4Xmk8WrWA9hvgIOHwCz+8AgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400659; c=relaxed/simple;
	bh=km6GkJRH1oXle4Y0aeGjvJ9VZaAmz5Ww5mIIUQ0fpFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADht75r9EBM/BQ+YGnVIiP8fSNv/4Rc5Zq28i9RIvV+jOkmpbKHm4l3VJIlLZkoaZQgDUjTLz49dXDUzIft61Rtd1pQ9mIeU/pgXWB0kZU46TdQpxpbmlAsLKX6qsvhId4N0bxdZbuGP+A5ZDdzrlGwsE1cOrH8HXWjp7AOEv+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JZW6DHNi; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JZW6DHNi"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36daacdbf21so1936965ab.2
        for <linux-block@vger.kernel.org>; Wed, 22 May 2024 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716400656; x=1717005456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvzMaUzKqFOseklIwtjARXZ+I/8PBiP7raqhNOSJqDw=;
        b=JZW6DHNik4i+ZmVTi1e+aXeZz/LUGUchQgL0lIocvg46NrLytfU85zIPLLbXqDkhI0
         2sJIrooVtdWhV0jLn9Xr+hwJkEWE/YIgzaqOw9f0lj00XDdPF8L39HtGjXHdGkinbGUK
         CqKk96pF0CAN7DsyFzG3HjYdq4+KbTXLmh5ehWP/bmR6nkOx4uiz47Yzc4z1jAye+v5H
         IvecX/zyJ1duFRJHFRPsN/rLww5pnKXPrqXgF+Nrb7XCq74YRwmAcp4Ewq2b9qh+oIkV
         yhixLCJvX3V07vtJas59GoGcoXNhQ2DG4twxLCZ9usbMFJokJMO1WEo14A8Zfz7dv48d
         KihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400656; x=1717005456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvzMaUzKqFOseklIwtjARXZ+I/8PBiP7raqhNOSJqDw=;
        b=lCIDVD3GXxvxvj7T2bbJcz6ys9orM80ZoSlydUE8/DHuTGBNjOLo6xOlJIBnMNJM5h
         7Mi7hL0rOz2w3BfhHJkq8BXz700oFG7dj0aapy/xPojSItcgxl3oFQTGD18hhgtWCOnf
         FJ5F/AcAf0Re39bTmoaWOIhwCuN0e4MW8hFuQpNWrx9l8pS9t0JrQn0hSLeGCa4f4nz5
         xxxech1m89e0lNUWGJECHvn2rryVzxFXEcA0TtRq2nJXeW0JrNNuYV/H4MX04G5u8E3G
         zwECXM/hwGPzlvEe5VKoqN5RW2DUImN/5JoFXZZcq1EMapeyyBYH6q5P58hYKEZsmcMY
         GTIQ==
X-Gm-Message-State: AOJu0YyaMkxRgMqYLdiqKPe52rF56nSKKep6NabHv8sb7o5X8uoKKq8Z
	wtkVTM1GRqMDLQXIX9bXaqgQC5/S0QkPMkd+np498q5awMptObu9Cj9yQoTn6L45/6vTqfvWXKh
	L
X-Google-Smtp-Source: AGHT+IHXUHRzeijL9T4CaAAoS3S+jdJoetWF8AHLSeL5TvrVSBx4SyHEVK6B66pE+FSdZ/SqPFVxTA==
X-Received: by 2002:a05:6e02:1c47:b0:36c:c86b:9180 with SMTP id e9e14a558f8ab-371f56c8a4amr30384885ab.0.1716400654771;
        Wed, 22 May 2024 10:57:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3732463eeb2sm601815ab.84.2024.05.22.10.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 10:57:34 -0700 (PDT)
Message-ID: <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
Date: Wed, 22 May 2024 11:57:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Bart Van Assche <bvanassche@acm.org>,
 Yunlong Xing <yunlong.xing@unisoc.com>, yunlongxing23@gmail.com,
 niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/22/24 11:38 AM, Bart Van Assche wrote:
> On 5/22/24 00:48, Yunlong Xing wrote:
>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>>           set_active_memcg(old_memcg);
>>           css_put(cmd_memcg_css);
>>       }
>> +
>> +    if (ori_ioprio != cmd_ioprio)
>> +        set_task_ioprio(current, ori_ioprio);
>> +
>>    failed:
>>       /* complete non-aio request */
>>       if (!use_aio || ret) {
> 
> Does adding this call in the hot path have a measurable performance impact?

It's loop, I would not be concerned with overhead. But it does look pretty
bogus to modify the task ioprio from here.

-- 
Jens Axboe


