Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [GIT PULL] Followup merge window block fixes/changes
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CA+55aFy34p7YAtts5e0Uxt5drKws8QHw5nPDoBi64YX2xXnLrw@mail.gmail.com>
Date: Fri, 17 Nov 2017 21:18:05 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 Luca Miccio <lucmiccio@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <64E6F87F-FEF8-46D2-B7FA-4626EE3EA14E@linaro.org>
References: <82ee3a59-1767-3073-7893-bf78b5933c5e@kernel.dk> <CA+55aFy34p7YAtts5e0Uxt5drKws8QHw5nPDoBi64YX2xXnLrw@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 17 nov 2017, alle ore 20:29, Linus Torvalds =
<torvalds@linux-foundation.org> ha scritto:
>=20
> On Fri, Nov 17, 2017 at 8:51 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>=20
>> - Small BFQ updates series from Luca and Paolo.
>=20
> Honestly, this code is too ugly to live.
>=20
> Seriously. That update should have been rejected on the grounds of
> being completely unmaintainable crap.
>=20
> Why didn't you?
>=20
> Why are you allowing code like that patch to bfq_dispatch_request()
> into the kernel source tree?
>=20
> Yes, it improves performance. But it does so by adding random
> #iofdef's into the middle of some pretty crtitical code, with
> absolutely no attempt at having a sane maintainable code-base.
>=20
> That function is literally *three* lines of code without the #ifdef =
case:
>=20
>        spin_lock_irq(&bfqd->lock);
>        rq =3D __bfq_dispatch_request(hctx);
>        spin_unlock_irq(&bfqd->lock);
>=20
> and you could actually see what it did.
>=20
> But instead of trying to abstract it in some legible manner, that
> three-line obvious function got *three* copies of the same #if mess
> all enclosing rancom crap, and the end result is really hard to read.
>=20
> For example, I just spent a couple of minutes trying to make sense of
> the code, and stop that unreadable mess.  I came up with the appended
> patch.
>=20
> It may not work for some reason I can't see, but that's not the point.
> The attached patch is not meant as a "apply this as-is".
>=20
> It's meant as a "look, you can write legible code where the statistics
> just go away when they are compiled out".
>=20
> Now that "obvious three-liner function" is not three lines any more,
> but it's at least *clear* straight-line code:
>=20
>        spin_lock_irq(&bfqd->lock);
>=20
>        in_serv_queue =3D bfqd->in_service_queue;
>        waiting_rq =3D in_serv_queue && =
bfq_bfqq_wait_request(in_serv_queue);
>=20
>        rq =3D __bfq_dispatch_request(hctx);
>=20
>        idle_timer_disabled =3D
>                waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
>=20
>        spin_unlock_irq(&bfqd->lock);
>=20
>        bfq_dispatch_statistics(hctx, rq, in_serv_queue, waiting_rq,
> idle_timer_disabled);
>=20
> and I am  hopeful that when bfq_dispatch_statistics() is disabled, the
> compiler will be smart enough to not generate extra code, certainly
> not noticeably so.
>=20

Sorry for causing this problem.  Yours was our first version, but then
we feared that leaving useless instructions was worse than adding a
burst of ifdefs. I'll try not to repeat this mistake.

Thanks,
Paolo

> See? One is a mess of horrible ugly #ifdef's in the middle of the code
> that makes the end result completely illegible.
>=20
> The other is actually somewhat legible, and has a clear separation of
> the statistics gathering. And that *statistics* gathering is clearly
> optionally enabled or not.
>=20
> Not the mess of random code put together in random ways that are
> completely illegble.
>=20
> Your job as maintainer is _literally_ to tell people "f*ck no, that
> code is too ugly, you need to write it so that it can be maintained".
>=20
> And I'm doing my job.
>=20
> "F*ck no, that code is too ugly, you need to write it so that it can
> be maintained".
>=20
> Show some taste.
>=20
>                Linus
> <patch.diff>
