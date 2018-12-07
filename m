Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DF6C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C3220850
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rwLFNKJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C3220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGBWR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:22:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57604 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGBWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 20:22:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB71AAA8108135;
        Fri, 7 Dec 2018 01:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RtJS9oAmBn38Osv+76y/PfoAbAbYcR+p+PtfFzo61Jk=;
 b=rwLFNKJ+JDTXy0RNu6p4Jx33Wv73x1dqAg5voLDrpP9jO8z79SjcEOGSalLcdFF7nyuU
 tpeU9mYR9ysd2AzaQKEEw/1VyLsLSRwEf1YGcnOr9AM45t+oF11pvIJsPdzFNoHl2cxz
 X0UDK4kVt+Gx2x0RRPFGjmQjME76oSCZpUh/IvhEIRM+bWe2RqqVcEog/oeZlnBgRJjk
 8sPAbEvwRgOSz4YACmbAGr+DwEm4hLO1fIGXRVx4aRADa6QI0h/gDqeaXMkuuxGxuEbL
 BfbWY5BMMgM07fdUXo5Hc7+hsl3y8hoIM5D2YfAW/yXrhc1rPuzyAI57EE8wByc7M12Y Aw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxru8f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 01:22:04 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB71LwIn011871
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 01:21:59 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB71LwQY030595;
        Fri, 7 Dec 2018 01:21:58 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 17:21:58 -0800
Subject: Re: [PATCH] block: fix direct dispatch issue failure for clones
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
 <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
 <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <671bf8cd-672d-55ed-ad1e-1deb0b17f701@oracle.com>
Date:   Fri, 7 Dec 2018 09:22:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/7/18 9:13 AM, Jens Axboe wrote:
> On 12/6/18 6:04 PM, jianchao.wang wrote:
>>
>>
>> On 12/7/18 6:20 AM, Jens Axboe wrote:
>>> After the direct dispatch corruption fix, we permanently disallow direct
>>> dispatch of non read/write requests. This works fine off the normal IO
>>> path, as they will be retried like any other failed direct dispatch
>>> request. But for the blk_insert_cloned_request() that only DM uses to
>>> bypass the bottom level scheduler, we always first attempt direct
>>> dispatch. For some types of requests, that's now a permanent failure,
>>> and no amount of retrying will make that succeed.
>>>
>>> Don't use direct dispatch off the cloned insert path, always just use
>>> bypass inserts. This still bypasses the bottom level scheduler, which is
>>> what DM wants.
>>>
>>> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> ---
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index deb56932f8c4..4c44e6fa0d08 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
>>>  		 * bypass a potential scheduler on the bottom device for
>>>  		 * insert.
>>>  		 */
>>> -		return blk_mq_request_issue_directly(rq);
>>> +		blk_mq_request_bypass_insert(rq, true);
>>> +		return BLK_STS_OK;
>>>  	}
>>>  
>>>  	spin_lock_irqsave(q->queue_lock, flags);
>>>
>> Not sure about this because it will break the merging promotion for request based DM
>> from Ming.
>> 396eaf21ee17c476e8f66249fb1f4a39003d0ab4
>> (blk-mq: improve DM's blk-mq IO merging via blk_insert_cloned_request feedback)
>>
>> We could use some other way to fix this.
> 
> That really shouldn't matter as this is the cloned insert, merging should
> have been done on the original request.
> 
> 
Just quote some comments from the patch.

"
                       But dm-rq currently can't get the underlying queue's
    dispatch feedback at all.  Without knowing whether a request was issued
    or not (e.g. due to underlying queue being busy) the dm-rq elevator will
    not be able to provide effective IO merging (as a side-effect of dm-rq
    currently blindly destaging a request from its elevator only to requeue
    it after a delay, which kills any opportunity for merging).  This
    obviously causes very bad sequential IO performance.
    ...
    With this, request-based DM's blk-mq sequential IO performance is vastly
    improved (as much as 3X in mpath/virtio-scsi testing)
"

Using blk_mq_request_bypass_insert to replace the blk_mq_request_issue_directly
could be a fast method to fix the current issue. Maybe we could get the merging
promotion back after some time.



Thanks
Jianchao

