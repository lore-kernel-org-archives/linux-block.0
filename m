Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C5EC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C822085A
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 09:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4oltJLb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfCYJMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:12:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43340 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfCYJMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 05:12:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P98NZp178088;
        Mon, 25 Mar 2019 09:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kGkBM9kpb2lfL1AANt3V6cK+WL12X/5xhvwtkBe6mX0=;
 b=4oltJLb4fgsTPreh5E/71yhPIJGyNiACE2SIsr8EIAqWoj6ojK88XJVSblZl0Ow17EH+
 319HtAnZQGV9NaUJwJGHyRAvADWH7GZVr58VgbXzkik4M2NsGjxbatxS+GvTFIEWdl93
 tP6X55e9YalsXfwzW71wa87S+lLi7nMjSl1LnyAzWdTOL3VLDTc/WmBBli91sJ2ZlcVK
 Fege3pWrZX+L6MW6moZoj72+dnxOWxrbXJMHudDnkfsl3Nefd8RZzMT44osXIi+f6PQs
 Gxh/Uq7JFHyXKPdsGniBGPngPE+14/Z8ySXcQKX9ZA0FXxta55ykG2wWs7vYzepC8SjO RA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2re6g0tssp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 09:12:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2P9CJ8E019218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 09:12:19 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P9CJe4012974;
        Mon, 25 Mar 2019 09:12:19 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 02:12:18 -0700
Subject: Re: [PATCH V2 8/8] blk-mq: remove blk_mq_tagset_busy_iter
To:     Hannes Reinecke <hare@suse.de>, axboe@kernel.dk
Cc:     keith.busch@intel.com, jsmart2021@gmail.com, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        jthumshirn@suse.de, hch@lst.de, bvanassche@acm.org
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-9-git-send-email-jianchao.w.wang@oracle.com>
 <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>
 <f9d22543-65d1-e473-e3ab-deefa2d6e884@oracle.com>
 <15fa9443-776b-bb75-0e20-538609d34eba@suse.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <5b8025dc-3aeb-c704-b539-9a2a926c2f02@oracle.com>
Date:   Mon, 25 Mar 2019 17:12:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <15fa9443-776b-bb75-0e20-538609d34eba@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250070
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/25/19 4:25 PM, Hannes Reinecke wrote:
> On 3/25/19 8:37 AM, jianchao.wang wrote:
>> Hi Hannes
>>
>> On 3/25/19 3:18 PM, Hannes Reinecke wrote:
>>> On 3/25/19 6:38 AM, Jianchao Wang wrote:
>>>> As nobody uses blk_mq_tagset_busy_iter, remove it.
>>>>
>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>> ---
>>>>    block/blk-mq-tag.c     | 95 --------------------------------------------------
>>>>    include/linux/blk-mq.h |  2 --
>>>>    2 files changed, 97 deletions(-)
>>>>
>>> Please, don't.
>>>
>>> I'm currently implementing reserved commands for SCSI and reworking the SCSI error handling where I rely on
>>> this interface quite heavily.
>>
>>
>> blk_mq_tagset_busy_iter could access some stale requests which maybe freed due to io scheduler switching,
>> request_queue cleanup (shared tagset)
>> when there is someone submits io and gets driver tag. When io scheduler attached, even quiesce
                                                         ^^^^
                                                      s/When/Without
>> request_queue won't work.
>>
>> If this patchset is accepted, blk_mq_tagset_busy_iter could be replaced with blk_mq_queue_inflight_tag_iter
>> which needs to be invoked by every request_queue that shares the tagset.
>>
> The point is, at that time I do _not_ have a request queue to work with.
> 
> Most SCSI drivers have a host-wide shared tagset, which is used by all request queues on that host.
> Iterating over the shared tagset is far more efficient than to traverse over all devices and the attached request queues.
> 
> If I had to traverse all request queues I would need to add additional locking to ensure this traversal is race-free, making it a really cumbersome interface to use.

Yes, the new interface int this patchset is indeed not convenient to use with shared tagset case.
Perhaps we could introduce a interface to iterate all of the request_queue that shares a same tagset, such as,

mutex_lock(&set->tag_list_lock)
list_for_each_entry(q, &set->tag_list, tag_set_list)
...
mutex_unlock(&set->tag_list_lock)

> 
> Plus the tagset iter is understood to be used only in cases where I/O is stopped from the upper layers (ie no new I/O will be submitted).

The window is during get driver tag and store the rq into tags->rqs[].
w/ io-scheduler attached, we need to quiesce the request_queue to stop the driver tag allocation attempts.
w/o io-scheduler attached, quiesce request_queue cannot work, we need to freeze the queue and drain all of tasks that enters blk_mq_make_request
to rule out all of attempts of allocating driver tags. Unfortunately, we cannot distinguish between the task entering .make_request and allocated
requests both of which occupies q_usage_counter.

So to stop all of the attmpts of allocating driver tag, we have freeze & drain and quiesce the request_queue.


Thanks
Jianchao

> So here we only need to protect against I/O being completed, which is not what this patchset is about.
> 
> So my objection still stands: Please, don't.
> 
> Cheers,
> 
> Hannes
