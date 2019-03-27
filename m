Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDB5C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 02:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286782075E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 02:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbfC0CGY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:06:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731754AbfC0CGS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 22:06:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76C3830B96D8;
        Wed, 27 Mar 2019 02:06:18 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C98FD2655C;
        Wed, 27 Mar 2019 02:06:13 +0000 (UTC)
Date:   Wed, 27 Mar 2019 10:06:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] blk-mq/nvme: cancel request synchronously
Message-ID: <20190327020608.GB4882@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318032950.17770-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 27 Mar 2019 02:06:18 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 18, 2019 at 11:29:48AM +0800, Ming Lei wrote:
> Hi,
> 
> This patchset introduces blk_mq_complete_request_sync() for canceling
> request synchronously in error handler context, then one race between
> completing request and destroying contoller/queues can be fixed.
> 
> 
> Ming Lei (2):
>   blk-mq: introduce blk_mq_complete_request_sync()
>   nvme: cancel request synchronously
> 
>  block/blk-mq.c           | 20 ++++++++++++++++----
>  drivers/nvme/host/core.c |  2 +-
>  include/linux/blk-mq.h   |  1 +
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-nvme@lists.infradead.org
> 
> -- 
> 2.9.5
> 

Hi Jens and Christoph,

This two simple patches do fix kernel oops in the "Link flap / Failover
testing an NVMe over RDMA connection" from our customer.

Looks no one objects this fix, could you consider them for v5.1 if you
are fine?

Thanks,
Ming
