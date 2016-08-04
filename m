Return-Path: <zwisler@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1470319801-20594-1-git-send-email-hch@lst.de>
References: <1470319801-20594-1-git-send-email-hch@lst.de>
From: Ross Zwisler <zwisler@gmail.com>
Date: Thu, 4 Aug 2016 12:55:26 -0600
Message-ID: <CAOxpaSXxmO8sB1D_03yu9H1CLeF+5iUWtRE7WLqddkqgSrCd_g@mail.gmail.com>
Subject: Re: fix loop discard regression
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, ming.lei@canonical.com,
	Mike Christie <mchristi@redhat.com>, Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 4, 2016 at 8:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> The first patch fixes a regression where discard request were accidentally
> marked as aio after the req_op conversion.  This would have been mostly
> harmless except for the god-awful parsing of request types later in the
> actual I/O handler which turns them into a write, so the second patch
> rewrites that handler using a proper switch statement as well.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Tested-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Also, your 2nd patch is missing a signed-off-by.
