Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CFFCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781F721D82
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="D2V5n0wP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfJYUPo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:15:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44657 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfJYUPn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 16:15:43 -0400
Received: by mail-io1-f67.google.com with SMTP id w12so3787956iol.11
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pWHX0UrTmMtss8CndBx7mJZc1pv8fuxV56FPYrFpw3g=;
        b=D2V5n0wPstuy6jC0M1L+WT+IZgB802CGrnFjXm4RHP1RHz3XtAQKp5chmaJ9gCrKdm
         Ll7J2Ce5zeeQbH7IfOZqOsxoBv21/3ndiQ7ZDBHxdhKEpeiisnZXNs76Jis2U5kL/PsC
         fv3m3OdW5PGXBWLto4mm2kmfI+hb0dadsooyKOFDqVOJs/rTu2/1pdGvPzWrQ5UDC5oR
         u6UrANoCGj8uo/SyWZxtmN51l1zd2uevYaVBOUdDxdX/JwQo6SjkKfQcpxkuWpNkSPrX
         2RmiMl30sTs87O2Pcw5z7sguQhR2kkXLMJgixsrYueeIol1J9B0qWLL1w6XS71vbRjX+
         MqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pWHX0UrTmMtss8CndBx7mJZc1pv8fuxV56FPYrFpw3g=;
        b=kP1zrOKCj3+CA9qy8w0N3HVoK0nclV67CCpkJBmY2TqTCtHQy4tYkTaGJltiOx1b5z
         Hh9St+uka6KL5ql5D0wb0i9P9mQahb6n4iNIhofvFZ+vqsVd6/6innT2BpFJQpqq43vK
         AM/N8ofKbb+mapc7qUxuxUlxqy0dzTp7pbcrHPMSJup0E7fnbTSzSZ9inLBCqv9bveLe
         odzrgKWn2NyN2fAvVK6e9DTN/XJ+5+w73AV+V9QpU4BnkqiJj/Fu6cbq4Lq3/doC1EW7
         sVo5aBDJ0p0d7R9mW0Otbt7jaAEBgSuddRPNRMlR6uay3kxey97CZJeHqKDxet+Jbg8U
         UVwA==
X-Gm-Message-State: APjAAAUDLD+oBXlFK3u9xT7/VKvMEvde5tJQcyVhb4G00AZ2cHlU1db1
        odVBu/yMaYZUiCeO4z7wnOHPsN+f+WYZ6w==
X-Google-Smtp-Source: APXvYqz86OMLWDBrxyRAvjgtMpyO+wLhBbxOeW0qq5oU8YjYNJLAKW6yOiavz81u9bnoAM1iW5cmdQ==
X-Received: by 2002:a5d:83d7:: with SMTP id u23mr2798526ior.27.1572034542705;
        Fri, 25 Oct 2019 13:15:42 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f145sm446736ilh.48.2019.10.25.13.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:15:41 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove needless goto from blk_mq_get_driver_tag
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20191022174108.15554-1-andrealmeid@collabora.com>
 <2a8a99a6-4b39-e459-988a-ba9502919044@acm.org>
 <f3e19c37-2430-81d5-ed5b-bc15d93e93c2@kernel.dk>
 <9f8cd2a8-a0b7-00e0-3d2e-16d1372d5989@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32555b04-0ba7-81a9-7311-45ef78ba8a8f@kernel.dk>
Date:   Fri, 25 Oct 2019 14:15:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9f8cd2a8-a0b7-00e0-3d2e-16d1372d5989@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 12:10 PM, André Almeida wrote:
> On 10/24/19 12:32 AM, Jens Axboe wrote:
>> On 10/23/19 7:34 PM, Bart Van Assche wrote:
>>> On 2019-10-22 10:41, André Almeida wrote:
>>>> The only usage of the label "done" is when (rq->tag != -1) at the
>>>> begging of the function. Rather than jumping to label, we can just
>>>> remove this label and execute the code at the "if". Besides that,
>>>> the code that would be executed after the label "done" is the return of
>>>> the logical expression (rq->tag != -1) but since we are already inside
>>>> the if, we now that this is true. Remove the label and replace the goto
>>>> with the proper result of the label.
>>>>
>>>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>>>> ---
>>>> Hello,
>>>>
>>>> I've used `blktest` to check if this change add any regression. I have
>>>> used `./check block` and I got the same results with and without this
>>>> patch (a bunch of "passed" and three "not run" because of the virtual
>>>> scsi capabilities). Please let me know if there would be a better way to
>>>> test changes at block stack.
>>>>
>>>> This commit was rebase at linux-block/for-5.5/block.
>>>>
>>>> Thanks,
>>>> 	André
>>>> ---
>>>>    block/blk-mq.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 8538dc415499..1e067b78ab97 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -1036,7 +1036,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
>>>>    	bool shared;
>>>>    
>>>>    	if (rq->tag != -1)
>>>> -		goto done;
>>>> +		return true;
>>>>    
>>>>    	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
>>>>    		data.flags |= BLK_MQ_REQ_RESERVED;
>>>> @@ -1051,7 +1051,6 @@ bool blk_mq_get_driver_tag(struct request *rq)
>>>>    		data.hctx->tags->rqs[rq->tag] = rq;
>>>>    	}
>>>>    
>>>> -done:
>>>>    	return rq->tag != -1;
>>>>    }
>>>
>>> Do we really need code changes like the above? I'm not aware of any text
>>> in the Documentation/ directory that forbids the use of goto statements.
> 
> goto are allowed, but the coding style document[1] provides some
> rationale for using goto, including that "If there is no cleanup needed
> then just return directly". Seems like this code used to do some stuff
> in the the past, but since 8ab6bb9ee8d0 "blk-mq: cleanup
> blk_mq_get_driver_tag()" it is just a return.
> 
>>
>> Agree, it looks fine as-is. It's also a fast path, so I'd never get rid
>> of that without looking at the generated code.
>>
> 
> You can have a look at the generated code for x86, here's the
> original[2] and here is the modified[3]. The only improvement at the
> assembly is that we get rid of this duplicated cmp instruction:
> 
>      2736:   83 f8 ff                cmp    eax,0xffffffff
>      2739:   75 4b                   jne    2786
>      ...
>      2786:   83 f8 ff                cmp    eax,0xffffffff
>      2789:   0f 95 c0                setne  al

Well, that's a win. I'll apply it.

-- 
Jens Axboe

