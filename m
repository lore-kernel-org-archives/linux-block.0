Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEA5C3A5A1
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 02:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3CB2070B
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 02:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHZCZq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Aug 2019 22:25:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfHZCZq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Aug 2019 22:25:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F33C23086262;
        Mon, 26 Aug 2019 02:25:45 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F1221001958;
        Mon, 26 Aug 2019 02:25:36 +0000 (UTC)
Date:   Mon, 26 Aug 2019 10:25:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH V2 4/6] blk-mq: don't hold q->sysfs_lock in
 blk_mq_realloc_hw_ctxs()
Message-ID: <20190826022529.GB25756@ming.t460p>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-5-ming.lei@redhat.com>
 <51cf9611-c62f-3dcf-2447-d8bde28bc238@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cf9611-c62f-3dcf-2447-d8bde28bc238@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 26 Aug 2019 02:25:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 21, 2019 at 08:56:36AM -0700, Bart Van Assche wrote:
> On 8/21/19 2:15 AM, Ming Lei wrote:
> > blk_mq_realloc_hw_ctxs() is called from blk_mq_init_allocated_queue()
> > and blk_mq_update_nr_hw_queues(). For the former caller, the kobject
> > isn't exposed to userspace yet. For the latter caller, sysfs/debugfs
> > is un-registered before updating nr_hw_queues.
> > 
> > On the other hand, commit 2f8f1336a48b ("blk-mq: always free hctx after
> > request queue is freed") moves freeing hctx into queue's release
> > handler, so there won't be race with queue release path too.
> > 
> > So don't hold q->sysfs_lock in blk_mq_realloc_hw_ctxs().
> 
> How about mentioning that the locking at the start of
> blk_mq_update_nr_hw_queues() serializes all blk_mq_realloc_hw_ctxs() calls
> that happen after a queue has been registered in sysfs?

This patch is actually wrong because elevator switch still may happen
during updating nr_hw_queues, since only hctx sysfs entries are
un-registered, and "queue/scheduler" is still visible to userspace.

So I will drop this patch in V3.

Thanks,
Ming
