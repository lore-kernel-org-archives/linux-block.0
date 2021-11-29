Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB65C433FE
	for <linux-block@archiver.kernel.org>; Mon, 29 Nov 2021 02:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhK2CTV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Nov 2021 21:19:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231567AbhK2CRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Nov 2021 21:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638152043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UsND0WUJx3OdyiBYmPkELfPAaNB8Sg6JYEf2yT7Btts=;
        b=EVrUfBGO5f+/Kuns+ZUYpwf9wueHjOeh4tYVBpvavCqAodLJi/GaGGXWxEP5TDdCz4zg1G
        g/5rhLue0D/waBGpLnNCZZOSLg7a/G0Yh8CPsp+kiaVj3uq2jcWrng8ElKnc9vo8HsMQzu
        qWHfAY5CAKH+vt+agiB/T+Ai5inzBSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-58uIZnieNb-CNlo1YaEybw-1; Sun, 28 Nov 2021 21:14:01 -0500
X-MC-Unique: 58uIZnieNb-CNlo1YaEybw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0FB91006AA0;
        Mon, 29 Nov 2021 02:13:59 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E54735D6BA;
        Mon, 29 Nov 2021 02:13:53 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:13:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] block: Fix fsync always failed if once failed
Message-ID: <YaQ3XGi1HHIIMgI+@T590>
References: <20211129012659.1553733-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129012659.1553733-1-yebin10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 29, 2021 at 09:26:59AM +0800, Ye Bin wrote:
> We do test with inject error fault base on v4.19, after test some time we found
> sync /dev/sda always failed.
> [root@localhost] sync /dev/sda
> sync: error syncing '/dev/sda': Input/output error
> 
> scsi log as follows:
> [19069.812296] sd 0:0:0:0: [sda] tag#64 Send: scmd 0x00000000d03a0b6b
> [19069.812302] sd 0:0:0:0: [sda] tag#64 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
> [19069.812533] sd 0:0:0:0: [sda] tag#64 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK
> [19069.812536] sd 0:0:0:0: [sda] tag#64 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
> [19069.812539] sd 0:0:0:0: [sda] tag#64 scsi host busy 1 failed 0
> [19069.812542] sd 0:0:0:0: Notifying upper driver of completion (result 0)
> [19069.812546] sd 0:0:0:0: [sda] tag#64 sd_done: completed 0 of 0 bytes
> [19069.812549] sd 0:0:0:0: [sda] tag#64 0 sectors total, 0 bytes done.
> [19069.812564] print_req_error: I/O error, dev sda, sector 0
> 
> ftrace log as follows:
>  rep-306069 [007] .... 19654.923315: block_bio_queue: 8,0 FWS 0 + 0 [rep]
>  rep-306069 [007] .... 19654.923333: block_getrq: 8,0 FWS 0 + 0 [rep]
>  kworker/7:1H-250   [007] .... 19654.923352: block_rq_issue: 8,0 FF 0 () 0 + 0 [kworker/7:1H]
>  <idle>-0     [007] ..s. 19654.923562: block_rq_complete: 8,0 FF () 18446744073709551615 + 0 [0]
>  <idle>-0     [007] d.s. 19654.923576: block_rq_complete: 8,0 WS () 0 + 0 [-5]
> 
> As 8d6996630c03 introduce 'fq->rq_status', this data only update when 'flush_rq'
> reference count isn't zero. If flush request once failed and record error code
> in 'fq->rq_status'. If there is no chance to update 'fq->rq_status',then do fsync
> will always failed.
> To address this issue reset 'fq->rq_status' after return error code to upper layer.
> 
> Fixes: 8d6996630c03("block: fix null pointer dereference in blk_mq_rq_timed_out()")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  block/blk-flush.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 902e80e48e4a..8b43088d41f2 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -242,8 +242,10 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  	 * avoiding use-after-free.
>  	 */
>  	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
> -	if (fq->rq_status != BLK_STS_OK)
> +	if (fq->rq_status != BLK_STS_OK) {
>  		error = fq->rq_status;
> +		fq->rq_status = BLK_STS_OK;
> +	}

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming

