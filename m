Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 18 Jun 2017 23:27:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170619062706.GC2311@infradead.org>
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-5-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497729594-4707-5-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jun 17, 2017 at 01:59:47PM -0600, Jens Axboe wrote:
> Add four flags for the pwritev2(2) system call, allowing an application
> to give the kernel a hint about what on-media life times can be
> expected from a given write.
> 
> The intent is for these values to be relative to each other, no
> absolute meaning should be attached to these flag names.
> 
> Set aside 3 bits in the iocb flags structure to carry this information
> over from the pwritev2 RWF_WRITE_LIFE_* flags.

What is the strong use case for the per-I/O flags?  I'd much rather
stick to fcntl only for now if we can.
