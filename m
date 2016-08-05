Return-Path: <hch@lst.de>
Date: Fri, 5 Aug 2016 09:39:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ross Zwisler <zwisler@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, ming.lei@canonical.com,
	Mike Christie <mchristi@redhat.com>,
	Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fix loop discard regression
Message-ID: <20160805073956.GA24229@lst.de>
References: <1470319801-20594-1-git-send-email-hch@lst.de> <CAOxpaSXxmO8sB1D_03yu9H1CLeF+5iUWtRE7WLqddkqgSrCd_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOxpaSXxmO8sB1D_03yu9H1CLeF+5iUWtRE7WLqddkqgSrCd_g@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 04, 2016 at 12:55:26PM -0600, Ross Zwisler wrote:
> On Thu, Aug 4, 2016 at 8:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> > The first patch fixes a regression where discard request were accidentally
> > marked as aio after the req_op conversion.  This would have been mostly
> > harmless except for the god-awful parsing of request types later in the
> > actual I/O handler which turns them into a write, so the second patch
> > rewrites that handler using a proper switch statement as well.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-block" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Tested-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> 
> Also, your 2nd patch is missing a signed-off-by.

Signed-off-by: Christoph Hellwig <hch@lst.de>

in case that Jens wants to bother with force-updating the tree.
