Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E670C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 09:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506382145D
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 09:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgDTJwW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:52:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTJwW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 05:52:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1EF9AACA2;
        Mon, 20 Apr 2020 09:52:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF6091E126F; Mon, 20 Apr 2020 11:52:18 +0200 (CEST)
Date:   Mon, 20 Apr 2020 11:52:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200420095218.GB17130@quack2.suse.cz>
References: <20200416165453.1080463-1-hch@lst.de>
 <20200416165453.1080463-4-hch@lst.de>
 <20200417085909.GA12234@quack2.suse.cz>
 <70f001cd-eaec-874f-9742-c44e66368a2a@acm.org>
 <20200419075809.GA12222@lst.de>
 <a37e947d-c49a-837e-e97d-647ca9d378c3@acm.org>
 <20200419160651.GA18308@lst.de>
 <20200420074801.GA30795@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420074801.GA30795@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 20-04-20 09:48:01, Christoph Hellwig wrote:
> On Sun, Apr 19, 2020 at 06:06:51PM +0200, Christoph Hellwig wrote:
> > > (https://lore.kernel.org/linux-block/20200416071519.807660-4-hch@lst.de/) 
> > > and also to the replies to that patch? This is what I found in the replies: 
> > > "When driver try to to re-register bdi but without release_bdi(), the old 
> > > dev_name will be cover directly by the newer in bdi_register_va(). So, I am 
> > > not sure whether it can cause memory leak for bdi->dev_name."
> > >
> > > Has it been considered to avoid that leak by freeing bdi->dev_name from 
> > > unregister_bdi(), e.g. as follows?
> > 
> > We'd need some protection against concurrent accesses as unregister_bdi
> > can race with them.  But with RCU that could be handled, so let me try
> > that.
> 
> I looked into it, and while it seems doable I think this goes in the
> wrong direction as it pushed the RCU knowledge into the callers.  I'd
> rather get something like this series in ASAP, and then for 5.8 or 5.9
> move the bdi pointer to the gendisk and stop re-registering it and thus
> solve the problems root cause for real.

Yeah, if it could be done it would be a nice solution. Because
re-registering of BDIs is a long-term source of troubles...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
