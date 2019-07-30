Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A271C433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 00:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535F220651
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 00:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfG3Api (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:45:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbfG3Api (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 20:45:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 073613179157;
        Tue, 30 Jul 2019 00:45:38 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC6E710013A7;
        Tue, 30 Jul 2019 00:45:31 +0000 (UTC)
Date:   Tue, 30 Jul 2019 08:45:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/5] blk-mq: wait until completed req's complete fn is
 run
Message-ID: <20190730004525.GB28708@ming.t460p>
References: <20190724034843.10879-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 30 Jul 2019 00:45:38 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 24, 2019 at 11:48:38AM +0800, Ming Lei wrote:
> Hi,
> 
> blk-mq may schedule to call queue's complete function on remote CPU via
> IPI, but never provide any way to synchronize the request's complete
> fn.
> 
> In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> re-allocated. If the completed request's complete fn is run finally after the
> hardware queue's resource is released, kernel crash will be triggered.
> 
> Fixes this issue by waitting until completed req's complete fn is run.
> 
> V2:
> 	- fix one build warning
> 	- fix commit log
> 	- apply the wait on nvme-fc code too
> 
> Thanks,
> Ming
> 
> Ming Lei (5):
>   blk-mq: introduce blk_mq_request_completed()
>   blk-mq: introduce blk_mq_tagset_wait_completed_request()
>   nvme: don't abort completed request in nvme_cancel_request
>   nvme: wait until all completed request's complete fn is called
>   blk-mq: remove blk_mq_complete_request_sync
> 
>  block/blk-mq-tag.c         | 32 ++++++++++++++++++++++++++++++++
>  block/blk-mq.c             | 13 ++++++-------
>  drivers/nvme/host/core.c   |  6 +++++-
>  drivers/nvme/host/fc.c     |  2 ++
>  drivers/nvme/host/pci.c    |  2 ++
>  drivers/nvme/host/rdma.c   |  8 ++++++--
>  drivers/nvme/host/tcp.c    |  8 ++++++--
>  drivers/nvme/target/loop.c |  2 ++
>  include/linux/blk-mq.h     |  3 ++-
>  9 files changed, 63 insertions(+), 13 deletions(-)
> 
> Cc: Max Gurtovoy <maxg@mellanox.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>

Hello Jens, Chritoph and Guys,

Ping on this fix.

Thanks,
Ming
