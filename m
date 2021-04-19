Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E242CC433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F8E61104
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhDSHQj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:16:39 -0400
Received: from verein.lst.de ([213.95.11.211]:45436 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237681AbhDSHQi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:16:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96BDD68B05; Mon, 19 Apr 2021 09:16:05 +0200 (CEST)
Date:   Mon, 19 Apr 2021 09:16:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210419071605.GA19658@lst.de>
References: <20210416165353.3088547-1-kbusch@kernel.org> <20210416165353.3088547-2-kbusch@kernel.org> <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com> <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 17, 2021 at 02:17:35AM +0900, Keith Busch wrote:
> On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > >         if (poll)
> > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > You may need to audit other completion handlers for blk_execute_rq_nowait().
> 
> Why? Those callers already provide their own callback that directly get
> the error.
> 
> > How to get error ret from polled rq?
> 
> Please see nvme_end_sync_rq() for that driver's polled handler callback.
> It already has the error.

But it never looks at it..
