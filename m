Return-Path: <idryomov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180404094931.2345742-1-arnd@arndb.de>
References: <20180404094931.2345742-1-arnd@arndb.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 4 Apr 2018 13:04:29 +0200
Message-ID: <CAOi1vP9mfukUhMb5wXVuTyF9gtmo-L6xs7axninLGQ+pJ1dmoA@mail.gmail.com>
Subject: Re: [PATCH] rbd: add missing return statements
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Dillaman <dillaman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 4, 2018 at 11:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> A new set of warnings appeared in next-20180403 in some configurations
> when gcc cannot see that rbd_assert(0) leads to an unreachable code
> path:
>
> drivers/block/rbd.c: In function 'rbd_img_is_write':
> drivers/block/rbd.c:1397:1: error: control reaches end of non-void function [-Werror=return-type]
> drivers/block/rbd.c: In function '__rbd_obj_handle_request':
> drivers/block/rbd.c:2499:1: error: control reaches end of non-void function [-Werror=return-type]
> drivers/block/rbd.c: In function 'rbd_obj_handle_write':
> drivers/block/rbd.c:2471:1: error: control reaches end of non-void function [-Werror=return-type]
>
> To work around this, we can add a return statement to each of these
> cases. An alternative would be to remove the unlikely() annotation
> in rbd_assert(), or to just use BUG()/BUG_ON() directly. This adds the
> return statements, guessing what the most reasonable behavior
> would be.

Hi Arnd,

I don't like these bogus return statements.  Let's go with explicit
BUG/BUG_ON() instead.

Thanks,

                Ilya
