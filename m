Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA82CA9EC5
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 19:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF6A20717
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 19:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i++vkj0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJ3TXb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:23:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfJ3TXb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 15:23:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UJMPPT039322;
        Wed, 30 Oct 2019 19:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=WIw00kb0AA+5Zup2dTZSax5SGMBXDAMSunWfeax8GF8=;
 b=i++vkj0s9+M3m9T30Zth5MNqjAPACyFD/LrGPjPK5Ckdt67JPvUGSUlJmqBqXAAJCPwR
 YVWDYdQWqEloA7ULsvKorSvIflFqK0F03WcuTKQyTx9X3DnQhu84yh98YHTQkJI7HNnq
 cD9/5G7SQpcq00gUZfBi2g+pgzKKT7zAOwlinAJBczWUyCtoujjy2ndI4rvKAXPCKh31
 lZCcdkzM1VFbmBWSMtVTRajvKK+RloYCPB+2bsgOcWYKWsr6FZBJlErrUH4h3UDPp9dL
 3BgXw+YFx26zwwAbCsiteiD6BTHzwGaJmmNMYu9//UQieWQQ831MTHKWKQYXpZ+L0LTG Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vxwhfegy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 19:23:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UJDLsM050698;
        Wed, 30 Oct 2019 19:21:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vxwj7bswh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 19:21:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9UJLQnn031026;
        Wed, 30 Oct 2019 19:21:27 GMT
