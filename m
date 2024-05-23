Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077113B7BC
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469455; cv=none; b=VUh8d16dTD+xlyz/bgJ9eB4NAtQSdfP0/0pbgtpj/c6kmJahHga6CY+DIXMfOKNLRfJNwUbKDgvVDLLqShZBtg9v2FJIbCbchEtwcHCcoI65YQkxA5BHTmotVT7K8XgFevm1QsWk+8t7e6Eo+jFPJ3ykHQkoNVMOU+7WcL+rHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469455; c=relaxed/simple;
	bh=gPGMwLLeDLNkh3TYTRIn0gXVjE6IQM9ONM01R4ivyJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmbdScmtNdwltFORTIbIWsxqblGemMkZe5v5eI2mlsGpaJnaJLHHPMt4/93Wll8cnAA8N9sI2cGfoWUCWGtmTkJs6NFtaYNqzvMJdj7/133yLyk9xMZwMWGjVmJYurucHe3HpTwxAOlwcdOxKd7YRhcNOVbR5T7X8PUjj7mLxCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c+2RCE0r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c+2RCE0r"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f2f6becadaso154725ad.3
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716469451; x=1717074251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPcBTM5I+MFfOzb0MSOYi+VNek3mHku58ke+pzSmNtQ=;
        b=c+2RCE0ru38BgMQZ3kdNaPfHWngzdAzopNdsAl/u0WNEIBTlOOUyTmzvr9ou8VFmGB
         vfNLVHfkWH8hMZr9OX1a73U9a/K327uRqtME5E40C9G8dDPr0TBqHI9YCLuCdx8MXr3g
         veo/pkn3gtqaxDnpaawh28PINkK5EcHGX44xWM2v2zQTJTseASiv43RNeqYyB4PtvtiU
         q7vh04CrUAnRp0pWTmrFbovCAFIXu2A0MKDvjc0ABZ7ikUdpQG/1T8bM00XSqWwPdT+n
         xrvXpjO74lyapsVcvK/cc2apCGrbLtsI0/vNWbJ8vjF45tLdct50LL170r1loR9PRhQc
         Ntlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716469451; x=1717074251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPcBTM5I+MFfOzb0MSOYi+VNek3mHku58ke+pzSmNtQ=;
        b=HMbNCOYxU7I5eWnSlv4+ckZc3GCRMKLyv8hblw9192w1qruM0FdKjSQfxDUmEprS1z
         9xEMLR+KEzpfhyWHbi+sY15Ik8Ajg22KYtNqpYnZDy7Pdu5ANP9rVDR1/jsFYTMkJFeF
         FFD0M07WzycUMvpxHRnw8w9YJDVyw3amVPmtmb3hsHUODbGheGGvpAxO18FGSiFZRH8j
         honwlb5FI5HIZlhtbpF7+2S8fWRP5q5GbwOa1M8Ps4IoXhx3MKsKeL6YnFlosHHxAl9+
         ZaKilx95n6BQhvqwTDO/ti4EtCMfdMizhZ93HTI9yuz+bRgVDFa9Sr3+yemHqpPmK22p
         UFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/8Bw9qWhcojg5NBDPDsByphWzPSOuTyBtVbo0zXU/C1lpv4orhSifmOjI97FdetMWdeS6zuwXGgv8M5dlzpoXnK18jUfjjJAaW6M=
X-Gm-Message-State: AOJu0Yzt2eg3gntfAgKWqjlQPLp3A1J6S6zSoKoVZ8pUX4e64c3JgAEH
	RGzXd0xH7ZFN6bdgasgP8tKpYO8DXJ5qVvLEk4Lh2RjTt/alagrY5QmxgEgUm9U=
X-Google-Smtp-Source: AGHT+IEqZumjDycfTAekXjBdCht0wMdxVooj/kFc6UYJXA9kMC56gWlA98Y7SCepLg/V0zaIRcI/CQ==
X-Received: by 2002:a17:902:d489:b0:1f2:f12e:27f6 with SMTP id d9443c01a7336-1f31c7ff1cdmr51407425ad.0.1716469451262;
        Thu, 23 May 2024 06:04:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f328767adesm28199705ad.189.2024.05.23.06.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 06:04:10 -0700 (PDT)
Message-ID: <ab21593c-d32e-40b4-9238-60acdd402fd1@kernel.dk>
Date: Thu, 23 May 2024 07:04:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: yunlong xing <yunlongxing23@gmail.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Yunlong Xing <yunlong.xing@unisoc.com>, niuzhiguo84@gmail.com,
 Hao_hao.Wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
 <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
 <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
 <CA+3AYtS=5=_4cQK3=ASvgqQWWCohOsDuVwqiuDgErAnBJ17bBw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+3AYtS=5=_4cQK3=ASvgqQWWCohOsDuVwqiuDgErAnBJ17bBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 12:04 AM, yunlong xing wrote:
> Bart Van Assche <bvanassche@acm.org> ?2024?5?23??? 02:12???
>>
>> On 5/22/24 10:57, Jens Axboe wrote:
>>> On 5/22/24 11:38 AM, Bart Van Assche wrote:
>>>> On 5/22/24 00:48, Yunlong Xing wrote:
>>>>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>>>>>            set_active_memcg(old_memcg);
>>>>>            css_put(cmd_memcg_css);
>>>>>        }
>>>>> +
>>>>> +    if (ori_ioprio != cmd_ioprio)
>>>>> +        set_task_ioprio(current, ori_ioprio);
>>>>> +
>>>>>     failed:
>>>>>        /* complete non-aio request */
>>>>>        if (!use_aio || ret) {
>>>>
>>>> Does adding this call in the hot path have a measurable performance impact?
>>>
>>> It's loop, I would not be concerned with overhead. But it does look pretty
>>> bogus to modify the task ioprio from here.
>>
>> Hi Jens,
>>
>> Maybe Yunlong uses that call to pass the I/O priority to the I/O submitter?
>>
>> I think that it is easy to pass the I/O priority to the kiocb submitted by
>> lo_rw_aio() without calling set_task_ioprio().
>>
>> lo_read_simple() and lo_write_simple() however call vfs_iter_read() /
>> vfs_iter_write(). This results in a call of do_iter_readv_writev() and
>> init_sync_kiocb(). The latter function calls get_current_ioprio(). This is
>> probably why the set_task_ioprio() call has been added?
> 
> Yeah that's why I call set_task_ioprio.  I want to the loop kwoker
> task?submit I/O to the real disk device?can pass the iopriority of the
> loop device request? both lo_rw_aio() and
> lo_read_simple()/lo_write_simple().

And that's a totally backwards and suboptimal way to do it. The task
priority is only used as a last resort lower down, if the IO itself
hasn't been appropriately marked.

Like I said, it's back to the drawing board on this patch, there's no
way it's acceptable in its current form.

-- 
Jens Axboe

