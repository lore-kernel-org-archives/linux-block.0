Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57598 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751720AbdB0TkC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 14:40:02 -0500
Subject: Re: [PATCH 1/3] blk-mq: make blk_mq_alloc_request_hctx() allocate a
 scheduler request
To: Omar Sandoval <osandov@osandov.com>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
 <6137d2c6-816e-83b2-103c-cdf0840f49fd@fb.com> <20170227183021.GG10715@vader>
CC: Sagi Grimberg <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <5d9bc14d-9a90-8915-f538-f61452420677@fb.com>
Date: Mon, 27 Feb 2017 11:34:47 -0700
MIME-Version: 1.0
In-Reply-To: <20170227183021.GG10715@vader>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/27/2017 11:30 AM, Omar Sandoval wrote:
> On Mon, Feb 27, 2017 at 11:07:27AM -0700, Jens Axboe wrote:
>> On 02/27/2017 10:47 AM, Omar Sandoval wrote:
>>> From: Omar Sandoval <osandov@fb.com>
>>>
>>> blk_mq_alloc_request_hctx() allocates a driver request directly, unlike
>>> its blk_mq_alloc_request() counterpart. It also crashes because it
>>> doesn't update the tags->rqs map.
>>>
>>> Fix it by making it allocate a scheduler request.
>>
>> All three look good to me. Would you mind respinning #1, it doesn't
>> apply on top of the reserved tag patch.
> 
> Yup, I had those based on Sagi's original patches for some reason. I
> fat-fingered send-email, sent as a reply to the original patch 1 instead
> of this email.

I got it, applied all 3, thanks Omar!

-- 
Jens Axboe
