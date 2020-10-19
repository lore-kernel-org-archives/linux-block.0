Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D865CC433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 03:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4222268
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 03:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LAn1zvUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgJSDpy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Oct 2020 23:45:54 -0400
Received: from m12-14.163.com ([220.181.12.14]:56684 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731534AbgJSDpy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Oct 2020 23:45:54 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2020 23:45:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Mime-Version:Subject:Message-Id:Date; bh=7IvJ3
        IO42eFK6fnoLa0WIPrl1Xf2HyPsX3t8lsPUvU0=; b=LAn1zvUqNLU6+rVbSLRCI
        snaSdX8rhSX+E/lN95nf7ywRTygtDDiCKHPwhAsuh4w1jot9FnVkTjJpHZaSpLmc
        pnNNUXShm9RVI1xRcrdFWOs4402xa/Rsmlx2+baRuzvhumTUPKWNMvCdoxBnoHxA
        oVny35e+aXifcUJmXvEMLs=
Received: from [127.0.0.1] (unknown [223.112.105.131])
        by smtp10 (Coremail) with SMTP id DsCowABnj_spCI1fXuO5Qw--.25655S3;
        Mon, 19 Oct 2020 11:29:45 +0800 (CST)
From:   lining <lining2020x@163.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: [bug report] NBD: rbd-nbd + ext4 stuck after nbd resized
Message-Id: <464B35DA-D889-41F8-9193-EBBC8C4F7E9D@163.com>
Date:   Mon, 19 Oct 2020 11:29:44 +0800
Cc:     donglifekernel@126.com
To:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        yunchuan.wen@kylin-cloud.com, ceph-users@ceph.io
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-CM-TRANSID: DsCowABnj_spCI1fXuO5Qw--.25655S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1UWrWUKr18Gw1UXr13Jwb_yoW5AFW3pF
        srK3W5GF1v9w1UWF4xWF1UXFyF9an2y3WUW392gr1jvrZFqrn7t3WIka42gF4UK39rWws7
        WF95tws2gr1UGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4E_NUUUUU=
X-Originating-IP: [223.112.105.131]
X-CM-SenderInfo: polqx0bjsqjir06rljoofrz/1tbiKxfCNlQHWKR4OAAAsn
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi kernel=E3=80=81ceph comunity:

We run into an issue that mainly related to the (kernel) nbd driver and =
(ceph) rbd-nbd.=20
After some investigations, I found that the root cause of the problem =
seems to be related to the change in the block size of nbd.

I am not sure whether it is the nbd driver or rbd-nbd bug, however there =
is such a problem.


What happened=EF=BC=9A
It will always hang when accessing the mount point of nbd device with =
ext4 after nbd resized.=20


Environment information:
- kernel:               v4.19.25 or master
- rbd-nbd(ceph):  v12.2.0 Luminous or master
- the fs of nbd:    ext4


Steps to reproduce:
1. rbd create --size 2G rbdpool/foo  # create a 2G size rbd image
2. rbd-nbd map rbdpool/foo            # map the rbd image as a local =
block device /dev/nbd0, block size is 512(the default block size is set =
in rbd-nbd code when nbd mapped).
3. mkfs.ext4 /dev/nbd0                     # mkfs.ext4 on nbd0, only nbd =
+ ext4 can reproduce the problem
4. mount /dev/nbd0 /mnt                # mount nbd0 on /mnt
5. rbd resize --size 4G rbdpool/foo   # expand the nbd backend image =
from 2G to 4G size
6. ls /mnt                                         # `ls` stuck here =
forever

ln@ubuntu:linux>$ ps -ef |grep mnt
root        8670    7519 98 10:16 pts/5    00:28:46 ls --color=3Dauto =
/mnt/
ln          9508    9293  0 10:45 pts/6    00:00:00 grep --color=3Dauto =
mnt


ln@ubuntu:linux>$ sudo cat /proc/8670/stack
[<0>] io_schedule+0x1a/0x40
[<0>] __lock_page+0x105/0x150
[<0>] pagecache_get_page+0x199/0x2c0
[<0>] __getblk_gfp+0xef/0x290
[<0>] ext4_getblk+0x83/0x1a0
[<0>] ext4_bread+0x26/0xb0
[<0>] __ext4_read_dirblock+0x34/0x2c0
[<0>] htree_dirblock_to_tree+0x56/0x1c0
[<0>] ext4_htree_fill_tree+0xad/0x330
[<0>] ext4_readdir+0x6a3/0x980
[<0>] iterate_dir+0x9e/0x1a0
[<0>] ksys_getdents64+0xa0/0x130
[<0>] __x64_sys_getdents64+0x1e/0x30
[<0>] do_syscall_64+0x5e/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] 0xffffffffffffffff


Some investigations on the kernel side:
By git bisect, I found the problem is related to this commit: =
https://github.com/torvalds/linux/commit/9a9c3c02eacecf4bfde74b08ed32749a4=
929a2cf .
The kernel with this commit (9a9c3c02) can reproduce the problem, revert =
the commit and the problem disappears.


Some Logical analysis about the nbd block size changing:
1. rbd-nbd map rbdpool/foo     =20
    =3D> ioctl NBD_BLKSZSET 512=20
      =3D> nbd_size_set()=20
        =3D> nbd_size_update(nbd)=20
          =3D>{
                  bdev =3D bdget_disk(nbd->disk, 0);
                  bd_set_size(bdev, 512) =20
                  set_blocksize(bdev, 512)
               }

2. mkfs.ext4 /dev/nbd0

3. mount /dev/nbd0 /mnt   =20
    =3D> vfs mount
      =3D>  ext4_mount()=20
        =3D> =E2=80=A6=20
          =3D> sb_set_blocksize()=20
            =3D> set_blocksize(bdev, 4096)   <=3D mount ext4 will set =
the nbd blocksize to 4096

4. rbd resize =E2=80=93size 4G rbdpool/foo  =20
    =3D> ioctl NBD_SET_SIZE 4G   <=3D rbd-nbd will update the latest =
total size of nbd device
      =3D>  nbd_size_set()=20
        =3D> nbd_size_update(nbd)=20
          =3D>{
                  bdev =3D bdget_disk(nbd->disk, 0);
                  bd_set_size(bdev, 512) =20
                  set_blocksize(bdev, 512)   <=3D the blocksize is set =
back to 512 [code line: set_blocksize(bdev, config->blksize);  ]. It =
seems to be the root cause.
               }=20



