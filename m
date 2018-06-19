Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr720063.outbound.protection.outlook.com ([40.107.72.63]:39072
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936748AbeFSK2m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 06:28:42 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "michal.sorn@intel.com" <michal.sorn@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 0/5] lightnvm: More flexible approach to metadata
Date: Tue, 19 Jun 2018 10:28:37 +0000
Message-ID: <57C4B452-66EF-49A0-9253-5E3557004595@cnexlabs.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
In-Reply-To: <20180615222706.3801-1-igor.j.konopko@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_97A7BF25-0150-45A9-B6A8-FACDBD5CFED6";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_97A7BF25-0150-45A9-B6A8-FACDBD5CFED6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 16 Jun 2018, at 00.27, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This series of patches introduce some more flexibility in pblk
> related to OOB meta:
> -ability to use different sizes of metadata (previously fixed 16b)
> -ability to use pblk on drives without metadata
> -ensuring that extended (interleaved) metadata is not in use
>=20
> I belive that most of this patches, maybe except of number 4 (Support
> for packed metadata) are rather simple, so waiting for comments
> especially about this one.
>=20
> Igor Konopko (5):
>  lightnvm: pblk: Helpers for OOB metadata
>  lightnvm: pblk: Remove resv field for sec meta
>  lightnvm: Flexible DMA pool entry size
>  lightnvm: pblk: Support for packed metadata in pblk.
>  lightnvm: pblk: Disable interleaved metadata in pblk
>=20
> drivers/lightnvm/core.c          | 33 ++++++++++-----
> drivers/lightnvm/pblk-core.c     | 86 =
+++++++++++++++++++++++++++++++---------
> drivers/lightnvm/pblk-init.c     | 52 +++++++++++++++++++++++-
> drivers/lightnvm/pblk-map.c      | 21 ++++++----
> drivers/lightnvm/pblk-rb.c       |  3 ++
> drivers/lightnvm/pblk-read.c     | 85 =
+++++++++++++++++++++++++--------------
> drivers/lightnvm/pblk-recovery.c | 67 +++++++++++++++++++++----------
> drivers/lightnvm/pblk-sysfs.c    |  7 ++++
> drivers/lightnvm/pblk-write.c    | 22 ++++++----
> drivers/lightnvm/pblk.h          | 46 +++++++++++++++++++--
> drivers/nvme/host/lightnvm.c     |  7 +++-
> include/linux/lightnvm.h         |  9 +++--
> 12 files changed, 333 insertions(+), 105 deletions(-)
>=20
> --
> 2.14.3

I get a number of errors when running the series. A simple bisect points
to the first patch being the one introducing the (first) regression.
Here you have the trace attached. I could easily reproduce it mounting
ext4 and running a RocksDB's db_bench.

[   80.302731] Workqueue: pblk-read-end-wq pblk_line_put_ws
[   80.302733] RIP: 0010:__pblk_line_put+0xc3/0xd0
[   80.302733] Code: 89 55 70 48 89 4b 20 48 89 43 28 48 89 10 83 45 64 =
01 c6 07 00 0f 1f 40 00 48 89 de 4c 89 ef 5b 5d 41 5c 41 5d e9 5d a5 00 =
00 <0f> 0b e9 60 ff ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 55 53 48 89
[   80.302755] RSP: 0018:ffffb17102733e40 EFLAGS: 00010293
[   80.302756] RAX: 0000000000000000 RBX: ffff8d34529003e8 RCX: =
ffff8d3467068020
[   80.302757] RDX: 0000000000000001 RSI: ffff8d34529003e8 RDI: =
ffff8d34529004a8
[   80.302758] RBP: ffff8d34622ae800 R08: 0000000000000000 R09: =
8080808080808080
[   80.302758] R10: 0000000000000018 R11: fefefefefefefeff R12: =
ffff8d34529004a8
[   80.302759] R13: 0000000000000000 R14: ffff8d346532c600 R15: =
0ffff8d345f59990
[   80.302760] FS:  0000000000000000(0000) GS:ffff8d34778c0000(0000) =
knlGS:0000000000000000
[   80.302761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.302762] CR2: 00007f4d37e00000 CR3: 000000020780a002 CR4: =
00000000003606e0
[   80.302763] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[   80.302764] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[   80.302764] Call Trace:
[   80.302768]  pblk_line_put_ws+0x1a/0x30
[   80.302771]  process_one_work+0x15e/0x3d0
[   80.302773]  worker_thread+0x4c/0x440
[   80.302774]  kthread+0xf8/0x130
[   80.302776]  ? rescuer_thread+0x350/0x350
[   80.302777]  ? kthread_associate_blkcg+0x90/0x90
[   80.302779]  ret_from_fork+0x35/0x40
[   80.302781] ---[ end trace c4ab4ef1527265f6 ]---
[   81.551907] WARNING: CPU: 6 PID: 5045 at =
drivers/lightnvm/pblk-core.c:162 __pblk_map_invalidate+0x10b/0x130
[   81.551908] Modules linked in:
[   81.551910] CPU: 6 PID: 5045 Comm: rocksdb:bg0 Tainted: G        W    =
     4.17.0--00884b2fb689 #2569
