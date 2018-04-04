Return-Path: <idryomov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180404125345.4008862-1-arnd@arndb.de>
References: <20180404125345.4008862-1-arnd@arndb.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 4 Apr 2018 15:10:26 +0200
Message-ID: <CAOi1vP8KMoSKuw87wBJkAe5ke8Vb0jQ4qeizdX5jrfaChxNCCg@mail.gmail.com>
Subject: Re: [PATCH] [v2] rbd: avoid Wreturn-type warnings
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Dillaman <dillaman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 4, 2018 at 2:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
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
> As the rbd_assert() here shows has no extra information beyond the verbose
> BUG(), we can simply use BUG() directly in its place.  This is reliably
> detected as not returning on any architecture, since it doesn't depend
> on the unlikely() comparison that confused gcc.
>
> Fixes: 3da691bf4366 ("rbd: new request handling code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/rbd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 07dc5419bd63..5f7f4d4b78a8 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1392,7 +1392,7 @@ static bool rbd_img_is_write(struct rbd_img_request *img_req)
>         case OBJ_OP_DISCARD:
>                 return true;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>  }
>
> @@ -2466,7 +2466,7 @@ static bool rbd_obj_handle_write(struct rbd_obj_request *obj_req)
>                 }
>                 return false;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>  }
>
> @@ -2494,7 +2494,7 @@ static bool __rbd_obj_handle_request(struct rbd_obj_request *obj_req)
>                 }
>                 return false;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>  }
>

Applied.

Thanks,

                Ilya
