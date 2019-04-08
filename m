Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9DBC10F0E
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 03:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269DA206DD
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 03:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iufcmF9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDHDQY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 23:16:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34304 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHDQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 23:16:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3834Qbh123687;
        Mon, 8 Apr 2019 03:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XaC1LRwyHOIypqO6J1Rf6iWRuFgfQqPOtjqbwRmH1/Y=;
 b=iufcmF9sJ+w+LGDlRd8bHenn7sLhb8XjgyJzRuUjh7tdZuqMtFeO7X40GM/1a/9JqxSr
 fhGPQ8aXCbMzAKo0srUS6XqInWgarYI+uFDGcAysNR7iiub8OHzDUeNAnOKSec/VnRfC
 WNMWT9estz6itXuH7JA+uQZLon3bZmzYsB1Etb3lU4v8fkPpSaXoZUkKpM5rPU+UQGGc
 RUxobXWV5D94dd4zZB2ot9PRpK92Q3/NugRgM78shqknRQJmO0Tr1TPwkTBu7vs7fBey
 SjCCz9NHa2roQzpn6Tc4X8FnOZRGJs946Vx2mLWksA5iSC7pbpRu/tOP4GDVOEQbyupy HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2rpmrpumwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 03:16:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x383FWJd191547;
        Mon, 8 Apr 2019 03:16:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2rpj59s1w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 03:16:10 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x383G8S3005396;
        Mon, 8 Apr 2019 03:16:08 GMT
Received: from [10.182.69.255] (/10.182.69.255)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Apr 2019 20:16:08 -0700
Subject: Re: [PATCH V4 3/7] blk-mq: quiesce queue before updating nr_hw_queues
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20190404084320.24681-1-ming.lei@redhat.com>
 <20190404084320.24681-4-ming.lei@redhat.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <402dd676-ce8b-6691-03ff-cb80aab38ecf@oracle.com>
Date:   Mon, 8 Apr 2019 11:16:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404084320.24681-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080027
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080027
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

Why not add percpu_ref_tryget/put pair into run queue and requeue work,
or before queue the work ?

Then freezing queue could really implement to freeze the queue and there will be
no any queue activity after freeze, including run queue and requeue work.

Thanks
Jianchao

On 4/4/19 4:43 PM, Ming Lei wrote:
> Inside __blk_mq_update_nr_hw_queues(), only request queues are frozen
> before updating nr_hw_queues.
> 
> However, even though blk_mq_freeze_queue() is returned, there might be
> run queue activity not completed, then use-after-free may be triggered
> on hctx and its fields.
> 
> Fix this issue by really quiescing queue via blk_mq_quiesce_queue() and
> blk_sync_queue() for making sure no any run queue activity pending
> before releasing hctx.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b512ba0cb359..41c12d9008b7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3224,8 +3224,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
>  		return;
>  
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		blk_mq_freeze_queue(q);
> +		blk_mq_quiesce_queue(q);
> +		blk_sync_queue(q);
> +	}
>  	/*
>  	 * Sync with blk_mq_queue_tag_busy_iter.
>  	 */
> @@ -3269,8 +3272,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		blk_mq_elv_switch_back(&head, q);
>  
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		blk_mq_unquiesce_queue(q);
>  		blk_mq_unfreeze_queue(q);
> +	}
>  }
>  
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
> 
