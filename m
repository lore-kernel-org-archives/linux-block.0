Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF81BC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 01:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B0F208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 01:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B0F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeK0Mmt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:42:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeK0Mmt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 07:42:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F2A4307DAB6;
        Tue, 27 Nov 2018 01:46:40 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FC065C8B3;
        Tue, 27 Nov 2018 01:46:33 +0000 (UTC)
Date:   Tue, 27 Nov 2018 09:46:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block/025: test discard sector alignement and sector
 size overflow
Message-ID: <20181127014628.GA25199@ming.t460p>
References: <20181115040017.4920-1-ming.lei@redhat.com>
 <20181127003310.GA846@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127003310.GA846@vader>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 27 Nov 2018 01:46:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 04:33:10PM -0800, Omar Sandoval wrote:
> On Thu, Nov 15, 2018 at 12:00:17PM +0800, Ming Lei wrote:
> > This test covers the following two issues:
> > 
> > 1) discard sector need to be aligned with logical block size
> > 
> > 2) make sure 'sector_t' instead of 'unsigned int' is used when comparing
> > with discard sector size
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tests/block/025     | 37 +++++++++++++++++++++++++++++++++++++
> >  tests/block/025.out |  2 ++
> >  2 files changed, 39 insertions(+)
> >  create mode 100755 tests/block/025
> >  create mode 100644 tests/block/025.out
> > 
> > diff --git a/tests/block/025 b/tests/block/025
> > new file mode 100755
> > index 000000000000..32b632431793
> > --- /dev/null
> > +++ b/tests/block/025
> > @@ -0,0 +1,37 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2018 Ming Lei <ming.lei@redhat.com>
> > +#
> > +# Check two corener cases of BLKDISCARD.
> > +#
> > +# 1) test if discard bio's sector is algined with logical size, fixed by
> > +#    1adfc5e4136f ("block: make sure discard bio is aligned with logical block size")
> 
> Hm, I'm not seeing how this test case tests this commit. Aren't 2049G
> and 512M both aligned to 4096 bytes?

2049G caused 32bit 'nr_sects' in __blkdev_issue_discard() overflow,
please see commit 4800bf7bc8c725e955fcb ("block: fix 32 bit overflow in __blkdev_issue_discard()").

4096 logical block size may trigger 'req_sects' un-alignment issue
because 'nr_sects' from fs is 512byte aligned, please see 1adfc5e4136f5967d59 ("block:
make sure discard bio is aligned with logical block size").

Thanks,
Ming
