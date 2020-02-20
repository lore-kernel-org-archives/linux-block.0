Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B643BC5ACC4
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 03:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D1924656
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 03:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eLh6pBDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgBTDLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 22:11:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41174 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgBTDLm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 22:11:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K32vXe166542;
        Thu, 20 Feb 2020 03:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yIzZpckXsuwtE6Nx3h4VrTdz55GwVvjmAiEiwHRpifE=;
 b=eLh6pBDEjNbfQ0cgrRspvoA+Lm7tY9y4B9yzCDBWkpwxM6S2GBhzwcaE7vrXcUiCfJCz
 N7QZjS42HvjDu1R4YPoQvONh1CMnbQ1THJo3RLWPnaSusV33TImJ36JcOAwwF7jaXBfd
 RBbhqmOqy4bTGKttK8PfDEy0ZeCciGtrRWzdUIBbZvlpRfz19qGs/QRXKu73hy+eDsop
 rBhgChgUqLMkdn915xRKMFNIC+juwAzV9bkH4Ff5coxUiodeU9/2ofxXblWDSbtvYd7w
 UA0v8qtixpEGaaEJ9kwPyvcGhl9PxQ71SAa5kJrbrMdhzoheGWZlDsMJgcASu2IvB65G sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y8udd71xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 03:11:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K33CfI146410;
        Thu, 20 Feb 2020 03:11:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y8udbr7g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 03:11:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01K3BQ7i018289;
        Thu, 20 Feb 2020 03:11:26 GMT
Received: from [10.159.136.49] (/10.159.136.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 19:11:26 -0800
Subject: Re: [PATCH] blk-mq: insert passthrough request into hctx->dispatch
 directly
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Ewan D. Milne" <emilne@redhat.com>
References: <20200215032140.4093-1-ming.lei@redhat.com>
 <20200219163615.GE18377@infradead.org> <20200219221036.GA24522@ming.t460p>
 <0e1d5b99-28f3-79b3-d5b4-25f6b4f95955@oracle.com>
 <20200220014526.GA1469@ming.t460p>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <91a78b4a-97cb-ee34-a240-3d3748dcf969@oracle.com>
Date:   Wed, 19 Feb 2020 19:11:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220014526.GA1469@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200023
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/19/20 5:45 PM, Ming Lei wrote:
> On Wed, Feb 19, 2020 at 03:47:50PM -0800, dongli.zhang@oracle.com wrote:
>>
>>
>> On 2/19/20 2:10 PM, Ming Lei wrote:
>>> On Wed, Feb 19, 2020 at 08:36:15AM -0800, Christoph Hellwig wrote:
>>>> On Sat, Feb 15, 2020 at 11:21:40AM +0800, Ming Lei wrote:
>>>>> For some reason, device may be in one situation which can't handle
>>>>> FS request, so STS_RESOURCE is always returned and the FS request
>>>>> will be added to hctx->dispatch. However passthrough request may
>>>>> be required at that time for fixing the problem. If passthrough
>>>>> request is added to scheduler queue, there isn't any chance for
>>>>> blk-mq to dispatch it given we prioritize requests in hctx->dispatch.
>>>>> Then the FS IO request may never be completed, and IO hang is caused.
>>>>>
>>>>> So passthrough request has to be added to hctx->dispatch directly.
>>>>>
>>>>> Fix this issue by inserting passthrough request into hctx->dispatch
>>>>> directly. Then it becomes consistent with original legacy IO request
>>>>> path, in which passthrough request is always added to q->queue_head.
>>>>
>>>> Do you have a description of an actual problem this fixes?  Maybe even
>>>> a reproducer for blktests?
>>>>
>>>
>>> It is reported by one RH customer in the following test case:
>>>
>>> 	1) Start IO on Emulex FC host
>>> 	2) Fail one controller, wait 5 minutes
>>> 	3) Bring controller back online
>>>
>>> When we trace the problem, it is found that FS request started in device_add_disk()
>>> from scsi disk probe context stuck because scsi_queue_rq() always return
>>> STS_BUSY via scsi_setup_fs_cmnd() -> alua_prep_fn().
>>>
>>> The kernel ALUA state is TRANSITIONING at that time, so it is reasonable to see
>>> BLK_TYPE_FS requests won't go anywhere because of the check in alua_prep_fn().
>>>
>>> However, the passthrough request(TEST UNIT READY) is submitted from alua_rtpg_work
>>> when the FS request can't be dispatched to LLD. And SCSI stack should
>>> have been allowed to handle this passthrough rquest. But it can't reach SCSI stack
>>> via .queue_rq() because blk-mq won't dispatch it until hctx->dispatch is
>>> empty.
>>>
>>> The legacy IO request code always added passthrough request into head of q->queue_head
>>> directly instead of scheduler queue or sw queue, so no such issue.
>>>
>>> So far not figured out one blktests test case, but the problem is real.
>>>
>>> BTW, I just found we need the extra following change:
>>>
>>> @@ -1301,7 +1301,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>>>                         q->mq_ops->commit_rqs(hctx);
>>>
>>>                 spin_lock(&hctx->lock);
>>> -               list_splice_init(list, &hctx->dispatch);
>>> +               list_splice_tail_init(list, &hctx->dispatch);
>>>                 spin_unlock(&hctx->lock);
>>>
>>
>> Is it fine to add to tail as the requests on dispatch would be reordered?
> 
> Wrt. FS request:
> 
> Firstly we never guarantee that the request is dispatched in order.
> 
> Secondly and more importantly, request can be added into hctx->dispatch
> in any order. One usual case is that request is added to hctx->dispatch
> concurrently when .queue_rq() fails. On the other side, in case of not
> concurrent adding to hctx->dispatch, after one request is added to
> hctx->dispatch, we always dispatch request from hctx->dispatch first,
> instead of dequeuing request from scheduler queue and adding them to
> hctx->dispatch again after .queue_rq() fails.
> 
>>
>> A, B, C and D are on the list. Suppose A is failed and the new list would become
>> B, C D, A?
> 
> Right, I don't see there is any issue in this way, do you see issues?

Thank you very much for the explanation. I do not see issue if order guarantee
in hctx->dispatch is not required.

Dongli Zhang
