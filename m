Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
References: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Sep 2017 17:18:49 -1000
Message-ID: <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 22, 2017 at 9:32 AM, Jens Axboe <axboe@kernel.dk> wrote:
> Hi Linus,
>
> A round of fixes for this series. This pull request contains:

No, Jens.

This isn't fixes. This is new code that does new things, or cleanups,
or other random things mixed up with some fixes.

Stop this fuckery already.

The block layer has now becomes the biggest maintenance problem I
have, because I get shit like this.

Keep the fixes separate. Stop the random crazy changes. Stop the churn.

WTF? Why is this so hard? It used to be that IDE drove people crazy.
Now it's NVMe and generic block layer stuff.

              Linus
