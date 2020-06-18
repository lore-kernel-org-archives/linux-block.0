Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51048C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F7620897
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgFROeG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:34:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:38368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbgFROeG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:34:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4C221AC5E;
        Thu, 18 Jun 2020 14:34:04 +0000 (UTC)
Date:   Thu, 18 Jun 2020 16:34:04 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infrdead.org
Subject: Re: [PATCH 02/12] blk-mq: factor out a helper to reise the block
 softirq
Message-ID: <20200618143404.ro2kviia72qy6niv@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-3-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:42AM +0200, Christoph Hellwig wrote:
>  /*
>   * Setup and invoke a run of 'trigger_softirq' on the given cpu.
>   */
> @@ -681,19 +689,8 @@ static void __blk_complete_request(struct request *req)
>  	 * avoids IPI sending from current CPU to the first CPU of a group.
>  	 */
>  	if (ccpu == cpu || shared) {
> -		struct list_head *list;
>  do_local:
> -		list = this_cpu_ptr(&blk_cpu_done);
> -		list_add_tail(&req->ipi_list, list);
> -
> -		/*
> -		 * if the list only contains our just added request,
> -		 * signal a raise of the softirq. If there are already
> -		 * entries there, someone already raised the irq but it
> -		 * hasn't run yet.
> -		 */
> -		if (list->next == &req->ipi_list)
> -			raise_softirq_irqoff(BLOCK_SOFTIRQ);
> +		blk_mq_trigger_softirq(req);
>  	} else if (raise_blk_irq(ccpu, req))
>  		goto do_local;

Couldn't this be folded into the previous condition, e.g

	if (ccpu == cpu || shared || raised_blk_irq(ccpu, req))

?
