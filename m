Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDBBC43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 08:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44C124676
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 08:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rFDhigjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfLSI1k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:27:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35628 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSI1k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 03:27:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ8Qdtu137281;
        Thu, 19 Dec 2019 08:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Wp+bAt0EvwSSjK/6InPP8AUpjWgmwt4OQuVNGhNMlrU=;
 b=rFDhigjXskQKgdJIYjXQffE5mTXfzvdawQaxkDkgcwFu9AfLFMpf4f30Z4t8zwu30DkP
 S4B9L86JO9eu7KFDZJl4X5L599icFDejzD8V6mQcpZ8Nch8inNdq5wr4bWzquFFZgLJA
 xMPQ0vPBigtWCqQaYxp6vpnzXBKYWfk2kyvo5VFec6cXoe26TMNLtU8MQzHjo2vcC4Dd
 UDK+UiXaaFDTHzK6IyQtdi0jrg+LcJAMiLjTXI+YKOdw9WwSWsokammXeT6ZRIu3Ey3b
 VZAgXpjmdX9NLerFExzkiSw+VQQFSUn0RHK3yoKhaw/5YEFWaqLHgQvWy/qoAgNgVSQX iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2x01ja98ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 08:27:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ8IWKY136142;
        Thu, 19 Dec 2019 08:27:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wyut50dav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 08:27:31 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJ8RUjf027387;
        Thu, 19 Dec 2019 08:27:30 GMT
Received: from [10.191.9.152] (/10.191.9.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 00:27:30 -0800
Subject: Re: [PATCH] block: fix memleak when __blk_rq_map_user_iov() is failed
To:     Yang Yingliang <yangyingliang@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576658644-88101-1-git-send-email-yangyingliang@huawei.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <ba72f5ee-cab9-5a88-bb2d-c826c293553f@oracle.com>
Date:   Thu, 19 Dec 2019 16:27:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1576658644-88101-1-git-send-email-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/19 4:44 PM, Yang Yingliang wrote:
> When I doing fuzzy test, get the memleak report:
> 
> BUG: memory leak
> unreferenced object 0xffff88837af80000 (size 4096):
>   comm "memleak", pid 3557, jiffies 4294817681 (age 112.499s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     20 00 00 00 10 01 00 00 00 00 00 00 01 00 00 00   ...............
>   backtrace:
>     [<000000001c894df8>] bio_alloc_bioset+0x393/0x590
>     [<000000008b139a3c>] bio_copy_user_iov+0x300/0xcd0
>     [<00000000a998bd8c>] blk_rq_map_user_iov+0x2f1/0x5f0
>     [<000000005ceb7f05>] blk_rq_map_user+0xf2/0x160
>     [<000000006454da92>] sg_common_write.isra.21+0x1094/0x1870
>     [<00000000064bb208>] sg_write.part.25+0x5d9/0x950
>     [<000000004fc670f6>] sg_write+0x5f/0x8c
>     [<00000000b0d05c7b>] __vfs_write+0x7c/0x100
>     [<000000008e177714>] vfs_write+0x1c3/0x500
>     [<0000000087d23f34>] ksys_write+0xf9/0x200
>     [<000000002c8dbc9d>] do_syscall_64+0x9f/0x4f0
>     [<00000000678d8e9a>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> If __blk_rq_map_user_iov() is failed in blk_rq_map_user_iov(),
> the bio(s) which is allocated before this failing will leak. The
> refcount of the bio(s) is init to 1 and increased to 2 by calling
> bio_get(), but __blk_rq_unmap_user() only decrease it to 1, so
> the bio cannot be freed. Fix it by calling blk_rq_unmap_user().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Good catch! Looks fine to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

> ---
>  block/blk-map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 3a62e471d81b..b0790268ed9d 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -151,7 +151,7 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
>  	return 0;
>  
>  unmap_rq:
> -	__blk_rq_unmap_user(bio);
> +	blk_rq_unmap_user(bio);
>  fail:
>  	rq->bio = NULL;
>  	return ret;
> 

