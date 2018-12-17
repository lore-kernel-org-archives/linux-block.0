Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E8C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728392084D
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbeLQB1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:27:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731106AbeLQB1Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 20:27:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7030F83F42;
        Mon, 17 Dec 2018 01:27:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D5245C1B4;
        Mon, 17 Dec 2018 01:27:14 +0000 (UTC)
Date:   Mon, 17 Dec 2018 09:27:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 3/4] blk-mq: deal with shared queue mapping reliably
Message-ID: <20181217012708.GE1223@ming.t460p>
References: <20181216022517.26650-1-ming.lei@redhat.com>
 <20181216022517.26650-4-ming.lei@redhat.com>
 <20181216161650.GD9957@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216161650.GD9957@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Dec 2018 01:27:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16, 2018 at 05:16:50PM +0100, Christoph Hellwig wrote:
> On Sun, Dec 16, 2018 at 10:25:16AM +0800, Ming Lei wrote:
> > This patch sets map->nr_queues as zero explictly if there is zero
> > queues for such queue type, then blk_mq_map_swqueue() can become
> > more robust to deal with shared mappings.
> 
> This looks a lot more clumsy than what we had before, can you explain
> what additional robustnes it buys us?

If there isn't one mapping type, its .nr_queues is set as zero explicitly,
then we don't need to touch the related hctx/ctx which is retrieved via the
shared mapping table.

thanks,
Ming
