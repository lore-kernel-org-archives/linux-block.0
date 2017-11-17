Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Followup merge window block fixes/changes
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Luca Miccio <lucmiccio@gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <82ee3a59-1767-3073-7893-bf78b5933c5e@kernel.dk>
 <CA+55aFy34p7YAtts5e0Uxt5drKws8QHw5nPDoBi64YX2xXnLrw@mail.gmail.com>
 <CA+55aFxeRBHhTyKTHPYGAz3+bUv-ObLNwMLtqRV-cftuDhLxZA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0f58f74a-705c-ce6b-2ef1-e3a267a03b7c@kernel.dk>
Date: Fri, 17 Nov 2017 14:26:10 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFxeRBHhTyKTHPYGAz3+bUv-ObLNwMLtqRV-cftuDhLxZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/17/2017 12:35 PM, Linus Torvalds wrote:
> On Fri, Nov 17, 2017 at 11:29 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> "F*ck no, that code is too ugly, you need to write it so that it can
>> be maintained".
> 
> Dammit, the rest of the pull looks ok, so I'll take it anyway.
> 
> But I really do expect you to
> 
>  (a) clean up that mess - maybe with my patch as an example, but maybe
> some entirely different way. The patch I sent is already deleted from
> my tree, it was purely meant as an example.
> 
>  (b) really push back on people when they send you ugly code
> 
> It shouldn't have to always be me being upset and pushing back on the
> block pulls.

My bad, I have probably given Paolo and Luca a bit more leeway than
usual, since they are new to upstream development and the BFQ code does
need some cleanups here and there. A huge part of that was completed as
part of getting it merged, but it still needs a bit of love.

Now that they have received the Linus hazing, I guess the honey moon is
over.

In all seriousness, I do push back on crap quite often. Sometimes I miss
some too...

-- 
Jens Axboe
