Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 19 Jun 2017 11:58:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca,
	martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170619185805.GC32047@infradead.org>
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-5-git-send-email-axboe@kernel.dk>
 <20170619062706.GC2311@infradead.org>
 <b04642e6-4ecc-f2e8-8184-6fff302d3d0b@kernel.dk>
 <8db675e7-b868-bae1-784a-33cba67d0874@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <8db675e7-b868-bae1-784a-33cba67d0874@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 19, 2017 at 10:02:09AM -0600, Jens Axboe wrote:
> Actually, one good use case is O_DIRECT on a block device. Since I'm
> not a huge fan of having per-call hints that is only useful for a
> single case, how about we add the hints to the struct file as well?
> For buffered IO, just grab it from the inode. If we have a file
> available, then that overrides the per-inode setting.

Even for buffered I/O per-fіle would seem more useful to be honest.
For the buffer_head based file systems this could even be done fairly
easily.
