Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33057 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934500AbcKLApd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2016 19:45:33 -0500
MIME-Version: 1.0
In-Reply-To: <21b1c040-ea27-847d-326a-266224516814@fb.com>
References: <21b1c040-ea27-847d-326a-266224516814@fb.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Nov 2016 16:45:32 -0800
Message-ID: <CA+55aFzjUTzokY8MHYXFPhr0W037Qzhu1EchGoAkkFUgrkV+CA@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 4.9-rc
To: Jens Axboe <axboe@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 11, 2016 at 4:11 PM, Jens Axboe <axboe@fb.com> wrote:
> Hi Linus,
>
> Three small (really, one liners all of them!) fixes that should go into
> this series:

What about the aoeblk one? That seems to have come in with a tester
lately. From your original email:

 "I'm wondering if this is bio iteration breakage. aoeblk does this weird
  inc/dec of page counts, which should not be needed. At least others
  would be hit by this as well. In any case, should suffice for a test,
  before we look further. Can anyone test with this debug patch?"

Anyway, that bug seems to have been around forever and I'm not seeing
a lot of complaints, but I thought I'd ask.

Your oneliners pulled. Except when I pull, I don't actually get this one:

    Matias Bj=C3=B8rling (1):
          lightnvm: invalid offset calculation for lba_shift

but since you know how very deeply I care about lighnvm, I'm not
finding it in myself to worry about why that one was missing.

               Linus
