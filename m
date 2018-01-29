Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <354fd487-3eb2-84ea-ed32-02261b228d41@kernel.dk>
References: <5a2213b5-bc7f-da73-f566-886c38a6d3c9@kernel.dk>
 <CA+55aFyUYmkX44WBb7XNGp5rH=QijefA_GGG+mdKhznqR+7_rQ@mail.gmail.com> <354fd487-3eb2-84ea-ed32-02261b228d41@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2018 12:14:36 -0800
Message-ID: <CA+55aFx3-2CFC_0BXtMC3kQ+nW_6aK2etyMi1AJks1m5z2W=qA@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 4.16-rc
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 29, 2018 at 12:08 PM, Jens Axboe <axboe@kernel.dk> wrote:
>
> Yes of course, I can switch to using signed tags for pull requests
> for you.

Thanks. I don't actually know the maintainership status of kernel.dk.

You show up as the 'whois' contact, but I'm also assuming it doesn't
have the same kind of fairly draconian access control as the
kernel.org suite of sites, and I'm actively trying to make sure we
either use signed tags or the kernel.org repos (and honestly, even
with the kernel.org ones I tend to prefer signed tags).

Right now I only _require_ it for public hosting, but I'm trying to
move to just signed tags being the default everywhere.

              Linus
