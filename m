Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 02/11] blk: make the bioset rescue_workqueue optional.
To: NeilBrown <neilb@suse.com>, Christoph Hellwig <hch@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672858.27388.11409778158413625707.stgit@noble>
 <20170421112458.GB12523@infradead.org>
 <87h91er2t6.fsf@notabene.neil.brown.name>
 <20170424151013.GA17867@infradead.org>
 <87tw55qigs.fsf@notabene.neil.brown.name>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <583a23d7-3d5f-e280-6ef4-a7fec84359e2@kernel.dk>
Date: Mon, 1 May 2017 08:02:13 -0600
MIME-Version: 1.0
In-Reply-To: <87tw55qigs.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/30/2017 11:00 PM, NeilBrown wrote:
> On Mon, Apr 24 2017, Christoph Hellwig wrote:
> 
>> On Mon, Apr 24, 2017 at 11:51:01AM +1000, NeilBrown wrote:
>>>
>>> I was following the existing practice exemplified by
>>> bioset_create_nobvec().
>>
>> Which is pretty ugly to start with..
> 
> That is a matter of personal taste.
> As such, it is up to the maintainer to change it if they want it
> changed.
> 
>>
>>> By not changing the signature of the function, I can avoid touching
>>> quite a few places where it is called.
>>
>> There are 13 callers of bioset_create and one caller of
>> bioset_create_nobvec, and your series touches many of those.
>>
>> So just adding a flags argument to bioset_create and passing
>> BIOSET_NEED_BVECS and BIOSET_NEED_RESUER flags to it doesn't seem
>> to much of an effort, and it's going to create a much nicer and easier
>> to extend interface.
> 
> If someone else submitted a patch to discard bioset_create_nobvec in
> favour of BIOSET_NEED_BVECS and got it accepted, then I would rebase my
> series on that.  As it is, I'm basing my patches on the style currently
> present in the tree.
> 
> Of course, if Jens says he'll only take my patches if I change to style
> to match your preference, I'll do that.

I generally tend to prefer tree wide cleanups to improve our APIs, even
if it does cause an extra bit of pain. Would you mind doing that as a
prep patch?

-- 
Jens Axboe
