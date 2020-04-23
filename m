Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E53C2BA19
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BB920736
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgDWHPC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:15:02 -0400
Received: from verein.lst.de ([213.95.11.211]:56373 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWHPC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C23268BEB; Thu, 23 Apr 2020 09:14:59 +0200 (CEST)
Date:   Thu, 23 Apr 2020 09:14:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V7 1/9] blk-mq: mark blk_mq_get_driver_tag as static
Message-ID: <20200423071458.GA10951@lst.de>
References: <20200418030925.31996-1-ming.lei@redhat.com> <20200418030925.31996-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418030925.31996-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 18, 2020 at 11:09:17AM +0800, Ming Lei wrote:
> Now all callers of blk_mq_get_driver_tag are in blk-mq.c, so mark
> it as static.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
