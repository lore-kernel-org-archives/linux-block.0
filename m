Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2834C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC26213A2
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 09:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KNs5YV0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfDAJTU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:19:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33518 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDAJTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 05:19:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3194Cik091650;
        Mon, 1 Apr 2019 09:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XRl1QmEdNWQV5dsmWsJ5qr3weJMDJFoO6g5XRJBflmI=;
 b=KNs5YV0FyJ6Sc1X6tu23eW2RvQ31/to/+IZRHtAKt+x9FW3JDNHunZ0mlXkdcKMHM5jx
 5sJ2QthaWg9Tt4wrjE+G0pBhuOvsweP8VolYlWVkYzpn3Dn4A+iFU/tX35IxlbvzNwn6
 wZq0TkNUlE9i+yMXSfAgRSRMf0vjzLOC2d1jKRqJGIeJisKeKJJOYKCaOnottrIylQm4
 B//ZcdAJq+XYD7GphySIK5KgF/146/or+2qLLRItq8qDryJnqjDxkWB96rHfLhKtkiyG
 29UG3DO51ggH5yVjRlAtaD0euWXp4Sq/kCE5dp6r6su2MSdewW/4OPidTYJXcXMvzZtD Ew== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2rhwycwwp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 09:19:05 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x319IsXP023178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 09:18:54 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x319Iqjh002759;
        Mon, 1 Apr 2019 09:18:52 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 02:18:52 -0700
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
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ef192658-74cd-e193-cb40-aed546c2b309@oracle.com>
Date:   Mon, 1 Apr 2019 17:19:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401032852.GG30776@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010065
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

On 4/1/19 11:28 AM, Ming Lei wrote:
> On Mon, Apr 01, 2019 at 11:25:50AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 4/1/19 10:52 AM, Ming Lei wrote:
>>>> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
>>>> percpu_ref_kill() changes the state of a per-cpu counter to the "dead"
>>>> state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue()
>>>> already calls blk_set_queue_dying() and that last function calls
>>>> blk_freeze_queue_start(). So I think that what you wrote is not correct and
>>>> that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
>>>> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and
>>>> also that moving the percpu_ref_exit() call into blk_release_queue() makes
>>>> sense.
>>> If percpu_ref_exit() is moved to blk_release_queue(), we still need to
>>> move freeing of hw queue's resource into blk_release_queue() like what
>>> the patchset is doing.
>>>
>>> Then we don't need to get/put q_usage_counter in blk_mq_run_hw_queues() any more,
>>> do we?
>>
>> IMO, if we could get a way to prevent any attempt to run queue, it would be
>> better and clearer.
> 
> It is hard to do that way, and not necessary.
> 
> I will post V2 soon for review.
> 

Put percpu_ref_tryget/put pair into blk_mq_run_hw_queues could stop run queue after
requet_queue is frozen and drained (run queue is also unnecessary because there is no
entered requests). And also percpu_ref_tryget could avoid the io hung issue you mentioned.
We have similar one in blk_mq_timeout_work.

freeze and drain queue to stop new attempt to run queue, blk_sync_queue syncs and stops
the started ones, then hctx->run_queue is cleaned totally.

IMO, it would be better to have a checkpoint after which there will be no any in-flight
asynchronous activities of the request_queue (hctx->run_work, q->requeue_work, q-> timeout_work)
and any attempt to start them will fail.

Perhaps, this will be a good change to do this ；）

Thanks
Jianchao
