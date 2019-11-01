Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D480ECA9ECB
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 02:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69EB208CB
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 02:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ROpihfoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfKACPD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:15:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39100 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfKACPC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 22:15:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA12DiUV140621;
        Fri, 1 Nov 2019 02:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=+D5uZVrrm2UUwBzgJZjbEAL/lxOpZVzPX8fBvNBqg+8=;
 b=ROpihfooAfUBgl605qGxVr1Uam3xdsvmJemdAWh9+EOZ+jP+GrJ3XMloQVwGsNJ97Uck
 YrajK3+qtmbYBXzxGse7amlxYr+vfsERdAeDz1292F/YxZ5VdkQBHRGgKekBHbC0DzOs
 3CYKbcAfZApLhszMYvp2vaA8CjBAnJMpo55F0CWo7OZ9liOSotQBty054zVCgqAWDn5+
 /PvWxPD+ttL5aOR+ddcF9GTCYoND3rzQThyk+sdnJqExSmI7irSYzjSpswmaJDuFN8Co
 OwgvxdZIKgbtdWUlm4dUMLQzEqChyELPAeEKFN+kO+o8L6H60KabGItwvjQyNnSFerKT kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vxwhfxvww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 02:14:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA12EL2n076724;
        Fri, 1 Nov 2019 02:14:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vysbvyd2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 02:14:48 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA12Ekig026521;
        Fri, 1 Nov 2019 02:14:46 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 19:14:46 -0700
Subject: Re: [PATCH] io_uring: set -EINTR directly when a signal wakes up in
 io_cqring_wait
To:     Jackie Liu <liuyun01@kylinos.cn>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <1572319002-9943-1-git-send-email-liuyun01@kylinos.cn>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <bb55cf58-ce2f-23fe-67a6-c542a1e82f1e@oracle.com>
Date:   Fri, 1 Nov 2019 10:14:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1572319002-9943-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911010020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911010020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/19 11:16 AM, Jackie Liu wrote:
> We didn't use -ERESTARTSYS to tell the application layer to restart the
> system call, but instead return -EINTR. we can set -EINTR directly when
> wakeup by the signal, which can help us save an assignment operation and
> comparison operation.
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Looks good to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

> ---
>  fs/io_uring.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index a30c4f6..63eee7e 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2878,7 +2878,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>  		.to_wait	= min_events,
>  	};
>  	struct io_rings *rings = ctx->rings;
> -	int ret;
> +	int ret = 0;
>  
>  	if (io_cqring_events(rings) >= min_events)
>  		return 0;
> @@ -2896,7 +2896,6 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>  			return ret;
>  	}
>  
> -	ret = 0;
>  	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
>  	do {
>  		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq,
> @@ -2905,15 +2904,13 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>  			break;
>  		schedule();
>  		if (signal_pending(current)) {
> -			ret = -ERESTARTSYS;
> +			ret = -EINTR;
>  			break;
>  		}
>  	} while (1);
>  	finish_wait(&ctx->wait, &iowq.wq);
>  
> -	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
> -	if (ret == -ERESTARTSYS)
> -		ret = -EINTR;
> +	restore_saved_sigmask_unless(ret == -EINTR);
>  
>  	return READ_ONCE(rings->cq.head) == READ_ONCE(rings->cq.tail) ? ret : 0;
>  }
> 

