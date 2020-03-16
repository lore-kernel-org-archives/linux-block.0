Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0E9C0044D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 12:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886D42051A
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 12:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgCPM0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:26:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730896AbgCPM0p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 08:26:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6D3732A51CF7D85A3715;
        Mon, 16 Mar 2020 20:26:41 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Mar 2020 20:26:35 +0800
Subject: Re: [PATCH] nbd: make starting request more reasonable
From:   Yufen Yu <yuyufen@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
References: <20200303130843.12065-1-yuyufen@huawei.com>
Message-ID: <9cdba8b1-f0e5-a079-8d44-0078478dd4d8@huawei.com>
Date:   Mon, 16 Mar 2020 20:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200303130843.12065-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping and Cc to more expert in blk-mq.

On 2020/3/3 21:08, Yufen Yu wrote:
> Our test robot reported a warning for refcount_dec trying to decrease
> value '0'. The reason is that blk_mq_dispatch_rq_list() try to complete
> the failed request from nbd driver, while the request have finished in
> nbd timeout handle function. The race as following:
> 
> CPU1                             CPU2
> 
> //req->ref = 1
> blk_mq_dispatch_rq_list
> nbd_queue_rq
>    nbd_handle_cmd
>      blk_mq_start_request
>                                   blk_mq_check_expired
>                                     //req->ref = 2
>                                     blk_mq_rq_timed_out
>                                       nbd_xmit_timeout
>                                         blk_mq_complete_request
>                                           //req->ref = 1
>                                           refcount_dec_and_test(&req->ref)
> 
>                                     refcount_dec_and_test(&req->ref)
>                                     //req->ref = 0
>                                       __blk_mq_free_request(req)
>    ret = BLK_STS_IOERR
> blk_mq_end_request
> // req->ref = 0, req have been free
> refcount_dec_and_test(&rq->ref)
> 
> In fact, the bug also have been reported by syzbot:
>    https://lkml.org/lkml/2018/12/5/1308
> 
> Since the request have been freed by timeout handle, it can be reused
> by others. Then, blk_mq_end_request() may get the re-initialized request
> and free it, which is unexpected.
> 
> To fix the problem, we move blk_mq_start_request() down until the driver
> will handle the request actully. If .queue_rq return something error in
> preparation phase, timeout handle may don't need. Thus, moving start
> request down may be more reasonable. Then, nbd_queue_rq() will not return
> BLK_STS_IOERR after starting request.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   drivers/block/nbd.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 78181908f0df..5256e9d02a03 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -541,6 +541,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
>   		return -EIO;
>   	}
>   
> +	blk_mq_start_request(req);
> +
>   	if (req->cmd_flags & REQ_FUA)
>   		nbd_cmd_flags |= NBD_CMD_FLAG_FUA;
>   
> @@ -879,7 +881,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>   		dev_err_ratelimited(disk_to_dev(nbd->disk),
>   				    "Socks array is empty\n");
> -		blk_mq_start_request(req);
>   		return -EINVAL;
>   	}
>   	config = nbd->config;
> @@ -888,7 +889,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>   		dev_err_ratelimited(disk_to_dev(nbd->disk),
>   				    "Attempted send on invalid socket\n");
>   		nbd_config_put(nbd);
> -		blk_mq_start_request(req);
>   		return -EINVAL;
>   	}
>   	cmd->status = BLK_STS_OK;
> @@ -912,7 +912,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>   			 */
>   			sock_shutdown(nbd);
>   			nbd_config_put(nbd);
> -			blk_mq_start_request(req);
>   			return -EIO;
>   		}
>   		goto again;
> @@ -923,7 +922,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>   	 * here so that it gets put _after_ the request that is already on the
>   	 * dispatch list.
>   	 */
> -	blk_mq_start_request(req);
>   	if (unlikely(nsock->pending && nsock->pending != req)) {
>   		nbd_requeue_cmd(cmd);
>   		ret = 0;
> 
