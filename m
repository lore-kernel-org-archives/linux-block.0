Return-Path: <hch@lst.de>
Date: Wed, 9 Nov 2016 03:40:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
Message-ID: <20161109024036.GA1379@lst.de>
References: <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com> <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com> <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com> <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com> <20161109010959.GA32126@lst.de> <b3d8c5fa-b930-b21f-3986-1ff94611c7f9@wdc.com> <a6d1d368-04a2-e999-a610-abd96add81a9@fb.com> <03cda65e-3a82-6ccd-861b-67a55888eb19@kernel.dk> <98e85291-21b6-e961-dfa8-abdc6b2fbb68@wdc.com> <13243c58-167c-6535-d920-be79004e72ce@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13243c58-167c-6535-d920-be79004e72ce@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 08, 2016 at 07:38:29PM -0700, Jens Axboe wrote:
> Great, thanks for testing! So that validates the theory. I'll get
> something committed with a comment. It's not the prettiest patch, but
> it'll do for now.

Should we revert the change instead (logically, not with an actual
git revert as that would break) and require and add REQ_SYNC to
all users instead?
