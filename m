Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1FECA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 19:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8AD21A4C
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 19:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bsbXUAtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfJXTSd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:18:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50950 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfJXTSd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 15:18:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OJDpep056935;
        Thu, 24 Oct 2019 19:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=g2hRYHKg7mYI+XMa9ztEy2oE08gyVcby73KGJMWZlU8=;
 b=bsbXUAtDG4fAXmdYkbaxFdDWCaBxxZ9e8cgxyVDQ4OJbYzhW+mBVyOgWbeIXVW7q6KRI
 tib/3Da0qXthLWkmgnylnfbo55Upd1NBIqEmunI+hX+eoJsQt0zExl2yiawQiEQwuIr7
 XY1AcYkLjTDPUbeGEqMPWyc4uqkR5vJHdNyXY6w60aiq8PNiFPJggff7NvQA961gtUGl
 lU9YeC/pYyaVrEVgwNaqc+blogsSJETEltM2rDlsLHM8ERBhc5w/ArwgRkdOc6TVBTLq
 oXZsMdumxsDTOu26KNmfXvY3n2pGTOqexU2wV+t9sDWxfvaHQJpawirF11GC8xV9NX50 dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vqswtwtxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 19:18:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OJEbaJ040202;
        Thu, 24 Oct 2019 19:18:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vtsk5hhsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 19:18:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9OJISbh016853;
        Thu, 24 Oct 2019 19:18:30 GMT
Received: from [10.175.26.174] (/10.175.26.174)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 12:18:28 -0700
Subject: Re: [RFC 0/2] io_uring: examine request result only after completion
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
 <22fc1057-237b-a9b8-5a57-b7c53166a609@kernel.dk>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <201931df-ae22-c2fc-a9c7-496ceb87dff7@oracle.com>
Date:   Thu, 24 Oct 2019 12:18:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <22fc1057-237b-a9b8-5a57-b7c53166a609@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240180
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/24/19 10:09 AM, Jens Axboe wrote:
> On 10/24/19 3:18 AM, Bijan Mottahedeh wrote:
>> Running an fio test consistenly crashes the kernel with the trace included
>> below.  The root cause seems to be the code in __io_submit_sqe() that
>> checks the result of a request for -EAGAIN in polled mode, without
>> ensuring first that the request has completed:
>>
>> 	if (ctx->flags & IORING_SETUP_IOPOLL) {
>> 		if (req->result == -EAGAIN)
>> 			return -EAGAIN;
> I'm a little confused, because we should be holding the submission
> reference to the request still at this point. So how is it going away?
> I must be missing something...

I don't think the submission reference is going away...

I *think* the problem has to do with the fact that 
io_complete_rw_iopoll() which sets REQ_F_IOPOLL_COMPLETED is being 
called from interrupt context in my configuration and so there is a 
potential race between updating the request there and checking it in 
__io_submit_sqe().

My first workaround was to simply poll for REQ_F_IOPOLL_COMPLETED in the 
code snippet above:

     if (req->result == --EAGAIN) {

         poll for REQ_F_IOPOLL_COMPLETED

         return -EAGAIN;

}

and that got rid of the problem.

>
>> The request will be immediately resubmitted in io_sq_wq_submit_work(),
>> potentially before the the fisrt submission has completed.  This creates
>> a race where the original completion may set REQ_F_IOPOLL_COMPLETED in
>> a freed submission request, overwriting the poisoned bits, casusing the
>> panic below.
>>
>> 	do {
>> 		ret = __io_submit_sqe(ctx, req, s, false);
>> 		/*
>> 		 * We can get EAGAIN for polled IO even though
>> 		 * we're forcing a sync submission from here,
>> 		 * since we can't wait for request slots on the
>> 		 * block side.
>> 		 */
>> 		if (ret != -EAGAIN)
>> 			break;
>> 		cond_resched();
>> 	} while (1);
>>
>> The suggested fix is to move a submitted request to the poll list
>> unconditionally in polled mode.  The request can then be retried if
>> necessary once the original submission has indeed completed.
>>
>> This bug raises an issue however since REQ_F_IOPOLL_COMPLETED is set
>> in io_complete_rw_iopoll() from interrupt context.  NVMe polled queues
>> however are not supposed to generate interrupts so it is not clear what
>> is the reason for this apparent inconsitency.
> It's because you're not running with poll queues for NVMe, hence you're
> throwing a lot of performance away. Load nvme with poll_queues=X (or boot
> with nvme.poll_queues=X, if built in) to have a set of separate queues
> for polling. These don't have IRQs enabled, and it'll work much faster
> for you.
>
That's what I did in fact.  I booted with nvme.poll_queues=36 (I figured 
1 per core but I'm not sure what is a reasonable number).

I also checked that /sys/block/<nvme>/queue/io_poll = 1.

What's really odd is that the irq/sec numbers from mpstat and perf show 
equivalent values with/without polling (with/without fio "hipri" option) 
even though I can see from perf top that we are in fact polling in one 
case. I don't if I missing a step or something is off in my config.

Thanks.

--bijan

