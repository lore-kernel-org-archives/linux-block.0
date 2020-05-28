Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557DCC433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 11:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B634208E4
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 11:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbgE1LSe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 07:18:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:46706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388038AbgE1LSe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 07:18:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89ED3ABCE;
        Thu, 28 May 2020 11:18:32 +0000 (UTC)
Date:   Thu, 28 May 2020 13:18:32 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/6] blk-mq: pass request queue into get/put budget
 callback
Message-ID: <20200528111832.w344qhpy4b6ddbbe@beryllium.lan>
References: <20200528080053.1062653-1-ming.lei@redhat.com>
 <20200528080053.1062653-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528080053.1062653-2-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 04:00:48PM +0800, Ming Lei wrote:
> blk-mq budget is abstract from scsi's device queue depth, and it is
> always per-request-queue instead of hctx.
> 
> It can be quite absurd to get a budget from one hctx, then dequeue a
> request from scheduler queue, and this request may not belong to this
> hctx, at least for bfq and deadline.
> 
> So fix the mess and always pass request queue to get/put budget
> callback.
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

