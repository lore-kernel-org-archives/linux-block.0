Return-Path: <axboe@kernel.dk>
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Christoph Hellwig <hch@lst.de>
References: <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com>
 <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
 <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
 <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com>
 <20161109010959.GA32126@lst.de>
 <b3d8c5fa-b930-b21f-3986-1ff94611c7f9@wdc.com>
 <a6d1d368-04a2-e999-a610-abd96add81a9@fb.com>
 <03cda65e-3a82-6ccd-861b-67a55888eb19@kernel.dk>
 <98e85291-21b6-e961-dfa8-abdc6b2fbb68@wdc.com>
 <13243c58-167c-6535-d920-be79004e72ce@kernel.dk>
 <20161109024036.GA1379@lst.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 Mike Snitzer <snitzer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f1a21c70-8161-7e2a-5945-5305637fde8e@kernel.dk>
Date: Tue, 8 Nov 2016 19:45:08 -0700
MIME-Version: 1.0
In-Reply-To: <20161109024036.GA1379@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 07:40 PM, Christoph Hellwig wrote:
> On Tue, Nov 08, 2016 at 07:38:29PM -0700, Jens Axboe wrote:
>> Great, thanks for testing! So that validates the theory. I'll get
>> something committed with a comment. It's not the prettiest patch, but
>> it'll do for now.
>
> Should we revert the change instead (logically, not with an actual
> git revert as that would break) and require and add REQ_SYNC to
> all users instead?

I just committed the work-around. But yes, let's have a logical revert
and require that REQ_SYNC be set for REQ_FUA|REQ_PREFLUSH to avoid it
being this fragile.

-- 
Jens Axboe
