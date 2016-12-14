Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53207 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753481AbcLNOLG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2016 09:11:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBEE54Vb083295
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2016 09:11:05 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27b4takjbf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2016 09:11:05 -0500
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <dougmill@linux.vnet.ibm.com>;
        Wed, 14 Dec 2016 09:11:04 -0500
Subject: Re: [PATCH RESEND v2 1/2] blk-mq: Fix failed allocation path when
 mapping queues
To: Gabriel Krisman Bertazi <gabriel@krisman.be>, axboe@kernel.dk
References: <87lgvje449.fsf@krisman.be>
Cc: linux-block@vger.kernel.org
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 08:11:01 -0600
MIME-Version: 1.0
In-Reply-To: <87lgvje449.fsf@krisman.be>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6ca54b91-a40c-a223-eb5b-905f24c9a3fa@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/13/2016 06:39 PM, Gabriel Krisman Bertazi wrote:
> On 12/06/2016 09:31 AM, Gabriel Krisman Bertazi wrote:
>> In blk_mq_map_swqueue, there is a memory optimization that frees the
>> tags of a queue that has gone unmapped.  Later, if that hctx is remapped
>> after another topology change, the tags need to be reallocated.
>>
>> If this allocation fails, a simple WARN_ON triggers, but the block layer
>> ends up with an active hctx without any corresponding set of tags.
>> Then, any income IO to that hctx can trigger an Oops.
>>
>> I can reproduce it consistently by running IO, flipping CPUs on and off
>> and eventually injecting a memory allocation failure in that path.
>>
>> In the fix below, if the system experiences a failed allocation of any
>> hctx's tags, we remap all the ctxs of that queue to the hctx_0, which
>> should always keep it's tags.  There is a minor performance hit, since
>> our mapping just got worse after the error path, but this is
>> the simplest solution to handle this error path.  The performance hit
>> will disappear after another successful remap.
>>
>> I considered dropping the memory optimization all together, but it
>> seemed a bad trade-off to handle this very specific error case.
>>
>> This should apply cleanly on top of Jen's for-next branch.
> Hi,
>
> I saw this patchset missed the first PR for 4.10, though I'd really like
> to see it merged in this cycle, if possible.  If you see anything
> particularly concerning about this that I missed, please let me know,
> but I fear this has been around for a while without much feedback.
>
> Thanks,
>
I want to repeat what Gabriel says. We are now seeing evidence of the 
condition often. This really needs to get fix soon.

Thanks,

