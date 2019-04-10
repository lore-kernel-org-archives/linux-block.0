Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE8BC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 17:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAA22077C
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 17:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h6PyZat0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfDJRjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:39:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56930 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbfDJRjF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 13:39:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3AHXqvJ073777;
        Wed, 10 Apr 2019 17:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=r9d+4HJ1YhTsTNJNafCIeJauD4NOh20rQoicT9MoGWc=;
 b=h6PyZat0Ncx+Z1/u3SnZ+QCmYMdXMQ+Twv4/YLrpLAZ4CtluC25b5oWzeDLx6UkYbGz6
 XplJZHpun3veGev9u5smWhIEuKSBBhvNhrSziKNWTntiGkZ7hqJVddfQDvsOdCls0voy
 DRVjkb0PPDEl8Q2UwJcEzzaO7Ficiu1GmmBBO3GjkjK8el2vekmmGTnRmz767sO93NXA
 VNubyf16jo5LQXCPTohHcC0rF3Bp1PtYMrF+VXPVPLaj1w7EA5tv5NT/aEZ/yLqBuKVb
 nRufNLIBm63MMFl66qf47nfjkK0WvmHPnNIYk+d8EVmcwy82SIQ6qVYStaEgY5Vi/D6U Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rphmempsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 17:39:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3AHcQwU004824;
        Wed, 10 Apr 2019 17:38:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2rpj5bapkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 17:38:59 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3AHcvcN005911;
        Wed, 10 Apr 2019 17:38:59 GMT
Received: from [192.168.2.8] (/106.39.148.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 10:38:57 -0700
Subject: Re: [PATCH 1/1] blk-mq: do not splice ctx->rq_lists[type] to
 hctx->dispatch if ctx is not mapped to hctx
To:     axboe@kernel.dk
References: <1554721973-32456-1-git-send-email-dongli.zhang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <f30ce403-3af1-3e55-e080-0ef0bb9d5c50@oracle.com>
Date:   Thu, 11 Apr 2019 01:38:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1554721973-32456-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100118
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100117
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 04/08/2019 07:12 PM, Dongli Zhang wrote:
> When a cpu is offline, blk_mq_hctx_notify_dead() is called once for each
> hctx for the offline cpu.
> 
> While blk_mq_hctx_notify_dead() is used to splice all ctx->rq_lists[type]
> to hctx->dispatch, it never checks whether the ctx is already mapped to the
> hctx.
> 
> For example, on a VM (with nvme) of 4 cpu, to offline cpu 2 out of the
> 4 cpu (0-3), blk_mq_hctx_notify_dead() is called once for each io queue
> hctx:
> 
> 1st: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 3
> 2nd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 2
> 3rd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 1
> 4th: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 0
> 
> Although blk_mq_ctx->cpu = 2 is only mapped to blk_mq_hw_ctx->queue_num = 2
> in this case, its ctx->rq_lists[type] will however be moved to
> blk_mq_hw_ctx->queue_num = 3 during the 1st call of
> blk_mq_hctx_notify_dead().
> 
> This patch would return and go ahead to next call of
> blk_mq_hctx_notify_dead() if ctx is not mapped to hctx.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Would you consider this one?

In addition to Ming's Reviewed-by, there is another Reviewed-by from Keith as in
below link.

https://lore.kernel.org/linux-block/20190408153627.GF32498@localhost.localdomain/

Thank you very much!

Dongli Zhang

> ---
>  block/blk-mq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a935483..9612746 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2219,6 +2219,10 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  	enum hctx_type type;
>  
>  	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> +
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
>  	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
>  	type = hctx->type;
>  
> 
