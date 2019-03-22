Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D0C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 01:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3F9218A1
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 01:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCVBFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:05:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfCVBFD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 21:05:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A12F930B96D4;
        Fri, 22 Mar 2019 01:05:03 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26248600C0;
        Fri, 22 Mar 2019 01:04:58 +0000 (UTC)
Date:   Fri, 22 Mar 2019 09:04:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH V2] blktests: add userspace IO test
Message-ID: <20190322010453.GA2913@ming.t460p>
References: <20190305015026.10751-1-ming.lei@redhat.com>
 <20190311205505.GC1315@vader>
 <20190321223626.GD20838@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321223626.GD20838@vader>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 22 Mar 2019 01:05:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 21, 2019 at 03:36:26PM -0700, Omar Sandoval wrote:
> On Mon, Mar 11, 2019 at 01:55:05PM -0700, Omar Sandoval wrote:
> > On Tue, Mar 05, 2019 at 09:50:26AM +0800, Ming Lei wrote:
> > > Add one test to cover changes on block passthrough IO interface,
> > > such as blk_rq_map_user(), blk_rq_map_user_iov(), blk_rq_unmap_user()
> > > and blk_rq_map_kern().
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  tests/block/029     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/block/029.out |   4 ++
> > >  2 files changed, 115 insertions(+)
> > >  create mode 100755 tests/block/029
> > >  create mode 100644 tests/block/029.out
> > > 
> > > diff --git a/tests/block/029 b/tests/block/029
> > > new file mode 100755
> > > index 000000000000..c7c674464285
> > > --- /dev/null
> > > +++ b/tests/block/029
> > > @@ -0,0 +1,111 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0+
> > > +# Copyright (c) 2019 Ming Lei <ming.lei@redhat.com>
> > > +#
> > > +# Test userspace IO on NVMe loop device
> > 
> > This is still missing a reference to the patch it's testing.
> > 
> > > +. tests/nvme/rc
> > 
> > Shouldn't this be in the nvme group?
> > 
> > > +DESCRIPTION="test userspace IO via nvme-cli read/write interface"
> > > +QUICK=1
> > > +
> > > +requires() {
> > > +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> > > +		_have_configfs
> > > +}
> > > +
> > > +__test_user_io()
> > > +{
> > > +	local disk="$1"
> > > +	local start=$2
> > > +	local cnt=$3
> > > +
> > > +	local bs=$(blockdev --getss $disk)
> > 
> > This still has a ton of missing quoting and shellcheck errors.
> > 
> > I fixed all of this and pushed to
> > https://github.com/osandov/blktests/tree/user-io. Let me know if this
> > looks fine and I'll push it to master.

Yeah, it is fine for me.

Thanks,
Ming
