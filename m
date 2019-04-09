Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ED8C282CE
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 01:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DF8217F4
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 01:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tKle+x7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfDIBbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:31:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47308 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDIBbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 21:31:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x391SqnR073496;
        Tue, 9 Apr 2019 01:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cFyO+0ZZhGOEWGs2k8qJIpuznQL6SvY0kmLSG++tBZA=;
 b=tKle+x7Yuxv6UYDrwkSbcP+YdFNnXDcNOcOW/gy+GK8j034PeVhXECdZSWNlw3hT3s5x
 9aSaLhCZJPy6GM8V7u1CZ4VttUn7jiw0LaACn4zhoadvk8JKhBVMpoaCirZhFnLEWlbj
 GfrXlDCDLQILmNe3TQjBN2bklGtkU8jmlBiAVEGMwtMSX5qoEsivlTj4kwLs9SXyzy6m
 rHptjZu2rOqcUpy/gatkxFlzfR5WsOvbuYxwuuQ0sQd+5jr+bGosT6QJ+Lu6RkaCUtF1
 FWFmvdg6vUoM4MQWKqzC1GqVJ2iwAoIQpgilso5Mk3pYeUZDYN8B2PYGtIB6xvZPZj0E mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2rpmrq1u8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 01:31:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x391Tp10092398;
        Tue, 9 Apr 2019 01:31:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2rpkej0rd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 01:31:01 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x391V0Bg015170;
        Tue, 9 Apr 2019 01:31:00 GMT
Received: from [10.182.71.93] (/10.182.71.93)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 18:31:00 -0700
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
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <328a5660-8355-ddad-be0e-32cbaa76cc84@oracle.com>
Date:   Tue, 9 Apr 2019 09:31:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2254e259-107f-38d4-1692-e542271db654@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090008
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/8/19 10:36 AM, jianchao.wang wrote:
> 
> 
> On 4/8/19 10:07 AM, jianchao.wang wrote:
>> Hi Bart
>>
>> On 4/4/19 4:11 AM, Bart Van Assche wrote:
>>> If blk_mq_try_issue_directly() returns BLK_STS*_RESOURCE that means that
>>> the request has not been queued and that the caller should retry to submit
>>> the request. Both blk_mq_request_bypass_insert() and
>>> blk_mq_sched_insert_request() guarantee that a request will be processed.
>>> Hence return BLK_STS_OK if one of these functions is called. This patch
>>> avoids that blk_mq_dispatch_rq_list() crashes when using dm-mpath.
>>
>> Sorry, I seem to miss the original mail list that reported this issue.
>> As your comment, it looks like that the request is handled again when
>> the blk_mq_try_issue_directly return BLK_STS*_RESOURCE, right ?
>>
>> The usage of this helper interface is,
>> if care about the return value and want to handle the request yourself when
>> return BLK_STS*_RESOURCE, pass 'byass' as true.
>> otherwise, just pass 'bypass' as false, then blk_mq_try_issue_directly would
>> take over all of the work including requeue or complete the request.
>>
>> if dm-mpath case, the driver should only invoke dm_dispatch_clone_request,
>> the 'bypass' parameter should only be true.
>> as the blk_mq_try_issue_directly,
>> it would return BLK_STS_OK when have to insert the request, otherwise,
>> it would do nothing but return BLK_STS*_RESOURCE.
>>
>> Would you please show the cause that the dm-mpath driver invoke blk_mq_try_issue_direclty
>> with 'bypass == false' ?
>>
> 
> The issue seems to be here,
> 
> blk_mq_try_issue_directly
> 
> 
>     if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q))) {
>         run_queue = false;
>         bypass = false;          //------> HERE !!!
>         goto out_unlock;
>     }
> 
> 
>     case BLK_STS_RESOURCE:
>         if (force) {
>             blk_mq_request_bypass_insert(rq, run_queue);
>             ret = bypass ? BLK_STS_OK : ret;
>         } else if (!bypass) {
>             blk_mq_sched_insert_request(rq, false,
>                             run_queue, false);
>         }
>         break;
> 
> Then the request will be inserted and blk_mq_try_issue_dreictly returns BLK_STS_RESOURCE.
> 
> 
> Could following patch fix the issue ?

Hi Laurence

Would you please test this patch to see whether the issue could be fixed ?

Thanks
Jianchao
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a9c1816..a3394f2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1813,7 +1813,7 @@ blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>          */
>         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q))) {
>                 run_queue = false;
> -               bypass = false;
> +               force = true;
>                 goto out_unlock;
>         }
> 
> Thanks
> Jianchao
> 
>>
>>>
>>> Cc: Christoph Hellwig <hch@infradead.org>
>>> Cc: Hannes Reinecke <hare@suse.com>
>>> Cc: James Smart <james.smart@broadcom.com>
>>> Cc: Ming Lei <ming.lei@redhat.com>
>>> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
>>> Cc: Keith Busch <keith.busch@intel.com>
>>> Cc: Dongli Zhang <dongli.zhang@oracle.com>
>>> Cc: Laurence Oberman <loberman@redhat.com>
>>> Tested-by: Laurence Oberman <loberman@redhat.com>
>>> Reviewed-by: Laurence Oberman <loberman@redhat.com>
>>> Reported-by: Laurence Oberman <loberman@redhat.com>
>>> Fixes: 7f556a44e61d ("blk-mq: refactor the code of issue request directly") # v5.0.
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>  block/blk-mq.c | 9 ++-------
>>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 652d0c6d5945..b2c20dce8a30 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1859,16 +1859,11 @@ blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>>  	case BLK_STS_RESOURCE:
>>>  		if (force) {
>>>  			blk_mq_request_bypass_insert(rq, run_queue);
>>> -			/*
>>> -			 * We have to return BLK_STS_OK for the DM
>>> -			 * to avoid livelock. Otherwise, we return
>>> -			 * the real result to indicate whether the
>>> -			 * request is direct-issued successfully.
>>> -			 */
>>> -			ret = bypass ? BLK_STS_OK : ret;
>>> +			ret = BLK_STS_OK;
>>>  		} else if (!bypass) {
>>>  			blk_mq_sched_insert_request(rq, false,
>>>  						    run_queue, false);
>>> +			ret = BLK_STS_OK;
>>>  		}
>>>  		break;
>>>  	default:
>>>
>>
> 
