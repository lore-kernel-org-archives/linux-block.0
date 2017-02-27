Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60531 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751468AbdB0TyZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 14:54:25 -0500
Subject: Re: [PATCH 1/3] blk-mq: make blk_mq_alloc_request_hctx() allocate a
 scheduler request
To: Sagi Grimberg <sagi@grimberg.me>,
        Omar Sandoval <osandov@osandov.com>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
 <6137d2c6-816e-83b2-103c-cdf0840f49fd@fb.com> <20170227183021.GG10715@vader>
 <5d9bc14d-9a90-8915-f538-f61452420677@fb.com>
 <719e3d15-73e2-0b11-e205-e733b882c2ae@grimberg.me>
CC: <linux-block@vger.kernel.org>, <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <9314f153-0264-2efb-fe52-a7823ce18051@fb.com>
Date: Mon, 27 Feb 2017 11:44:32 -0700
MIME-Version: 1.0
In-Reply-To: <719e3d15-73e2-0b11-e205-e733b882c2ae@grimberg.me>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/27/2017 11:41 AM, Sagi Grimberg wrote:
> 
>>>>> blk_mq_alloc_request_hctx() allocates a driver request directly, unlike
>>>>> its blk_mq_alloc_request() counterpart. It also crashes because it
>>>>> doesn't update the tags->rqs map.
>>>>>
>>>>> Fix it by making it allocate a scheduler request.
>>>>
>>>> All three look good to me. Would you mind respinning #1, it doesn't
>>>> apply on top of the reserved tag patch.
>>>
>>> Yup, I had those based on Sagi's original patches for some reason. I
>>> fat-fingered send-email, sent as a reply to the original patch 1 instead
>>> of this email.
>>
>> I got it, applied all 3, thanks Omar!
> 
> FWIW, you can add my:
> 
> Tested-by: Sagi Grimberg <sagi@grmberg.me>

Done, I fixed up your typo, though :-)

> Although I didn't try to trigger reserved vs. normal tag
> competition which will never ever happen for nvmf btw, but
> I assume it can happen in drivers who use reserved for error
> handling.

As long as we verify they work independently, there should not
be a need to check that edge case separately. We should have
identical behavior there now to previously.

-- 
Jens Axboe
