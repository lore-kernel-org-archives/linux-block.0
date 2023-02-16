Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0307FC636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 09:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBPJDs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 04:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBPJDr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 04:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A68EF95
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 01:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676538180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbyxAm5//S8A+8lL3KxfVIyNpRZugoKBKmpVGRzmu8U=;
        b=czCKueAQ15l9TTLAQpEfApsh/AafaNHM7CuVxoFPYM8NHn0pGz0HU8ElVSl6SlDvhFpAhO
        O92vfMF3okBLuXO9/OobWrueTWYzYxc5MwDzvkPvDaaohkR9mJgEPLxQe0rhK48x/e7ifw
        S3/PRPIJL5EATwd4c2aTexFrsvEUZTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-IsfjFc5lPkSffRaodNR0oQ-1; Thu, 16 Feb 2023 04:02:56 -0500
X-MC-Unique: IsfjFc5lPkSffRaodNR0oQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3AAC85CCE0;
        Thu, 16 Feb 2023 09:02:56 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16DCE492B0E;
        Thu, 16 Feb 2023 09:02:53 +0000 (UTC)
Date:   Thu, 16 Feb 2023 17:02:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] blktests/033: add test to cover gendisk leak
Message-ID: <Y+3xN1vuhwQNyfiv@T590>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
 <20230216030134.1368607-3-ming.lei@redhat.com>
 <20230216082929.j4wgi27cu2rtkp5a@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216082929.j4wgi27cu2rtkp5a@shindev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16, 2023 at 08:29:29AM +0000, Shinichiro Kawasaki wrote:
> 
> 
> 
> I suggest the commit title:
> 
>     block/033: add test to cover gendisk leak

OK.

> 
> On Feb 16, 2023 / 11:01, Ming Lei wrote:
> > So far only sync ublk removal is supported, and the device's
> > last reference is dropped in gendisk's ->free_disk(), so it
> > can be used to test gendisk leak issue.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  common/ublk         | 32 ++++++++++++++++++++++++++++++++
> >  tests/block/033     | 33 +++++++++++++++++++++++++++++++++
> >  tests/block/033.out |  2 ++
> >  3 files changed, 67 insertions(+)
> >  create mode 100644 common/ublk
> >  create mode 100755 tests/block/033
> >  create mode 100644 tests/block/033.out
> > 
> > diff --git a/common/ublk b/common/ublk
> > new file mode 100644
> > index 0000000..66b3a58
> > --- /dev/null
> > +++ b/common/ublk
> > @@ -0,0 +1,32 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2023 Ming Lei
> > +#
> > +# null_blk helper functions.
> 
> I think you meant s/null_blk/ublk/

Sure, :-)

> 
> > +
> > +. common/shellcheck
> > +
> > +_have_ublk() {
> > +	_have_driver ublk_drv
> 
> The _init_ublk() below looks assuming the ublk_drv modules is loadable. If so,
> the live above should be:
> 
>     _have_module ublk_drv

OK

> 
> Of note is that some of the blkteste users run tests with all drivers as
> built-in modules. So it is the better that the new test case can run with
> built-in ublk_drv, if possible. (Or it can be a left work.)

The test doesn't care if it is builtin or module, and I think the choice
should be in hand of user.


Thanks, 
Ming

