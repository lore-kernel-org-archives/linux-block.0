Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052112E8B74
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404404; cv=none; b=jRzAhZISma0pdKc29ZRdI8iFfH0hechu1REdO0z6WjEMLtvGxojTa8qhid95i3zTxu6c/PGNsay7dgHnpON4QUSfNOlO4UQBI/L4WzXsH5mnvAgm56uT9izKn2SVhML0vFAvymJRswXo6cGAVfUCssvde1DSjhP+KUWZL7Nz02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404404; c=relaxed/simple;
	bh=0/F4TDV0UiAUy0rUQ3S2guINcAU7UzUN13WXmSHQ1Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QY9nEF7oIAYNC3Bnm+meGqoEK+ufhj0JRhqHWDSvks5SvHkOOsFF6v0eHHQwQKhPM6rxre4idzH9FsNibWqY5OzKDcfAbOhTwGhYaeT2IzyRYuIJ/kVGAn5TkQTLDrUSEXtXva8x5jGGEeVHcVa4OuonKiMwdj1J+GEy5wVuoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XdZMwUGg; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XdZMwUGg"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3f5aaa0c8d7so6719439fac.3
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 07:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768404401; x=1769009201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDmgdyOlCADWml/YDAc9mPJyIF2TgZY1TTtFY3TujVQ=;
        b=XdZMwUGgyUkr60+LRPoXm4TCq2dYjHw57lvwanPlNkY0dFlmQbbFKidJZYKfp4CblQ
         mntex81FclRj1SBxVhjeFvsWiVnTte+wmmp3eiDvhHso6t/5y7BWrX8f98b8ygbwPc0X
         NMN4kymtrR5jsauOIpJyVwnjJOMadzGYa36Xikbnvxgy+kQY5XF+ADnkW2QJ9EJgIQSP
         zU1uQeOTt6Cseu5yZjJMRDPPLqNd3WRrBYID9+vP6FKPtz2EQ1bxOBkxzTi5ODnaOl8k
         j4CkaMa9wmqZeDp60xJDM3Rg/Ux1CFUEPBxVBIZku6xmaW4+eLOA5Bc3y1dBAnVsCrwr
         twXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404401; x=1769009201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDmgdyOlCADWml/YDAc9mPJyIF2TgZY1TTtFY3TujVQ=;
        b=DsFqgKGl+qWBygR+J1nta7c8uTKYCHjPReBsf3S1NMkhZrexwcuOOb26mqbtrdG/ZR
         dLxDGSpVjsTmg2MY4u0/41plKbOS9OcrahYZDk4e4ZmGDfyvnKtns4+wx1KLxopIL4BJ
         Ocq+0EHB+/sO+Miv83I4xlqrjC8s7hbk5EcvWSwvmAdEXER+bi3DcdsJina8x5zgNquZ
         Ay/PFiHA6bKsKudm5xT4tT0rdb+NLun4gVkQyMFmHAwbI1O7Ivws7ZDNbxWSBsMFUiMT
         ucz8vArB0I+TXxGwPWYu+xrG50glDSP6R5MOcGRIdaH7BvKZRe8s+WtK5Ci8X5Rx4QeS
         dq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhO71mS5r64TROr5GwZStxQzHx6oBajitBFT2yWfauIr6CLQcpZkMzc5CxQF6HCrZ8NHlCj6O0ItNJPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGzanW4iJjvtVJmQlGQHeeBnnRQ1q+BWg+bt2HD2wy68yGLTV
	L9mUuZziWBm1DBim7yEM3U+XIqegi9YOK4KVnevOqDUNBPQV9XIWviREN1Z81FC1n9Y=
X-Gm-Gg: AY/fxX5u7jPTnOqX/XY+qGWMdwWzH60eerahLZvwuNTOzIJtP1Pc2N4SDwF1DxHW3DA
	WiU2VgZ5zA2eqRgJm49QdWxIY7tDEwX3/BSp/6N7TH4+AHv5fYwsQhdtgWzG/67uwOITwluqUDy
	ojSnQbkDhfu7w0Qcz++2wBnawoG0d9+bNXJiA7QvLMDuE7ifREkBkRqbsKhqivObmVW7gCzBib4
	6+6temkpsYm/vMfZSHyQlI/CsrncpLidfF/MoLsUINizSCsYYORCisVePqMcXZeyB4XgSYDSQIX
	jBkjEG9AbhXi5v2kI/cOf7uRpFHLcI1swx5undVScgfF2FEzpPrv2l3EBCGM5Bvre1icqW5bBgy
	10MzFa1jMCUVwzMqWu05XzrN6JXkBX9UoVypN9Oh346tg+vUJeeetv7xa3b6e7du8Y64GjagdIc
	gme1BeH20=
X-Received: by 2002:a05:6870:3751:b0:3ec:565a:13a4 with SMTP id 586e51a60fabf-404070fb615mr1921030fac.34.1768404400649;
        Wed, 14 Jan 2026 07:26:40 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa5072427sm16245382fac.12.2026.01.14.07.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 07:26:40 -0800 (PST)
Message-ID: <836abb95-31ca-40c1-8f9e-c1748a251c1b@kernel.dk>
Date: Wed, 14 Jan 2026 08:26:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][bisected] kernel BUG at lib/list_debug.c:32!
 triggered by blktests nvme/049
