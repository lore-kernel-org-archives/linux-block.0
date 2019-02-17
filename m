Return-Path: <SRS0=s4v/=QY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB552C10F06
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCED222F0
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 15:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfBQPhd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Feb 2019 10:37:33 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57955 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbfBQPhd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Feb 2019 10:37:33 -0500
X-Originating-IP: 78.194.159.98
Received: from gandi.net (unknown [78.194.159.98])
        (Authenticated sender: thibaut@sautereau.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 29E3660004;
        Sun, 17 Feb 2019 15:37:30 +0000 (UTC)
Date:   Sun, 17 Feb 2019 16:37:29 +0100
From:   Thibaut Sautereau <thibaut@sautereau.fr>
To:     stable@vger.kernel.org
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>, m19@florianstecker.de,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix a hung issue when fsync
Message-ID: <20190217153729.GA3835@gandi.net>
References: <1548838916-25051-1-git-send-email-jianchao.w.wang@oracle.com>
 <319fffef-2fa8-afff-8f93-1ce8fd721581@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <319fffef-2fa8-afff-8f93-1ce8fd721581@kernel.dk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 30, 2019 at 08:54:09AM -0700, Jens Axboe wrote:
> On 1/30/19 2:01 AM, Jianchao Wang wrote:
> > Florian reported a io hung issue when fsync(). It should be
> > triggered by following race condition.
> > 
> > data + post flush         a flush
> > 
> > blk_flush_complete_seq
> >   case REQ_FSEQ_DATA
> >     blk_flush_queue_rq
> >     issued to driver      blk_mq_dispatch_rq_list
> >                             try to issue a flush req
> >                             failed due to NON-NCQ command
> >                             .queue_rq return BLK_STS_DEV_RESOURCE
> > 
> > request completion
> >   req->end_io // doesn't check RESTART
> >   mq_flush_data_end_io
> >     case REQ_FSEQ_POSTFLUSH
> >       blk_kick_flush
> >         do nothing because previous flush
> >         has not been completed
> >      blk_mq_run_hw_queue
> >                               insert rq to hctx->dispatch
> >                               due to RESTART is still set, do nothing
> > 
> > To fix this, replace the blk_mq_run_hw_queue in mq_flush_data_end_io
> > with blk_mq_sched_restart to check and clear the RESTART flag.
> 
> Applied, thanks.
> 
> -- 
> Jens Axboe

Can this be applied to stable kernels please?

It's commit 85bd6e61f34dffa8ec2dc75ff3c02ee7b2f1cbce upstream.

Thanks,

-- 
Thibaut
