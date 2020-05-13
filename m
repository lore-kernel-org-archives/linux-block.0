Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7769C2D0FC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD762176D
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbgEMMGn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:06:43 -0400
Received: from verein.lst.de ([213.95.11.211]:46120 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgEMMGn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:06:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4B54A68BEB; Wed, 13 May 2020 14:06:40 +0200 (CEST)
Date:   Wed, 13 May 2020 14:06:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 09/12] blk-mq: add blk_mq_hctx_handle_dead_cpu for
 handling cpu dead
Message-ID: <20200513120640.GE6297@lst.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com> <20200513034803.1844579-10-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513034803.1844579-10-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 11:48:00AM +0800, Ming Lei wrote:
> Add helper of blk_mq_hctx_handle_dead_cpu for handling cpu dead,
> and prepare for handling inactive hctx.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
