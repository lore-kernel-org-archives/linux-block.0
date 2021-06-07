Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5340BC4743F
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086CB613C8
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhFGQ1v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233140AbhFGQWg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Jun 2021 12:22:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ECD26192B;
        Mon,  7 Jun 2021 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623082519;
        bh=6XxCmyoN0H5/AYd8uNXZEGj/OJd/VcSdJDpCprpvhLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sByRQALyYsNwTbtIqc52Vevi1FBI3NypcTfdnvhPhbotIvqIbb4UVM5hyA6pmd4+S
         YYATZz11gocdVbdlmGqxpO/QPRDm2VEgvMIA6JpBA5nCon2WysnWREckp9MSiKC+Kq
         9nDCGEkZK9rtNZ30yoavuyNFsEzxwNazkGUri2naG6KYHvUX0W6dFvD3GtXyiZHfBS
         HU1J9LeHMkBhT+yBkkoilKqVuYHmWExAzUuSMSDHcPIM4+riULZLA3c5tCvtqI7N+G
         8gUA7yNshmsKHsE1UDtB8yn4K5FqjrTsGEPRgj6K7uY+IzDV0vX3rIYIwJliw4M5Wr
         5LJRhyEBhoekw==
Date:   Tue, 8 Jun 2021 01:15:12 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough commands
Message-ID: <20210607161512.GB21631@redsun51.ssa.fujisawa.hgst.com>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-3-kbusch@kernel.org>
 <CA+1E3rJM3sGLsOuPbYVH6kaTR8S9ogfe+wryuyWpqnA-pgDsEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJM3sGLsOuPbYVH6kaTR8S9ogfe+wryuyWpqnA-pgDsEw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 26, 2021 at 02:17:23PM +0530, Kanchan Joshi wrote:
> On Sat, May 22, 2021 at 2:05 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > The generic blk_execute_rq() knows how to handle polled completions. Use
> > that instead of implementing an nvme specific handler.
> >
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> > No changes since v2
> >
> >  drivers/nvme/host/core.c    | 38 +++++--------------------------------
> >  drivers/nvme/host/fabrics.c | 13 ++++++-------
> >  drivers/nvme/host/fabrics.h |  2 +-
> >  drivers/nvme/host/fc.c      |  2 +-
> >  drivers/nvme/host/nvme.h    |  2 +-
> >  drivers/nvme/host/rdma.c    |  3 +--
> >  drivers/nvme/host/tcp.c     |  2 +-
> >  drivers/nvme/target/loop.c  |  2 +-
> >  8 files changed, 17 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 762125f2905f..1a73eed61eee 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1012,31 +1012,6 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
> >  }
> >  EXPORT_SYMBOL_GPL(nvme_setup_cmd);
> >
> > -static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
> > -{
> > -       struct completion *waiting = rq->end_io_data;
> > -
> > -       rq->end_io_data = NULL;
> > -       complete(waiting);
> > -}
> > -
> > -static void nvme_execute_rq_polled(struct request_queue *q,
> > -               struct gendisk *bd_disk, struct request *rq, int at_head)
> > -{
> > -       DECLARE_COMPLETION_ONSTACK(wait);
> > -
> > -       WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
> > -
> > -       rq->cmd_flags |= REQ_HIPRI;
> 
> The new code doesn't retain this flag.
> Looks good otherwise.

The flag is only used to select an apporpriate hctx. We've explicitly
selected a polling hctx in this path already, so the flag is
unnecessary.
