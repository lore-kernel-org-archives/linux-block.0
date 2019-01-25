Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63832C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 03:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2801F218D9
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 03:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1e1sraA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfAYDsH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:48:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44482 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfAYDsG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 22:48:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0P3i61S084190;
        Fri, 25 Jan 2019 03:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=CGcn5haGU3aX+UXMHPS0Wg97KRtYIc68Fl2yDBQR+kA=;
 b=1e1sraA0eO2sV1Fl9EcAPalZKb14RItkdQf+088/H++dGFiXdCxca/nFAJ5Elvnt1QAS
 4aP4FFxLpTKx7GcY8LSavhkblNz7aJ+Qzj6GtuND1ao26wfVMd6EPk27ZuvXY+yIh7mG
 fkKTxeBCNhbl4vGchREiS2x7ef6CYXY6n4ASVHfeeTdjYJ5T+DOdO8006OCVc8Ehzv+I
 1TX6jD+u7nPTL7kSQS+BrE+RIPK5vu0ltG3csabudmV8xxUxpUPpU3XjiwpNtc+pQnMj
 eMYpMnc8ksypD/TBp2/MbJMoq7drGqd02LyeAU6hkR1QIzJtu4lns48hjhT3ZkIez4NE xA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2q3uav3h1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 03:48:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0P3lt6i005915
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 03:47:55 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0P3lsK3010067;
        Fri, 25 Jan 2019 03:47:54 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jan 2019 19:47:54 -0800
Subject: Re: fsync hangs after scsi rejected a request
To:     Ming Lei <tom.leiming@gmail.com>,
        Florian Stecker <m19@florianstecker.de>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
 <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
 <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
 <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e18051e3-4008-e259-dee3-dd58f23642ab@oracle.com>
