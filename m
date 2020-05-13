Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3389C2D0FC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F4920740
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgEML4m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:56:42 -0400
Received: from verein.lst.de ([213.95.11.211]:46049 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgEML4l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:56:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 815EC68BEB; Wed, 13 May 2020 13:56:38 +0200 (CEST)
Date:   Wed, 13 May 2020 13:56:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V11 05/12] blk-mq: add blk_mq_all_tag_iter
Message-ID: <20200513115638.GA6297@lst.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com> <20200513034803.1844579-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513034803.1844579-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 11:47:56AM +0800, Ming Lei wrote:
> Now request is thought as in-flight only when its state is updated as
> MQ_RQ_IN_FLIGHT, which is done by driver via blk_mq_start_request().

This should probably mention who considers it it in flight.

> Actually from blk-mq's view, one rq can be thought as in-flight
> after its tag is >= 0.

> Add one new function of blk_mq_all_tag_iter so that we can iterate
> every in-flight request, and this way is more flexible since caller
> can decide to handle request according to rq's state.

Maybe I'd reword the whole commit log as:

"Add a new blk_mq_all_tag_iter that iterates all requets which have a tag
assigned to them.  This is more flexible than the existing iterator
iterator as it allows the caller to check the request state and act
upon it."

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
