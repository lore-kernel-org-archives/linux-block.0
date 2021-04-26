Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF60BC433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 17:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD030610A2
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 17:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhDZRQP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235187AbhDZRQO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 13:16:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C35E761042;
        Mon, 26 Apr 2021 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619457332;
        bh=p+q7TkEFrJhq35tq5j0hlE1Ruxcv/DpvcnsFTIwgtvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOuArXOa4U0VE3VWVFERC4Ul58+revaMkdQOLLr1nKK+FCrMvzO4GHixj9O5whRR0
         KJoBjyTgt/qiJ79zUgUzr+NJE0XLJ67oBwhSeMoe7mXDKbDYlK4RkRYurFLTaHwhc5
         pSqdXkgXGvmlJvzDadiLa3a+8CazHBouE7X4Zrhry+pQoKRjonYexBzhUrXXBBeNWK
         JrhkRyDlo6UY9Kjd64TPCHn+cQcPQHs/GfsT65KVJ298Xu4hPk2ygrVD0lu7nj2/61
         7poEomUsV845cRqr/yvFuXplVig8FSvhmJMdGfuUqlFOBNR5upFOKEDUYccrioIBEi
         GkzXM2ptTaP4A==
Date:   Tue, 27 Apr 2021 02:15:25 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Yuanyuan Zhong <yzhong@purestorage.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 4/5] nvme: use return value from blk_execute_rq()
Message-ID: <20210426171525.GA13018@redsun51.ssa.fujisawa.hgst.com>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-5-kbusch@kernel.org>
 <CA+AMecF+n+xVk8HcQn12oiO=YMJM08aC0AG3iM_3h8SgNxURow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AMecF+n+xVk8HcQn12oiO=YMJM08aC0AG3iM_3h8SgNxURow@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 26, 2021 at 10:10:09AM -0700, Yuanyuan Zhong wrote:
> On Fri, Apr 23, 2021 at 3:06 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > We don't have an nvme status to report if the driver's .queue_rq()
> > returns an error without dispatching the requested nvme command. Use the
> > return value from blk_execute_rq() for all passthrough commands so the
> > caller may know their command was not successful.
> >
> > If the command is from the target passthrough interface and fails to
> > dispatch, synthesize the response back to the host as a internal target
> > error.
> >
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/core.c       | 16 ++++++++++++----
> >  drivers/nvme/host/ioctl.c      |  6 +-----
> >  drivers/nvme/host/nvme.h       |  2 +-
> >  drivers/nvme/target/passthru.c |  8 ++++----
> >  4 files changed, 18 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 10bb8406e067..62af5fe7a0ce 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -972,12 +972,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> >                         goto out;
> >         }
> >
> > -       blk_execute_rq(NULL, req, at_head);
> > +       ret = blk_execute_rq(NULL, req, at_head);
> >         if (result)
> >                 *result = nvme_req(req)->result;
> >         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> >                 ret = -EINTR;
> > -       else
> > +       else if (nvme_req(req)->status)
> 
> Since nvme_req(req)->status is uninitialized for a command failed to dispatch,
> it's valid only if ret from blk_execute_rq() is 0.

That's not quite right. If queue_rq() succeeds, but the SSD returns an
error, blk_execute_rq() returns a non-zero value with a valid nvme_req
status.