To: Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, fengnanchang@gmail.com,
 linux-block <linux-block@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
 <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
 <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
 <aWekEgznso6zkgdI@fedora> <78ff994b-26e8-4b35-a83f-15bb61865e87@kernel.dk>
 <9ae067ba-d0b6-49ac-9e96-01d23348261f@kernel.dk> <aWe0SjcDRQZM2t2G@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aWe0SjcDRQZM2t2G@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 8:20 AM, Ming Lei wrote:
> On Wed, Jan 14, 2026 at 07:58:54AM -0700, Jens Axboe wrote:
>> On 1/14/26 7:43 AM, Jens Axboe wrote:
>>> On 1/14/26 7:11 AM, Ming Lei wrote:
>>>> On Wed, Jan 14, 2026 at 01:58:03PM +0800, Yi Zhang wrote:
>>>>> On Thu, Jan 8, 2026 at 2:39?PM Yi Zhang <yi.zhang@redhat.com> wrote:
>>>>>>
>>>>>> On Thu, Jan 8, 2026 at 12:48?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>
>>>>>>> On 1/7/26 9:39 AM, Yi Zhang wrote:
>>>>>>>> Hi
>>>>>>>> The following issue[2] was triggered by blktests nvme/059 and it's
>>>>>>>
>>>>>>> nvme/049 presumably?
>>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>>> 100% reproduced with commit[1]. Please help check it and let me know
>>>>>>>> if you need any info/test for it.
>>>>>>>> Seems it's one regression, I will try to test with the latest
>>>>>>>> linux-block/for-next and also bisect it tomorrow.
>>>>>>>
>>>>>>> Doesn't reproduce for me on the current tree, but nothing since:
>>>>>>>
>>>>>>>> commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
>>>>>>>> Merge: 29cefd61e0c6 fcf463b92a08
>>>>>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>>>>>> Date:   Tue Jan 6 05:48:07 2026 -0700
>>>>>>>>
>>>>>>>>     Merge branch 'for-7.0/blk-pvec' into for-next
>>>>>>>
>>>>>>> should have impacted that. So please do bisect.
>>>>>>
>>>>>> Hi Jens
>>>>>> The issue seems was introduced from below commit.
>>>>>> and the issue cannot be reproduced after reverting this commit.
>>>>>
>>>>> The issue still can be reproduced on the latest linux-block/for-next
>>>>
>>>> Hi Yi,
>>>>
>>>> Can you try the following patch?
>>>>
>>>>
>>>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>>>> index a9c097dacad6..7b0e62b8322b 100644
>>>> --- a/drivers/nvme/host/ioctl.c
>>>> +++ b/drivers/nvme/host/ioctl.c
>>>> @@ -425,14 +425,23 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>>>>  	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
>>>>  
>>>>  	/*
>>>> -	 * IOPOLL could potentially complete this request directly, but
>>>> -	 * if multiple rings are polling on the same queue, then it's possible
>>>> -	 * for one ring to find completions for another ring. Punting the
>>>> -	 * completion via task_work will always direct it to the right
>>>> -	 * location, rather than potentially complete requests for ringA
>>>> -	 * under iopoll invocations from ringB.
>>>> +	 * For IOPOLL, complete the request inline. The request's io_kiocb
>>>> +	 * uses a union for io_task_work and iopoll_node, so scheduling
>>>> +	 * task_work would corrupt the iopoll_list while the request is
>>>> +	 * still on it. io_uring_cmd_done() handles IOPOLL by setting
>>>> +	 * iopoll_completed rather than scheduling task_work.
>>>> +	 *
>>>> +	 * For non-IOPOLL, complete via task_work to ensure we run in the
>>>> +	 * submitter's context and handling multiple rings is safe.
>>>>  	 */
>>>> -	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
>>>> +	if (blk_rq_is_poll(req)) {
>>>> +		if (pdu->bio)
>>>> +			blk_rq_unmap_user(pdu->bio);
>>>> +		io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, 0);
>>>> +	} else {
>>>> +		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
>>>> +	}
>>>> +
>>>>  	return RQ_END_IO_FREE;
>>>>  }
>>>>  
>>>
>>> Ah yes that should fix it, the task_work addition will conflict with
>>> the list addition. Don't think it's safe though, which is why I made
>>> them all use task_work previously. Let me fix it in the IOPOLL patch
>>> instead.
>>
>> This should be better:
>>
>> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
>> index dd084a55bed8..1fa8d829cbac 100644
>> --- a/include/linux/io_uring_types.h
>> +++ b/include/linux/io_uring_types.h
>> @@ -719,13 +719,10 @@ struct io_kiocb {
>>  	atomic_t			refs;
>>  	bool				cancel_seq_set;
>>  
>> -	/*
>> -	 * IOPOLL doesn't use task_work, so use the ->iopoll_node list
>> -	 * entry to manage pending iopoll requests.
>> -	 */
>>  	union {
>>  		struct io_task_work	io_task_work;
>> -		struct list_head	iopoll_node;
>> +		/* For IOPOLL setup queues, with hybrid polling */
>> +		u64                     iopoll_start;
>>  	};
>>  
>>  	union {
>> @@ -734,8 +731,8 @@ struct io_kiocb {
>>  		 * poll
>>  		 */
>>  		struct hlist_node	hash_node;
>> -		/* For IOPOLL setup queues, with hybrid polling */
>> -		u64                     iopoll_start;
>> +		/* IOPOLL completion handling */
>> +		struct list_head	iopoll_node;
>>  		/* for private io_kiocb freeing */
>>  		struct rcu_head		rcu_head;
>>  	};
> 
> This way looks better, just `req->iopoll_start` needs to read to local
> variable first in io_uring_hybrid_poll().

True, let me send out a v2.

-- 
Jens Axboe

