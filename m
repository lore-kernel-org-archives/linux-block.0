Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E62CA9EA0
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 10:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977B5217F4
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 10:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KaZDn1Id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfKDKJS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:09:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKDKJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 05:09:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4A895B154440;
        Mon, 4 Nov 2019 10:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=xtrXNlecFH2TLIOMFvgOVgexRvyQb2ELoQsKBZ/PqcI=;
 b=KaZDn1IdWpRIdPOohM2dyv+/h6BOkNhK860/3S95hNaf2rpViHGaMewi/5GaAPb6dNcz
 GmwEv09ZQBoCaKnaIiJgRxkmylSZjyUQH0100AGt8AoZTZU0Tv2zWxYwGRhgEcFjKltu
 6u5A/Zz357qwPXqeGMigbRTtb+XfhPVinkWUe+S8EjS46jrn86/SHd8DrZlcqW0cwsSR
 Q2ts2njDn7Sf9mVmSK3fjzHq1UJ5lB1CgTEeZRVpgeWhnhYXeyZE38G0QFbiRVMnfPJP
 9TSIZiHel6dYfyVohr34kfB0+15PrTsjk+89TlMErKFUkj/mqCMtetvkuQPcSdMZvuF0 hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w12eqx2uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:09:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4A7VEj079111;
        Mon, 4 Nov 2019 10:09:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w1kxm3u5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:09:10 +0000
Received: from abhmp0021.oracle.com (abhmp0021.oracle.com [141.146.116.27])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4A98tc009323;
        Mon, 4 Nov 2019 10:09:08 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 02:09:07 -0800
Subject: Re: [RFC] io_uring: stop only support read/write for ctx with
 IORING_SETUP_IOPOLL
To:     yangerkun <yangerkun@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     houtao1@huawei.com, yi.zhang@huawei.com
References: <20191104085608.44816-1-yangerkun@huawei.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <a01cc299-69e7-daa2-6894-1c60aaa64e67@oracle.com>
Date:   Mon, 4 Nov 2019 18:09:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20191104085608.44816-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040101
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 4:56 PM, yangerkun wrote:
> There is no problem to support other type request for the ctx with
> IORING_SETUP_IOPOLL. 

Could you describe the benefit of doing this?

> What we should do is just insert read/write
> requests to poll list, and protect cqes with comopletion_lock in
> io_iopoll_complete since other requests now can be completed as the same
> time while we do io_iopoll_complete.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/io_uring.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index f9a38998f2fc..8bf52d9a2c55 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -753,9 +753,11 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
>  {
>  	void *reqs[IO_IOPOLL_BATCH];
>  	struct io_kiocb *req;
> +	unsigned long flags;
>  	int to_free;
>  
>  	to_free = 0;
> +	spin_lock_irqsave(&ctx->completion_lock, flags);
>  	while (!list_empty(done)) {
>  		req = list_first_entry(done, struct io_kiocb, list);
>  		list_del(&req->list);
> @@ -781,6 +783,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
>  	}
>  
>  	io_commit_cqring(ctx);
> +	spin_unlock_irqrestore(&ctx->completion_lock, flags);
>  	io_free_req_many(ctx, reqs, &to_free);
>  }
>  
> @@ -1517,9 +1520,6 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
>  	struct io_ring_ctx *ctx = req->ctx;
>  	long err = 0;
>  
> -	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
> -		return -EINVAL;
> -
>  	io_cqring_add_event(ctx, user_data, err);
>  	io_put_req(req);
>  	return 0;
> @@ -1527,13 +1527,9 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
>  
>  static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  {
> -	struct io_ring_ctx *ctx = req->ctx;
> -
>  	if (!req->file)
>  		return -EBADF;
>  
> -	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
> -		return -EINVAL;
>  	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
>  		return -EINVAL;
>  
> @@ -1574,14 +1570,11 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  
>  static int io_prep_sfr(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  {
> -	struct io_ring_ctx *ctx = req->ctx;
>  	int ret = 0;
>  
>  	if (!req->file)
>  		return -EBADF;
>  
> -	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
> -		return -EINVAL;
>  	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
>  		return -EINVAL;
>  
> @@ -1627,9 +1620,6 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  	struct socket *sock;
>  	int ret;
>  
> -	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
> -		return -EINVAL;
> -
>  	sock = sock_from_file(req->file, &ret);
>  	if (sock) {
>  		struct user_msghdr __user *msg;
> @@ -1712,8 +1702,6 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  	struct io_kiocb *poll_req, *next;
>  	int ret = -ENOENT;
>  
> -	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
> -		return -EINVAL;
>  	if (sqe->ioprio || sqe->off || sqe->len || sqe->buf_index ||
>  	    sqe->poll_events)
>  		return -EINVAL;
> @@ -1833,8 +1821,6 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  	__poll_t mask;
>  	u16 events;
>  
> -	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
> -		return -EINVAL;
>  	if (sqe->addr || sqe->ioprio || sqe->off || sqe->len || sqe->buf_index)
>  		return -EINVAL;
>  	if (!poll->file)
> @@ -1932,8 +1918,6 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  	struct timespec64 ts;
>  	unsigned span = 0;
>  
> -	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
> -		return -EINVAL;
>  	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->timeout_flags ||
>  	    sqe->len != 1)
>  		return -EINVAL;
> @@ -2032,6 +2016,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>  			   const struct sqe_submit *s, bool force_nonblock)
>  {
>  	int ret, opcode;
> +	bool poll = false;
>  
>  	req->user_data = READ_ONCE(s->sqe->user_data);
>  
> @@ -2046,17 +2031,21 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>  	case IORING_OP_READV:
>  		if (unlikely(s->sqe->buf_index))
>  			return -EINVAL;
> +		poll = true;
>  		ret = io_read(req, s, force_nonblock);
>  		break;
>  	case IORING_OP_WRITEV:
>  		if (unlikely(s->sqe->buf_index))
>  			return -EINVAL;
> +		poll = true;
>  		ret = io_write(req, s, force_nonblock);
>  		break;
>  	case IORING_OP_READ_FIXED:
> +		poll = true;
>  		ret = io_read(req, s, force_nonblock);
>  		break;
>  	case IORING_OP_WRITE_FIXED:
> +		poll = true;
>  		ret = io_write(req, s, force_nonblock);
>  		break;
>  	case IORING_OP_FSYNC:
> @@ -2088,7 +2077,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>  	if (ret)
>  		return ret;
>  
> -	if (ctx->flags & IORING_SETUP_IOPOLL) {
> +	if ((ctx->flags & IORING_SETUP_IOPOLL) && poll) {
>  		if (req->result == -EAGAIN)
>  			return -EAGAIN;
>  
> 

