Return-Path: <ming.lei@redhat.com>
Date: Wed, 23 May 2018 08:37:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/020: test IO req allocation
Message-ID: <20180523003750.GD31196@ming.t460p>
References: <20180522111249.14136-1-ming.lei@redhat.com>
 <20180523000154.GI9536@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523000154.GI9536@vader>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 05:01:54PM -0700, Omar Sandoval wrote:
> On Tue, May 22, 2018 at 07:12:49PM +0800, Ming Lei wrote:
> > IO request allocation may hang for ever if the allocation process
> > migrages. This test covers the request allocation code path.
> > 
> > The following patch can fix this issue on linus kernel:
> > 
> > https://marc.info/?l=linux-block&m=152671586923185&w=2
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tests/block/020     | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/block/020.out |  2 ++
> >  2 files changed, 52 insertions(+)
> >  create mode 100755 tests/block/020
> >  create mode 100755 tests/block/020.out
> > 
> > diff --git a/tests/block/020 b/tests/block/020
> > new file mode 100755
> > index 000000000000..b102d7f12173
> > --- /dev/null
> > +++ b/tests/block/020
> > @@ -0,0 +1,50 @@
> > +#!/bin/bash
> > +#
> > +# Test blk-mq IO request allocation.
> 
> This isn't very descriptive. How about
> 
> Test blk-mq request allocation when hardware tags are limited.

It is fine, except the issue isn't limited to small hw queue tags,
and it might be triggered on NVMe if there are huge IO processes.

> 
> Additionally, for regression tests for specific patches, please
> reference what patch it is testing. In this case, it'd be
> 
> Regression test for patch "blk-mq: avoid to starve tag allocation after
> allocation process migrates".

OK.

> 
> > +# Copyright (C) 2018 Ming Lei <ming.lei@redhat.com>
> > +#
> > +# This program is free software: you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation, either version 3 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > +
> > +DESCRIPTION="check if IO req allocation may hang"
> 
> A better description would say what this test actually does. In this
> case, something like
> 
> DESCRIPTION="run null-blk on different schedulers with only one hardware tag"
> 
> I can fix this and apply when the discussion on the patch itself
> settles. Thanks, Ming!

OK, thanks!

Thanks,
Ming
