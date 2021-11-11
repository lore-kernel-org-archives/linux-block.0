Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA48AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D242561884
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhKKI7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:59:41 -0500
Received: from verein.lst.de ([213.95.11.211]:57489 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhKKI7l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 03:59:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C9AE67373; Thu, 11 Nov 2021 09:56:50 +0100 (CET)
Date:   Thu, 11 Nov 2021 09:56:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] blk-mq: don't grab ->q_usage_counter in
 blk_mq_sched_bio_merge
Message-ID: <20211111085650.GA476@lst.de>
References: <20211111085134.345235-1-ming.lei@redhat.com> <20211111085134.345235-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111085134.345235-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 11, 2021 at 04:51:33PM +0800, Ming Lei wrote:
> blk_mq_sched_bio_merge is only called from blk-mq.c:blk_attempt_bio_merge(),
> which is called when queue usage counter is grabbed already:
> 
> 1) blk_mq_get_new_requests()
> 
> 2) blk_mq_get_request()
> - cached request in current plug owns one queue usage counter
> 
> So don't grab ->q_usage_counter in blk_mq_sched_bio_merge(), and more
> importantly this nest way causes hang in blk_mq_freeze_queue_wait().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
