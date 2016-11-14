Subject: Re: [PATCHSET] Add support for simplified async direct-io
To: Christoph Hellwig <hch@infradead.org>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
 <20161114173728.GA22167@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
Date: Mon, 14 Nov 2016 10:47:46 -0700
MIME-Version: 1.0
In-Reply-To: <20161114173728.GA22167@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/14/2016 10:37 AM, Christoph Hellwig wrote:
> On Mon, Nov 14, 2016 at 10:28:37AM -0700, Jens Axboe wrote:
>> This is on top of for-4.10/dio, which has Christophs simplified sync
>> O_DIRECT support and the IO poll bits.
>>
>> The restriction on 4 inline vecs is removed on the sync support, we
>> just allocate the bio_vec array if we have to. I realize this negates
>> parts of the win of the patch for sync, but it's still a lot leaner
>> than the old code. And it means we use the same path for any type
>> of sync O_DIRECT, instead of potentially bouncing between the two.
>>
>> Second patch is adding async support for the code base. Lightly
>> tested. Performance results, from fio:
>
> І'd much rather add a separate path pased on the same scheme.  And
> because I prefer that so much I actually did it a while ago, although
> it will need some minor updates for the current tree:
>
> 	http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/new-dio
>
> I'll see if I can get it quickly updated..

This seems less clean in basically all ways, not sure I agree with you.
We already have 4 vecs inlined in a generic bio, and we might as well
use the fs bioset instead of creating our own. You also add a smallish
dio to track things, I don't think we need that. Ditto for the ref count
- if we keep the sync and async parts separate, we don't need it.

I looked into sharing some code for the async and sync paths, but
there's really nothing to share. We can fold the alignment and account
parts if we wanted, but that's about it.

-- 
Jens Axboe
