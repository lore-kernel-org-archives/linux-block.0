Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:36432 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753640AbdIGTEb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2017 15:04:31 -0400
Received: by mail-it0-f54.google.com with SMTP id 6so1308482itl.1
        for <linux-block@vger.kernel.org>; Thu, 07 Sep 2017 12:04:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c1aab1af-4dba-b324-0972-c3933816ecc8@kernel.dk>
References: <c1aab1af-4dba-b324-0972-c3933816ecc8@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Sep 2017 12:04:30 -0700
Message-ID: <CA+55aFwrpd+fz3jxK3d6dckFcApc=aCZOrsKogxRYZozwUdHrg@mail.gmail.com>
Subject: Re: [GIT PULL] First set of block changes for 4.14-rc1
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 5, 2017 at 7:31 AM, Jens Axboe <axboe@kernel.dk> wrote:
>
> Note that you'll hit a conflict in block/bio-integrity.c and
> mm/page_io.c, since we had fixes later in the 4.13 series for both of
> those that ended up conflicting with new changes. Both are trivial to
> fix up, I've included my resolution at the end of this email.

Actually, the _real_ conflict is with commit 8e654f8fbff5 ("zram: read
page from backing device") and the preceding code, which added a
"zram->bdev" that is the backing dev for the zram device.

And then it does

     bio->bi_bdev = zram->bdev;

but now the block layer has AGAIN changed some stupid internal detail
for no obvious reason, so now it doesn't work.

My initial thought was to just do

    bio->bi_disk = zram->disk;

instead, which *syntactically* seems to make sense, and match things
up in the obvious way.

But when I actually thought about it more, I decided that's bullshit.
"zram->disk" is not the backing device at all, it's the zram interface
itself.

The correct resolution seems to be

    bio_set_dev(bio, zram->bdev);

but *dammit*, Jens, this insane crazy constant "let's randomly change
block layer details around" needs to STOP.

This has been going on for too many releases by now. What the f*ck is
*wrong* with you and Christoph that you can't just leave this thing
alone?

Stop the pointless churn already.

When I saw your comment:

  It's a quiet series this round, which I think we needed after
  the churn of the last few series.

I was like "finally". And then this shows that you were just lying,
and the pointless churn is still happening.

Stop it. Really.

Here's a hint: if some stupid change requires you to mindlessly do 150
changes using a wrapper helper, it's churn.

We need *stability* by now, after these crazy changes. Make sure that happens.

                  Linus
