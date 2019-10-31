Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EA8CA9EC3
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5B22086D
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 10:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XlV4qjJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfJaKK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:10:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49034 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfJaKK6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 06:10:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VA8fTR154021;
        Thu, 31 Oct 2019 10:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=BBxOI1HRozanqXDqOhpfDLGPkCP20IcBqxNnuBGwBMc=;
 b=XlV4qjJDtsU6SmRn0X0S9RyUyuOz5mTfaC3P6Z4ek/9w4WB71z45ypVha6ph6z+Sr4F9
 P/px3j8eJVl5KMiY3qLnMs0tYBTA6JPipuJ0FNPlRKbnGlDfFnF7p3vU6fy9P8S5rlCN
 7ghQFIr2DC6B+fxiGx1V0FL9xdVGg4HIHv3K4sN0ctUnl5dXjfvgHVBiV891UT6c2vfa
 BvIhY9TGMctbRDVIKQ2JmK+UIbzXu2OtKyercK8WFl0sn7J0vCMQGFVuOzXjL+zfGLDf
 yPEiWEAmyLIpCA9YjnRQMcNdILJhcltOoV0xAFT2en1rJQ1QHeW9OAo06p1qTYkE9u2N 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vxwhft58v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:10:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VA8QTT036299;
        Thu, 31 Oct 2019 10:10:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vysbtvbn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:10:46 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9VAAjkk019487;
        Thu, 31 Oct 2019 10:10:45 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 03:10:45 -0700
Subject: Re: [PATCH] blk-mq: Make blk_mq_run_hw_queue() return void
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1572368370-139412-1-git-send-email-john.garry@huawei.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <b488b2ee-4e0d-f7e9-6d28-6507840e6aac@oracle.com>
Date:   Thu, 31 Oct 2019 18:10:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1572368370-139412-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310103
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/30/19 12:59 AM, John Garry wrote:
> Since commit 97889f9ac24f ("blk-mq: remove synchronize_rcu() from
> blk_mq_del_queue_tag_set()"), the return value of blk_mq_run_hw_queue()
> is never checked, so make it return void, which very marginally simplifies
> the code.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 

Reviewed-by: Bob Liu <bob.liu@oracle.com>

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ec791156e9cc..8daa9740929a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1486,7 +1486,7 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
>  }
>  EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>  
> -bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
> +void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>  {
>  	int srcu_idx;
>  	bool need_run;
> @@ -1504,12 +1504,8 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>  		blk_mq_hctx_has_pending(hctx);
>  	hctx_unlock(hctx, srcu_idx);
>  
> -	if (need_run) {
> +	if (need_run)
>  		__blk_mq_delay_run_hw_queue(hctx, async, 0);
> -		return true;
> -	}
> -
> -	return false;
>  }
>  EXPORT_SYMBOL(blk_mq_run_hw_queue);
>  
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 0bf056de5cc3..c963038dfb92 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -324,7 +324,7 @@ void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
>  void blk_mq_quiesce_queue(struct request_queue *q);
>  void blk_mq_unquiesce_queue(struct request_queue *q);
>  void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
> -bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
> +void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
>  void blk_mq_run_hw_queues(struct request_queue *q, bool async);
>  void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>  		busy_tag_iter_fn *fn, void *priv);
> 

