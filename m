Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34076 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755577AbeDYP6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Apr 2018 11:58:42 -0400
Received: by mail-pf0-f175.google.com with SMTP id a14so5091542pfi.1
        for <linux-block@vger.kernel.org>; Wed, 25 Apr 2018 08:58:42 -0700 (PDT)
Date: Wed, 25 Apr 2018 08:58:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 3/3] nvme: add a regression test for UUID ns
 descriptops
Message-ID: <20180425155839.GC30070@vader>
References: <20180424161251.6502-1-jthumshirn@suse.de>
 <20180424161251.6502-3-jthumshirn@suse.de>
 <20180425153036.GA30070@vader>
 <20180425155211.o4bwaryvo3lo6l4i@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180425155211.o4bwaryvo3lo6l4i@linux-x5ow.site>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 25, 2018 at 09:52:12AM -0600, Johannes Thumshirn wrote:
> On Wed, Apr 25, 2018 at 08:30:36AM -0700, Omar Sandoval wrote:
> [...]
> > The TODO comment was leftover here, I removed it.
> 
> Oops sorry.

I should probably rename it `make check` and have it check for leftover
TODO comments as well.

> > > +DESCRIPTION="Test nvme and nvmet UUID NS descriptors"
> > > +
> > > +QUICK=1
> > > +
> > > +requires() {
> > > +	_have_program nvme && _have_module nvme-loop && _have_module loop \
> > > +	    && _have_configfs
> > > +}
> > > +
> > > +_find_nvme_loop_dev() {
> > > +	for dev in /sys/block/nvme*; do
> > > +		dev="$(basename $dev)"
> > 
> > There's some missing quoting around "$dev" here. There's also some more
> > missing quoting, `make shellcheck` will catch this sort of thing.
> 
> Thanks, I'll try to not forget running shellcheck. Maybe we should set
> up travis on github to catch this?

Good idea. I need to clean up some other errors that have snuck in.
