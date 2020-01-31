Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B7FC33CB7
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 03:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA2E20708
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 03:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+r/yhkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgAaDhA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:37:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43426 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgAaDg7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jan 2020 22:36:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V3SUO4114959;
        Fri, 31 Jan 2020 03:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=cfljfKQYb816AWsAg73hBRRbvJb2+9srkEKpYvW6uFE=;
 b=Z+r/yhknoH3tQb0UQ6Ub34XgaTunE93Sr9jjuA67Ht+j/ssHE1NW2g3wF5ef+eSzqvHW
 2gquMqRWAqVYC0vOpwIqS7PdMgNF193bfEZ3z0vn0hCNwDdkrwXPiNThj4RKylJLzugg
 O8VhtkMW36uyX/Qka3vHreCZAwNHCMlxe9N4oonO9lXjSSN2mm5J98355SSTXQ5X+9dO
 rs4XtB4Mw1coWzVpviaxi30Z3FCvHkKmD6kocyVK7BGSB74tBJ2u4jIVi0DErE0Yoliw
 56Tk9N5EDbOR62nMLG7sbLChXqPv/lLv4lMvZWSHDVeTdz8F+M0IZ+66v7955uxz//GG /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xrearqsmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 03:36:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V3YPwn143544;
        Fri, 31 Jan 2020 03:36:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xuheu3wn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 03:36:52 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00V3aoJR031801;
        Fri, 31 Jan 2020 03:36:50 GMT
Received: from [10.154.154.177] (/10.154.154.177)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 19:36:49 -0800
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
 <f56a8767-c754-b2e9-bfea-1ced197a05d7@oracle.com>
 <3f3f8b48-2e50-d0bb-b912-6d03961b2d6a@kernel.dk>
 <5d110b77-fdd3-d907-69b2-26894b5ad43a@oracle.com>
 <047765e1-1820-a3d6-3529-c9451316119d@kernel.dk>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <aa9a5d6d-dd70-ae82-8fef-6882f7591d5b@oracle.com>
Date:   Thu, 30 Jan 2020 19:36:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <047765e1-1820-a3d6-3529-c9451316119d@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 200129-0, 01/28/2020), Outbound message
X-Antivirus-Status: Clean
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310029
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>>>> I'm however still seeing a use-after-free error in the request
>>>>>>>> completion path in nvme_unmap_data().  It happens only when testing with
>>>>>>>> large block sizes in fio, typically > 128k, e.g. bs=256k will always hit it.
>>>>>>>>
>>>>>>>> This is the error:
>>>>>>>>
>>>>>>>> DMA-API: nvme 0000:00:04.0: device driver tries to free DMA memory it
>>>>>>>> has not allocated [device address=0x6b6b6b6b6b6b6b6b] [size=1802201963
>>>>>>>> bytes]
>>>>>>>>
>>>>>>>> and this warning occasionally:
>>>>>>>>
>>>>>>>> WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
>>>>>>>>
>>>>>>>> It seems like a request might be issued multiple times but I can't see
>>>>>>>> anything in io_uring code that would account for it.
>>>>>>> Both of them indicate reuse, and I agree I don't think it's io_uring. It
>>>>>>> really feels like an issue with nvme when a poll queue is shared, but I
>>>>>>> haven't been able to pin point what it is yet.
>>>>>>>
>>>>>>> The 128K is interesting, that would seem to indicate that it's related to
>>>>>>> splitting of the IO (which would create > 1 IO per submitted IO).
>>>>>>>
>>>>>> Where does the split take place?  I had suspected that it might be
>>>>>> related to the submit_bio() loop in __blkdev_direct_IO() but I don't
>>>>>> think I saw multiple submit_bio() calls or maybe I missed something.
>>>>> See the path from blk_mq_make_request() -> __blk_queue_split() ->
>>>>> blk_bio_segment_split(). The bio is built and submitted, then split if
>>>>> it violates any size constraints. The splits are submitted through
>>>>> generic_make_request(), so that might be why you didn't see multiple
>>>>> submit_bio() calls.
>>>>>
>>>> I think the problem is in __blkdev_direct_IO() and not related to
>>>> request size:
>>>>
>>>>                            qc = submit_bio(bio);
>>>>
>>>>                            if (polled)
>>>>                                    WRITE_ONCE(iocb->ki_cookie, qc);
>>>>
>>>>
>>>> The first call to submit_bio() when dio->is_sync is not set won't have
>>>> acquired a bio ref through bio_get() and so the bio/dio could be freed
>>>> when ki_cookie is set.
>>>>
>>>> With the specific io_uring test, this happens because
>>>> blk_mq_make_request()->blk_mq_get_request() fails and so terminates the
>>>> request.
>>>>
>>>> As for the fix for polled io (!is_sync) case, I'm wondering if
>>>> dio->multi_bio is really necessary in __blkdev_direct_IO(). Can we call
>>>> bio_get() unconditionally after the call to bio_alloc_bioset(), set
>>>> dio->ref = 1, and increment it for additional submit bio calls?  Would
>>>> it make sense to do away with multi_bio?
>>> It's not ideal, but not sure I see a better way to fix it. You see the
>>> case on failure, which we could check for (don't write cookie if it's
>>> invalid). But this won't fix the case where the IO complete fast, or
>>> even immediately.
>>>
>>> Hence I think you're right, there's really no way around doing the bio
>>> ref counting, even for the sync case. Care to cook up a patch we can
>>> take a look at? I can run some high performance sync testing too, so we
>>> can see how badly it might hurt.
>> Sure, I'll take a stab at it.
> Thanks!

I sent it out.  When I tested with next-20200114, the fio test ran ok 
for sync/async with 4k.  The sync test ran ok with 256k as well but I 
still hit the original use-after-free bug with 256k.

With next-20200130 however, I'm hitting the use-after-free bug even with 
4k so it is not a size related issue.

I wasn't sure how to force a multi-bio case so that hasn't been tested.

Also, a question about below code in io_complete_rw_iopoll()

         if (res != req->result)
                 req_set_fail_links(req);


req->result could be set to the size of the completed io request, is the 
check ok in that case?

>>>> Also, I'm not clear on how is_sync + mult_bio case is supposed to work.
>>>> __blkdev_direct_IO() polls for *a* completion in the request's hctx and
>>>> not *the* request completion itself, so what does that tell us for
>>>> multi_bio + is_sync? Is the polling supposed to guarantee that all
>>>> constituent bios for a mult_bio request have completed before return?
>>> The polling really just ignores that, it doesn't take multi requests
>>> into account. We just poll for the first part of it.

In a multi-bio case, I think it would poll for the last part of it, I 
haven't changed that.  I did add a check for a valid cookie since I 
think it would loop forever in that case.

