Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6E5CA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 19:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728FB2067D
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 19:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZkVTiwKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJ2TvZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:51:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56600 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfJ2TvZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 15:51:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TJiVDA064591;
        Tue, 29 Oct 2019 19:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=cQ/2W/PomX+Hti8bttIOPTG0SHPNnh+gc9dW6KJW3r0=;
 b=ZkVTiwKov/hZv+SBFLjUpZKQbi2rho9Yfo0m1D8CVDuMglF35yavswDD9517brCm1kkO
 JbnaviHV/iJwNByBJ2jNtZEg33Ufav26Ier6WGAama/1SgBUD/8LOujbCMmPWOy1FcQX
 oNxKxrFgoNaYy9MNNlX/96L2LsfPhYXXHqMKR+S7dklkoOpyJbUrWRfdHc6e7rXecuXC
 HmjBTc1suXQe2wuy1biU5ucMAG9UIcLhDagDh7AN+a4cZ/Ot/5SNbDcPt/BHcJOBDrgQ
 cLtfYGqkq21HS1h0RhsW2E0ouNCGly9+XntQn0IKszh6jAqkGH9Z10gEElS0ecNtRflY Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vvdjubrjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 19:51:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TJmiHo118690;
        Tue, 29 Oct 2019 19:51:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vxj8gukn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 19:51:22 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9TJpL3e001607;
        Tue, 29 Oct 2019 19:51:22 GMT
Received: from [10.175.57.238] (/10.175.57.238)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 12:51:21 -0700
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
 <6adb9d2d-93f1-f915-7f20-5faa34b06398@kernel.dk>
 <cdaa2942-5f27-79f8-9933-1b947646f918@oracle.com>
 <34f483d9-2a97-30c3-9937-d3596649356c@oracle.com>
 <47b38d9d-04a3-99f6-c586-e82611d21655@kernel.dk>
 <c7b599e4-cf3d-5390-f6f4-360d4435ea43@oracle.com>
 <057bb6f9-29ec-1160-a1b1-00c57b610282@kernel.dk>
 <5d79122d-afcd-9340-df67-d81e1d94dd80@oracle.com>
 <e7d6ec39-1a1b-b4da-3944-8a1492c2c37e@kernel.dk>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <3b71fff1-5b5e-3d33-b701-c7e1b3c9d8b9@oracle.com>
