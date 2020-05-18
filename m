Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E408DC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57352070A
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 18:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgERSpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 14:45:50 -0400
Received: from verein.lst.de ([213.95.11.211]:40098 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbgERSpu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 14:45:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1F0F168B05; Mon, 18 May 2020 20:45:44 +0200 (CEST)
Date:   Mon, 18 May 2020 20:45:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200518184543.GA26157@lst.de>
References: <20200518093155.GB35380@T590> <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590> <20200518131634.GA645@lst.de> <20200518141107.GA50374@T590> <20200518165619.GA17465@lst.de> <87o8qlw0kz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8qlw0kz.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 08:38:04PM +0200, Thomas Gleixner wrote:
> > Shouldn't all the per-cpu kthreads also stop as part of the offlining?
> > If they don't quiesce before the new blk-mq stop state I think we need
> > to make sure they do.  It is rather pointless to quiesce the requests
> > if a thread that can submit I/O is still live.
> 
> Which kthreads are you talking about?

I think PF_KTHREAD threads bound to single cpu will usually be
workqueues, yes.

> Workqueues? CPU bound workqueues are shut down in
> CPUHP_AP_WORKQUEUE_ONLINE state.

That's what I mean.  If we shut down I/O before that happend we'd have
a problem, but as I expected your state machine is smarter than that :)
