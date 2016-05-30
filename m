Return-Path: <linux-block-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41791 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933234AbcE3M6h (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 30 May 2016 08:58:37 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jens Axboe <axboe@fb.com>,
	Quentin Casasnovas <quentin.casasnovas@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Clements <paul.clements@steeleye.com>,
	Pavel Machek <pavel@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] nbd: fix race in ioctl
Date: Mon, 30 May 2016 14:58:27 +0200
Message-ID: <22193884.IvLroPXQMD@adelgunde>
In-Reply-To: <1464346775-370-1-git-send-email-vegard.nossum@oracle.com>
References: <1464346775-370-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2395935.5xcyYbna2E"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--nextPart2395935.5xcyYbna2E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

On Friday 27 May 2016 12:59:35 Vegard Nossum wrote:
> Quentin ran into this bug:
>=20
> WARNING: CPU: 64 PID: 10085 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x65/=
0x80
> sysfs: cannot create duplicate filename '/devices/virtual/block/nbd3/=
pid'
> Modules linked in: nbd
> CPU: 64 PID: 10085 Comm: qemu-nbd Tainted: G      D         4.6.0+ #7=

>  0000000000000000 ffff8820330bba68 ffffffff814b8791 ffff8820330bbac8
>  0000000000000000 ffff8820330bbab8 ffffffff810d04ab ffff8820330bbaa8
>  0000001f00000296 0000000000017681 ffff8810380bf000 ffffffffa0001790
> Call Trace:
>  [<ffffffff814b8791>] dump_stack+0x4d/0x6c
>  [<ffffffff810d04ab>] __warn+0xdb/0x100
>  [<ffffffff810d0574>] warn_slowpath_fmt+0x44/0x50
>  [<ffffffff81218c65>] sysfs_warn_dup+0x65/0x80
>  [<ffffffff81218a02>] sysfs_add_file_mode_ns+0x172/0x180
>  [<ffffffff81218a35>] sysfs_create_file_ns+0x25/0x30
>  [<ffffffff81594a76>] device_create_file+0x36/0x90
>  [<ffffffffa0000e8d>] __nbd_ioctl+0x32d/0x9b0 [nbd]
>  [<ffffffff814cc8e8>] ? find_next_bit+0x18/0x20
>  [<ffffffff810f7c29>] ? select_idle_sibling+0xe9/0x120
>  [<ffffffff810f6cd7>] ? __enqueue_entity+0x67/0x70
>  [<ffffffff810f9bf0>] ? enqueue_task_fair+0x630/0xe20
>  [<ffffffff810efa76>] ? resched_curr+0x36/0x70
>  [<ffffffff810f0078>] ? check_preempt_curr+0x78/0x90
>  [<ffffffff810f00a2>] ? ttwu_do_wakeup+0x12/0x80
>  [<ffffffff810f01b1>] ? ttwu_do_activate.constprop.86+0x61/0x70
>  [<ffffffff810f0c15>] ? try_to_wake_up+0x185/0x2d0
>  [<ffffffff810f0d6d>] ? default_wake_function+0xd/0x10
>  [<ffffffff81105471>] ? autoremove_wake_function+0x11/0x40
>  [<ffffffffa0001577>] nbd_ioctl+0x67/0x94 [nbd]
>  [<ffffffff814ac0fd>] blkdev_ioctl+0x14d/0x940
>  [<ffffffff811b0da2>] ? put_pipe_info+0x22/0x60
>  [<ffffffff811d96cc>] block_ioctl+0x3c/0x40
>  [<ffffffff811ba08d>] do_vfs_ioctl+0x8d/0x5e0
>  [<ffffffff811aa329>] ? ____fput+0x9/0x10
>  [<ffffffff810e9092>] ? task_work_run+0x72/0x90
>  [<ffffffff811ba627>] SyS_ioctl+0x47/0x80
>  [<ffffffff8185f5df>] entry_SYSCALL_64_fastpath+0x17/0x93
> ---[ end trace 7899b295e4f850c8 ]---
>=20
> It seems fairly obvious that device_create_file() is not being protec=
ted
> from being run concurrently on the same nbd.
>=20
> Quentin found the following relevant commits:
>=20
> 1a2ad21 nbd: add locking to nbd_ioctl
> 90b8f28 [PATCH] end of methods switch: remove the old ones
> d4430d6 [PATCH] beginning of methods conversion
> 08f8585 [PATCH] move block_device_operations to blkdev.h
>=20
> It would seem that the race was introduced in the process of moving n=
bd
> from BKL to unlocked ioctls.
>=20
> By setting nbd->task_recv while the mutex is held, we can prevent oth=
er
> processes from running concurrently (since nbd->task_recv is also che=
cked
> while the mutex is held).
>=20
> Reported-and-tested-by: Quentin Casasnovas <quentin.casasnovas@oracle=
.com>
> Cc: Markus Pargmann <mpa@pengutronix.de>
> Cc: Paul Clements <paul.clements@steeleye.com>
> Cc: Pavel Machek <pavel@suse.cz>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Thanks, applied.

