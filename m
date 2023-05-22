Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C732C7EE2D
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 23:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjEVXKK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 19:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjEVXKJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 19:10:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5BCD
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lj6VvLUXWGm5tqegsbePf8zkOY9k2WARVauXS8FZNkY=; b=4H3/rSiFTJmSGi3yY6DioKAdzC
        PGROCxWTG6bIx97VS1DmDW8ubmMLz6S+wXSDEIgv218RyraK+YJbxKHcXfmMG2B/YBeJvM6gEvL/U
        2KLKcZ6uitsy8NMFuRblEvB9Uk/ebAVEpsfQFbKjNoarIAF99Va4Mwm/TahRClD1po2BQ3PxQZAu6
        9xy1G3OeKsz6+QwbEOh7tcCTaC/Wf8ukccPBJdJX0U8Lg8Ur2I4USXDbqkZXXjljo13YKqijeRv52
        ueQ/48X9EAk4qFkfTltW1JSDCR3o1Ably0pwLML8fsYDGkROYHiP0M+WJPg/WkERGjmAUiEF0YxC3
        pXQ1mSDQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1EfE-008Jrj-3A;
        Mon, 22 May 2023 23:10:05 +0000
Date:   Mon, 22 May 2023 16:10:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 1/9] block: Use pr_info() instead of printk(KERN_INFO
 ...)
Message-ID: <ZGv2TP1HZE1kgKlA@bombadil.infradead.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522222554.525229-2-bvanassche@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 03:25:33PM -0700, Bart Van Assche wrote:
> Switch to the modern style of printing kernel messages. Use %u instead
> of %d to print unsigned integers.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-settings.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..1d8d2ae7bdf4 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -127,8 +127,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>  
>  	if ((max_hw_sectors << 9) < PAGE_SIZE) {
>  		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
> -		printk(KERN_INFO "%s: set to minimum %d\n",
> -		       __func__, max_hw_sectors);
> +		pr_info("%s: set to minimum %u\n", __func__, max_hw_sectors);

You may want to then also add at the very top of the file before any
includes something like:

#define pr_fmt(fmt) "blk-settings: " fmt

You can see the other defines of pr_fmt on block/*.c

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
