Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFwbmkTkPo5hgnDZ7aSKhUHZeec21wwcxCszZvrTgjaY7g@mail.gmail.com>
References: <1f069ba0-19bf-a7b3-3a65-78f7f20ddc65@kernel.dk> <CA+55aFwbmkTkPo5hgnDZ7aSKhUHZeec21wwcxCszZvrTgjaY7g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Sep 2017 13:00:41 -0700
Message-ID: <CA+55aFxHL=CdZiFTw0R-L2=ESvS6hVUbt5wUA6pEHxCeOB862g@mail.gmail.com>
Subject: Re: [GIT PULL] Followup block pull request for 4.14-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 9, 2017 at 12:54 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Other than that, we match.

Oh, and I almost cried when I saw this nasty thing:

   ilog2(SZ_4K) - 9

in that nvme code, but I left it alone.

Why the hell people think "SZ_4K" is somehow more legible than 4096, I
have no idea. And depending on our ilog2() just doing the right thing
at build time, instead of just saying "12" with a comment, is just
odd.

It's not like "ilog2(SZ_4K)" is a particularly good comment.

That code should probably just make it clear that 4096 is the NVME
page size, and document it as such, rather than picking a random name
for a random constant.

So something like

   #define NVME_PAGE_SIZE 4096
   #define NVME_PAGE_SHIFT 12

and then using *those* would actually have documented something,
rather than these crazy odd random expressions.

            Linus
