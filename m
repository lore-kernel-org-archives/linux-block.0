Return-Path: <torvalds@linuxfoundation.org>
Return-Path: <torvalds@linuxfoundation.org>
MIME-Version: 1.0
References: <dc6c712a-57c4-81cd-0d6e-072973bb52ce@kernel.dk>
In-Reply-To: <dc6c712a-57c4-81cd-0d6e-072973bb52ce@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Nov 2018 11:27:35 -0700
Message-ID: <CAHk-=wgPvfTf-2v-MnOOf3SVBsjDSvW4wc5MaqagtTPc7220pQ@mail.gmail.com>
Subject: Re: [GIT PULL] Final block merge window changes/fixes
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 2, 2018 at 10:08 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> The biggest part of this pull request is the revert of the blkcg cleanup
> series. It had one fix earlier for a stacked device issue, but another
> one was reported. Rather than play whack-a-mole with this, revert the
> entire series and try again for the next kernel release.
>
> Apart from that, only small fixes/changes.

Pulled,

                          Linus
