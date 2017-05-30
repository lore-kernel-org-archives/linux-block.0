Return-Path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <20170528074952.GA22193@infradead.org>
References: <20170526212237.103525-1-mka@chromium.org> <20170526212237.103525-2-mka@chromium.org>
 <20170528074952.GA22193@infradead.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 May 2017 09:28:17 -0700
Message-ID: <CAD=FV=VCdvZZEBvqnre4r0QxM0N545QVQ2sYngyxf+5R1jM6LA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cfq-iosched: Mark cfq_clear_cfqq_*() as __maybe_unused
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Christoph,

On Sun, May 28, 2017 at 12:49 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, May 26, 2017 at 02:22:35PM -0700, Matthias Kaehlcke wrote:
>> This fixes the following warning when building with clang:
>>
>>     block/cfq-iosched.c:449:1: error: unused function 'cfq_clear_cfqq_sync'
>>         [-Werror,-Wunused-function]
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>
> Matthias, can you please stop sending these patches?  Gcc semantics
> correctly are that static inlines can be unused and it's perfectly
> fine.  It's your job to make clang fit that instead of spreading garbage
> all over the kernel.

I think we've been having discussions about this in many different
scattered threads.  A quick summary here is:

* clang only warns about unused static inline functions if those
functions are in ".c" files.  That basically means there aren't nearly
as many false positives of the check as you would think.

* Matthias has found several instances of dead code with his work.
It's nice to get rid of those.  In addition, in at least one example
his work has actually identified code that was not dead (AKA actual
instructions were generated) but the code was clearly not correct.
That's because there was a "static inline" save and restore function.
The save was called but not the restore.  This points to either a bug
(should have called the restore) or code that should be eliminated.
https://patchwork.kernel.org/patch/9750813/

* Most compiler warnings generate a bit of "noise".  It's always a
judgement call about whether the signal to noise ratio makes the
warning useful.  This is a tough call, but IMHO the signal to noise
ratio for the clang behavior makes it worth it.  The number of "maybe
unused" patches is not that great and IMHO adding the attribute is
also documenting the function, which is useful too.

* There exists a patch to make clang behave like gcc.
https://patchwork.kernel.org/patch/9746913/.  If folks truly believe
that the noise is not worth it, we can apply that.


I just talked to Matthias and he is going to try to start a thread to
get hopefully get a general policy agreed upon before continuing to
post patches.


-Doug
