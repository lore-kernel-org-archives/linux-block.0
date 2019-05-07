Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E6C04AAD
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 06:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430B42087F
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 06:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfEGGJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 02:09:22 -0400
Received: from verein.lst.de ([213.95.11.211]:57526 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfEGGJV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 May 2019 02:09:21 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5564868AFE; Tue,  7 May 2019 08:09:01 +0200 (CEST)
Date:   Tue, 7 May 2019 08:09:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 8/8] block: never take page references for ITER_BVEC
Message-ID: <20190507060900.GA27680@lst.de>
References: <20190502233332.28720-1-hch@lst.de> <20190502233332.28720-9-hch@lst.de> <20190506081952.GA24702@ming.t460p> <20190506133027.GA5810@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506133027.GA5810@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 06, 2019 at 03:30:27PM +0200, Christoph Hellwig wrote:
> On Mon, May 06, 2019 at 04:19:54PM +0800, Ming Lei wrote:
> > I remember that this way is the initial version of Jens' patch, however
> > kernel bug is triggered:
> > 
> > https://lore.kernel.org/linux-block/20190226034613.GA676@sol.localdomain/
> > 
> > Or maybe I miss some recent changes, could you explain it a bit?
> 
> I'm not even sure how the original would crash..  When I run the
> rest locally it gets and EBUSY from ioctl LOOP_SET_FD, so I'm
> not sure what it tends up testing in the end.

I also did another run with KASAN enabled and a clean environment,
this gives no EBUSY and still works fine.  I still don't understand
what the original problem might have been here, though.
