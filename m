Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8ADC47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 05:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33DF61263
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 05:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFHF2D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 01:28:03 -0400
Received: from verein.lst.de ([213.95.11.211]:49143 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhFHF2C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 01:28:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E9B8867373; Tue,  8 Jun 2021 07:26:07 +0200 (CEST)
Date:   Tue, 8 Jun 2021 07:26:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 4/4] nvme: use return value from blk_execute_rq()
Message-ID: <20210608052607.GB13828@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org> <20210521202145.3674904-5-kbusch@kernel.org> <20210524080428.GA24488@lst.de> <20210607165827.GC21631@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607165827.GC21631@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 08, 2021 at 01:58:27AM +0900, Keith Busch wrote:
> On Mon, May 24, 2021 at 10:04:28AM +0200, Christoph Hellwig wrote:
> > > @@ -168,7 +167,8 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
> > >  			nvmet_passthru_override_id_ns(req);
> > >  			break;
> > >  		}
> > > -	}
> > > +	} else if (status < 0)
> > > +		status = NVME_SC_INTERNAL;
> > 
> > Don't we need a better translation here?
> 
> Did you have something in mind? I couldn't think of anything more
> appropriate than the generic internal error. The errno's we get here are
> -EINTR or -EIO. Both indicate we can't communicate with the back-end
> device, but these problems are internal to the target from the host's
> perspective.

Ok.
