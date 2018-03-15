Return-Path: <linux@rainbow-software.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] block: remove the paride drivers
Date: Thu, 15 Mar 2018 23:04:40 +0100
Cc: axboe@kernel.dk,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180315075256.25652-1-hch@lst.de> <201803150904.25087.linux@rainbow-software.org> <20180315080455.GA12388@lst.de>
In-Reply-To: <20180315080455.GA12388@lst.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201803152304.40423.linux@rainbow-software.org>
List-ID: <linux-block@vger.kernel.org>

On Thursday 15 March 2018 09:04:55 Christoph Hellwig wrote:
> On Thu, Mar 15, 2018 at 09:04:24AM +0100, Ondrej Zary wrote:
> > On Thursday 15 March 2018, Christoph Hellwig wrote:
> > > The paride drivers are some of the cruftiest, grottiest block drivers
> > > (besides drivers/ide and floppy.c) and have seen one single targeted
> > > commit since the dawn of git in 2007.  Drop them to make block layer
> > > improvements easier.
> >
> > This will make my parallel port ZIP and LS-120 drives useless :(
>
> So you are still using them and the code actually works properly?

I don't use them daily, only occasionally. Last time they worked.
Checked now and it seems to work:

[    0.000000] Linux version 4.16.0-rc4+ (zary@gsql) (gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)) #217 SMP Tue Mar 13 00:08:16 CET 2018

...

# modprobe epat
[   47.376762] paride: epat registered as protocol 0
# modprobe pf drive0=0x378,0
[   59.048408] pf: pf version 1.04, major 47, cluster 64, nice 0
[   59.156038] pf0: Sharing parport0 at 0x378
[   59.157017] pf0: epat 1.02, Shuttle EPAT chip c6 at 0x378,
[   59.157020] mode 5 (EPP-32), delay 1
[   59.187400] pf0: mode sense completion: alt=0x51 stat=0x51 err=0x64 loop=0 phase=3
[   59.188080] pf0: mode sense data done: alt=0x51 stat=0x51 err=0x64 loop=0 phase=3
[   59.190648] pf0: Sense key: 6, ASC: 29, ASQ: 0
[   59.196326] pf0: get capacity completion: alt=0x51 stat=0x51 err=0x24 loop=0 phase=3
[   59.197038] pf0: get capacity data done: alt=0x51 stat=0x51 err=0x24 loop=0 phase=3
[   59.199499] pf0: Sense key: 2, ASC: 3a, ASQ: 0
[   59.200108] pf0: MATSHITA LS-120 COSM 04, master LUN 0, type 0
[   59.200109] , removable
[   59.200745] , no media
[   59.219353] pf0: get capacity completion: alt=0x51 stat=0x51 err=0x24 loop=0 phase=3
[   59.220078] pf0: get capacity data done: alt=0x51 stat=0x51 err=0x24 loop=0 phase=3
[   59.222777] pf0: Sense key: 2, ASC: 3a, ASQ: 0
[   59.223419] pf0: MATSHITA LS-120 COSM 04, master LUN 0, type 0
[   59.223420] , removable
[   59.224042] , no media
# mount /dev/pf0 /media/floppy
[   89.255905] pf0: mode sense completion: alt=0x51 stat=0x51 err=0x64 loop=0 phase=3
[   89.256657] pf0: mode sense data done: alt=0x51 stat=0x51 err=0x64 loop=0 phase=3
[   89.259415] pf0: Sense key: 6, ASC: 28, ASQ: 0
[   89.265571] pf0: MATSHITA LS-120 COSM 04, master LUN 0, type 0
[   89.265573] , removable
[   89.266228] , RO
[   89.266871] , 246528 blocks
[   96.871316] pf0: MATSHITA LS-120 COSM 04, master LUN 0, type 0
[   96.871319] , removable
[   96.871998] , RO
[   96.872653] , 246528 blocks
[   96.888131] pf0: MATSHITA LS-120 COSM 04, master LUN 0, type 0
[   96.888134] , removable
[   96.888808] , RO
[   96.889479] , 246528 blocks
mount: /dev/pf0 is write-protected, mounting read-only
# ls -la /media/floppy/
total 356
drwxr-xr-x 9 root root   2048 Jun 11  2002 !!!!!!!!
drwxr-xr-x 6 root root  16384 Jan  1  1970 .
drwxr-xr-x 6 root root   4096 Sep 16  2015 ..
-rwxr-xr-x 1 root root    750 Nov  8  2007 auditsc-move-name-to-end-of-record.patch
-rwxr-xr-x 1 root root    638 Nov  8  2007 audit-send-netlink-sync.patch
-rwxr-xr-x 1 root root   5557 Nov  8  2007 cdu31a_interrupt_handling_new.patch
-rwxr-xr-x 1 root root   4317 Nov  8  2007 cdu31a_interrupt_handling.patch
-rwxr-xr-x 1 root root  51440 Nov  8  2007 cdu31a-locking-dd.patch
-rwxr-xr-x 1 root root  48769 Nov  8  2007 cdu31a-locking.patch
-rwxr-xr-x 1 root root  19470 Nov  8  2007 cdu31a-make-working.patch
-rwxr-xr-x 1 root root    899 Nov  8  2007 cdu31a-timeouts-fix.patch
-rwxr-xr-x 1 root root  36067 Nov  8  2007 cdu31a_trivial_cleanups.patch
-rwxr-xr-x 1 root root  19278 Nov  8  2007 cdu31a_use_semaphores.patch
-rwxr-xr-x 1 root root    462 Nov  8  2007 cyrix-math-new.patch
-rwxr-xr-x 1 root root    530 Nov  8  2007 cyrix-math.patch
-rwxr-xr-x 1 root root    391 Nov  8  2007 cyrix-new.patch
-rwxr-xr-x 1 root root   1468 Nov  8  2007 cyrix-test.patch
drwxr-xr-x 2 root root   2048 Jun  5  2002 DEUTSCH
drwxr-xr-x 2 root root   2048 Jun  5  2002 ENGLISH
drwxr-xr-x 2 root root   2048 Jun  5  2002 FRAN?AIS
-rwxr-xr-x 1 root root    490 Nov  8  2007 hz100.patch
-rwxr-xr-x 1 root root    796 Nov  8  2007 ide-floppy-eject.patch
-rwxr-xr-x 1 root root   1655 Nov  8  2007 pf-fix-excess-reconnects.patch
-rwxr-xr-x 1 root root    561 Nov  8  2007 sata_via_pata_dma_fix.patch
-rwxr-xr-x 1 root root 111104 Sep 26  1997 SETUP.EXE
-rwxr-xr-x 1 root root    643 Nov  8  2007 uncompressed-kernel-boot.patch
-rwxr-xr-x 1 root root    455 Nov  8  2007 uncompressed-kernel-make.patch
-rwxr-xr-x 1 root root   1098 Nov  8  2007 uncompressed-kernel.patch
-rwxr-xr-x 1 root root   1558 Nov  8  2007 usbtouchscreen-invert.patch

-- 
Ondrej Zary