[   81.551911] Hardware name: Supermicro Super Server/X11SSH-F, BIOS 2.1 =
12/11/2017
[   81.551912] RIP: 0010:__pblk_map_invalidate+0x10b/0x130
[   81.551912] Code: 48 89 de 4c 89 e7 e8 f4 fd ff ff 49 89 c5 e9 62 ff =
ff ff 48 c7 c7 ec 8e 5e a4 c6 05 50 65 10 01 01 e8 29 eb 88 ff 0f 0b eb =
c5 <0f> 0b e9 1b ff ff ff c6 07 00 0f 1f 40 00 4c 89 e7 c6 07 00 0f 1f
[   81.551927] RSP: 0018:ffffb17106d23808 EFLAGS: 00010246
[   81.551928] RAX: 0000000000000000 RBX: ffff8d34529003e8 RCX: =
0000000000000300
[   81.551929] RDX: 0000000000000001 RSI: ffff8d34529003e8 RDI: =
ffff8d34529004a8
[   81.551929] RBP: ffff8d34529004a8 R08: 0000000000000018 R09: =
ffff8d345d6e96d0
[   81.551930] R10: ffffb17106d237c8 R11: 0000000000000040 R12: =
ffff8d34622ae800
[   81.551930] R13: 0000000000000b40 R14: ffff8d34622aec10 R15: =
ffffb1710615d7c0
[   81.551931] FS:  00007f4d6707e700(0000) GS:ffff8d3477980000(0000) =
knlGS:0000000000000000
[   81.551932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.551932] CR2: 00007f4d57e00000 CR3: 000000040c204006 CR4: =
00000000003606e0
[   81.551933] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[   81.551933] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[   81.551934] Call Trace:
[   81.551937]  pblk_update_map_dev+0x69/0x370
[   81.551938]  __pblk_rb_update_l2p+0x52/0x160
[   81.551939]  __pblk_rb_may_write+0x40/0x50
[   81.551941]  pblk_rb_may_write_user+0x6c/0xe0
[   81.551942]  pblk_write_to_cache+0xa1/0x270
[   81.551944]  ? pblk_make_rq+0x6d/0x110
[   81.551944]  pblk_make_rq+0x6d/0x110
[   81.551947]  generic_make_request+0x1e8/0x410
[   81.551948]  ? submit_bio+0x6c/0x140
[   81.551950]  ? iov_iter_get_pages+0xbd/0x340
[   81.551951]  submit_bio+0x6c/0x140
[   81.551952]  ? bio_add_page+0x1b/0x50
[   81.551954]  do_blockdev_direct_IO+0x2011/0x29f0
[   81.551957]  ? ext4_dio_get_block_unwritten_sync+0x50/0x50
[   81.551958]  ? ext4_direct_IO+0x288/0x740
[   81.551959]  ext4_direct_IO+0x288/0x740
[   81.551961]  generic_file_direct_write+0xc4/0x160
[   81.551962]  __generic_file_write_iter+0xb6/0x1e0
[   81.551964]  ? __switch_to_asm+0x40/0x70
[   81.551965]  ? __switch_to_asm+0x34/0x70
[   81.551966]  ext4_file_write_iter+0xc7/0x400
[   81.551967]  ? __switch_to_asm+0x34/0x70
[   81.551968]  ? __switch_to_asm+0x40/0x70
[   81.551968]  ? __switch_to_asm+0x34/0x70
[   81.551969]  ? __switch_to_asm+0x40/0x70
[   81.551970]  ? __switch_to_asm+0x34/0x70
[   81.551971]  __vfs_write+0x112/0x1a0
[   81.551973]  vfs_write+0xb3/0x1a0
[   81.551974]  ksys_pwrite64+0x71/0x90
[   81.551976]  ? exit_to_usermode_loop+0x5c/0xb0
[   81.551977]  do_syscall_64+0x55/0x100
[   81.551978]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   81.551980] RIP: 0033:0x7f4dd04a2da3
[   81.551980] Code: 49 89 ca b8 12 00 00 00 0f 05 48 3d 01 f0 ff ff 73 =
34 c3 48 83 ec 08 e8 cb f3 ff ff 48 89 04 24 49 89 ca b8 12 00 00 00 0f =
05 <48> 8b 3c 24 48 89 c2 e8 11 f4 ff ff 48 89 d0 48 83 c4 08 48 3d 01
[   81.551995] RSP: 002b:00007f4d6707a8f0 EFLAGS: 00000293 ORIG_RAX: =
0000000000000012
[   81.551996] RAX: ffffffffffffffda RBX: 0000000006a05000 RCX: =
00007f4dd04a2da3
[   81.551997] RDX: 0000000006a05000 RSI: 00007f4d4ffff000 RDI: =
000000000000000f
[   81.551997] RBP: 00007f4d6707a950 R08: 00007f4d60000d70 R09: =
00007f4d6707aad0
[   81.551998] R10: 0000000008000000 R11: 0000000000000293 R12: =
0000000008000000
[   81.551998] R13: 00007f4d4ffff000 R14: 00007f4d60000bc0 R15: =
00007f4d6707a9a0
[   81.551999] ---[ end trace c4ab4ef1527265f7 ]---
[   81.555052] WARNING: CPU: 6 PID: 5045 at =
drivers/lightnvm/pblk-core.c:162 __pblk_map_invalidate+0x10b/0x130
[   81.555053] Modules linked in:
[   81.555055] CPU: 6 PID: 5045 Comm: rocksdb:bg0 Tainted: G        W    =
     4.17.0--00884b2fb689 #2569
