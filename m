Return-Path: <axboe@kernel.dk>
Subject: Re: limits->max_sectors is getting set to 0, why/where? [was: Re: dm:
 kernel oops by divide error on v4.16+]
To: Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 dm-devel@redhat.com, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>
References: <20180408040005.GA19128@ming.t460p>
 <20180409155120.GA10990@redhat.com> <20180409183836.GA11256@redhat.com>
 <db4499d6-05b8-73f3-76d0-a91af91430b0@kernel.dk>
 <70f1d349-f091-19a2-9ec6-978ac1e7dda0@kernel.dk>
 <78732cb7-3666-e1b0-e6d3-2a3409a0d4ca@kernel.dk>
 <CAGXu5j+81yUffU4=7h4goQYx_pWwvv6wtwrLy4sx6H=AGmK3ZQ@mail.gmail.com>
 <ddc93069-1ccd-d867-6c8d-6fd429bc2080@kernel.dk>
 <20180409222716.GA6450@ming.t460p>
 <911ff78b-5b60-e05c-de88-8077d502290a@kernel.dk>
 <CAGXu5jJD0b15a2yBUEiTT=Kjy2cLTVWCqhsnVZu5aKf-ieyZ+A@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <24e7093b-ba3a-9f0d-4c5b-572862a6c622@kernel.dk>
Date: Mon, 9 Apr 2018 17:01:34 -0600
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJD0b15a2yBUEiTT=Kjy2cLTVWCqhsnVZu5aKf-ieyZ+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/9/18 4:38 PM, Kees Cook wrote:
> On Mon, Apr 9, 2018 at 3:32 PM, Jens Axboe <axboe@kernel.dk> wrote:
>> That's bad, for sure, but my worry was bigger than an oops or crash,
>> we could have had corruption due to this.
>>
>> The resulting min/max and friends would have been trivial to test, but
>> clearly they weren't.
> 
> Yeah, that was bad luck and my fault: I tested min(), max(), min_t(),

It's only bad luck if it was tested :-)

> and max_t(). My assumption was that since the others were built from
> them, they'd be fine. Not true in this shadow variable case, though.
> :(  We could do something like this, which would have caught it:

Might not hurt to do.

-- 
Jens Axboe
