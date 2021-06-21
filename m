Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A09C48BE5
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E1861156
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhFUHWw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:22:52 -0400
Received: from verein.lst.de ([213.95.11.211]:40848 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhFUHWw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 03:22:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3685968BFE; Mon, 21 Jun 2021 09:20:37 +0200 (CEST)
Date:   Mon, 21 Jun 2021 09:20:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [RFC PATCH V2 1/3] block: add helper of blk_queue_poll
Message-ID: <20210621072036.GB6651@lst.de>
References: <20210617103549.930311-1-ming.lei@redhat.com> <20210617103549.930311-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617103549.930311-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 06:35:47PM +0800, Ming Lei wrote:
> There has been 3 users, and will be more, so add one such helper.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I still don't like hiding a simple flag test like this, it just adds
another step to grepping what is going on.
