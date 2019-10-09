Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F7ECE596
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 03:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1371920B7C
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 03:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQm4ZLc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfJIDb0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 23:31:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJIDb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 23:31:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x993Smrk079724;
        Wed, 9 Oct 2019 03:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=hbxHVutXIWyFYvNKxR7qqFz5fomjnzR0pLgVn3uaI9I=;
 b=VQm4ZLc5YIC1kiJqu1oAwbMFJ609sVuTaW/ohH8LS+DOj9rDs7kopArato4dxEHj5gY8
 HQxIvI2WTKiXEV+tOtlAz2Sdrrvw9wVzGsodJdmQcQtghdlQ+Ng5BQLTHYTkgeckQstB
 uerOCEABZwBseUWxZsumSLfyPiPVfQnp7ZIpkxM/Qrq4dL8BNDrE808zIyd8grvq9qMo
 KTuoDsePck/supAqlHv0k00ZpmwNl+BlIKtLZGDtO6DKRr/qKjm1ugfMDXShz1Y8V7Gg
 Vh8THSoNbdRfeKbivqZ8qtynJyeX5NFupfs6SxNmgIiK5sGocXjDJsqEiQN8WbzmW9vk Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4qh7y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 03:31:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x993SRf5115080;
        Wed, 9 Oct 2019 03:31:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vgefbu5dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 03:31:23 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x993VMoL006129;
        Wed, 9 Oct 2019 03:31:22 GMT
Received: from [192.168.1.14] (/180.165.87.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 20:31:22 -0700
Subject: Re: [PATCH V2] block: Fix elv_support_iosched()
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20191008223954.6084-1-damien.lemoal@wdc.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <8a3b1a9a-ef48-0413-2e6b-96e96a265543@oracle.com>
Date:   Wed, 9 Oct 2019 11:31:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20191008223954.6084-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090030
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/9/19 6:39 AM, Damien Le Moal wrote:
> A BIO based request queue does not have a tag_set, which prevent testing
> for the flag BLK_MQ_F_NO_SCHED indicating that the queue does not
> require an elevator. This leads to an incorrect initialization of a
> default elevator in some cases such as BIO based null_blk
> (queue_mode == BIO) with zoned mode enabled as the default elevator in
> this case is mq-deadline instead of "none".
> 
> Fix this by testing for a NULL queue mq_ops field which indicates that
> the queue is BIO based and should not have an elevator.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
> Changes from V1:
> * Test if q->mq_ops is NULL to identify BIO based queues
> 
>  block/elevator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 5437059c9261..076ba7308e65 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -616,7 +616,8 @@ int elevator_switch_mq(struct request_queue *q,
>  
>  static inline bool elv_support_iosched(struct request_queue *q)
>  {
> -	if (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
> +	if (!q->mq_ops ||
> +	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
>  		return false;
>  	return true;
>  }
> 

Looks good to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

