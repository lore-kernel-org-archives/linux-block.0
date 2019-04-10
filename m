Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5E4C282CE
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 00:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C4821841
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 00:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f4QOeUSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDJAvr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:51:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60630 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDJAvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 20:51:47 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A0nEMS045365;
        Wed, 10 Apr 2019 00:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kI9xAvXGQcPCO6Sef3ggGX57u3EzifZL/8MhlcZbGvU=;
 b=f4QOeUSzsoqFeWyeZpX229LyZ3E7XlMIujhDT9f+VWfwh/AGWMhpCl9H4uQELjG2s8wo
 yRZpRserGETMUkrLlIOpuX5E2MLzxz4YQloxqMbfvbL479tsrwtKN3pbEkhnEoIHni9K
 aVC4tZgYdQ5xazOcWshL/sM1qxviL1/5eE+XnvxQ7DwQUjxwS2ddFCq6HKsVqO6PV+sV
 cyAoN6UeU25js7u3Q0g8eIkbGjdRdqik76Ga2tetRZbeTETJR8QpzdlVlmQrseys9J+X
 rtpdqOb1nfwYk3SVGi3H+au3pFTh71IYiD0QhewuxrQhRerO9JCulP1ux479w5fLszya dA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rphmegbpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 00:51:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A0nZmu082031;
        Wed, 10 Apr 2019 00:51:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rpj5aurr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 00:51:16 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3A0p7UN023533;
        Wed, 10 Apr 2019 00:51:10 GMT
Received: from [10.182.69.255] (/10.182.69.255)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 17:51:07 -0700
Subject: Re: [PATCH] block: Fix blk_mq_try_issue_directly()
To:     Laurence Oberman <loberman@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
References: <20190403201126.22819-1-bvanassche@acm.org>
 <2c3dbaa5-dad9-12a4-b535-5e1e614c43e1@oracle.com>
 <2254e259-107f-38d4-1692-e542271db654@oracle.com>
 <328a5660-8355-ddad-be0e-32cbaa76cc84@oracle.com>
 <f2703a1e76262820cbe0e40ed7110771606ec2f6.camel@redhat.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <05ce8c99-615d-e1f4-3e83-b947a31ff7be@oracle.com>
Date:   Wed, 10 Apr 2019 08:51:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f2703a1e76262820cbe0e40ed7110771606ec2f6.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100004
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100004
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/9/19 8:28 PM, Laurence Oberman wrote:
> On Tue, 2019-04-09 at 09:31 +0800, jianchao.wang wrote:
>>
>> On 4/8/19 10:36 AM, jianchao.wang wrote:
>>>
>>>
>>> On 4/8/19 10:07 AM, jianchao.wang wrote:
>>>> Hi Bart
>>>>
>>>> On 4/4/19 4:11 AM, Bart Van Assche wrote:
>>>>> If blk_mq_try_issue_directly() returns BLK_STS*_RESOURCE that
>>>>> means that
>>>>> the request has not been queued and that the caller should
>>>>> retry to submit
>>>>> the request. Both blk_mq_request_bypass_insert() and
>>>>> blk_mq_sched_insert_request() guarantee that a request will be
>>>>> processed.
>>>>> Hence return BLK_STS_OK if one of these functions is called.
>>>>> This patch
>>>>> avoids that blk_mq_dispatch_rq_list() crashes when using dm-
>>>>> mpath.
>>>>
>>>> Sorry, I seem to miss the original mail list that reported this
>>>> issue.
>>>> As your comment, it looks like that the request is handled again
>>>> when
>>>> the blk_mq_try_issue_directly return BLK_STS*_RESOURCE, right ?
>>>>
>>>> The usage of this helper interface is,
>>>> if care about the return value and want to handle the request
>>>> yourself when
>>>> return BLK_STS*_RESOURCE, pass 'byass' as true.
>>>> otherwise, just pass 'bypass' as false, then
>>>> blk_mq_try_issue_directly would
>>>> take over all of the work including requeue or complete the
>>>> request.
>>>>
>>>> if dm-mpath case, the driver should only invoke
>>>> dm_dispatch_clone_request,
>>>> the 'bypass' parameter should only be true.
>>>> as the blk_mq_try_issue_directly,
>>>> it would return BLK_STS_OK when have to insert the request,
>>>> otherwise,
>>>> it would do nothing but return BLK_STS*_RESOURCE.
>>>>
>>>> Would you please show the cause that the dm-mpath driver invoke
>>>> blk_mq_try_issue_direclty
>>>> with 'bypass == false' ?
>>>>
>>>
>>> The issue seems to be here,
>>>
>>> blk_mq_try_issue_directly
>>>
>>>
>>>     if (unlikely(blk_mq_hctx_stopped(hctx) ||
>>> blk_queue_quiesced(q))) {
>>>         run_queue = false;
>>>         bypass = false;          //------> HERE !!!
>>>         goto out_unlock;
>>>     }
>>>
>>>
>>>     case BLK_STS_RESOURCE:
>>>         if (force) {
>>>             blk_mq_request_bypass_insert(rq, run_queue);
>>>             ret = bypass ? BLK_STS_OK : ret;
>>>         } else if (!bypass) {
>>>             blk_mq_sched_insert_request(rq, false,
>>>                             run_queue, false);
>>>         }
>>>         break;
>>>
>>> Then the request will be inserted and blk_mq_try_issue_dreictly
>>> returns BLK_STS_RESOURCE.
>>>
>>>
>>> Could following patch fix the issue ?
>>
>> Hi Laurence
>>
>> Would you please test this patch to see whether the issue could be
>> fixed ?
>>
>> Thanks
>> Jianchao
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index a9c1816..a3394f2 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1813,7 +1813,7 @@ blk_status_t blk_mq_try_issue_directly(struct
>>> blk_mq_hw_ctx *hctx,
>>>          */
>>>         if (unlikely(blk_mq_hctx_stopped(hctx) ||
>>> blk_queue_quiesced(q))) {
>>>                 run_queue = false;
>>> -               bypass = false;
>>> +               force = true;
>>>                 goto out_unlock;
>>>         }
>>>
>>> Thanks
>>> Jianchao
>>>
...
> Hello Sir
> I think Jens already took the revert patch though.
> I will try this when I gat a chance.
> Need to wait until I can reboot the targetserver again.

Thanks so much for your help. Please share the test result here.
I will get the reverted patches back after that.

Thanks
Jianchao