[   81.555056] Hardware name: Supermicro Super Server/X11SSH-F, BIOS 2.1 =
12/11/2017
[   81.555057] RIP: 0010:__pblk_map_invalidate+0x10b/0x130
[   81.555057] Code: 48 89 de 4c 89 e7 e8 f4 fd ff ff 49 89 c5 e9 62 ff =
ff ff 48 c7 c7 ec 8e 5e a4 c6 05 50 65 10 01 01 e8 29 eb 88 ff 0f 0b eb =
c5 <0f> 0b e9 1b ff ff ff c6 07 00 0f 1f 40 00 4c 89 e7 c6 07 00 0f 1f
[   81.555072] RSP: 0018:ffffb17106d23808 EFLAGS: 00010246
[   81.555073] RAX: 0000000000000000 RBX: ffff8d34529003e8 RCX: =
0000000000000300
[   81.555073] RDX: 0000000000000001 RSI: ffff8d34529003e8 RDI: =
ffff8d34529004a8
[   81.555074] RBP: ffff8d34529004a8 R08: 0000000000000018 R09: =
ffff8d345d6e96d0
[   81.555074] R10: ffffb17106d237c8 R11: 0000000000000040 R12: =
ffff8d34622ae800
[   81.555075] R13: 0000000000000d41 R14: ffff8d34622aec10 R15: =
ffffb17106166808
[   81.555076] FS:  00007f4d6707e700(0000) GS:ffff8d3477980000(0000) =
knlGS:0000000000000000
[   81.555076] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.555077] CR2: 00007f4d57e00000 CR3: 000000040c204006 CR4: =
00000000003606e0
[   81.555078] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[   81.555078] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[   81.555078] Call Trace:
[   81.555081]  pblk_update_map_dev+0x69/0x370
[   81.555083]  __pblk_rb_update_l2p+0x52/0x160
[   81.555084]  __pblk_rb_may_write+0x40/0x50
[   81.555085]  pblk_rb_may_write_user+0x6c/0xe0
[   81.555087]  pblk_write_to_cache+0xa1/0x270
[   81.555088]  ? pblk_make_rq+0x6d/0x110
[   81.555089]  pblk_make_rq+0x6d/0x110
[   81.555092]  generic_make_request+0x1e8/0x410
[   81.555093]  ? submit_bio+0x6c/0x140
[   81.555095]  ? iov_iter_get_pages+0xbd/0x340
[   81.555096]  submit_bio+0x6c/0x140
[   81.555098]  ? bio_add_page+0x1b/0x50
[   81.555100]  do_blockdev_direct_IO+0x2011/0x29f0
[   81.555102]  ? ext4_dio_get_block_unwritten_sync+0x50/0x50
[   81.555104]  ? ext4_direct_IO+0x288/0x740
[   81.555104]  ext4_direct_IO+0x288/0x740
[   81.555107]  generic_file_direct_write+0xc4/0x160
[   81.555108]  __generic_file_write_iter+0xb6/0x1e0
[   81.555110]  ? __switch_to_asm+0x40/0x70
[   81.555111]  ? __switch_to_asm+0x34/0x70
[   81.555112]  ext4_file_write_iter+0xc7/0x400
[   81.555113]  ? __switch_to_asm+0x34/0x70
[   81.555114]  ? __switch_to_asm+0x40/0x70
[   81.555114]  ? __switch_to_asm+0x34/0x70
[   81.555115]  ? __switch_to_asm+0x40/0x70
[   81.555115]  ? __switch_to_asm+0x34/0x70
[   81.555117]  __vfs_write+0x112/0x1a0
[   81.555119]  vfs_write+0xb3/0x1a0
[   81.555121]  ksys_pwrite64+0x71/0x90
[   81.555123]  ? exit_to_usermode_loop+0x5c/0xb0
[   81.555124]  do_syscall_64+0x55/0x100
[   81.555125]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   81.555127] RIP: 0033:0x7f4dd04a2da3

