Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1944C4360F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 09:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB25217D4
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 09:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e0ZsR4O2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfDEJ2s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:28:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbfDEJ2s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 05:28:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x359NxKt088688;
        Fri, 5 Apr 2019 09:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YkEEPH3oVIEW9V/9f5f103FoxW/4EliOcysSrYQknb0=;
 b=e0ZsR4O265k/R7liC7zMJEchVjUgRvZ/olNcItLhHlYJtr9AQ6STX0ueeAsebKyWK7F8
 dkcp8jyENRIkTi5FSUmET5P+M8yB841E+1aefe4QYyn0XU7pcufm2od0gdlu1RMRivCy
 p9pA7uVDFGgwZYECWBawviH1VmFTYA/WLzanFjPtx2jCNF2rbUufvm01r1dtl7h1ds/P
 RpK59z/E5cE8sf06ZLkg0KM645Zanq3yvJBCYH8sj4bQ/9j60ul2wLRyZtPVLk4mTivc
 qyBWXLKVH+43KBeIGiKzDlUaAUuia+355GrXw5dJktwLSOKhu+Lw50kIlSisghMKj0Zg eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2rhyvtkvn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 09:28:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x359PN1U095165;
        Fri, 5 Apr 2019 09:26:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rp34j91xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 09:26:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x359QVdE024658;
        Fri, 5 Apr 2019 09:26:34 GMT
Received: from [192.168.2.8] (/106.39.150.192)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Apr 2019 02:26:31 -0700
Subject: Re: [PATCH V4 1/7] blk-mq: grab .q_usage_counter when queuing request
 from plug code path
To:     Ming Lei <ming.lei@redhat.com>
References: <20190404084320.24681-1-ming.lei@redhat.com>
 <20190404084320.24681-2-ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <d4aca4e1-efe5-887b-bb48-f49eaebd5283@oracle.com>
Date:   Fri, 5 Apr 2019 17:26:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190404084320.24681-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050069
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050069
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 04/04/2019 04:43 PM, Ming Lei wrote:
> Just like aio/io_uring, we need to grab 2 refcount for queuing one
> request, one is for submission, another is for completion.
> 
> If the request isn't queued from plug code path, the refcount grabbed
> in generic_make_request() serves for submission. In theroy, this
> refcount should have been released after the sumission(async run queue)
> is done. blk_freeze_queue() works with blk_sync_queue() together
> for avoiding race between cleanup queue and IO submission, given async
> run queue activities are canceled because hctx->run_work is scheduled with
> the refcount held, so it is fine to not hold the refcount when
> running the run queue work function for dispatch IO.
> 
> However, if request is staggered into plug list, and finally queued
> from plug code path, the refcount in submission side is actually missed.
> And we may start to run queue after queue is removed because the queue's
> kobject refcount isn't guaranteed to be grabbed in flushing plug list
> context, then kernel oops is triggered, see the following race:
> 
> blk_mq_flush_plug_list():
>         blk_mq_sched_insert_requests()
>                 insert requests to sw queue or scheduler queue
>                 blk_mq_run_hw_queue
> 
> Because of concurrent run queue, all requests inserted above may be
> completed before calling the above blk_mq_run_hw_queue. Then queue can
> be freed during the above blk_mq_run_hw_queue().
> 
> Fixes the issue by grab .q_usage_counter before calling
> blk_mq_sched_insert_requests() in blk_mq_flush_plug_list(). This way is
> safe because the queue is absolutely alive before inserting request.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ff3d7b49969..5b586affee09 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1728,9 +1728,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
>  			if (this_hctx) {
>  				trace_block_unplug(this_q, depth, !from_schedule);
> +
> +				percpu_ref_get(&this_q->q_usage_counter);

Sorry to bother but I would just like to double confirm the reason to use
"percpu_ref_get()" here which does not check whether the queue has been frozen.

Is it because there is assumption that any direct/indirect caller of
blk_mq_flush_plug_list() much have already grabbed q_usage_counter, which is
similar to blk_queue_enter_live()?

Thank you very much!

Dongli Zhang
