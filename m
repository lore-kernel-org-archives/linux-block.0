Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD76C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C00E217D7
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CB3kF7DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAYJD6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:03:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51330 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfAYJD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:03:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0P8xX6u086131;
        Fri, 25 Jan 2019 09:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uiQ+msSuTrzc5CX01QeqtKLN0rdgjME5kpMPCaJd5aE=;
 b=CB3kF7DCFrnGHd7g9eEiZQH6knGt9Lk3MgPRwd16/oEWDsfWhrcHsT6nldbcU+h/DLvg
 0EjldiayppTNuOwllfqRdBQCs0laD5qehXUxlhjsguHGHb7jMTDrAGF70znxep5u2Cqp
 ijx0EZF7kImrkWls5rQ4qxw72Y5PdGeYWp7pbtYdq0KPvqkn77JrAxLBzNphsazFb7ck
 z4Otjk1XU8MjIRqK+Z9qkmamoyK5yOCgefiNqMwgOtAFm+eoCkyn3Ml+farHwyS/gg8L
 2pSJTSUtVyO1nKx7s+ziYl4uvd5BpHfu/aWoV0SYsWifCLHLYTYX4ZFi76Sw9LmhgO6L CA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2q3vhs4fes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 09:03:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0P93obX000539
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 09:03:51 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0P93oMb006409;
        Fri, 25 Jan 2019 09:03:50 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jan 2019 01:03:50 -0800
Subject: Re: fsync hangs after scsi rejected a request
To:     Florian Stecker <m19@florianstecker.de>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
 <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
 <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
 <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com>
 <e18051e3-4008-e259-dee3-dd58f23642ab@oracle.com>
 <4b631218-49ee-c3ed-46be-17f9d30b663f@florianstecker.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c42631fa-3e61-e046-851e-8079906a14fb@oracle.com>
Date:   Fri, 25 Jan 2019 17:05:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4b631218-49ee-c3ed-46be-17f9d30b663f@florianstecker.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9146 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901250075
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/25/19 4:56 PM, Florian Stecker wrote:
> On 1/25/19 4:49 AM, jianchao.wang wrote:
>>
>> It sounds like not so easy to trigger.
>>
>> blk_mq_dispatch_rq_list
>>    scsi_queue_rq
>>       if (atomic_read(&sdev->device_busy) ||
>>         scsi_device_blocked(sdev))
>>         ret = BLK_STS_DEV_RESOURCE;             scsi_end_request
>>                                                   __blk_mq_end_request
>>                                                     blk_mq_sched_restart // clear RESTART
>>                                                       blk_mq_run_hw_queue
>>                                                   blk_mq_run_hw_queues
>>      list_splice_init(list, &hctx->dispatch)
>>    needs_restart = blk_mq_sched_needs_restart(hctx)
>>
>> The 'needs_restart' will be false, so the queue would be rerun.
>>
>> Thanks
>> Jianchao
> 
> Good point. So the RESTART flag is supposed to protect against this? Now I see, this is also sort of what the lengthy comment in blk_mq_dispatch_rq_list is saying.
> 
> May I complain that this is very unintuitive (the queue gets rerun when the RESTART flag is _not_ set) and also unreliable, as not every caller of blk_mq_dispatch_rq_list seems to set the flag, and also it does not always get cleared in __blk_mq_end_request?
> 
> __blk_mq_end_request does the following:
> 
>     if (rq->end_io) {
>         rq_qos_done(rq->q, rq);
>         rq->end_io(rq, error);
>     } else {
>         if (unlikely(blk_bidi_rq(rq)))
>             blk_mq_free_request(rq->next_rq);
>         blk_mq_free_request(rq);
>     }
> 
> and blk_mq_free_request then calls blk_mq_sched_restart, which clears the flag. But in my case, rq->end_io != 0, so blk_mq_free_request is never called.

So what is your rq->end_io ?
flush_end_io ? or mq_flush_data_end_io ? or other ?
In normal case, the blk_mq_end_request should be finally invoked.

Did you ever try the bfq io scheduler instead of mq-deadline ?

Can you share your dmesg and config file here ?

Thanks
Jianchao