--Apple-Mail=_97A7BF25-0150-45A9-B6A8-FACDBD5CFED6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlso2tMACgkQIX4xUKFR
nnQFew/+N+k+vNIQKRz9/joxYan988/lzoxLbMyodQEiPz72eIsJ5WRHb/SR0xKK
h/fwZa1mol0DzKdHINJdp8K//QFWR8gKmMHAsu/zcigW3c6x1kmdVILa92FFxESP
zdtQ2ijckATLHaZyA+daGZcR+/Dx2EOf8W8OnpvBrNdqLnWv2Q240y6YD9CA3VmX
rDHuRDeiu1/oJFhceyPYpfAuoP77gFyMVZFE6LnWlRi34L0S750xvSzeBhqJt+8f
0B57nouJezQ/sjaUp/p6fsteuVTSxRTZk4OHiSvO0tsQOpChJjyxzFXsGxch9Ird
ZBYAMgsFfNwJGcZBjNtZsHcuT3zW7S5NtC95Wr8IB5dwERNzDmNUX6HrGAjC8QVT
YcGBy/YuOMND6GBmmvlBTRMrRd1a2eNzKDYJTbkUtqRbNi859I0pQSuUjmI7TFfL
/zVHQghFNUsUxDSr7vQd91CcU9VjTi7QROubJAP30KQXXP6Exiu4jkCwo+VoImSs
4WJ8X8OQgKA1sualTtxvPKmPica3h1O4lN4/nacAVwEUimWozuY92t+DSRKVaVxA
NJeCvYERX8GIGZjw45lk1zLZ88CFLfipUL3nJn1Za0qxL7ZfSd3d+RCqwUWb+tp9
UhvJPXkrNsSbHNEpTRywtzYOM+4EQJFMeJXqNj0SLkQduCcrzuQ=
=+oXf
-----END PGP SIGNATURE-----

--Apple-Mail=_97A7BF25-0150-45A9-B6A8-FACDBD5CFED6--
