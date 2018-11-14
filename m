Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9DC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 05:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E256822360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 05:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5YVRkiAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E256822360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeKNPng (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:43:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55424 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeKNPng (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 10:43:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAE5cqoR145564;
        Wed, 14 Nov 2018 05:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ChgY6Lob4LO43Ueuk8Q8lmWLXqLK7bbVyGKKe7SlAl0=;
 b=5YVRkiAOSg2aT4Egub4mE1Gil+j1+vNVZ/PCT0KaMWhy28UrhM8BQnoesA/TrmDTvrVu
 xygvTjAWn9R0AGEFc7LXwt/HwebvQIg7v5HMmcRusJO+4vJf64rUIilWS+rows9g5c2h
 hurxtz4537Tg4NBjHrG9TpeDNci3Y1mCfQ/BV7fuxoojZlGdOloRmLwcA7pF9K0d4O1K
 cFgn4UNnLDoOpol7kldqN2GUjlCPIXyxgCz99tFtrnPrr3nAN01w1ZVVer1g5iEub/Ui
 /OK5AjbRSW9JUbehonBX6K91I923QEhzk8CKXRqbZa2gtTLNHMONIe0YHt75tQpY7BmY HQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nr7cs15rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 05:41:38 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAE5fbVF016552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 05:41:37 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAE5fadJ005050;
        Wed, 14 Nov 2018 05:41:36 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Nov 2018 21:41:36 -0800
Subject: Re: [RFC PATCH] SCSI: fix queue cleanup race before queue is
 initialized done
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
References: <20181114043512.19627-1-ming.lei@redhat.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <31e77713-c974-1d6a-89a6-7c09b8190ef1@oracle.com>
Date:   Wed, 14 Nov 2018 13:41:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114043512.19627-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140051
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/14/18 12:35 PM, Ming Lei wrote:
> c2856ae2f315d ("blk-mq: quiesce queue before freeing queue") has
> already fixed this race, however the implied synchronize_rcu()
> in blk_mq_quiesce_queue() can slow down LUN probe a lot, so caused
> performance regression.
> 
> Then 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
> tried to only quiesce queue for avoiding unnecessary synchronize_rcu()
> in case that queue isn't initialized done.
> 
> However, turns out we still need to quiesce the queue in case that
> queue isn't initialized done. Because when one SCSI command is
> completed, the user is waken up immediately, then the scsi device
> can be removed, meantime the run queue in scsi_end_request() can
> be still in-progress, so kernel panic is triggered.
> 
> In Red Hat QE lab, there are several reports about this kind of kernel
> panic triggered during kernel booting.
> 
> Fixes: 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
> Cc: Andrew Jones <drjones@redhat.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c        |  6 +++---
>  drivers/scsi/scsi_lib.c | 36 ++++++++++++++++++++++++++++++------
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ce12515f9b9b..cf7742a677c4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -798,9 +798,9 @@ void blk_cleanup_queue(struct request_queue *q)
>  	 * dispatch may still be in-progress since we dispatch requests
>  	 * from more than one contexts.
>  	 *
> -	 * No need to quiesce queue if it isn't initialized yet since
> -	 * blk_freeze_queue() should be enough for cases of passthrough
> -	 * request.
> +	 * We rely on driver to deal with the race in case that queue
> +	 * initialization isn't done.
> +	 *
>  	 */
>  	if (q->mq_ops && blk_queue_init_done(q))
>  		blk_mq_quiesce_queue(q);
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index c7fccbb8f554..7ec7a8a2d000 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -697,13 +697,37 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
>  		 */
>  		scsi_mq_uninit_cmd(cmd);
>  
> -		__blk_mq_end_request(req, error);
> +		/*
> +		 * When block queue initialization isn't done, the request
> +		 * queue won't be quiesced in blk_cleanup_queue() for avoiding
> +		 * slowing down LUN probe, so queue still may be run even though
> +		 * its resource is cleaned up, this way can cause kernel panic.
> +		 *
> +		 * Workaround this issue by freeing request after running the
> +		 * queue when queue initialization isn't done, so the queue's
> +		 * usage counter can be held during running queue.
> +		 *
> +		 * This way is safe because sdev->device_busy has been decreased
> +		 * already, and scsi_queue_rq() may guarantee the forward-progress.
> +		 *
> +		 */
> +		if (blk_queue_init_done(q)) {
> +			__blk_mq_end_request(req, error);
> +
> +			if (scsi_target(sdev)->single_lun ||
> +					!list_empty(&sdev->host->starved_list))
> +				kblockd_schedule_work(&sdev->requeue_work);
> +			else
> +				blk_mq_run_hw_queues(q, true);
> +		} else {
>  
> -		if (scsi_target(sdev)->single_lun ||
> -		    !list_empty(&sdev->host->starved_list))
> -			kblockd_schedule_work(&sdev->requeue_work);
> -		else
> -			blk_mq_run_hw_queues(q, true);
> +			if (scsi_target(sdev)->single_lun ||
> +					!list_empty(&sdev->host->starved_list))
> +				kblockd_schedule_work(&sdev->requeue_work);
> +			else
> +				blk_mq_run_hw_queues(q, true);
> +			__blk_mq_end_request(req, error);
> +		}
>  	} else {
>  		unsigned long flags;
>  
> 

Why not get a q_usage_counter during this ?

Something like，

@@ -610,6 +610,7 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
         */
        scsi_mq_uninit_cmd(cmd);
 
+       percpu_ref_get(&q->q_usage_counter)
        __blk_mq_end_request(req, error);
 
        if (scsi_target(sdev)->single_lun ||
@@ -618,6 +619,8 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
        else
                blk_mq_run_hw_queues(q, true);
 
+       percpu_ref_put(&q->q_usage_counter)
+
        put_device(&sdev->sdev_gendev);
        return false;
 }

Thanks
Jianchao
