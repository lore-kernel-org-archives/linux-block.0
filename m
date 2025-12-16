Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887B346E5F
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897436; cv=none; b=py7SevHPdRfM6U6nvHPYguXerhIqW9eBAZOzRhOQi4IlU7dGT92UB/fkl++rERJyjnqQ7SHzLNVg+ELSWOFbSZgvTFL3ouPpzkI11YjPz0iaSQmWZu3FkhGyjaeDaq9U9YcJonWllzWOuQySXCepUa2fkQZrfHqDQNRUOcK78EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897436; c=relaxed/simple;
	bh=ws27C7+jay9p2/RPBNDO1/3bVrdfdU20rRAr9hNJdSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1YFGERUjQeAJp10V6ExwqYYitmIBr9yxER+CJnxQyp85eSL0ZXXdWtMB5dm+qn2bLg7HVRsILWaHFMGRcAPpmU1jWvuhcoV9YSb+tpVRpPaa9i5guMTUDHjFnSD4VLSIHj+JEBrj0Bz7iWBycR/OHY8rQkrA70T9O7q+5t6IPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nXatgNin; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nXatgNin"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7caf5314847so1875793a34.0
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 07:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765897431; x=1766502231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MVOD7/HioZfWu5D63rjjIlYxVeB0V1EHQBic+v3220=;
        b=nXatgNinKdAahD3Jb9GUEBAKQ+t4ubNh4iOdJFE/taRcH3daT3ak/FSkgnuGD9rF2v
         YUnAf4YbxZZul5A5moSGW6ZkHK3T8eBzT01uSZMTIeMNmt81AllqewYrQjZbZVV3qkpT
         0o3HLEDyx9aMFEe44gnTK7sqzAO2NSNG4pveT0sybaHulMCEb0w/BQhshE9erZd+ddo/
         uhJgS5LrGwnNdY/+rC7mlDEy3p3bw8ZWIF89i1CWN5ussIVCXdZsw09Y09BcbiJhVASI
         oC10smASwu3zKXHOjNZOIDhV58u+RcMr3bp+kwloNzio7l/dIrpyvO0TtbaXN05MVS5/
         uB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897431; x=1766502231;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MVOD7/HioZfWu5D63rjjIlYxVeB0V1EHQBic+v3220=;
        b=C/wEnpOnDEDDS4OyEzNJiXdobCGXw2NUDpr+4RiwUd1yoUel2NwUAwaLgGMqUVfTVV
         Chg6+lRZAXMEV1CWYGcCqeaapCsas7KiO57f/BBLUtSXmyAJF7bdgF+G2WmDCt6GwgIm
         Ir0KFnhNPg30RA6MVx4MfTcfB+6r69yDS816UlxaEpyCbZSiCBpuKQJNN6MqyT+Fx384
         jTO5wtH6SM21wbSRytTErSy9UeT2JByydGnPK9G8265AOZF36i6LNiex4tRzDQ0VFCPo
         NsIoPVQutx+K0D+BptiRVeqXCxPyNwbdlhk33nZRo9NOad+uzDEWkv5vhDg8eMOokEoe
         Tfpw==
X-Gm-Message-State: AOJu0Yx/Si+cbE6tOn+eN7/ZbBKiusGY1TFOSqWRmR4XZtuF89P/2moH
	dpqM5oSktT6LeWcc7INV8GzA5XHQZ2zRm10p6C2mSs4MIzg9GmWqGSYKDU8+SkjOSBVeukou72o
	0wOasMjY=
X-Gm-Gg: AY/fxX7VbcnEBu4Ei1GycpXHegDTYcSZdYos6mYSgq40wV0tH/j+0f4mrxcAp6TlCui
	iFOWkoz8jZn2UqdhbWETqBfM0YBbOSUZ1w6p/tsUqq31QwCwRRG7aeqt46QNA8psQOaSSb6pNOv
	1BtD14ZTckMKDsoNk0WUOFaStQP9G5SaPDdYjzcEvDKU+ZpFSR4pkTxM2j2mGUL53GNkv6GpXJV
	fqYUsIdvch3WCIjs33BSUoIuDx2zD2mC2KDnskOKR3MwKceSyIKkIH/V25Yl8XgVdne3a3UHLEH
	oLa/iJ+uVfB1mDbJnQScVcXM7yF41RUMMDe0+1f6gdcra5nwM0kGi7XVMqQ9P3EbymMTxtOYJVr
	jcGPkY7ZewovHZmPhu9Ci3+ZlBaelAASljeuZjWCuVDceVkowyDcw53EvRAdv2vOCyhEUZePasI
	xhbpbNDLvO