Date:   Tue, 29 Oct 2019 12:51:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e7d6ec39-1a1b-b4da-3944-8a1492c2c37e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290170
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/29/19 12:46 PM, Jens Axboe wrote:
> On 10/29/19 1:40 PM, Bijan Mottahedeh wrote:
>> On 10/29/19 12:33 PM, Jens Axboe wrote:
>>> On 10/29/19 1:31 PM, Bijan Mottahedeh wrote:
>>>> On 10/29/19 12:27 PM, Jens Axboe wrote:
>>>>> On 10/29/19 1:23 PM, Bijan Mottahedeh wrote:
>>>>>> On 10/29/19 12:17 PM, Bijan Mottahedeh wrote:
>>>>>>> On 10/25/19 7:21 AM, Jens Axboe wrote:
>>>>>>>> On 10/25/19 8:18 AM, Jens Axboe wrote:
>>>>>>>>> On 10/25/19 8:07 AM, Jens Axboe wrote:
>>>>>>>>>> On 10/25/19 7:46 AM, Bijan Mottahedeh wrote:
>>>>>>>>>>> On 10/24/19 3:31 PM, Jens Axboe wrote:
>>>>>>>>>>>> On 10/24/19 1:18 PM, Bijan Mottahedeh wrote:
>>>>>>>>>>>>> On 10/24/19 10:09 AM, Jens Axboe wrote:
>>>>>>>>>>>>>> On 10/24/19 3:18 AM, Bijan Mottahedeh wrote:
>>>>>>>>>>>>>>> Running an fio test consistenly crashes the kernel with the
>>>>>>>>>>>>>>> trace included
>>>>>>>>>>>>>>> below.  The root cause seems to be the code in
>>>>>>>>>>>>>>> __io_submit_sqe() that
>>>>>>>>>>>>>>> checks the result of a request for -EAGAIN in polled mode,
>>>>>>>>>>>>>>> without
>>>>>>>>>>>>>>> ensuring first that the request has completed:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>           if (ctx->flags & IORING_SETUP_IOPOLL) {
>>>>>>>>>>>>>>>               if (req->result == -EAGAIN)
>>>>>>>>>>>>>>>                   return -EAGAIN;
>>>>>>>>>>>>>> I'm a little confused, because we should be holding the submission
>>>>>>>>>>>>>> reference to the request still at this point. So how is it
>>>>>>>>>>>>>> going away?
>>>>>>>>>>>>>> I must be missing something...
>>>>>>>>>>>>> I don't think the submission reference is going away...
>>>>>>>>>>>>>
>>>>>>>>>>>>> I *think* the problem has to do with the fact that
>>>>>>>>>>>>> io_complete_rw_iopoll() which sets REQ_F_IOPOLL_COMPLETED is being
>>>>>>>>>>>>> called from interrupt context in my configuration and so there is a
>>>>>>>>>>>>> potential race between updating the request there and checking
>>>>>>>>>>>>> it in
>>>>>>>>>>>>> __io_submit_sqe().
>>>>>>>>>>>>>
>>>>>>>>>>>>> My first workaround was to simply poll for
>>>>>>>>>>>>> REQ_F_IOPOLL_COMPLETED in the
>>>>>>>>>>>>> code snippet above:
>>>>>>>>>>>>>
>>>>>>>>>>>>>                 if (req->result == --EAGAIN) {
>>>>>>>>>>>>>
>>>>>>>>>>>>>                     poll for REQ_F_IOPOLL_COMPLETED
>>>>>>>>>>>>>
>>>>>>>>>>>>>                     return -EAGAIN;
>>>>>>>>>>>>>
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> and that got rid of the problem.
>>>>>>>>>>>> But that will not work at all for a proper poll setup, where you
>>>>>>>>>>>> don't
>>>>>>>>>>>> trigger any IRQs... It only happens to work for this case because
>>>>>>>>>>>> you're
>>>>>>>>>>>> still triggering interrupts. But even in that case, it's not a real
>>>>>>>>>>>> solution, but I don't think that's the argument here ;-)
>>>>>>>>>>> Sure.
>>>>>>>>>>>
>>>>>>>>>>> I'm just curious though as how it would break the poll case because
>>>>>>>>>>> io_complete_rw_iopoll() would still be called though through polling,
>>>>>>>>>>> REQ_F_IOPOLL_COMPLETED would be set, and so io_iopoll_complete()
>>>>>>>>>>> should be able to reliably check req->result.
>>>>>>>>>> It'd break the poll case because the task doing the submission is
>>>>>>>>>> generally also the one that finds and reaps completion. Hence if you
>>>>>>>>>> block that task just polling on that completion bit, you are
>>>>>>>>>> preventing
>>>>>>>>>> that very task from going and reaping completions. The condition would
>>>>>>>>>> never become true, and you are now looping forever.
>>>>>>>>>>
>>>>>>>>>>> The same poll test seemed to run ok with nvme interrupts not being
>>>>>>>>>>> triggered. Anyway, no argument that it's not needed!
>>>>>>>>>> A few reasons why it would make progress:
>>>>>>>>>>
>>>>>>>>>> - You eventually trigger a timeout on the nvme side, as blk-mq
>>>>>>>>>> finds the
>>>>>>>>>>            request hasn't been completed by an IRQ. But that's a 30
>>>>>>>>>> second ordeal
>>>>>>>>>>            before that event occurs.
>>>>>>>>>>
>>>>>>>>>> - There was still interrupts enabled.
>>>>>>>>>>
>>>>>>>>>> - You have two threads, one doing submission and one doing
>>>>>>>>>> completions.
>>>>>>>>>>            Maybe using SQPOLL? If that's the case, then yes, it'd still
>>>>>>>>>> work as
>>>>>>>>>>            you have separate threads for submission and completion.
>>>>>>>>>>
>>>>>>>>>> For the "generic" case of just using one thread and IRQs disabled,
>>>>>>>>>> it'd
>>>>>>>>>> deadlock.
>>>>>>>>>>
>>>>>>>>>>>> I see what the race is now, it's specific to IRQ driven polling. We
>>>>>>>>>>>> really should just disallow that, to be honest, it doesn't make any
>>>>>>>>>>>> sense. But let me think about if we can do a reasonable solution
>>>>>>>>>>>> to this
>>>>>>>>>>>> that doesn't involve adding overhead for a proper setup.
>>>>>>>>>>> It's a nonsensical config in a way and so disallowing it would make
>>>>>>>>>>> the most sense.
>>>>>>>>>> Definitely. The nvme driver should not set .poll() if it doesn't have
>>>>>>>>>> non-irq poll queues. Something like this:
>>>>>>>>> Actually, we already disable polling if we don't have specific poll
>>>>>>>>> queues:
>>>>>>>>>
>>>>>>>>>                 if (set->nr_maps > HCTX_TYPE_POLL &&
>>>>>>>>>                     set->map[HCTX_TYPE_POLL].nr_queues)
>>>>>>>>>                         blk_queue_flag_set(QUEUE_FLAG_POLL, q);
>>>>>>>>>
>>>>>>>>> Did you see any timeouts in your tests? I wonder if the use-after-free
>>>>>>>>> triggered when the timeout found the request while you had the
>>>>>>>>> busy-spin
>>>>>>>>> logic we discussed previously.
>>>>>>>> Ah, but we still have fops->iopoll() set for that case. So we just won't
>>>>>>>> poll for it, it'll get completed by IRQ. So I do think we need to handle
>>>>>>>> this case in io_uring. I'll get back to you.
>>>>>>>>
>>>>>>> I ran the same test on linux-next-20191029 in polled mode and got the
>>>>>>> same free-after-user panic:
>>>>>>>
>>>>>>> - I booted with nvme.poll_queues set and verified that all queues
>>>>>>> except default where of type poll
>>>>>>>
>>>>>>> - I added three assertions to verify the following:
>>>>>>>
>>>>>>>           - nvme_timeout() is not called
>>>>>>>
>>>>>>>           - io_complete_rw_iopoll() is not called from interrupt context
>>>>>>>
>>>>>>>           - io_sq_offload_start() is not called with IORING_SETUP_SQPOLL set
>>>>>>>
>>>>>>> Is it possible that the race is there also in polled mode since a
>>>>>>> request submitted by one thread could conceivably be polled for and
>>>>>>> completed by a different thread, e.g. in
>>>>>>> io_uring_enter()->io_iopoll_check()?
>>>>>>>
>>>>>>> --bijan
>>>>>>>
>>>>>>>
>>>>>> I also tested my RFC again with 1 thread and with queue depths of 1 to
>>>>>> 1024 in multiples of 8 and didn't see any hangs.
>>>>>>
>>>>>> Just to be clear, the busy-spin logic discussed before was only a
>>>>>> workaround an not in the RFC.
>>>>> What is your exact test case?
>>>>>
>>>> See original cover letter.  I can reproduce the failure with numjobs
>>>> between 8 and 32.
>>> And how many poll queues are you using?
>>>
>> 30
> And how many threads/cores in the box? Trying to get a sense for how
> many CPUs share a single poll queue, if any.
>
Thread(s) per core:    2
Core(s) per socket:    8
Socket(s):             2

