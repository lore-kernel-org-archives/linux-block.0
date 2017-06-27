Return-Path: <BATV+44f69bf97f3b7d1cdb28+5056+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 27 Jun 2017 07:52:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
	martin.petersen@oracle.com
Subject: Re: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
Message-ID: <20170627145256.GA1003@infradead.org>
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
 <1498491480-16306-2-git-send-email-axboe@kernel.dk>
 <20170627144255.GB2541@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170627144255.GB2541@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 27, 2017 at 07:42:55AM -0700, Christoph Hellwig wrote:
> The API looks ok, but the code could use some cleanups.  What do
> you think about the incremental patch below:
> 
> It refactors various manipulations, and stores the write hint right
> in the iocb as there is a 4 byte hole (this will need some minor
> adjustments in the next patches):

And looking over the followons I'd love to just store the hints
directly in the inode, bio and request themselves.  We have big
enough holes at least in the bio and request to store them, although
instead of the enum which is at least in sized we'd have to make them
an explicit u16 or even u8.