X-Google-Smtp-Source: AGHT+IGlYplOnfgGcqnJVNsSSMFBqX9IfSjSBn+ZcWfx4gFUuIl3GXCj/imVs9g608j3t62fabnQUg==
X-Received: by 2002:a05:6830:2645:b0:7cb:125d:2a41 with SMTP id 46e09a7af769-7cb125d2dbemr791844a34.34.1765897430158;
        Tue, 16 Dec 2025 07:03:50 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb3261bfsm11370820a34.25.2025.12.16.07.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 07:03:48 -0800 (PST)
Message-ID: <6d40e8a0-14e9-45f4-bbea-360678524767@kernel.dk>
Date: Tue, 16 Dec 2025 08:03:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
References: <20251212143415.485359-1-ming.lei@redhat.com>
 <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk> <aTzPUzyZ21lVOk1L@fedora>
 <93163617-11bb-4700-aca9-940c0df7429f@kernel.dk> <aUEeu9luJ9ZNvJzA@fedora>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aUEeu9luJ9ZNvJzA@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 1:56 AM, Ming Lei wrote:
> On Sat, Dec 13, 2025 at 11:41:52PM -0700, Jens Axboe wrote:
>> On 12/12/25 7:28 PM, Ming Lei wrote:
>>> On Fri, Dec 12, 2025 at 12:49:49PM -0700, Jens Axboe wrote:
>>>> On 12/12/25 7:34 AM, Ming Lei wrote:
>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>>>> index df9831783a13..38f138f248e6 100644
>>>>> --- a/drivers/block/ublk_drv.c
>>>>> +++ b/drivers/block/ublk_drv.c
>>>>> @@ -1080,12 +1080,20 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
>>>>>  	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
>>>>>  }
>>>>>  
>>>>> +static void ublk_end_request(struct request *req, blk_status_t error)
>>>>> +{
>>>>> +	local_bh_disable();
>>>>> +	blk_mq_end_request(req, error);
>>>>> +	local_bh_enable();
>>>>> +}
>>>>
>>>> This is really almost too ugly to live, as a work-around for what just
>>>> happens to be in __fput_deferred()... Surely we can come up with
>>>> something better here? Heck even a PF_ flag would be better than this,
>>>> imho.
>>>
>>> task flag will switch to release all files opened by current from wq context,
>>> and there may be chance to cause regression, especially this fix needs to
>>> backport to stable.
>>
>> I don't mean in general for the task, just across the completion. It'd
>> cause the exact same punts to async puts as the current patch.
> 
> Technically it is very similar with the posted path, just task flag
> way touches core code, especially there are only 4bits left.

Doesn't matter if it touches core code or not, the cleaner fix is what
matters. But a task flag is not very clean other, don't disagree on
that. Just tossing out ideas to make this palatable.

>>> So I'd suggest to take it for safe stable purpose.
>>
>> I'm really having a hard time with it - and I have to defend it once I
>> send it further upstream. And I can tell you who's going to hate it, the
>> guy that pulls from me. We might get lucky that he doesn't look at it.
>> But the underlying issue here is that the patch is one nasty bandaid,
>> not that Linus would yell at it, with good reason imho.
> 
> Understood.
> 
> IMHO, even this patch is a workaround and looks ugly, but it has enough
> benefits too:
> 
> - driver only change and won't touch core code

You bring this up again, why does it matter?

> - it is for handling abnormal userspace behavior(close(disk_fd) before
>   completing block IO)
> - correct & safe because it is always fine to complete IO request from irq
>   context
> - easy to backport

The only benefit that is valid here is the last one, yeah it's an easier
backport. But it's not like that one is that important, the other
suggested fix is a trivial backport as well.

>> At the same time, I don't really have other good suggestions. Let me
>> ponder it a bit, about to get on a flight anyway and -rc1 has been cut
>> at this point regardless.
>>
>> Obviously this isn't a ublk induced issue, it's all down to the lock
>> grabbing that happens there. Maybe bdev_release() could do a deferred
>> put if a trylock of ->open_mutex fails?
> 
> There is risk to break application since some cases need to drain
> bdev_release before returning to userspace.

How so? There's no guarantee that the release is sync and inline, in
fact there are already cases where that isn't so, and yours very much
takes advantage of that.

> The issue for ublk is actually triggered by something abnormal: submit AIO
> & close(ublk disk) in client application, then fput() is called when the
> submitted AIO is done, it will cause deferred fput handler to wq for any block
> IO completed from irq handler.

My suggested logic is something ala this in bdev_release():

	if (current->flags & PF_KTHREAD) {
		mutex_lock(&disk->open_mutex);
	} else {
		if (!mutex_trylock(&disk->open_mutex)) {
			deferred_put(file);
			return;
		}
	}

and that's about it.

-- 
Jens Axboe
