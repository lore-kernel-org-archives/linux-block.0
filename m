Return-Path: <BATV+a531e2bbbc8af89517f3+5043+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 14 Jun 2017 13:26:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170614202657.GB7022@infradead.org>
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-5-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497467134-6323-5-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 14, 2017 at 01:05:27PM -0600, Jens Axboe wrote:
> Add four flags for the pwritev2(2) system call, allowing an application
> to give the kernel a hint about what on-media life times can be
> expected from a given write.
> 
> The intent is for these values to be relative to each other, no
> absolute meaning should be attached to these flag names.
> 
> Define IOCB flags to carry this information over, and finally
> transform them into the block defined stream values.

Note that we also have the RWF_NOWAIT flag pending, with which this
would clash.  Maybe move it to the end of the space.
