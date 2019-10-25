Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5AFCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 14:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5490C205ED
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 14:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c21wMSUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440485AbfJYOnE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:43:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39640 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440461AbfJYOnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 10:43:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PEd2Vw024242;
        Fri, 25 Oct 2019 14:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=5RRu3+gr6X25WegTfi/1/qk+bKkDm8bHsLu4oBL8FvM=;
 b=c21wMSUlOSEYVfjxqElj/rwdnvnYaj416tf9sFPOQiZAzQnNG90HsnfnzzkRp5AmSMum
 CDdtJK0Il1+zGse6A+CkUEyTMl2XEqZh1I/nOaEKe0byKxxtH4a2ZzMnbzKcYuMlMccU
 73EegiuVwfcTMVv43PZ4t/rFKc+P+YffroN6BGR4Zcj+9pUNnQ4Hpdufpb5y3t4IrdhA
 lnV1FLPS5a0kuYjKthtaTW6Lqmh0NJKLuC6HKsWZewrBLIYOCinsAGB49WbJZbmX33Rz
 uNdHKPjHl0ozOdVUoI9e8cwXHyohUni6kXS0ikGt6afrMVUqzPXjbXO7r37RtWn2vW1Y iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vqteqbhhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 14:43:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PEcwwY143905;
        Fri, 25 Oct 2019 14:43:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vunbmj7ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 14:43:00 +0000
Received: from abhmp0021.oracle.com (abhmp0021.oracle.com [141.146.116.27])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9PEgwIs031006;
        Fri, 25 Oct 2019 14:42:59 GMT
Received: from [10.175.3.200] (/10.175.3.200)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Oct 2019 14:42:57 +0000
Subject: Re: [RFC 0/2] io_uring: examine request result only after completion
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
 <22fc1057-237b-a9b8-5a57-b7c53166a609@kernel.dk>
 <201931df-ae22-c2fc-a9c7-496ceb87dff7@oracle.com>
 <90c23805-4b73-4ade-1b54-dc68010b54dd@kernel.dk>
 <fa82e9fc-caf7-a94a-ebff-536413e9ecce@oracle.com>
 <b7abb363-d665-b46a-9fb5-d01e7a6ce4d6@kernel.dk>
 <533409a8-6907-44d8-1b90-a10ec3483c2c@kernel.dk>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <37fee9db-484c-2ae2-08a1-c0681485ef57@oracle.com>
Date:   Fri, 25 Oct 2019 07:42:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <533409a8-6907-44d8-1b90-a10ec3483c2c@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250140
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/25/19 7:18 AM, Jens Axboe wrote:
> On 10/25/19 8:07 AM, Jens Axboe wrote:
>> On 10/25/19 7:46 AM, Bijan Mottahedeh wrote:
>>> On 10/24/19 3:31 PM, Jens Axboe wrote:
>>>> On 10/24/19 1:18 PM, Bijan Mottahedeh wrote:
>>>>> On 10/24/19 10:09 AM, Jens Axboe wrote:
>>>>>> On 10/24/19 3:18 AM, Bijan Mottahedeh wrote:
>>>>>>> Running an fio test consistenly crashes the kernel with the trace included
>>>>>>> below.  The root cause seems to be the code in __io_submit_sqe() that
>>>>>>> checks the result of a request for -EAGAIN in polled mode, without
>>>>>>> ensuring first that the request has completed:
>>>>>>>
>>>>>>> 	if (ctx->flags & IORING_SETUP_IOPOLL) {
>>>>>>> 		if (req->result == -EAGAIN)
>>>>>>> 			return -EAGAIN;
>>>>>> I'm a little confused, because we should be holding the submission
>>>>>> reference to the request still at this point. So how is it going away?
>>>>>> I must be missing something...
>>>>> I don't think the submission reference is going away...
>>>>>
>>>>> I *think* the problem has to do with the fact that
>>>>> io_complete_rw_iopoll() which sets REQ_F_IOPOLL_COMPLETED is being
>>>>> called from interrupt context in my configuration and so there is a
>>>>> potential race between updating the request there and checking it in
>>>>> __io_submit_sqe().
>>>>>
>>>>> My first workaround was to simply poll for REQ_F_IOPOLL_COMPLETED in the
>>>>> code snippet above:
>>>>>
>>>>>          if (req->result == --EAGAIN) {
>>>>>
>>>>>              poll for REQ_F_IOPOLL_COMPLETED
>>>>>
>>>>>              return -EAGAIN;
>>>>>
>>>>> }
>>>>>
>>>>> and that got rid of the problem.
>>>> But that will not work at all for a proper poll setup, where you don't
>>>> trigger any IRQs... It only happens to work for this case because you're
>>>> still triggering interrupts. But even in that case, it's not a real
>>>> solution, but I don't think that's the argument here ;-)
>>> Sure.
>>>
>>> I'm just curious though as how it would break the poll case because
>>> io_complete_rw_iopoll() would still be called though through polling,
>>> REQ_F_IOPOLL_COMPLETED would be set, and so io_iopoll_complete()
>>> should be able to reliably check req->result.
>> It'd break the poll case because the task doing the submission is
>> generally also the one that finds and reaps completion. Hence if you
>> block that task just polling on that completion bit, you are preventing
>> that very task from going and reaping completions. The condition would
>> never become true, and you are now looping forever.
>>
>>> The same poll test seemed to run ok with nvme interrupts not being
>>> triggered. Anyway, no argument that it's not needed!
>> A few reasons why it would make progress:
>>
>> - You eventually trigger a timeout on the nvme side, as blk-mq finds the
>>     request hasn't been completed by an IRQ. But that's a 30 second ordeal
>>     before that event occurs.
>>
>> - There was still interrupts enabled.
>>
>> - You have two threads, one doing submission and one doing completions.
>>     Maybe using SQPOLL? If that's the case, then yes, it'd still work as
>>     you have separate threads for submission and completion.
>>
>> For the "generic" case of just using one thread and IRQs disabled, it'd
>> deadlock.
>>
>>>> I see what the race is now, it's specific to IRQ driven polling. We
>>>> really should just disallow that, to be honest, it doesn't make any
>>>> sense. But let me think about if we can do a reasonable solution to this
>>>> that doesn't involve adding overhead for a proper setup.
>>> It's a nonsensical config in a way and so disallowing it would make
>>> the most sense.
>> Definitely. The nvme driver should not set .poll() if it doesn't have
>> non-irq poll queues. Something like this:
> Actually, we already disable polling if we don't have specific poll
> queues:
>
>          if (set->nr_maps > HCTX_TYPE_POLL &&
>              set->map[HCTX_TYPE_POLL].nr_queues)
>                  blk_queue_flag_set(QUEUE_FLAG_POLL, q);
>
> Did you see any timeouts in your tests? I wonder if the use-after-free
> triggered when the timeout found the request while you had the busy-spin
> logic we discussed previously.
>
I didn't notice any timeouts.  The error triggered without me making any 
changes.  The busy-spin workaround I mentioned before actually got rid 
of the error.


--bijan

