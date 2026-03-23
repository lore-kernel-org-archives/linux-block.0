Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A127470
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774227879; cv=none; b=mYFwkug7lbJiHtak98cm3/OiJy68s62LF5+9RDREwPeUPalla5RQnrBufpI6037SGCxVLkBquOHAadgMIIw2hOwf48+/OWA9tvw+1QqgpdrnZSv3DjcuhA9LIB509JwFA1LrH9jS1wHMP+Ghh4Gg+eRxtyuuxxnSaWkYcxRq1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774227879; c=relaxed/simple;
	bh=1858aEuXQCDBFZbM6Amq89zSY2nlYPEvVwLAwgsvue0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J52yU7cWL66keVGkitccvcg3KyKMmdqqPwSEjos5bo+iqPl7uYRoVojySnoRxTMxaga79j6mDECPFWddCdqNAvebn906fZC9fFnJqXSbFyxuNRuO/g5sHy90kgLoeqfnA7y+VI+T0FqaEK4svdihIvI87oJgu1cmwS/a6GEQ8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=G9Kyc+v2; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G9Kyc+v2"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-464ba2bb3aeso2344671b6e.1
        for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 18:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774227877; x=1774832677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1B1Svo5mktAT8Mqk4J/FNWcbOe8c+HvGIGaqad1TNU=;
        b=G9Kyc+v2awZBS+/v26IKHJ21bcY4Pc7iQIY4ZLvnZQSZDDO+yi5WyUqyFsOTSOrYsy
         +Vvh/9qDsOEOX5gF/Q9mpwN0V4O7unQq0DzdjmFcixVbiX24vXAcRtZVWqN1HlC8U8r0
         rsKMogLqSigh3GmEpQQwDJnvX7p9lCso1ifUbJl2S7ckcu6Ogxg1c9b3vg+gh4C9W3qm
         Ev9GUKAmMcKfe5KvC03vwY8Y5uZBb3LRm4LJ+dM36X1OX0WzVpioDmUc3RdV6sB8K+qp
         xKO0yZ9saxndv4tnjalLI8YiFUbymfVfZxpkd9FAPcamxy0s385VdfldmWDXMwC+4KSC
         FceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774227877; x=1774832677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1B1Svo5mktAT8Mqk4J/FNWcbOe8c+HvGIGaqad1TNU=;
        b=GscxQI8PPHmt8t2YlMuFsTvqW69dc5oI9fyTKJZajnwZ72UJlb0RIxsr4DQelPeISu
         qtfXD9nQq24vkHDifYaFq79OX6orgp1J/oQ/O0XggFCv/tccFAQ6x9hgC3xhpe6oJP9l
         ME8v1UAXrBFKXPWIHb2MWFHnZuPdGCeZiGN+AREgMGqzcNdmLbzUQsjy4bvLMYsB5/3B
         k8FZGsmjy+7Cj8PAtCAC5trKmUk3A6clr2j5wMIUhd9rbnM4GJAP0IrQvRp7EfnP7g0+
         puWmUtrPJsU8pHU6vxf3Iolfjc621suON7mrgvfLlLO+Ty2ZLDX3zFI6KmDA31oqDh50
         a16w==
X-Gm-Message-State: AOJu0YzBsyIKiTz3hXgevKLr1kWpupRO/lWbmUv+BMXFwcnuP8qYrPIo
	peig1Zb/IlAvU9J++8ZrVc9tk19leUU1DSZyufXS+bbfAewa+5hLzDFdpgTMdyTTSuc=
X-Gm-Gg: ATEYQzxbgHaBRKsC/lRIAFFePAEPyObYm4bCrVFsNLZdEZhf00EZ+tk6G8NKY0kf2FD
	26ft0t1IgcZK921GpM/nKWFc5Mx1ZwiiTF93cD08yk9RgEAfYV1FMYtYWctwrw7Me+fHLeHzwuk
	m63is4Q058KTH/gxgrQHskyXbGCucs1x16fJ4hF/TKcanm595VtENZVoN97uNLigal21xZBVP/5
	Vx6Xw1ogWZLIuuRLO3Q3lUfxzxNMOg5TBHYYo5xoOV8ztRHYWQwtv0E9MrWqBO4tNmTVwBKASis
	uOPS4ydrIUqUp0lcDDPYma4DHQAbJrGvCoPd+PqxvzXlnI6SX0+MQK/zeasePrHdvw4wO1pbft8
	A+ZRYy+QReMwlhxNWJt5SUh9NnTOw3NOVEITtEUV9dwQEegrE6agn89atH0+mQQzSkN2BeFy9Jo
	6OQ2B5ENwfBlksgSQrB4y8k1+ygs/noT/cK8a8Ozy51qnDW6HpDnV9Ox23L5XKZ8JA3aCOoIDxI
	UUyMY4hng==
X-Received: by 2002:a05:6808:1926:b0:467:fb12:c9f6 with SMTP id 5614622812f47-467fb12caf7mr4373668b6e.14.1774227877031;
        Sun, 22 Mar 2026 18:04:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14d63e29sm8851293fac.12.2026.03.22.18.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 18:04:36 -0700 (PDT)
Message-ID: <6fab0722-cf39-4081-a337-0be8e6ffc26d@kernel.dk>
Date: Sun, 22 Mar 2026 19:04:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch] bsg: initialize request and reply payloads in
 bsg_prepare_job
