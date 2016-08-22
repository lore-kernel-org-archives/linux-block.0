Return-Path: <ming.lei@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20160821175844.byt3lejy7mu5sohc@kmo-pixel>
References: <1471273882-3938-1-git-send-email-ming.lei@canonical.com>
 <20160815182328.GA13886@infradead.org> <20160815191253.cxbjui3mymrkpkz6@kmo-pixel>
 <alpine.LRH.2.11.1608181733110.10662@mail.ewheeler.net> <CACVXFVMDod01eDYxvd8_LXmXaNusz2gsQRywdNgi=Z+nJzzjTA@mail.gmail.com>
 <20160821175844.byt3lejy7mu5sohc@kmo-pixel>
From: Ming Lei <ming.lei@canonical.com>
Date: Mon, 22 Aug 2016 16:57:42 +0800
Message-ID: <CACVXFVM+RbD47dKsLo-J+aHkkfGjHOmNc03bESnh5H4VOFHgWw@mail.gmail.com>
Subject: Re: [PATCH v3] block: make sure big bio is splitted into at most 256 bvecs
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Eric Wheeler <bcache@lists.ewheeler.net>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@fb.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Sebastian Roesner <sroesner-kernelorg@roesner-online.de>, "4.3+" <stable@vger.kernel.org>,
	Shaohua Li <shli@fb.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 22, 2016 at 1:58 AM, Kent Overstreet
<kent.overstreet@gmail.com> wrote:
> On Sun, Aug 21, 2016 at 05:31:33PM +0800, Ming Lei wrote:
>> This patch is definitely correct, and I don't see dealing with 'no_merge'
>> should be removed.
>>
>> In this case, the bio is still possible to merge with others because
>> it doesn't violate any limit of the queue because it just can't be held in
>> 256 bvecs, that means it is correct to clear no_merge for this situation.
>>
>> Also I don't think it is complicated or ugly to deal with the flag.
>
> It's extra unnecessary code. All other things being equal, less code is always
> better than more code. It works just fine without it, what's the justification
> for adding the flag?

>From rationality view, the 'no_merge' flag need to be cleared because
it doesn't violate any queue's limit and should be allowed to merge, and
actually it is possible to submit all these splitted bios into hardware via
one request, that is different with other splitting cases.

Given you introduced support of arbitrarily sized bios in commit 54efd50bf
(block:make generic_make_request handle arbitrarily sized bios), other
drivers/fs might use this to simplify bio submission too in the future.

>
> Don't be so dismissive of other maintainer's concerns, we've got to deal with
> this code too. Especially when I and Christoph are agreeing on something - how
> often does that happen?

OK, I will submit a V4 and comment on not merging just for simplicity resaon.


Thanks,
Ming
