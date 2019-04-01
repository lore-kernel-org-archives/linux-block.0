Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B6CC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 01:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C8D20879
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 01:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C64+jyKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfDABuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 21:50:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49746 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDABuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 21:50:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x311nLYt158170;
        Mon, 1 Apr 2019 01:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Uxa0CtAoJz8k/jAv1Ag6aBMX0VNQ74T7D8+iRT2FThw=;
 b=C64+jyKs52ayUb+zu5EZVYHjsN7uYA8W2rEbMA/ijc1y7h7OkDOeCUgEmzcA2GpA2jpE
 6r5jGJfT1VwhOvkYi6TiZe2ywXZHE016kF4DhWQjHIF8JsOuI3gBBDnsYpM80cDm+xSh
 YT3HvAZtw0hSDmAdtjIx+EqAObAX9z1I/eeUJacnKEAjQqt8aCS3AwyRY4BQ3jYIDZKS
 A/vu0WvY85Kp72tYxw7rS/RpZewBcz8thp/D/YjT6KJh3k8xTDwNtFZYhrw4ZL5DEdpZ
 +y6vUmNgeIL4t95Pn4cJ09KzFRMr5hNed8Gd5KCFW5mR8q5pCsoWlgy3BCGlUSNjLPVI Ng== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2rhwycvb43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 01:49:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x311nmfv014035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 01:49:48 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x311nmb2019743;
        Mon, 1 Apr 2019 01:49:48 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Mar 2019 18:49:47 -0700
Subject: Re: [PATCH 5/5] SCSI: don't grab queue usage counter before run queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <20190331030954.22320-6-ming.lei@redhat.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <92d26c4c-3578-220f-92dd-426b0e28f298@oracle.com>
Date:   Mon, 1 Apr 2019 09:53:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190331030954.22320-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010012
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/31/19 11:09 AM, Ming Lei wrote:
> Now resources for dispatch is freed in queue's release handler,
> we don't need to worry about the possible race between blk_cleanup_queue
> and run queue.
> 
> So don't grab the queue usage counter before run queue in
> scsi_end_request().

Similar to prior one.

If something similar to do in the future, can we have "this is revert of
8dc765d438f1 ("SCSI: fix queue cleanup race before queue initialization is
done")......"

Thank you very much!

Dongli Zhang

> 
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/scsi_lib.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 601b9f1de267..18bf341d1236 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -604,12 +604,6 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
>  	 */
>  	scsi_mq_uninit_cmd(cmd);
>  
> -	/*
> -	 * queue is still alive, so grab the ref for preventing it
> -	 * from being cleaned up during running queue.
> -	 */
> -	percpu_ref_get(&q->q_usage_counter);
> -
>  	__blk_mq_end_request(req, error);
>  
>  	if (scsi_target(sdev)->single_lun ||
> @@ -618,7 +612,6 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
>  	else
>  		blk_mq_run_hw_queues(q, true);
>  
> -	percpu_ref_put(&q->q_usage_counter);
>  	put_device(&sdev->sdev_gendev);
>  	return false;
>  }
> 
