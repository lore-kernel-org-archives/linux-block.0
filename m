Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B095C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E438611F2
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 17:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbhDSRsd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232748AbhDSRsc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 13:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A1C56108B;
        Mon, 19 Apr 2021 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618854482;
        bh=hxK01/A4rWtVqKpx4rBzUpeIgw//lhzxcoo2hVMsxTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Be2XZAZvwKmaAIw+F4p8L7rOmcDVKnwP2++yMyE3S72EMJK0UWgH3c1yxAxocL+G7
         9tNsd88EteuzvxuQOx3zT8PQ00dHrpMNca9nLO1SbRgGmfqwcSwrzPUHju+1aALfCI
         1zQrGFjgP4tpuKPwgdEcyxlVuhQMFa9tqmxdgTNBViD3WDhTywT20J+G590ANEVIoG
         G/Xeu32tTQhBmCZx/8s5IdJP+gqJvv/exRWB4rOfgFDbAnpfqquPAjivjErQYr8ejo
         B92IKV7Yge8cBrluo39UvECQmSUhWWrV4jm2/rJ5vkQTpcwA4u4JSmNANMXmkspWjp
         UbBYsX8lr/Fzw==
Date:   Mon, 19 Apr 2021 10:48:00 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Yuanyuan Zhong <yzhong@purestorage.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210419174800.GA3130441@dhcp-10-100-145-180.wdc.com>
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
 <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
 <20210419071605.GA19658@lst.de>
 <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com>
 <CA+AMecFXLCm3zsrfGdjT5hW4fvvgDxJxGEZvxOEA0bJT3X11wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AMecFXLCm3zsrfGdjT5hW4fvvgDxJxGEZvxOEA0bJT3X11wg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 19, 2021 at 10:27:42AM -0700, Yuanyuan Zhong wrote:
> On Mon, Apr 19, 2021 at 8:14 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Mon, Apr 19, 2021 at 09:16:05AM +0200, Christoph Hellwig wrote:
> > > On Sat, Apr 17, 2021 at 02:17:35AM +0900, Keith Busch wrote:
> > > > On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > > > > >         if (poll)
> > > > > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > > > > You may need to audit other completion handlers for blk_execute_rq_nowait().
> > > >
> > > > Why? Those callers already provide their own callback that directly get
> > > > the error.
> 
> See below clarification. I was wondering whether the way you were going to
> propose for nvme_end_sync_rq() would establish new convention for other
> blk_execute_rq_nowait() completion handlers implementation.

I'm not sure it can be turned into a common pattern. The callbacks are
implementation specific.
 
> > > >
> > > > > How to get error ret from polled rq?
> > > >
> > > > Please see nvme_end_sync_rq() for that driver's polled handler callback.
> > > > It already has the error.
> > >
> > > But it never looks at it..
> >
> > The question was how to get ret. I didn't mean to imply the example was
> > actually using it. :)
> 
> The question was how to let nvme_end_sync_rq() propagate the blk_status_t
> error to the ret for __nvme_submit_sync_cmd(). That's part of the problem
> here: __nvme_submit_sync_cmd() may return success for a command that
> failed submission.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b57157106cac..a0fb9ad132af 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -949,6 +949,9 @@ static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
 	struct completion *waiting = rq->end_io_data;
 
 	rq->end_io_data = NULL;
+	if (error && !nvme_req(rq)->status)
+		nvme_req(rq)->status = blk_status_to_errno(error);
 	complete(waiting);
 }
 
--
