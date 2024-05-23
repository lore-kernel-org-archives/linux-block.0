Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894287470
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476334; cv=none; b=jbuPW56nqrq8M41hqDWzNzBvv48AMzwSPfEUEqMxa4vxwmMILrxMFxbLEYd851dQNebFAVVRR6XCKfmxkamXVJSXbzPJvyhUwlemHKG/5kjeaBAA3vvLsJPT1HRZunoX0ernEXe6yb1jNyF/6NAwPnxR6m9ZYBmad7lSonCInlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476334; c=relaxed/simple;
	bh=R+E4pRAuFfMJYL2+j0lxUR1KIGi7d5dv3fdg4BkB5kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0Cc/aBfBYwlxvYyd5NwoK1Wt0I1lBIUMzrqJWUl2sItjzEw8f1+pcziCZ23gEQXkVZDo7zhKvZojbfGnaUJ+VINC/mliUDy5v3vxkqIsffAtiqPrEXUkzEDtVuLatYsav14spx4at4bqkbFuQLBK0JX9XRRXoTWGXpcaCf0jkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zRY0KFCQ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zRY0KFCQ"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36dbdb1caf3so522835ab.2
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716476331; x=1717081131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfXXZckBzq2acoPDITkGPN2KIH+xyzDm74Vnyl/qeIU=;
        b=zRY0KFCQYonEWE58UQ6+aaVOAH+KKg1OqHLqvmhlHwh0wKQolv1scU4rYrVSjX/q9X
         87Ul+hw+bPY8wNQbvJC8Rn5FjSE9/OjUJEymga4eu1u/JXVyHFzLC+1cotgw/gV+eThQ
         u2a7T8uYINOnuZYThEmiV5S36R/jhpRrPJQ3jG1oRpkh2vY+STggSQvg+rsQ1a6zqsMC
         h9PHLE5pLmqTdp5glewJWRlVOIApY03SHCbX5YtdNqeaLw+X8OnrLr88KP+JsSQYu9wk
         iv5UUXVOVIDSkxHXpuGUPfNeRJrxDnlD1PUrakdLO8+9ewjJsrK8caCWk0YtuB1L+VYO
         eNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476331; x=1717081131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfXXZckBzq2acoPDITkGPN2KIH+xyzDm74Vnyl/qeIU=;
        b=LSIvbqCOhFTaRK2FUUkef5anJLyeaNOYbLOyyQriXz1VaxQ3oclP4unL04/m9I7+Zg
         oG0AFodDyl8ayV50WjkDSW8XjvMXknJTc4tztwL+pnB4f1Qt2Hn+IbNkwyYW1VhoWnYw
         /y6IHpP9s1eJO3Y5y2tzkGmkVDdlHcB7aGfPJxcA644NErgL8FwHasQy0tUYOTxWPEC+
         IYqZE+vDI41lxh6Vm5wp1Wq8pJWfUTWXyCWmt0PTyZEHm1AlTTRzxWjo1pkA2Uh8Wbft
         00A2tpUmtrT00IfGjaNHvMEvs0Sqi9M7fjVo7JXBENEB8RNs108Z7XAxvCmqLJnL/qdg
         WLOA==
X-Forwarded-Encrypted: i=1; AJvYcCXubOrOX5FLPn7uq+EKveohTRgoo1NKZr7Yjc15MPFW3+HKUhRbGVNvwv9hWMzm+5iFpVJF4pM2eUHxNlAnm4gXDO33lvC1GM5s4K8=
X-Gm-Message-State: AOJu0YxmdfZg4t9HxDLScSQviB/Wjyo/bhA9Fy/zEMcc5YlUAxt2phFG
	VrjH8DVtGaAcMQ99Ou6Ikro6/Qxa8NbYKBPkjYP+33X5hcEGN68GXzNEDgTjoEQ=
