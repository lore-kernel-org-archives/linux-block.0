Return-Path: <axboe@kernel.dk>
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To: Kyungtae Kim <kt0755@gmail.com>, jikos@kernel.org
Cc: Byoungyoung Lee <lifeasageek@gmail.com>,
 DaeRyong Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk>
Date: Tue, 23 Oct 2018 04:01:32 -0600
MIME-Version: 1.0
In-Reply-To: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/22/18 5:20 PM, Kyungtae Kim wrote:
> We report a bug found in v4.19-rc2 (v4.19-rc8 as well):
> UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
> 
> kernel config: https://kt0755.github.io/etc/config_v2-4.19
> repro: https://kt0755.github.io/etc/repro.b4076.c
> 
> Analysis:
> 
> struct floppy_raw_cmd {
>    unsigned char cmd_count;
>    unsigned char cmd[16];
>   ...
> };
> 
> for (i=0; i<raw_cmd->cmd_count; i++)
>     output_byte(raw_cmd->cmd[i])
> 
> In driver/block/floppy.c:1495, the code snippet above is trying to
> write some bytes to the floppy disk controller, depending on "cmd_count".
> As you see "struct floppy_raw_cmd" above, the size of array “cmd” is
> fixed as 16.
> The thing is, there is no boundary check for the index of array "cmd"
> when this is used. Besides, "cmd_count" can be manipulated by raw_cmd_ioctl
> which is derived from ioctl system call.
> We observed that cmd_count is set at line 2540 (or 2111), but that is
> after such a bug arose in our experiment. So by manipulating system call ioctl,
> user program can have illegitimate memory access.
> 
> The following is a simple patch to stop this. (This might not be the
> best.)
> 
> diff --git a/linux-4.19-rc2/drivers/block/floppy.c
> b/linux-4.19-rc2/drivers/block/floppy.c
> index f2b6f4d..a3610c9 100644
> --- a/linux-4.19-rc2/drivers/block/floppy.c
> +++ b/linux-4.19-rc2/drivers/block/floppy.c
> @@ -3149,6 +3149,8 @@ static int raw_cmd_copyin(int cmd, void __user *param,
>                          */
>                 return -EINVAL;
> 
> +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd)) {
> +               return -EINVAL;
> +
>         for (i = 0; i < 16; i++)
>                 ptr->reply[i] = 0;
>         ptr->resultcode = 0;

I think that's a decent way to fix it, but you probably want to
test your patch - it doesn't compile. Send something you've
tested that works.

-- 
Jens Axboe
