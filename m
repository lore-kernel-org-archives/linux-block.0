Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CB0C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF854206BA
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbeLQBBJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:01:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeLQBBJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 20:01:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0551981DF1;
        Mon, 17 Dec 2018 01:01:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 740B119C7F;
        Mon, 17 Dec 2018 01:00:57 +0000 (UTC)
Date:   Mon, 17 Dec 2018 09:00:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 1/4] nvme-pci: correct mapping for poll queue(s)
Message-ID: <20181217010051.GA1223@ming.t460p>
References: <20181216022517.26650-1-ming.lei@redhat.com>
 <20181216022517.26650-2-ming.lei@redhat.com>
 <20181216161159.GB9957@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216161159.GB9957@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 17 Dec 2018 01:01:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16, 2018 at 05:11:59PM +0100, Christoph Hellwig wrote:
> On Sun, Dec 16, 2018 at 10:25:14AM +0800, Ming Lei wrote:
> > If we don't have poll queue, its mapping should share default type's,
> > instead of setting up one new mapping via blk_mq_map_queues().
> 
> No, if we don't have poll queues nr_maps should be 2.  I've already
> posted a patch for that for nvme-pci which got it wrong (my fault..)

This patch doesn't touch nr_maps.

The issue is that if poll_queues/write_queues are zero, all three mapping
should be same, however they aren't actually because we still use blk_mq_map_queues()
to build a new mapping for poll queue.

This difference causes broken mapping especially with help of blk_mq_map_swqueue(), since
hctx->type could be re-written.

Thanks,
Ming
