Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BA2C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FD22084A
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbeLPQQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:16:52 -0500
Received: from verein.lst.de ([213.95.11.211]:57803 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbeLPQQw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:16:52 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 18EED68DD3; Sun, 16 Dec 2018 17:16:51 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:16:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] blk-mq: deal with shared queue mapping reliably
Message-ID: <20181216161650.GD9957@lst.de>
References: <20181216022517.26650-1-ming.lei@redhat.com> <20181216022517.26650-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216022517.26650-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16, 2018 at 10:25:16AM +0800, Ming Lei wrote:
> This patch sets map->nr_queues as zero explictly if there is zero
> queues for such queue type, then blk_mq_map_swqueue() can become
> more robust to deal with shared mappings.

This looks a lot more clumsy than what we had before, can you explain
what additional robustnes it buys us?
