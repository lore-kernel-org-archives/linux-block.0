Return-Path: <axboe@kernel.dk>
Subject: Re: fix loop discard regression
To: Christoph Hellwig <hch@lst.de>
References: <1470319801-20594-1-git-send-email-hch@lst.de>
Cc: ming.lei@canonical.com, mchristi@redhat.com, david@fromorbit.com,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <076cce77-d6ee-fc4e-8bf8-672d5c689c5e@kernel.dk>
Date: Thu, 4 Aug 2016 08:35:45 -0600
MIME-Version: 1.0
In-Reply-To: <1470319801-20594-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/04/2016 08:09 AM, Christoph Hellwig wrote:
> The first patch fixes a regression where discard request were accidentally
> marked as aio after the req_op conversion.  This would have been mostly
> harmless except for the god-awful parsing of request types later in the
> actual I/O handler which turns them into a write, so the second patch
> rewrites that handler using a proper switch statement as well.

Applied, thanks.

-- 
Jens Axboe
