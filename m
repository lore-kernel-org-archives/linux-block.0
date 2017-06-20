Return-Path: <BATV+36629bb5a09a6c0004be+5049+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 20 Jun 2017 01:57:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca,
	martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170620085739.GB31386@infradead.org>
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-5-git-send-email-axboe@kernel.dk>
 <20170619062706.GC2311@infradead.org>
 <b04642e6-4ecc-f2e8-8184-6fff302d3d0b@kernel.dk>
 <8db675e7-b868-bae1-784a-33cba67d0874@kernel.dk>
 <20170619185805.GC32047@infradead.org>
 <5259a1ba-1c5f-2d89-3b47-3a81cd0a3e4e@kernel.dk>
 <0c3c6a33-77c5-337e-66e0-49fe22d3cc4e@kernel.dk>
 <3e6f7b97-8372-b268-f55a-cc88812c1a68@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3e6f7b97-8372-b268-f55a-cc88812c1a68@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 19, 2017 at 02:33:41PM -0600, Jens Axboe wrote:
> That doesn't work, in case it's cleared, or for checking whether it has
> been set or not. Oh well, I added a NOT_SET variant for this. See below
> for an incremental that adds support for file write hints as well. Use
> the file write hint, if we have it, otherwise use the inode provided
> one.
> 
> Setting hints on a file propagates to the inode, only if the inode doesn't
> currently have a hint set.

Question:  IFF we can get the per-file hints to propagate to the
writeback code (which I think is pretty easy for ext4/xfs/bdev, not
sure about btrfs) do we even need the per-inode ones at all?