X-Google-Smtp-Source: AGHT+IGx3asnk7Za2Wl/hBXvOmtenUuwYO0KyfMDZtouSX+rYp0Z3ZaGtOTCXbTi9dvLhk664owmzw==
X-Received: by 2002:a5d:9496:0:b0:7e1:8bc8:8228 with SMTP id ca18e2360f4ac-7e34f7ff29fmr520451139f.0.1716476330632;
        Thu, 23 May 2024 07:58:50 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fb22asm8071929173.164.2024.05.23.07.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:58:50 -0700 (PDT)
Message-ID: <fac0eb31-55f4-43fe-9e85-6363031aa5ce@kernel.dk>
Date: Thu, 23 May 2024 08:58:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: yunlong xing <yunlongxing23@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Yunlong Xing <yunlong.xing@unisoc.com>, niuzhiguo84@gmail.com,
 Hao_hao.Wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
 <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
 <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
 <CA+3AYtS=5=_4cQK3=ASvgqQWWCohOsDuVwqiuDgErAnBJ17bBw@mail.gmail.com>
 <ab21593c-d32e-40b4-9238-60acdd402fd1@kernel.dk>
 <CA+3AYtTbkG_8KWNWJ8rZ-z=v-V+A9CqKCUUsXLPJyHZgL-FjwQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+3AYtTbkG_8KWNWJ8rZ-z=v-V+A9CqKCUUsXLPJyHZgL-FjwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 8:52 AM, yunlong xing wrote:
> Jens Axboe <axboe@kernel.dk> ?2024?5?23??? 21:04???
>>
>> On 5/23/24 12:04 AM, yunlong xing wrote:
>>> Bart Van Assche <bvanassche@acm.org> ?2024?5?23??? 02:12???
>>>>
>>>> On 5/22/24 10:57, Jens Axboe wrote:
>>>>> On 5/22/24 11:38 AM, Bart Van Assche wrote:
>>>>>> On 5/22/24 00:48, Yunlong Xing wrote:
>>>>>>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>>>>>>>            set_active_memcg(old_memcg);
>>>>>>>            css_put(cmd_memcg_css);
>>>>>>>        }
>>>>>>> +
>>>>>>> +    if (ori_ioprio != cmd_ioprio)
>>>>>>> +        set_task_ioprio(current, ori_ioprio);
>>>>>>> +
>>>>>>>     failed:
>>>>>>>        /* complete non-aio request */
>>>>>>>        if (!use_aio || ret) {
>>>>>>
>>>>>> Does adding this call in the hot path have a measurable performance impact?
>>>>>
>>>>> It's loop, I would not be concerned with overhead. But it does look pretty
>>>>> bogus to modify the task ioprio from here.
>>>>
>>>> Hi Jens,
>>>>
>>>> Maybe Yunlong uses that call to pass the I/O priority to the I/O submitter?
>>>>
>>>> I think that it is easy to pass the I/O priority to the kiocb submitted by
>>>> lo_rw_aio() without calling set_task_ioprio().
>>>>
>>>> lo_read_simple() and lo_write_simple() however call vfs_iter_read() /
>>>> vfs_iter_write(). This results in a call of do_iter_readv_writev() and
>>>> init_sync_kiocb(). The latter function calls get_current_ioprio(). This is
>>>> probably why the set_task_ioprio() call has been added?
>>>
>>> Yeah that's why I call set_task_ioprio.  I want to the loop kwoker
>>> task?submit I/O to the real disk device?can pass the iopriority of the
>>> loop device request? both lo_rw_aio() and
>>> lo_read_simple()/lo_write_simple().
>>
>> And that's a totally backwards and suboptimal way to do it. The task
>> priority is only used as a last resort lower down, if the IO itself
>> hasn't been appropriately marked.
>>
>> Like I said, it's back to the drawing board on this patch, there's no
>> way it's acceptable in its current form.
>>
>> --
>> Jens Axboe
>>
> Thanks for your advice. So, you can't accept pass the ioprio by
> set_task_ioprio?

Not sure how many times I'd have to state that, no.

> If only the method of lo_rw_aio() counld you accept? I don't want to
> submit this part of the modifications separately. I just want to know,
> this is ok to you or not?

Inheriting the kiocb ioprio from the request is the right approach, so
yeah that part is fine.

-- 
Jens Axboe

