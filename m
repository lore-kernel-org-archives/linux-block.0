Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932077AbeDYPwQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Apr 2018 11:52:16 -0400
Date: Wed, 25 Apr 2018 09:52:12 -0600
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 3/3] nvme: add a regression test for UUID ns
 descriptops
Message-ID: <20180425155211.o4bwaryvo3lo6l4i@linux-x5ow.site>
References: <20180424161251.6502-1-jthumshirn@suse.de>
 <20180424161251.6502-3-jthumshirn@suse.de>
 <20180425153036.GA30070@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180425153036.GA30070@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 25, 2018 at 08:30:36AM -0700, Omar Sandoval wrote:
[...]
> The TODO comment was leftover here, I removed it.

Oops sorry.

> > +DESCRIPTION="Test nvme and nvmet UUID NS descriptors"
> > +
> > +QUICK=1
> > +
> > +requires() {
> > +	_have_program nvme && _have_module nvme-loop && _have_module loop \
> > +	    && _have_configfs
> > +}
> > +
> > +_find_nvme_loop_dev() {
> > +	for dev in /sys/block/nvme*; do
> > +		dev="$(basename $dev)"
> 
> There's some missing quoting around "$dev" here. There's also some more
> missing quoting, `make shellcheck` will catch this sort of thing.

Thanks, I'll try to not forget running shellcheck. Maybe we should set
up travis on github to catch this?

   Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
