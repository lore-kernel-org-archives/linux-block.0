Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427DEC11D2F
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 17:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F24E20838
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 17:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yDrlukfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBXRpt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:45:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45734 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXRpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 12:45:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OHWd8M058506;
        Mon, 24 Feb 2020 17:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JEmkcdpMsIa43X9Z88Wvxio7e5oLNcgQ9OPAvzpgb4Q=;
 b=yDrlukfwDufZl9DIY24I+rEekcGjvVTMfHsvNT+yA8evF5rA32jVKHJWgAuN0Y2pD4R5
 IoXsxNzZ7yydTZNevWRauhiyw8GBZJykIwf9y8r+Ya7Pgf3QaRZBymmaHPFc1oueMsUt
 bP0halNJjHX4W7rHzHiIVlGHv9J0Pr+s6hCLYWZRu6/u4BgHZpafYksmGy850tmNZE/U
 rH9kus/4jeivZPQiPsI+VwAGtbeeMM155fh773Y9j7Y4VVP5A9msthsV/Gu58ekD0Pti
 YT7W+eO2lbXc/taKlT6wPBndRtV7VEEBghU9bDMsih2Fsjx73IiZhAUHcA2nG1PwaJge eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yavxrgwv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 17:45:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OHSErE127947;
        Mon, 24 Feb 2020 17:43:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2yby5cxrtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 17:43:46 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OHhiuD009375;
        Mon, 24 Feb 2020 17:43:45 GMT
Received: from dhcp-10-211-46-32.usdhcp.oraclecorp.com (/10.211.46.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 09:43:44 -0800
Subject: Re: [PATCH 1/1] null_blk: remove unused 'll_list' in 'nullb_cmd'
From:   dongli.zhang@oracle.com
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
References: <20200224172451.21320-1-dongli.zhang@oracle.com>
Organization: Oracle Corporation
Message-ID: <7ffcc2b3-c536-91c8-0836-1a8937cf80d8@oracle.com>
Date:   Mon, 24 Feb 2020 09:43:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200224172451.21320-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=6 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=6 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240131
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nullb_cmd->list is no longer used as well. I would send v2.

Dongli Zhang

On 2/24/20 9:24 AM, Dongli Zhang wrote:
> The 'll_list' is no longer used since commit 3c395a969acc ("null_blk: set a
> separate timer for each command").
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/block/null_blk.h      | 1 -
>  drivers/block/null_blk_main.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> index bc837862b767..34fec8814bf1 100644
> --- a/drivers/block/null_blk.h
> +++ b/drivers/block/null_blk.h
> @@ -15,7 +15,6 @@
>  
>  struct nullb_cmd {
>  	struct list_head list;
> -	struct llist_node ll_list;
>  	struct __call_single_data csd;
>  	struct request *rq;
>  	struct bio *bio;
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 16510795e377..07301c72b102 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -1519,7 +1519,6 @@ static int setup_commands(struct nullb_queue *nq)
>  	for (i = 0; i < nq->queue_depth; i++) {
>  		cmd = &nq->cmds[i];
>  		INIT_LIST_HEAD(&cmd->list);
> -		cmd->ll_list.next = NULL;
>  		cmd->tag = -1U;
>  	}
>  
> 
