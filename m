Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132AFC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 08:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56362184D
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 08:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w/bo0Wz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfCTIMl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:12:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40198 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfCTIMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 04:12:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2K842CW096677;
        Wed, 20 Mar 2019 08:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=a1AC1wofJli/yV9yu9q8nrFndivpd1UV7Cgl7WFZU1o=;
 b=w/bo0Wz8Fi0Pjc6CjutpEJE9j/YGnCCCHRmt7ClYngF9j4UpiMlHk+amP0lonRHYhHEo
 vraSE6+RlxrsMmJqLxO9XgTVSZvZti2WYcpbaY1GMNePZasM5NVPn0WCMo17tbYlsIQh
 SAo39E6fkd3crDJAp4MNvdAhK+NUGOH6qvwxbuxOosqK/ycHORIkLqkJYY6rKvzSApBT
 PWTCXIDW2iQ88UumMwUDOuTthOpIQxGcwOnBma8kGvb5h0t8oyEPM166WNxMdmOz+mzL
 yAa3EutDIEFzWi8Q8/9CR9YW62sMgiTP4SHmbJNAcg27VklQznqwIFshnIHIB+dXZeRm 2Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r8rjus7sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 08:12:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2K8CK0K001408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 08:12:21 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2K8CJF3003937;
        Wed, 20 Mar 2019 08:12:20 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 01:12:19 -0700
Subject: Re: [PATCH] blk-mq: fix a hung issue when set device state to blocked
 and restore running
To:     zhengbin <zhengbin13@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     houtao1@huawei.com, yanaijie@huawei.com, yuyufen@huawei.com
References: <1553068921-6605-1-git-send-email-zhengbin13@huawei.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <1e3643aa-6ce6-ddc0-721d-3c80e228a182@oracle.com>
Date:   Wed, 20 Mar 2019 16:15:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553068921-6605-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200068
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bin

On 3/20/19 4:02 PM, zhengbin wrote:
> When I use dd test a SCSI device which use blk-mq in the following steps:
> 1.echo "blocked" >/sys/block/sda/device/state
> 2.dd if=/dev/sda of=/mnt/t.log bs=1M count=10
> 3.echo "running" >/sys/block/sda/device/state
> dd should finish this work after step 3, unfortunately, still hung.

If this test case really matters for you, we should try to run the hw queues after set state
to 'running'.

Thanks
Jianchao
> 
> After step2, the key code process is like this:
> blk_mq_dispatch_rq_list-->scsi_queue_rq-->prep_to_mq
>                        -->if ret is BLK_STS_RESOURCE, delay run hw queue
> 
> prep_to_mq will return BLK_STS_RESOURCE, and scsi_queue_rq will transter
> it to BLK_STS_DEV_RESOURCE. In this situtation, we should delay run hw
> queue. This patch fixes that.
> 
> Fixes: 86ff7c2a80cd ("blk-mq: introduce BLK_STS_DEV_RESOURCE")
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  block/blk-mq.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a9c1816..556d606 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1309,15 +1309,17 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  		 *   returning BLK_STS_RESOURCE. Two exceptions are scsi-mq
>  		 *   and dm-rq.
>  		 *
> -		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
> -		 * bit is set, run queue after a delay to avoid IO stalls
> -		 * that could otherwise occur if the queue is idle.
> +		 * If driver returns BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE
> +		 * and SCHED_RESTART bit is set, run queue after a delay to
> +		 * avoid IO stalls that could otherwise occur if the queue
> +		 * is idle.
>  		 */
>  		needs_restart = blk_mq_sched_needs_restart(hctx);
>  		if (!needs_restart ||
>  		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
>  			blk_mq_run_hw_queue(hctx, true);
> -		else if (needs_restart && (ret == BLK_STS_RESOURCE))
> +		else if (needs_restart && ((ret == BLK_STS_RESOURCE) ||
> +					   (ret == BLK_STS_DEV_RESOURCE)))
>  			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> 
>  		blk_mq_update_dispatch_busy(hctx, true);
> --
> 2.7.4
> 
> 
