Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ACAC43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 02:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A77420830
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 02:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dJeuKAjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDBCCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:02:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48656 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCCs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 22:02:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x321wcnt156302;
        Tue, 2 Apr 2019 02:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=GNEYHlj+pXEJT3D/K85vUmRNvxkaMAelc2AUab3NE+k=;
 b=dJeuKAjbHae2YtSp88N8h6a4Bpd8JEc10WhqaacOlrEKjtgH7xABwVAdFJMjv7UO0Q68
 WRF327kYfwiXgYNl49HNeTGYbsTXJxqK5QnEFGKHYdQExxYBc2e0neYd+GSqWlU/Wnuo
 FtNJ1fP0HUYfEY1SKq1sN7WDM909ojNhUnPIFGJRQ1NOtnmSyDR7kB6gSTbrxnewGHay
 XePC8FZzreUz84vQAI9jSePom2Y3tRKVCWGkDOf+0viheHYCxlBNpVTEfX59grx/63+N
 Che7j1n2Fo63u3UJ9xlAJWMSCa8diAPK+tdvyvI4mqtyR/VsGXDjzyRHSQp69Lb8NOVJ uQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2rj13q28ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 02:02:36 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x3222Yhp008584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 02:02:35 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3222X0V008052;
        Tue, 2 Apr 2019 02:02:34 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 19:02:33 -0700
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
 <20190401020036.GB30776@ming.t460p>
 <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
 <20190401025237.GE30776@ming.t460p>
 <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
 <20190401032852.GG30776@ming.t460p>
 <ef192658-74cd-e193-cb40-aed546c2b309@oracle.com>
 <20190401100334.GA5493@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ad0f8f4c-5efe-e50f-a3a7-4f7e3d368d28@oracle.com>
Date:   Tue, 2 Apr 2019 10:02:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401100334.GA5493@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904020013
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

On 4/1/19 6:03 PM, Ming Lei wrote:
> On Mon, Apr 01, 2019 at 05:19:01PM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 4/1/19 11:28 AM, Ming Lei wrote:
>>> On Mon, Apr 01, 2019 at 11:25:50AM +0800, jianchao.wang wrote:
>>>> Hi Ming
>>>>
>>>> On 4/1/19 10:52 AM, Ming Lei wrote:
>>>>>> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
>>>>>> percpu_ref_kill() changes the state of a per-cpu counter to the "dead"
>>>>>> state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue()
>>>>>> already calls blk_set_queue_dying() and that last function calls
>>>>>> blk_freeze_queue_start(). So I think that what you wrote is not correct and
>>>>>> that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
>>>>>> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and
>>>>>> also that moving the percpu_ref_exit() call into blk_release_queue() makes
>>>>>> sense.
>>>>> If percpu_ref_exit() is moved to blk_release_queue(), we still need to
>>>>> move freeing of hw queue's resource into blk_release_queue() like what
>>>>> the patchset is doing.
>>>>>
>>>>> Then we don't need to get/put q_usage_counter in blk_mq_run_hw_queues() any more,
>>>>> do we?
>>>>
>>>> IMO, if we could get a way to prevent any attempt to run queue, it would be
>>>> better and clearer.
>>>
>>> It is hard to do that way, and not necessary.
>>>
>>> I will post V2 soon for review.
>>>
>>
>> Put percpu_ref_tryget/put pair into blk_mq_run_hw_queues could stop run queue after
>> requet_queue is frozen and drained (run queue is also unnecessary because there is no
>> entered requests). And also percpu_ref_tryget could avoid the io hung issue you mentioned.
>> We have similar one in blk_mq_timeout_work.
> 
> If percpu_ref_tryget() is used, percpu_ref_exit() has to be moved into
> queue's release handler.
> 
> Then we still have to move freeing hctx's resource into hctx or queue's
> release handler, that is exactly what this patch is doing. Then
> percpu_ref_tryget() becomes unnecessary again, right?

I'm not sure about the percpu_ref_exit. Perhaps I have some misunderstanding about it.

From the code of it, it frees the percpu_count and set ref->percpu_count_ptr to __PERCPU_REF_ATOMIC_DEAD.
The comment says 'the caller is responsible for ensuring that @ref is no longer in active use'
But if we use it after kill, does it count a active use ?
Based on the code, the __ref_is_percpu is always false during this, and percpu_ref_tryget will not
touch the freed percpu counter but just the atomic ref->count.

It looks safe.


> 
>>
>> freeze and drain queue to stop new attempt to run queue, blk_sync_queue syncs and stops
>> the started ones, then hctx->run_queue is cleaned totally.
>>
>> IMO, it would be better to have a checkpoint after which there will be no any in-flight
>> asynchronous activities of the request_queue (hctx->run_work, q->requeue_work, q-> timeout_work)
>> and any attempt to start them will fail.
> 
> All are canceled in blk_cleanup_queue(), but not enough, given queue can
> be run in sync mode(such as via plug, direct issue, ...), or driver's
> requeue, such as SCSI's requeue. SCSI's requeue may run other LUN's queue
> just by holding queue's kobject refcount.

Yes, so we need a checkpoint here to ensure the request_queue to enter into a certain state.
We provide a guarantee that all of the activities are stopped after this checkpoint.
It will be convenient for us to do other things following, for example release request_queue's
resource.

Thanks
Jianchao

> 
>>
>> Perhaps, this will be a good change to do this ；）
> 
> However, I don't see it is necessary if we simply move freeing hctx's
> resource into its release handler, just like V2.
> 
> 
> Thanks,
> Ming
> 
