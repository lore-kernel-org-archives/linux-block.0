Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:44167 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751936AbcIIQEc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Sep 2016 12:04:32 -0400
Message-ID: <1473437068.13672.41.camel@perches.com>
Subject: Re: [PATCH 3/5] nbd: use flags instead of bool
From: Joe Perches <joe@perches.com>
To: Jens Axboe <axboe@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mpa@pengutronix.de,
        nbd-general@lists.sourceforge.net
Date: Fri, 09 Sep 2016 09:04:28 -0700
In-Reply-To: <bda72452-8a5f-8a6a-2409-145585ea41f5@fb.com>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
         <1473369130-22986-4-git-send-email-jbacik@fb.com>
         <1473384038.13672.23.camel@perches.com>
         <bda72452-8a5f-8a6a-2409-145585ea41f5@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2016-09-09 at 07:55 -0600, Jens Axboe wrote:
> On 09/08/2016 07:20 PM, Joe Perches wrote:
> > On Thu, 2016-09-08 at 17:12 -0400, Josef Bacik wrote:
> > > In preparation for some future changes, change a few of the state bools over to
> > > normal bits to set/clear properly.
> > []
> > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > []
> > > @@ -41,8 +41,12 @@
> > >
> > >�#include <linux/nbd.h>
> > >
> > > +#define NBD_TIMEDOUT			0
> > > +#define NBD_DISCONNECT_REQUESTED	1
> > > +
> > >�struct nbd_device {
> > >�	u32 flags;
> > +	unsigned long runtime_flags;
> > Better to use DECLARE_BITMAP

> It's a few flags, we know it fits in a long. There's no point to using
> anything but that, and set/test/clear_bit().

It lets the reader know how it's used.


