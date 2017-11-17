Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <64E6F87F-FEF8-46D2-B7FA-4626EE3EA14E@linaro.org>
References: <82ee3a59-1767-3073-7893-bf78b5933c5e@kernel.dk>
 <CA+55aFy34p7YAtts5e0Uxt5drKws8QHw5nPDoBi64YX2xXnLrw@mail.gmail.com> <64E6F87F-FEF8-46D2-B7FA-4626EE3EA14E@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 Nov 2017 12:34:11 -0800
Message-ID: <CA+55aFyo0Md9G5xF40jLL8DwjBHCaxPn628xUEVG=yr3d6YBUg@mail.gmail.com>
Subject: Re: [GIT PULL] Followup merge window block fixes/changes
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Luca Miccio <lucmiccio@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 17, 2017 at 12:18 PM, Paolo Valente
<paolo.valente@linaro.org> wrote:
>
> Sorry for causing this problem.  Yours was our first version, but then
> we feared that leaving useless instructions was worse than adding a
> burst of ifdefs. I'll try not to repeat this mistake.

So I generally do not want people to depend on the compiler to do
non-obvious conversions (so please do not write bad code that you just
hope the compiler can sort out and make reasonable), but we do heavily
rely on the compiler doing the obvious dead code removal particularly
for when things end up not being used.

A lot of the time that's very much something you can and should depend
on, because we have abstraction layers that involves a lot of code
just becoming no-ops on many architectures, but other architectures
need some particular sequence.

Another example is a lot of helper functions to do verification of
various kernel rules that then are enabled by some debug option (eg
CONFIG_DEBUG_ATOMIC_SLEEP etc), where we know that (and depend on)
the compiler will do a reasonable job.

That's not so different from having "statistics gathering function
that compiles to nothing".

And yes, sometimes the code might need to be written so that the
compiler has an easier time _seeing_ that the core really goes away,
so it's not necessarily a blind trust in the compiler.

So for example,  the functions that can go away should obviously be
inline functions so that you don't end up having the compiler generate
the arguments and the call to an empty function body, and so that the
compiler can see that "oh, those arguments aren't even used at all, so
now I can remove all the code that generates them".

If you are comfy with assembler, it can actually be a great thing to
occasionally just verify the actual generated code if it's some piece
of code you care deeply about. Obviously for performance work,
profiling happens, and then you see it that way.

Because sometimes you find some silly "Duh!" moments, where you didn't
realize that the compiler wasn't able to really get rid of something
for some reason that is usually very obvious in hindsight, but wasn't
actually obvious at all until you looked at what the compiler
generated.

                   Linus
