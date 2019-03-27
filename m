Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC4C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 02:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531AF20811
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 02:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y35MTOzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfC0C2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:28:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42730 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbfC0C2V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 22:28:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2R2KOw3067126;
        Wed, 27 Mar 2019 02:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=b5+RGWj+E5eK6IbAMmRbOrSnXzITWamXd/TqlrRPG6A=;
 b=y35MTOzw3YZABJsVzD40XtjIvb9jVH2cWzrACR+yBvZAPLDrcQQNMtRjP+vX2iltcLtt
 NqefIUqL2LcgbxRpRRWS1+lPm1XOq5Aro1XOoANbAFzwFd5nfZgl4xWN6RQNu7mzkK9h
 oVgStvJ1W4wY4A22mnPkJQQrPuZfSeEkF7l225FDwll8dZH5+8hV1iKZp4SkdT0Izurl
 bjrTa5cFBJ0P+0ghz9Y4aTMAD4kmJUBXW3gXTnNuRs+KoSXItvMGScXbhm3o2tWVjAWD
 v2HxEVitd3VqsYSWJPJTElHKzlbITjhBZH/Y+J6me/o7MYi0jZ/X/5t8F6Oo68ZamqbQ +Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2re6g15uvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 02:27:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2R2RwZG011023
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 02:27:58 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2R2Rvgd026969;
        Wed, 27 Mar 2019 02:27:57 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 19:27:56 -0700
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Busch, Keith" <keith.busch@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
 <20190326235726.GC4328@localhost.localdomain>
 <c0d65c3c-bf2e-ff84-caac-e64b30e4e79f@oracle.com>
 <20190327021521.GA7389@localhost.localdomain>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <1bbe1b5c-3564-55e8-6824-f679b3c5dd3f@oracle.com>
Date:   Wed, 27 Mar 2019 10:27:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327021521.GA7389@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270015
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/27/19 10:15 AM, Keith Busch wrote:
> On Wed, Mar 27, 2019 at 10:03:26AM +0800, jianchao.wang wrote:
>> Hi Keith
>>
>> On 3/27/19 7:57 AM, Keith Busch wrote:
>>> On Mon, Mar 25, 2019 at 08:05:53PM -0700, jianchao.wang wrote:
>>>> What if there used to be a io scheduler and leave some stale requests of sched tags ?
>>>> Or the nr_hw_queues was decreased and leave the hctx->fq->flush_rq ?
>>>
>>> Requests internally queued in scheduler or block layer are not eligible
>>> for the nvme driver's iterator callback. We only use it to reclaim
>>> dispatched requests that the target can't return, which only applies to
>>> requests that must have a valid rq->tag value from hctx->tags.
>>>  
>>>> The stable request could be some tings freed and used
>>>> by others and the state field happen to be overwritten to non-zero...
>>>
>>> I am not sure I follow what this means. At least for nvme, every queue
>>> sharing the same tagset is quiesced and frozen, there should be no
>>> request state in flux at the time we iterate.
>>>
>>
>> In nvme_dev_disable, when we try to reclaim the in-flight requests with blk_mq_tagset_busy_iter,
>> the request_queues are quiesced but just start-freeze.
>> We will try to _drain_ the in-flight requests for the _shutdown_ case when controller is not dead.
>> For the reset case, there still could be someone escapes the checking of queue freezing and enters
>> blk_mq_make_request and tries to allocate tag, then we may get,
>>
>> generic_make_request        nvme_dev_disable
>>  -> blk_queue_enter              
>>                               -> nvme_start_freeze (just start freeze, no drain)
>>                               -> nvme_stop_queues
>>  -> blk_mq_make_request
>>   - > blk_mq_get_request      -> blk_mq_tagset_busy_iter
>>      -> blk_mq_get_tag
>>                       　　        -> bt_tags_for_each
>>                          　　　       -> bt_tags_iter
>>                               　　       -> rq = tags->rqs[] ---> [1]
>>      -> blk_mq_rq_ctx_init
>>        -> data->hctx->tags->rqs[rq->tag] = rq;
>>
>> The rq got on position [1] could be a stale request that has been freed due to,
>> 1. a hctx->fq.flush_rq of dead request_queue that shares the same tagset
>> 2. a removed io scheduler's sched request
>>
>> And this stale request may have been used by others and the request->state is changed to a non-zero
>> value and passes the checking of blk_mq_request_started and then it will be handled by nvme_cancel_request.
> 
> How is that request state going to be anyting other than IDLE? A freed
> request state is IDLE, and continues to be IDLE until dispatched. But
> dispatch is blocked for the entire tagset, so request states can't be
> started during an nvme reset.
> 

As the comment above, the stable request maybe something that has been freed due to following case,
1. a hctx->fq.flush_rq of dead request_queue that shares the same tagset
2. a removed io scheduler's sched request
and this freed request could be allocated by others which may change the field of request->state.

Thanks
Jianchao
