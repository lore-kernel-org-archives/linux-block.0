Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BD6C76186
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 00:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A1521855
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 00:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Khkgru1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfGYAe3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 20:34:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfGYAe2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 20:34:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P0TJ0s053857;
        Thu, 25 Jul 2019 00:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=JnKBvhRjV3PTJbylEfcrAcm4Io7m297kThqCQ7Xf6ec=;
 b=Khkgru1Eh037gaI43Nr1UnSTB5ih4YvG8u235f9K/lv48GKv8NdqOg/jktrqe8uyRjY4
 b3ITJWV/u/8rtu97ldYUN3WEjrnu8bcu6oMGum4nH3jIH7NmX4swJ/Qszx20RTWSveCe
 pbIMh13zF6J2BQBOZF1slAeXiYVlv0GjMTA3B2HzcZY9TaO+tfTPp6Vs/bFr1lJ7YpuR
 Q5OolqiDpGihAzN5vKDXrwy8iuWA0W5Y0ZOmzfQT6xU1bdd3y6MnRKl9TEq9B9mN4+a0
 nwF5y0ZGP6Vn56elFpVkSmAJH+9Fe2sbIN6Ji1v972BgB5MemM3rkPz/lSBkEuxNUJG3 aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tx61c0gd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 00:34:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P0Re30157812;
        Thu, 25 Jul 2019 00:32:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tx60xgxs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 00:32:00 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6P0VsOR021827;
        Thu, 25 Jul 2019 00:31:55 GMT
Received: from [192.168.1.14] (/180.165.87.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 17:31:54 -0700
Subject: Re: [PATCH] block: fix max segment size handling in
 blk_queue_virt_boundary
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux@roeck-us.net, James.Bottomley@HansenPartnership.com,
        linux-block@vger.kernel.org
References: <20190724162656.3967-1-hch@lst.de>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <46f296a0-515a-d662-efaf-742d90654e7c@oracle.com>
Date:   Thu, 25 Jul 2019 08:31:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190724162656.3967-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250002
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/25/19 12:26 AM, Christoph Hellwig wrote:
> We should only set the max segment size to unlimited if we actually
> have a virt boundary.  Otherwise we accidentally clear that limit
> when called from the SCSI midlayer, which always calls
> blk_queue_virt_boundary, even if that mask is 0.
> 
> Fixes: 7ad388d8e4c7 ("scsi: core: add a host / host template field for the virt boundary")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 2ae348c101a0..2c1831207a8f 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -752,7 +752,8 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
>  	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
>  	 * of that they are not limited by our notion of "segment size".
>  	 */
> -	q->limits.max_segment_size = UINT_MAX;
> +	if (mask)
> +		q->limits.max_segment_size = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_queue_virt_boundary);
>  

Looks good to me!
Reviewed-by: Bob Liu <bob.liu@oracle.com>

