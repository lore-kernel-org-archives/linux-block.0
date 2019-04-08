Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF6FC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351F62147A
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bKb1nwH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDHOBG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:01:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48250 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDHOBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 10:01:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38DsPgb073062;
        Mon, 8 Apr 2019 14:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=m/efIBr8E8soVR65yHJ2zq421SjtyPumToY+pb/KC8o=;
 b=bKb1nwH4JONqq7KNf4YKF/DYE6BGbNadl58fBjPIY7sK5SzjMPAldBuFNu0FkJo8+5Sh
 YEX/ZD6iJOr+uRIRR9sxgdre6TaIqVwkWtsL19Hw8w74w6DOqO5HTKEw3X02KcPy9ZF7
 NLYrYc3321G3hvAnPlFbPTYbi5hBouLhHVVub8t1lVR6/J3CDUU1hk/h7boYE0Prj1ES
 TPnIhVi6GcCaH9+RU0oOhrW63jii+0SjfbVPYg8QSvO5czFqtoskzU6/Spgz2Bd2Ma1k
 A7dkf5ouqv3WeJf3zLbY4WUH1r1SCMGxtM2CraShEPGWu3U68aZtBENOzNxJIYLRZfYR Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2rpmrpxh4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 14:00:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38DxaMF137275;
        Mon, 8 Apr 2019 14:00:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2rpj5a0c0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 14:00:53 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x38E0qPQ017657;
        Mon, 8 Apr 2019 14:00:52 GMT
Received: from [10.191.23.208] (/10.191.23.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 07:00:52 -0700
Subject: Re: [PATCH 1/1] virtio_blk: replace 0 by HCTX_TYPE_DEFAULT to index
 blk_mq_tag_set->map
To:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1552354316-20204-1-git-send-email-dongli.zhang@oracle.com>
Cc:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <630416d0-7eb0-656b-b780-74a84e2f7dc2@oracle.com>
Date:   Mon, 8 Apr 2019 22:00:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1552354316-20204-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080118
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080118
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

The similar patchset has been queued by linux-scsi 5.2/scsi-queue.

virtio-blk is the last place where HCTX_TYPE_DEFAULT is hardcoded.

It would be more friendly to cscope if the hardcoding is avoided.

Thank you very much!

Dongli Zhang

On 03/12/2019 09:31 AM, Dongli Zhang wrote:
> Use HCTX_TYPE_DEFAULT instead of 0 to avoid hardcoding.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> This is the only place to cleanup under drivers/block/*. Another patch set
> is sent to scsi and then all of below are cleaned up:
> - block/*
> - drivers/*
> 
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4bc083b..bed6035 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -691,7 +691,8 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
>  {
>  	struct virtio_blk *vblk = set->driver_data;
>  
> -	return blk_mq_virtio_map_queues(&set->map[0], vblk->vdev, 0);
> +	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> +					vblk->vdev, 0);
>  }
>  
>  #ifdef CONFIG_VIRTIO_BLK_SCSI
> 