Date:   Fri, 25 Jan 2019 11:49:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9146 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901250027
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/25/19 9:33 AM, Ming Lei wrote:
> On Fri, Jan 25, 2019 at 8:45 AM Florian Stecker <m19@florianstecker.de> wrote:
>>
>>
>>
>> On 1/22/19 4:22 AM, Ming Lei wrote:
>>> On Tue, Jan 22, 2019 at 5:13 AM Florian Stecker <m19@florianstecker.de> wrote:
>>>>
>>>> Hi everyone,
>>>>
>>>> on my laptop, I am experiencing occasional hangs of applications during
>>>> fsync(), which are sometimes up to 30 seconds long. I'm using a BTRFS
>>>> which spans two partitions on the same SSD (one of them used to contain
>>>> a Windows, but I removed it and added the partition to the BTRFS volume
>>>> instead). Also, the problem only occurs when an I/O scheduler
>>>> (mq-deadline) is in use. I'm running kernel version 4.20.3.
>>>>
>>>>   From what I understand so far, what happens is that a sync request
>>>> fails in the SCSI/ATA layer, in ata_std_qc_defer(), because it is a
>>>> "Non-NCQ command" and can not be queued together with other commands.
>>>> This propagates up into blk_mq_dispatch_rq_list(), where the call
>>>>
>>>> ret = q->mq_ops->queue_rq(hctx, &bd);
>>>>
>>>> returns BLK_STS_DEV_RESOURCE. Later in blk_mq_dispatch_rq_list(), there
>>>> is the piece of code
>>>>
>>>> needs_restart = blk_mq_sched_needs_restart(hctx);
>>>> if (!needs_restart ||
>>>>          (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
>>>>          blk_mq_run_hw_queue(hctx, true);
>>>> else if (needs_restart && (ret == BLK_STS_RESOURCE))
>>>>          blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
>>>>
>>>> which restarts the queue after a delay if BLK_STS_RESOURCE was returned,
>>>> but somehow not for BLK_STS_DEV_RESOURCE. Instead, nothing happens and
>>>> fsync() seems to hang until some other process wants to do I/O.
>>>>
>>>> So if I do
>>>>
>>>> - else if (needs_restart && (ret == BLK_STS_RESOURCE))
>>>> + else if (needs_restart && (ret == BLK_STS_RESOURCE || ret ==
>>>> BLK_STS_DEV_RESOURCE))
>>>>
>>>> it fixes my problem. But was there a reason why BLK_STS_DEV_RESOURCE was
>>>> treated differently that BLK_STS_RESOURCE here?
>>>
>>> Please see the comment:
>>>
>>> /*
>>>   * BLK_STS_DEV_RESOURCE is returned from the driver to the block layer if
>>>   * device related resources are unavailable, but the driver can guarantee
>>>   * that the queue will be rerun in the future once resources become
>>>   * available again. This is typically the case for device specific
>>>   * resources that are consumed for IO. If the driver fails allocating these
>>>   * resources, we know that inflight (or pending) IO will free these
>>>   * resource upon completion.
>>>   *
>>>   * This is different from BLK_STS_RESOURCE in that it explicitly references
>>>   * a device specific resource. For resources of wider scope, allocation
>>>   * failure can happen without having pending IO. This means that we can't
>>>   * rely on request completions freeing these resources, as IO may not be in
>>>   * flight. Examples of that are kernel memory allocations, DMA mappings, or
>>>   * any other system wide resources.
>>>   */
>>> #define BLK_STS_DEV_RESOURCE    ((__force blk_status_t)13)
>>>
>>>>
>>>> In any case, it seems wrong to me that ret is used here at all, as it
>>>> just contains the return value of the last request in the list, and
>>>> whether we rerun the queue should probably not only depend on the last
>>>> request?
>>>>
>>>> Can anyone of the experts tell me whether this makes sense or I got
>>>> something completely wrong?
>>>
>>> Sounds a bug in SCSI or ata driver.
>>>
>>> I remember there is hole in SCSI wrt. returning BLK_STS_DEV_RESOURCE,
>>> but I never get lucky to reproduce it.
>>>
>>> scsi_queue_rq():
>>>          ......
>>>          case BLK_STS_RESOURCE:
>>>                  if (atomic_read(&sdev->device_busy) ||
>>>                      scsi_device_blocked(sdev))
>>>                          ret = BLK_STS_DEV_RESOURCE;
>>>
>>
>> OK, please tell me if I understand this right now. What is supposed to
>> happen is
>>
>> - request 1 is being processed by the device
>> - request 2 (sync) fails with STS_DEV_RESOURCE because request 1 is
>> still being processed
>> - request 2 is put into hctx->dispatch inside blk_mq_dispatch_rq_list *
>> - queue does not get rerun because of STS_DEV_RESOURCE
>> - request 1 finishes
>> - scsi_end_request calls blk_mq_run_hw_queues
>> - blk_mq_run_hw_queue finds request 2 in hctx->dispatch **
>> - runs request 2
> 
> Right, it is one typical case if the hw queue depth is 2.
> 
>>
>> However, what happens for me is that request 1 finishes earlier, so that
>> ** is executed before *, and finds an empty hctx->dispatch list.
>>
>> At least this is consistent with what I see.
>>
>>  > All in-flight request may complete between reading 'sdev->device_busy'
>>  > and setting ret as 'BLK_STS_DEV_RESOURCE', then this IO hang may
>>  > be triggered.
>>  >
>>
>> More accurate would be: between reading sdev->device_busy and doing
>> list_splice_init(list,&hctx->dispatch) inside blk_mq_dispatch_rq_list.
> 
> Exactly.

It sounds like not so easy to trigger.

blk_mq_dispatch_rq_list
  scsi_queue_rq
     if (atomic_read(&sdev->device_busy) ||
       scsi_device_blocked(sdev))
       ret = BLK_STS_DEV_RESOURCE;             scsi_end_request
                                                 __blk_mq_end_request
                                                   blk_mq_sched_restart // clear RESTART
                                                     blk_mq_run_hw_queue
                                                 blk_mq_run_hw_queues
 
  list_splice_init(list, &hctx->dispatch)
  needs_restart = blk_mq_sched_needs_restart(hctx)

The 'needs_restart' will be false, so the queue would be rerun.

Thanks
Jianchao

> 
>>
>> I'm not sure how the SCSI driver can do anything about this except
>> returning BLK_STS_RESOURCE instead (which I guess would not be a great
>> solution), as basically everything else happens inside blk-mq. Or what
>> do you have in mind?
> 
> Not have a better idea yet, :-(
> 
> thanks,
> Ming Lei
> 
