Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59155C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 07:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiJJHns (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiJJHn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 03:43:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761164DA;
        Mon, 10 Oct 2022 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AUwsgJTxZk8MKdj+SCxkYVH878r8ylsMxJbYQCvp10o=; b=36JjWNXQMhRmkN9OEY1rDRHUdK
        d1oK6KGl/G7BhWmiM6SufkiJxHGg9TQcoalzygczfJMMqaXA7xf0Gb8+NaAySsBndO1tNghqgGQvW
        5GZQHIj6v/GaOOzK/H+lPNZXcPQWq940j1W/D044PI8hwrZSMKZtY2k3rbXMbK1eVON7yr/8SlN/D
        wjL7kmmve/QYCjP95EhwPAZ7g6cIVOepLkFzZ6JZjvzQpCxJZrn4XbI8bjUeGwE99AjOtaACBhP3w
        SgPJi9XnucU0vk+0UHqrDVwPWotluk2VyxkKDvtJH9KDpBzNZQa5bxJDDWIPbNAWO/0psy57oBFZi
        7wycACFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohnO3-00HPFA-EF; Mon, 10 Oct 2022 07:39:43 +0000
Date:   Mon, 10 Oct 2022 00:39:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yuwei Guan <Yuwei.Guan@zeekrlife.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: initialize csd/fifo_time before use
Message-ID: <Y0PMPw3pMFWZ11id@infradead.org>
References: <20221010071916.1075-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010071916.1075-1-Yuwei.Guan@zeekrlife.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 10, 2022 at 03:19:16PM +0800, Yuwei Guan wrote:
> csd/fifo_time need to be initialized before use again,
> otherwise, it will keep the last tag value.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
>  block/blk-mq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..f55d41f1d150 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -383,6 +383,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>         rq->end_io = NULL;
>         rq->end_io_data = NULL;
> 
> +       /* initialize csd/fifo_time before use */
> +       memset(&rq->csd, 0x0, sizeof(rq->csd));

This is a rather unusual spelling of 0.  But more importantly what
problem with reuse do you actually see here? The csd is always
initialized before use as it can't otherwise work.  fifo_time
also appears to, but the code is a bit convoluted.

