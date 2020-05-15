Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2415C433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC84F207BB
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 15:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgEOPiv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 11:38:51 -0400
Received: from verein.lst.de ([213.95.11.211]:57354 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgEOPiv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 11:38:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D11E068C65; Fri, 15 May 2020 17:38:47 +0200 (CEST)
Date:   Fri, 15 May 2020 17:38:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 5/6] blk-mq: disable preempt during allocating request
 tag
Message-ID: <20200515153847.GB29610@lst.de>
References: <20200515014153.2403464-1-ming.lei@redhat.com> <20200515014153.2403464-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515014153.2403464-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 15, 2020 at 09:41:52AM +0800, Ming Lei wrote:
> Disable preempt for a little while during allocating request tag, so
> request's tag(internal tag) is always allocated on the cpu of data->ctx,
> prepare for improving to handle cpu hotplug during allocating request.
> 
> In the following patch, hctx->state will be checked to see if it becomes
> inactive which is always set on the last CPU of hctx->cpumask.

I like the idea, but I hate the interface.  I really think we need
to moving assigning the ctx and hctx entirely into blk_mq_get_tag,
and then just unconditionally disable preemption in there.
