Return-Path: <SRS0=qLSf=3R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D71C2D0DB
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 20:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6DB2073A
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 20:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EU6ZQ7Vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgA1UfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:35:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgA1UfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jan 2020 15:35:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SKXAEJ071715;
        Tue, 28 Jan 2020 20:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=d3nOduFGNMIRVklSOzDpeqy27FD3AOXJuXt0+MEgZ0o=;
 b=EU6ZQ7VpYAJYZAAKgZdb3lg6RzYa/fVHt12I48Q/ok8jGnMJjwkMWpcuGjsxPhzcFOjI
 fLfhcMbLhO6dWp7z8Rv4DtsI234GG79eNuGUzbn2IJTkXvqSm6cq8FFvY5LvA6op8JpC
 82H0Zp0CEm5iyiOGFT89OIAuM7tdkkdv3e2cSTGjwyJ9ex5ESZHrYzVxggynXqLDsjlP
 i8wibGM8pZSWwQlpDG7KIRSjaU31917LZ2Ns+o75Fp/p/RZGjZHp+dUUEllxgGo0Iv23
 WvPfhl4LcsFe+YPIDQI6pvhZ5ym/c/BKSKtVv1md/JWW6HZF32XC+qYcL6tPY5lsyvsG 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xrd3u8xdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 20:34:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SKYeqX138945;
        Tue, 28 Jan 2020 20:34:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xta8jj2vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 20:34:56 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00SKYqJm017795;
        Tue, 28 Jan 2020 20:34:53 GMT
Received: from [10.154.146.35] (/10.154.146.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jan 2020 12:34:52 -0800
Subject: Re: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling
 io_issue_sqe()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@gmail.com>
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
 <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
 <8f7986c7-e5b4-8f24-1c71-666c01b16c8b@kernel.dk>
 <1397cd55-37a6-4e14-91ac-eb3c35e7d962@kernel.dk>
 <b43835cd-3bd6-705e-df51-923bbec78c67@oracle.com>
 <18346d15-d89d-9d28-1ef8-77574d44dce7@kernel.dk>
 <229bd8ea-cd65-c77a-ad58-2a79f3bd0c5b@oracle.com>
 <a316d3fe-4162-8274-a74a-2d13a4caf011@kernel.dk>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <f56a8767-c754-b2e9-bfea-1ced197a05d7@oracle.com>
Date:   Tue, 28 Jan 2020 12:34:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a316d3fe-4162-8274-a74a-2d13a4caf011@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 200127-0, 01/27/2020), Outbound message
X-Antivirus-Status: Clean
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280154
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/2020 1:26 PM, Jens Axboe wrote:
> On 1/16/20 2:04 PM, Bijan Mottahedeh wrote:
>> On 1/16/2020 12:02 PM, Jens Axboe wrote:
>>> On 1/16/20 12:08 PM, Bijan Mottahedeh wrote:
>>>> On 1/16/2020 8:22 AM, Jens Axboe wrote:
>>>>> On 1/15/20 9:42 PM, Jens Axboe wrote:
>>>>>> On 1/15/20 9:34 PM, Jens Axboe wrote:
>>>>>>> On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
>>>>>>>> io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
>>>>>>>> so acquire ctx->uring_lock beforehand similar to other instances of
>>>>>>>> calling io_issue_sqe().
>>>>>>> Is the below not enough?
>>>>>> This should be better, we have two that set ->in_async, and only one
>>>>>> doesn't hold the mutex.
>>>>>>
>>>>>> If this works for you, can you resend patch 2 with that? Also add a:
>>>>>>
>>>>>> Fixes: 8a4955ff1cca ("io_uring: sqthread should grab ctx->uring_lock for submissions")
>>>>>>
>>>>>> to it as well. Thanks!
>>>>> I tested and queued this up:
>>>>>
>>>>> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.5&id=11ba820bf163e224bf5dd44e545a66a44a5b1d7a
>>>>>
>>>>> Please let me know if this works, it sits on top of the ->result patch you
>>>>> sent in.
>>>>>
>>>> That works, thanks.
>>>>
>>>> I'm however still seeing a use-after-free error in the request
>>>> completion path in nvme_unmap_data().  It happens only when testing with
>>>> large block sizes in fio, typically > 128k, e.g. bs=256k will always hit it.
>>>>
>>>> This is the error:
>>>>
>>>> DMA-API: nvme 0000:00:04.0: device driver tries to free DMA memory it
>>>> has not allocated [device address=0x6b6b6b6b6b6b6b6b] [size=1802201963
>>>> bytes]
>>>>
>>>> and this warning occasionally:
>>>>
>>>> WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
>>>>
>>>> It seems like a request might be issued multiple times but I can't see
>>>> anything in io_uring code that would account for it.
>>> Both of them indicate reuse, and I agree I don't think it's io_uring. It
>>> really feels like an issue with nvme when a poll queue is shared, but I
>>> haven't been able to pin point what it is yet.
>>>
>>> The 128K is interesting, that would seem to indicate that it's related to
>>> splitting of the IO (which would create > 1 IO per submitted IO).
>>>
>> Where does the split take place?  I had suspected that it might be
>> related to the submit_bio() loop in __blkdev_direct_IO() but I don't
>> think I saw multiple submit_bio() calls or maybe I missed something.
> See the path from blk_mq_make_request() -> __blk_queue_split() ->
> blk_bio_segment_split(). The bio is built and submitted, then split if
> it violates any size constraints. The splits are submitted through
> generic_make_request(), so that might be why you didn't see multiple
> submit_bio() calls.
>

I think the problem is in __blkdev_direct_IO() and not related to 
request size:

                         qc = submit_bio(bio);

                         if (polled)
                                 WRITE_ONCE(iocb->ki_cookie, qc);


The first call to submit_bio() when dio->is_sync is not set won't have 
acquired a bio ref through bio_get() and so the bio/dio could be freed 
when ki_cookie is set.

With the specific io_uring test, this happens because 
blk_mq_make_request()->blk_mq_get_request() fails and so terminates the 
request.

As for the fix for polled io (!is_sync) case, I'm wondering if 
dio->multi_bio is really necessary in __blkdev_direct_IO(). Can we call 
bio_get() unconditionally after the call to bio_alloc_bioset(), set 
dio->ref = 1, and increment it for additional submit bio calls?  Would 
it make sense to do away with multi_bio?

Also, I'm not clear on how is_sync + mult_bio case is supposed to work.  
__blkdev_direct_IO() polls for *a* completion in the request's hctx and 
not *the* request completion itself, so what does that tell us for 
multi_bio + is_sync? Is the polling supposed to guarantee that all 
constituent bios for a mult_bio request have completed before return?


--bijan


PS I couldn't see 256k requests being split via __blk_queue_split(), 
still not sure how that works.