Received: from [10.175.10.171] (/10.175.10.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 12:21:26 -0700
Subject: Re: [RFC 0/2] io_uring: examine request result only after completion
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
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
 <3b71fff1-5b5e-3d33-b701-c7e1b3c9d8b9@oracle.com>
 <e334c317-e40a-f670-1d6e-220ddff05d64@kernel.dk>
 <07d23273-09e2-1a63-3f18-4d19af298a44@kernel.dk>
 <f5f647c4-2a6b-3678-1797-e40c89834149@oracle.com>
 <ff003ca8-e7d6-d3a8-9caa-311d55ef4319@kernel.dk>
 <54061a1a-0d90-43ff-445b-efb3d057b1ee@kernel.dk>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <b649d8aa-d8fb-8ab2-3816-a3b74dda5385@oracle.com>
Date:   Wed, 30 Oct 2019 12:21:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <54061a1a-0d90-43ff-445b-efb3d057b1ee@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300167
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/30/19 10:32 AM, Jens Axboe wrote:
> On 10/30/19 8:18 AM, Jens Axboe wrote:
>> On 10/30/19 8:02 AM, Bijan Mottahedeh wrote:
>>>> OK, so I still don't quite see where the issue is. Your setup has more
>>>> than one CPU per poll queue, and I can reproduce the issue quite easily
>>>> here with a similar setup.
>>> That's probably why I couldn't reproduce this in a vm.  This time I set
>>> up one poll queue in a 8 cpu vm and reproduced it.
>> You definitely do need poll queue sharing to hit this.
>>
>>>> Below are some things that are given:
>>>>
>>>> 1) If we fail to submit the IO, io_complete_rw_iopoll() is ultimately
>>>>        invoked _from_ the submission path. This means that the result is
>>>>        readily available by the time we go and check:
>>>>
>>>>        if (req->result == -EAGAIN)
>>>>
>>>>        in __io_submit_sqe().
>>> Is that always true?
>>>
>>> Let's say the operation was __io_submit_sqe()->io_read()
>>>
>>> By "failing to submit the io", do you mean that
>>> io_read()->call_read_iter() returned success or failure?  Are you saying
>>> that req->result was set from kiocb_done() or later in the block layer?
>> By "failed to submit" I mean that req->result == -EAGAIN. We set that in
>> io_complete_rw_iopoll(), which is called off bio_wouldblock_error() in
>> the block layer. This is different from an ret != 0 return, which would
>> have been some sort of other failure we encountered, failing to submit
>> the request. For that error, we just end the request. For the
>> bio_wouldblock_error(), we need to retry submission.
>>
>>> Anyway I assume that io_read() would have to return success since
>>> otherwise __io_submit_sqe() would immediately return and not check
>>> req->result:
>>>
>>>             if (ret)
>>>                     return ret;
>> Right, if ret != 0, then we have a fatal error for that request.
>> ->result will not have been set at all for that case.
>>
>>> So if io_read() did return success,  are we guaranteed that setting
>>> req->result = -EAGAIN would always happen before the check?
>> Always, since it happens inline from when you attempt to issue the read.
>>
>>> Also, is it possible that we can be preempted in __io_submit_sqe() after
>>> the call to io_read() but before the -EAGAIN check?
>> Sure, we're not disabling preemption. But that shouldn't have any
>> bearing on this case.
>>>> This is a submission time failure, not
>>>>        something that should be happening from a completion path after the
>>>>        IO has been submitted successfully.
>>>>
>>>> 2) If the succeed in submitting the request, given that we have other
>>>>        tasks polling, the request can complete any time. It can very well be
>>>>        complete by the time we call io_iopoll_req_issued(), and this is
>>>>        perfectly fine. We know the request isn't going away, as we're
>>>>        holding a reference to it. kiocb has the same lifetime, as it's
>>>>        embedded in the io_kiocb request. Note that this isn't the same
>>>>        io_ring_ctx at all, some other task with its own io_ring_ctx just
>>>>        happens to find our request when doing polling on the same queue
>>>>        itself.
>>> Ah yes, it's a different io_ring_ctx, different poll list etc. For my
>> Exactly
>>
>>> own clarity, I assume all contexts are mapping the same actual sq/cq
>>> rings?
>> The ring/context isn't mapped to a particular ring, a specific IO is
>> mapped to a specific queue at the time it's being submitted. That
>> depends on the IO type and where that task happens to be running at the
>> time the IO is being submitted.
> This might just do it, except it looks like there's a bug in sbitmap
> where we don't always flush deferred clears. I'll look into that now.
>
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index af1937d66aee..f3ca2ee44dbd 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1212,6 +1212,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
>   
>   		kiocb->ki_flags |= IOCB_HIPRI;
>   		kiocb->ki_complete = io_complete_rw_iopoll;
> +		req->result = 0;
>   	} else {
>   		if (kiocb->ki_flags & IOCB_HIPRI)
>   			return -EINVAL;
>
I checked out a few configs and didn't hit the error.  However, with 16 
poll queues and 32 fio jobs, I eventually started getting a bunch of 
nvme timeout/abort messages and the system seemed to be stuck in a poll 
loop.  IKilling the test didn't work and the system was hung:

...

[  407.978329] nvme nvme0: I/O 679 QID 30 timeout, aborting
[  408.085318] nvme nvme0: I/O 680 QID 30 timeout, aborting
[  408.164145] nvme nvme0: I/O 682 QID 30 timeout, aborting
[  408.238102] nvme nvme0: I/O 683 QID 30 timeout, aborting
[  412.970712] nvme nvme0: Abort status: 0x0r=239k IOPS][eta 01m:30s]
[  413.018696] nvme nvme0: Abort status: 0x0
[  413.066691] nvme nvme0: Abort status: 0x0
[  413.114684] nvme nvme0: Abort status: 0x0
[  438.035324] nvme nvme0: I/O 674 QID 30 timeout, reset controllers]
[  444.287637] nvme nvme0: 15/0/16 default/read/poll queues
[  637.073111] INFO: task kworker/u66:0:55 blocked for more than 122 
seconds.

...

fio: terminating on signal 2
Jobs: 32 (f=32): [r(32)][0.3%][eta 02d:01h:28m:36s]



Couldn't ssh to the machine and started getting hung task timeout errors.

