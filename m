Return-Path: <axboe@kernel.dk>
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To: Kyungtae Kim <kt0755@gmail.com>
Cc: jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
 DaeRyong Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
 <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk>
 <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
 <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com>
 <ad9f11b6-1e3c-8412-ecce-d04a1c8c317a@kernel.dk>
 <CAEAjamu-MmtPF0_kqyPKJBcZSWz=SGi_1VjLq7z9MMm5-t7Oog@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9206bb2f-b11f-cd57-819a-81438b388124@kernel.dk>
Date: Fri, 26 Oct 2018 08:20:09 -0600
MIME-Version: 1.0
In-Reply-To: <CAEAjamu-MmtPF0_kqyPKJBcZSWz=SGi_1VjLq7z9MMm5-t7Oog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/26/18 7:22 AM, Kyungtae Kim wrote:
> I corrected the patch as follows:

OK, we're getting there! Please resend as a separate email, so that
the subject line is the patch header, and just the commit message
in the body. I'd fix that up for this one, but you also need to
fix up:

> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index a8cfa01..41160a1 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param,
>                          */
>                 return -EINVAL;
> 
> +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
> +         return -EINVAL;
> +

This needs to use tabs, not two spaces. Look at the surrounding
code - if yours looks differently, then you should correct that.

-- 
Jens Axboe
