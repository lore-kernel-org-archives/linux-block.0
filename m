Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:45072 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdI0RgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Sep 2017 13:36:03 -0400
Received: by mail-it0-f65.google.com with SMTP id x15so8181130itb.0
        for <linux-block@vger.kernel.org>; Wed, 27 Sep 2017 10:36:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a530c31b-93ed-c00f-ebf6-8c229740b7be@kernel.dk>
References: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
 <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com>
 <20170924130304.GA21904@infradead.org> <CA+55aFx3Pxw+cqRCJY9TmnCCePhKY-x0A74SJ=QvG7nHNV19xw@mail.gmail.com>
 <ab2cab66-4d47-23d0-78f8-ef8450ab4b5b@kernel.dk> <CA+55aFzmyHRXu+zUBdWr3a9Xt_WoJp9OCzV5u6BZoRHKSKdbEQ@mail.gmail.com>
 <2856cdcf-a639-c2c9-5efe-7159fc574467@kernel.dk> <CA+55aFzyMoTV5Be1xQeOkgW7PwSu0j=dZFiQ_rDQp7FaQY44-w@mail.gmail.com>
 <7a7a141e-b756-72f9-ece6-1dc229267068@fb.com> <CA+55aFwfQkksqSC9UiUE2g-nGKi+=MoYtE3oh3Fxx=b_zKK_AA@mail.gmail.com>
 <a530c31b-93ed-c00f-ebf6-8c229740b7be@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Sep 2017 10:36:02 -0700
Message-ID: <CA+55aFzXueAygL0LNqwHvN7CSBpWQofYwLu1xivw_dKD1STPNw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 27, 2017 at 5:41 AM, Jens Axboe <axboe@kernel.dk> wrote:
>
> So I reworked the series, to include three prep patches that end up
> killing off free_more_memory(). This means that we don't have to do the
> 1024 -> 0 change in there. On top of that, I added a separate bit to
> manage range cyclic vs non range cyclic flush all work. This means that
> we don't have to worry about the laptop case either.
>
> I think that should quell any of the concerns in the patchset, you can
> find the new series here:
>
> http://git.kernel.dk/cgit/linux-block/log/?h=wb-start-all

Yeah, this I feel more confident about.

It still has some subtle changes (nr_pages is slightly different for
laptop mode, and the whole "we rely on the VM to not return NULL") but
I cannot for the life of me imagine that those changes are noticeable
or meaningful.

So now that last commit that limits the pending flushes is the only
one that seems to matter, and the one you wanted to build up to. It's
not a subtle change, but that's the one that fixes the actual bug you
see, so now the rest of the series really looks like "prep-work for
the bug fix".

Of course, with the change to support range_cycling for the laptop
mode case, there's actually possibly _two_ pending full flushes (the
range-cyclic and the "all" one), so that last changelog may not be
entirely accurate.

Long-term, I would prefer to maybe make the "range_whole" case to
always be range-cyclic, because I suspect that's the better behavior,
but I think that series is the one that changes existing semantics the
least for the existing cases, so I think your approach is better for
now.

As far as I can tell, the cases that do not set range_cyclic right now are:

 - wakeup_flusher_threads()

 - sync_inodes_sb()

and in neither case does that lack of range_cyclic really seem to make
any sense.

It might be a purely historical artifact (an _old_ one: that
range_cyclic logic goes back to 2006, as far as I can tell).

But there might also be something I'm missing.

Anyway, your series looks fine to me.

              Linus
