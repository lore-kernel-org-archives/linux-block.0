Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E00CA9EC5
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C4E20874
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 14:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jacC3sXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfJ3OC4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:02:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43424 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJ3OC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 10:02:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UDn2nM115634;
        Wed, 30 Oct 2019 14:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=52syFLSY8DhCN6RRALbz1XaMPKoKqqnrz8O9ImR+e9Q=;
 b=jacC3sXxcQvmlVVHV0UKapfyoVOB1iZMNy89xgy5zlMgpjnIbpvJweGZdvfIlRycEkdJ
 +SUz9KZWNTkf4mh9/XW47gePA488rQH5bx/ta0EOz16SnQ58+zkvsNCq/58i4ABkmJAM
 Nr4YwHHYxIOqlZmPD5QnCpTZ2EaL1d+pAfw9Uucwqj+S0yGcQPYApzZ9bXl9E7khchj+
 6YX/U2UzKj7jp93Fp5uM9sjJLjO/c6irWqaZFyRH2IBFP8IXEaMuI86ezs0njAGUknkD
 5wpxhq6lSxnkjuX7ufabdPnhI7zH5LYtzEy4G6+4V6KLsgiuxzjxOjdHl5S5RR/Bcwcc uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vxwhfmex6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 14:02:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UDmsoT107204;
        Wed, 30 Oct 2019 14:02:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vxwj9bmgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 14:02:50 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9UE2ojx003482;
        Wed, 30 Oct 2019 14:02:50 GMT
Received: from [10.175.10.171] (/10.175.10.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 07:02:49 -0700
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
 <3b71fff1-5b5e-3d33-b701-c7e1b3c9d8b9@oracle.com>
 <e334c317-e40a-f670-1d6e-220ddff05d64@kernel.dk>
 <07d23273-09e2-1a63-3f18-4d19af298a44@kernel.dk>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <f5f647c4-2a6b-3678-1797-e40c89834149@oracle.com>
Date:   Wed, 30 Oct 2019 07:02:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <07d23273-09e2-1a63-3f18-4d19af298a44@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300134
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> OK, so I still don't quite see where the issue is. Your setup has more
> than one CPU per poll queue, and I can reproduce the issue quite easily
> here with a similar setup.

That's probably why I couldn't reproduce this in a vm.  This time I set 
up one poll queue in a 8 cpu vm and reproduced it.

> Below are some things that are given:
>
> 1) If we fail to submit the IO, io_complete_rw_iopoll() is ultimately
>     invoked _from_ the submission path. This means that the result is
>     readily available by the time we go and check:
>
>     if (req->result == -EAGAIN)
>
>     in __io_submit_sqe().

Is that always true?

Let's say the operation was __io_submit_sqe()->io_read()

By "failing to submit the io", do you mean that 
io_read()->call_read_iter() returned success or failure?  Are you saying 
that req->result was set from kiocb_done() or later in the block layer?

Anyway I assume that io_read() would have to return success since 
otherwise __io_submit_sqe() would immediately return and not check 
req->result:

         if (ret)
                 return ret;

So if io_read() did return success,  are we guaranteed that setting 
req->result = -EAGAIN would always happen before the check?

Also, is it possible that we can be preempted in __io_submit_sqe() after 
the call to io_read() but before the -EAGAIN check?

> This is a submission time failure, not
>     something that should be happening from a completion path after the
>     IO has been submitted successfully.
>
> 2) If the succeed in submitting the request, given that we have other
>     tasks polling, the request can complete any time. It can very well be
>     complete by the time we call io_iopoll_req_issued(), and this is
>     perfectly fine. We know the request isn't going away, as we're
>     holding a reference to it. kiocb has the same lifetime, as it's
>     embedded in the io_kiocb request. Note that this isn't the same
>     io_ring_ctx at all, some other task with its own io_ring_ctx just
>     happens to find our request when doing polling on the same queue
>     itself.

Ah yes, it's a different io_ring_ctx, different poll list etc. For my 
own clarity, I assume all contexts are mapping the same actual sq/cq rings?

>
> We would definitely get in trouble if we submitted the request
> successfully, but returned -EAGAIN because we thought we didn't.
>
> In my testing, what I seem to see is double completions on the block
> layer side, and double issues. I can't quite get that to match up with
> anything...
>
> I'll keep digging, hopefully I'll get some deeper understanding of what
> exactly the issue is shortly. I was hoping I'd get that by writing my
> thoughts in this email, but alas that didn't happen yet.
>
