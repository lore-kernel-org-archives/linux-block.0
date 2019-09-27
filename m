Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAD2C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 04:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4FB20835
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 04:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bILJpP6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfI0EM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 00:12:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfI0EM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 00:12:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8R49vd1130344;
        Fri, 27 Sep 2019 04:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Rz+6DpZYpsPN/f2+4qqjZsY7BqgHuy/fPCmUuAKUnAI=;
 b=bILJpP6Z/7d3WagoF03xEuvCjnerTGz5YJy1haO/L6NBkN74OnJPxb/itJXyvvFEWx6J
 21HAiERb7JsW2gLEVAv3sWIlwIfSHO4KN2wpECmtN/JkF1+LVcd0A8YE1wxMtVqhhXX1
 fLyPbkoWFM2NhBQbvQXcMV0EZl9TKAjrGSO1HxdszExQ4tn3X6vTBuAdE2ZofTYwPuR4
 ylTu7Cce9e1QUkN1nl0lOg8erHpHF5nmfG2J/yK//BlhyzCr1gQnjIk+AeGfvN4YNc2b
 KWUYk4Amxl1YfT17l7TlWaWnJLBTucRFRxj7Rxo0CSNbiDwdNe2uvXzcCZEXoJZanIAV Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2v5cgrfj1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 04:12:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8R48w4h131491;
        Fri, 27 Sep 2019 04:10:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2v8yjxxkef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 04:10:49 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8R4AlX0017253;
        Fri, 27 Sep 2019 04:10:48 GMT
Received: from [192.168.1.14] (/180.165.87.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 21:10:46 -0700
Subject: Re: [PATCH] rq-qos: get rid of redundant wbt_update_limits()
To:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20190917120427.15008-1-yuyufen@huawei.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <8572a925-48ed-0307-399b-bec79fa540d1@oracle.com>
Date:   Fri, 27 Sep 2019 12:10:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190917120427.15008-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909270039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909270039
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 8:04 PM, Yufen Yu wrote:
> We have updated limits after calling wbt_set_min_lat(). No need to
> update again.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  block/blk-sysfs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 9bfa3ea4ed63..62d79916e429 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -482,7 +482,6 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
>  	blk_mq_quiesce_queue(q);
>  
>  	wbt_set_min_lat(q, val);
> -	wbt_update_limits(q);
>  
>  	blk_mq_unquiesce_queue(q);
>  	blk_mq_unfreeze_queue(q);
> 


Looks good to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

