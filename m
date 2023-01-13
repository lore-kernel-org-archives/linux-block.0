Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC52C61DB3
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 13:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbjAMNvN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjAMNup (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 08:50:45 -0500
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Jan 2023 05:46:35 PST
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707F6415
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 05:46:34 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5b2e8e20.dip0.t-ipconnect.de [91.46.142.32])
        by mail.itouring.de (Postfix) with ESMTPSA id 253BDCF1A9D;
        Fri, 13 Jan 2023 14:38:30 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id D848EF01581;
        Fri, 13 Jan 2023 14:38:29 +0100 (CET)
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
To:     Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
References: <20230113094410.2907223-1-yukuai3@huawei.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <bab60ee7-b0b7-4e45-40b4-29d77de67372@applied-asynchrony.com>
Date:   Fri, 13 Jan 2023 14:38:29 +0100
MIME-Version: 1.0
In-Reply-To: <20230113094410.2907223-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023-01-13 10:44, Yu Kuai wrote:
> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"),
> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
> bic->bfqq will be freed first, and bic_set_bfqq() is called with the freed
> bic->bfqq.
> 
> Fix the problem by always freeing bfqq after bic_set_bfqq().
> 
> Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
> Reported-and-tested-by: Shinichiro Kawasaki <shinichiro.kawasaki-Sjgp3cTcYWE@public.gmane.org>
> Signed-off-by: Yu Kuai <yukuai3-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   block/bfq-cgroup.c  | 2 +-
>   block/bfq-iosched.c | 4 +++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index a6e8da5f5cfd..feb13ac25557 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -749,8 +749,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>   		 * old cgroup.
>   		 */
>   		bfq_put_cooperator(sync_bfqq);
> -		bfq_release_process_ref(bfqd, sync_bfqq);
>   		bic_set_bfqq(bic, NULL, true, act_idx);
> +		bfq_release_process_ref(bfqd, sync_bfqq);
>   	}
>   }
>   
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 815b884d6c5a..2ddf831221c4 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5581,9 +5581,11 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
>   
>   	bfqq = bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
>   	if (bfqq) {
> -		bfq_release_process_ref(bfqd, bfqq);
> +		struct bfq_queue *old_bfqq = bfqq;
> +
>   		bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
>   		bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, bio));
> +		bfq_release_process_ref(bfqd, old_bfqq);
>   	}
>   
>   	bfqq = bic_to_bfqq(bic, true, bfq_actuator_index(bfqd, bio));
> 

Hello,

does this condition also affect the current code? I ask since the patch does not apply
as bfq_sync_bfqq_move() is only part of the multi-actuator work, which is only in
Jens' for-next. Comparing the code sections it seems it should also be necessary for
current 6.1/6.2, but I wanted to check.

thanks
Holger
