Return-Path: <kt0755@gmail.com>
MIME-Version: 1.0
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
 <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk> <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
In-Reply-To: <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
From: Kyungtae Kim <kt0755@gmail.com>
Date: Wed, 24 Oct 2018 02:33:55 -0400
Message-ID: <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To: axboe@kernel.dk
Cc: jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
	DaeRyong Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Corrected.


diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a8cfa01..41160a1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param=
,
                         */
                return -EINVAL;

+       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
+         return -EINVAL;
+
        for (i =3D 0; i < 16; i++)
                ptr->reply[i] =3D 0;
        ptr->resultcode =3D 0;


Thanks,
Kyungtae Kim
On Wed, Oct 24, 2018 at 2:29 AM Kyungtae Kim <kt0755@gmail.com> wrote:
>
> Thanks. The following should work.
>
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index a8cfa01..41160a1 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *par=
am,
>                          */
>                 return -EINVAL;
>
> +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
> +         return -EINVAL;
> +
>         for (i =3D 0; i < 16; i++)
>                 ptr->reply[i] =3D 0;
>         ptr->resultcode =3D 0;
> On Tue, Oct 23, 2018 at 6:01 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 10/22/18 5:20 PM, Kyungtae Kim wrote:
> > > We report a bug found in v4.19-rc2 (v4.19-rc8 as well):
> > > UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
> > >
> > > kernel config: https://kt0755.github.io/etc/config_v2-4.19
> > > repro: https://kt0755.github.io/etc/repro.b4076.c
> > >
> > > Analysis:
> > >
> > > struct floppy_raw_cmd {
> > >    unsigned char cmd_count;
> > >    unsigned char cmd[16];
> > >   ...
> > > };
> > >
> > > for (i=3D0; i<raw_cmd->cmd_count; i++)
> > >     output_byte(raw_cmd->cmd[i])
> > >
> > > In driver/block/floppy.c:1495, the code snippet above is trying to
> > > write some bytes to the floppy disk controller, depending on "cmd_cou=
nt".
> > > As you see "struct floppy_raw_cmd" above, the size of array =E2=80=9C=
cmd=E2=80=9D is
> > > fixed as 16.
> > > The thing is, there is no boundary check for the index of array "cmd"
> > > when this is used. Besides, "cmd_count" can be manipulated by raw_cmd=
_ioctl
> > > which is derived from ioctl system call.
> > > We observed that cmd_count is set at line 2540 (or 2111), but that is
> > > after such a bug arose in our experiment. So by manipulating system c=
all ioctl,
> > > user program can have illegitimate memory access.
> > >
> > > The following is a simple patch to stop this. (This might not be the
> > > best.)
> > >
> > > diff --git a/linux-4.19-rc2/drivers/block/floppy.c
> > > b/linux-4.19-rc2/drivers/block/floppy.c
> > > index f2b6f4d..a3610c9 100644
> > > --- a/linux-4.19-rc2/drivers/block/floppy.c
> > > +++ b/linux-4.19-rc2/drivers/block/floppy.c
> > > @@ -3149,6 +3149,8 @@ static int raw_cmd_copyin(int cmd, void __user =
*param,
> > >                          */
> > >                 return -EINVAL;
> > >
> > > +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd)) {
> > > +               return -EINVAL;
> > > +
> > >         for (i =3D 0; i < 16; i++)
> > >                 ptr->reply[i] =3D 0;
> > >         ptr->resultcode =3D 0;
> >
> > I think that's a decent way to fix it, but you probably want to
> > test your patch - it doesn't compile. Send something you've
> > tested that works.
> >
> > --
> > Jens Axboe
> >