Best Regards,

Markus

> ---
>  drivers/block/nbd.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 31e73a7..a831f2b 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -451,14 +451,9 @@ static int nbd_thread_recv(struct nbd_device *nb=
d, struct block_device *bdev)
> =20
>  =09sk_set_memalloc(nbd->sock->sk);
> =20
> -=09nbd->task_recv =3D current;
> -
>  =09ret =3D device_create_file(disk_to_dev(nbd->disk), &pid_attr);
>  =09if (ret) {
>  =09=09dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n"=
);
> -
> -=09=09nbd->task_recv =3D NULL;
> -
>  =09=09return ret;
>  =09}
> =20
> @@ -477,9 +472,6 @@ static int nbd_thread_recv(struct nbd_device *nbd=
, struct block_device *bdev)
>  =09nbd_size_clear(nbd, bdev);
> =20
>  =09device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
> -
> -=09nbd->task_recv =3D NULL;
> -
>  =09return ret;
>  }
> =20
> @@ -788,6 +780,8 @@ static int __nbd_ioctl(struct block_device *bdev,=
 struct nbd_device *nbd,
>  =09=09if (!nbd->sock)
>  =09=09=09return -EINVAL;
> =20
> +=09=09/* We have to claim the device under the lock */
> +=09=09nbd->task_recv =3D current;
>  =09=09mutex_unlock(&nbd->tx_lock);
> =20
>  =09=09nbd_parse_flags(nbd, bdev);
> @@ -796,6 +790,7 @@ static int __nbd_ioctl(struct block_device *bdev,=
 struct nbd_device *nbd,
>  =09=09=09=09     nbd_name(nbd));
>  =09=09if (IS_ERR(thread)) {
>  =09=09=09mutex_lock(&nbd->tx_lock);
> +=09=09=09nbd->task_recv =3D NULL;
>  =09=09=09return PTR_ERR(thread);
>  =09=09}
> =20
> @@ -805,6 +800,7 @@ static int __nbd_ioctl(struct block_device *bdev,=
 struct nbd_device *nbd,
>  =09=09kthread_stop(thread);
> =20
>  =09=09mutex_lock(&nbd->tx_lock);
> +=09=09nbd->task_recv =3D NULL;
> =20
>  =09=09sock_shutdown(nbd);
>  =09=09nbd_clear_que(nbd);
>=20

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart2395935.5xcyYbna2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXTDjzAAoJEEpcgKtcEGQQEd0QAJ+IDGFyGWwM4YtxjqRRX+3p
+Zza+ysl29ux6+eIytC2XY3Hwqtr7s0rQpaPrpx2B4Nf4yhqoW1MXuYBSuoPbO47
FXTzfnOa6ERZ9oZjKfvkpXrRKIg4CaNBmvD07X4/QcqLPk3Qw8GK62MumPVmMdZe
5NFeOgJfG31WCj8kKxsvADSPX9PQ/IREKy4Kw4IORGYsY1Lq8fDE++Xk4m/qLr57
e+MlyH2/mXxXDoPq2DGPB0ojsAkuWRj0WfY6Opw/PfYtfaF+kYD2V12Hlfe930T9
7iiBIgWSMS9tDd9Roj3ujtzyKqQJMhMDDyAN1sUegh/1Z51FakNqq3hSg65pchgG
NwebzWLYyTgZBlTCEuBlutjqgYJuS9354XEndzPqoZiI6Sq6XwN7eq/1RIOIPxSG
96mUkYOR39U6lkNqSilvIIKYkaFsIZeHqRrId/KLObyeANJr36d6rFLWT6l/gHGi
7MY2UmktmAqEaN4+aAyJlyucnGn7ZfvJ9ZzWt38PBTZQQT4sXhb2Hu+vB1hSJuUa
wA5Rs+Y+5YdefLe7IcsItbmy8PHIMmZMRFdqfFqVLShTkLhsOrWiaVWIoTLrLpjK
y0hNsuQp0Mpj1Ew0kjUCQUSfm8Az2Lru8wFJ1PLqV6DXFd6dEsmZoZwZIz9UaxMB
Za3zV/1UM0P5ECnyoDRC
=2UW5
-----END PGP SIGNATURE-----

--nextPart2395935.5xcyYbna2E--

