Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDA1C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E20320675
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbeLQRag (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:30:36 -0500
Received: from verein.lst.de ([213.95.11.211]:35682 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeLQRag (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 12:30:36 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EC5D068D8D; Mon, 17 Dec 2018 18:30:34 +0100 (CET)
Date:   Mon, 17 Dec 2018 18:30:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: skip zero-queue maps in blk_mq_map_swqueue
Message-ID: <20181217173034.GA13636@lst.de>
References: <20181217172856.14743-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217172856.14743-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 01:28:56AM +0800, Ming Lei wrote:
> >From 7e849dd9cf37 ("nvme-pci: don't share queue maps"), the mapping
> table won't be initialized actually if map->nr_queues is zero, so
> we can't use blk_mq_map_queue_type() to retrieve hctx any more.
> 
> This way still may cause broken mapping, fix it by skipping zero-queues
> maps in blk_mq_map_swqueue().

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
