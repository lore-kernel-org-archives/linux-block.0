Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
References: <5ba8d7db-03fe-4983-5636-78f0ff6881bb@kernel.dk>
In-Reply-To: <5ba8d7db-03fe-4983-5636-78f0ff6881bb@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Aug 2018 13:39:02 -0700
Message-ID: <CA+55aFyHYPATi0wTbKBBTEQvtoh4=rdFRz5zBQOnEzfT4h67og@mail.gmail.com>
Subject: Re: [GIT PULL] Follow up block changes for this merge window
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 22, 2018 at 10:54 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> - Set of bcache fixes and changes (Coly)

Some of those bcache style fixes look questionable.

Maybe we should push back on some of the checkpatch rules instead?

Like having argument names in declarations - sometimes descriptive
names can be good documentation. And sometimes they are just noise,
because the type is what describes it.

Oh well. Taken.

           Linus
