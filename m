Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, Shaohua Li <shli@kernel.org>
Subject: Re: I/O hangs after resuming from suspend-to-ram
Date: Thu, 21 Sep 2017 09:30:30 +0200
Message-ID: <3693727.dykhpN0O6j@merkaba>
In-Reply-To: <20170920222011.GB5105@ming.t460p>
References: <3926917.BCSovyVWdL@natalenko.name> <3567128.t9myNOm9ia@merkaba> <20170920222011.GB5105@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Ming Lei - 21.09.17, 06:20:
> On Mon, Aug 28, 2017 at 03:10:35PM +0200, Martin Steigerwald wrote:
> > Ming Lei - 28.08.17, 20:58:
> > > On Sun, Aug 27, 2017 at 09:43:52AM +0200, Oleksandr Natalenko wrote:
> > > > Hi.
> > > >=20
> > > > Here is disk setup for QEMU VM:
> > > >=20
> > > > =3D=3D=3D
> > > > [root@archmq ~]# smartctl -i /dev/sda
> > > > =E2=80=A6
> > > > Device Model:     QEMU HARDDISK
> > > > Serial Number:    QM00001
> > > > Firmware Version: 2.5+
> > > > User Capacity:    4,294,967,296 bytes [4.29 GB]
> > > > Sector Size:      512 bytes logical/physical
> > > > Device is:        Not in smartctl database [for details use: -P
> > > > showall]
> > > > ATA Version is:   ATA/ATAPI-7, ATA/ATAPI-5 published, ANSI NCITS
> > > > 340-2000
> > > > Local Time is:    Sun Aug 27 09:31:54 2017 CEST
> > > > SMART support is: Available - device has SMART capability.
> > > > SMART support is: Enabled
> > > >=20
> > > > [root@archmq ~]# lsblk
> > > > NAME                MAJ:MIN RM  SIZE RO TYPE   MOUNTPOINT
> > > > sda                   8:0    0    4G  0 disk
> > > > `-sda1                8:1    0    4G  0 part
> > > >=20
> > > >   `-md0               9:0    0    4G  0 raid10
> > > >  =20
> > > >     `-system        253:0    0    4G  0 crypt
> > > >    =20
> > > >       |-system-boot 253:1    0  512M  0 lvm    /boot
> > > >       |-system-swap 253:2    0  512M  0 lvm    [SWAP]
> > > >      =20
> > > >       `-system-root 253:3    0    3G  0 lvm    /
> > > >=20
> > > > sdb                   8:16   0    4G  0 disk
> > > > `-sdb1                8:17   0    4G  0 part
> > > >=20
> > > >   `-md0               9:0    0    4G  0 raid10
> > > >  =20
> > > >     `-system        253:0    0    4G  0 crypt
> > > >    =20
> > > >       |-system-boot 253:1    0  512M  0 lvm    /boot
> > > >       |-system-swap 253:2    0  512M  0 lvm    [SWAP]
> > > >      =20
> > > >       `-system-root 253:3    0    3G  0 lvm    /
> > > >=20
> > > > sr0                  11:0    1 1024M  0 rom
> > > >=20
> > > > [root@archmq ~]# mdadm --misc --detail /dev/md0
> > > >=20
> > > > /dev/md0:
> > > >         Version : 1.2
> > > >  =20
> > > >   Creation Time : Sat Jul 29 16:37:05 2017
> > > >  =20
> > > >      Raid Level : raid10
> > > >      Array Size : 4191232 (4.00 GiB 4.29 GB)
> > > >  =20
> > > >   Used Dev Size : 4191232 (4.00 GiB 4.29 GB)
> > > >  =20
> > > >    Raid Devices : 2
> > > >  =20
> > > >   Total Devices : 2
> > > >  =20
> > > >     Persistence : Superblock is persistent
> > > >    =20
> > > >     Update Time : Sun Aug 27 09:30:33 2017
> > > >    =20
> > > >           State : clean
> > > > =20
> > > >  Active Devices : 2
> > > >=20
> > > > Working Devices : 2
> > > >=20
> > > >  Failed Devices : 0
> > > > =20
> > > >   Spare Devices : 0
> > > >  =20
> > > >          Layout : far=3D2
> > > >     =20
> > > >      Chunk Size : 512K
> > > >     =20
> > > >            Name : archiso:0
> > > >            UUID : 43f4be59:c8d2fa0a:a94acdff:1c7f2f4e
> > > >         =20
> > > >          Events : 485
> > > >    =20
> > > >     Number   Major   Minor   RaidDevice State
> > > >    =20
> > > >        0       8        1        0      active sync   /dev/sda1
> > > >        1       8       17        1      active sync   /dev/sdb1
> > > >=20
> > > > =3D=3D=3D
> > > >=20
> > > > In words: 2 virtual disks, RAID10 setup with far-2 layout, LUKS on =
it,
> > > > then
> > > > LVM, then ext4 for boot, swap and btrfs for /.
> > > >=20
> > > > I couldn't reproduce the issue with single disk without RAID.
> > >=20
> > > Could you verify if the following patch fixes your issue?
>=20
> Yes, the patch should address this kind of issue, not related
> with RAID specially, and the latest version can be found in the
> following link:
>=20
> 	https://marc.info/?l=3Dlinux-block&m=3D150579298505484&w=3D2

Thank you.

So if I understand already I can just add

https://github.com/ming1/linux/tree/my_v4.13-safe-scsi-quiesce_V5_for_test

as an remote and go from there.

Thanks,
=2D-=20
Martin