To: jonghwi.rha@samsung.com, Hannes Reinecke <hare@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, =?UTF-8?B?6rmA7KCV7YOc?=
 <jt1217.kim@samsung.com>, =?UTF-8?B?7KCV7Zic7Jew?= <hyeon.chung@samsung.com>
References: <CGME20260318102030epcms2p7b2daaab73032a6a26eca9c8307a7322e@epcms2p7>
 <20260318102030epcms2p7b2daaab73032a6a26eca9c8307a7322e@epcms2p7>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260318102030epcms2p7b2daaab73032a6a26eca9c8307a7322e@epcms2p7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 4:20 AM, ??? wrote:
> On 2/6/26 13:58 PM, ??? wrote:
>> On 2/6/26 00:45, Hannes Reinecke wrote:
>>> On 2/5/26 14:42, Jens Axboe wrote:
>>>> On 2/4/26 10:32 PM, ??? wrote:
>>>>> bsg: initialize request and reply payloads in bsg_prepare_job
>>>>>
>>>>> struct bsg_job payloads contain fields that are only populated by
>>>>> certain commands, such as sg_list pointers.
>>>>>
>>>>> Because struct bsg_job is allocated with kmalloc(), memory may be
>>>>> reused across requests. If a command does not populate all payload
>>>>> fields, stale state from a previous job may remain and later be
>>>>> misinterpreted during cleanup, potentially leading to use-after-free
>>>>> or double-free issues.
>>>>>
>>>>> Initialize both request and reply payloads at the beginning of job
>>>>> preparation to ensure a clean state for all commands.
>>>>>
>>>>> Signed-off-by: Jonghwi Rha 
>>>>>
>>>>> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
>>>>> index 32da4a4429ce..0fbf8e311c03 100644
>>>>> --- a/block/bsg-lib.c
>>>>> +++ b/block/bsg-lib.c
>>>>> @@ -234,6 +234,12 @@ static bool bsg_prepare_job(struct device *dev, struct request *req)
>>>>>          struct bsg_job *job = blk_mq_rq_to_pdu(req);
>>>>>          int ret;
>>>>>
>>>>> +      /* Clear stale SG state since bsg_job is reused as a request PDU */
>>>>> +      job->request_payload.sg_list = NULL;
>>>>> +      job->request_payload.sg_cnt = 0;
>>>>> +      job->reply_payload.sg_list = NULL;
>>>>> +      job->reply_payload.sg_cnt = 0;
>>>>> +
>>>>>          job->timeout = req->timeout;
>>>>>
>>>>>          if (req->bio) {
>>>>
>>>> The patch is white-space damaged, tabs are spaces. But I can fix that
>>>> up. Do we just want to do a memset(job, 0, sizeof(*job)) here to avoid
>>>> any oddities like this in the future?
>>>>
>>>
>>> That might indeed be better.
>>
>> The suggested method impairs normal operation. If bsg_prepare_job performs
>> a zero?memset for the job structure, all request?related information set on
>> the driver side before the call will be lost. Therefore, if it runs as is,
>> it will go to ufs_bsg_request and cause a null?pointer access.
>>
>> Currently, the original patch has no functional impact.
>>
>> The blank problem seems to be due to a mistake I made while copying and pasting
>> the patch. I am reattaching the patch below. If needed, I can attach the patch
>> and resend the new email.
>>
>>
>> [PATCH] bsg: initialize request and reply payloads in bsg_prepare_job
>>
>> struct bsg_job payloads contain fields that are only populated by
>> certain commands, such as sg_list pointers.
>>
>> Because struct bsg_job is allocated with kmalloc(), memory may be
>> reused across requests. If a command does not populate all payload
>> fields, stale state from a previous job may remain and later be
>> misinterpreted during cleanup, potentially leading to use-after-free
>> or double-free issues.
>>
>> Initialize both request and reply payloads at the beginning of job
>> preparation to ensure a clean state for all commands.
>>
>> Signed-off-by: Jonghwi Rha 
>> ---
>>  block/bsg-lib.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
>> index 32da4a4429ce..0fbf8e311c03 100644
>> --- a/block/bsg-lib.c
>> +++ b/block/bsg-lib.c
>> @@ -234,6 +234,12 @@ static bool bsg_prepare_job(struct device *dev, struct request *req)
>>  	struct bsg_job *job = blk_mq_rq_to_pdu(req);
>>  	int ret;
>>  
>> +	/* Clear stale SG state since bsg_job is reused as a request PDU */
>> +	job->request_payload.sg_list = NULL;
>> +	job->request_payload.sg_cnt = 0;
>> +	job->reply_payload.sg_list = NULL;
>> +	job->reply_payload.sg_cnt = 0;
>> +
>> 	job->timeout = req->timeout;
>>
>> 	if (req->bio) {
>> -- 
> 
>> Regards,
>> Jonghwi,
> 
> --
> 
> Since there was no reply, I am resending the email as a reminder.
> First, I have confirmed in my environment that, as you suggested,
> memset?as 0 for all 'job' struct elements eventually results an error.
> The reason is, as I mentioned above, that the request/reply gets lost
> before re-using.
> 
> Also, since other elements in the structure are reused, so they are
> not relevant to the current issue.
> 
> If the code execution point is not ideal, there is also the option of
> zeroising after freeing the memory allocation.

Just send it out as a proper patch and we can take a look at it again.

-- 
Jens Axboe
