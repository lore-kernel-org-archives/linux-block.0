Return-Path: <linux@rainbow-software.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] block: remove the paride drivers
Date: Thu, 15 Mar 2018 23:17:19 +0100
Cc: axboe@kernel.dk,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180315075256.25652-1-hch@lst.de> <20180315080455.GA12388@lst.de> <201803152304.40423.linux@rainbow-software.org>
In-Reply-To: <201803152304.40423.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201803152317.20367.linux@rainbow-software.org>
List-ID: <linux-block@vger.kernel.org>

On Thursday 15 March 2018 23:04:40 Ondrej Zary wrote:
> On Thursday 15 March 2018 09:04:55 Christoph Hellwig wrote:
> > On Thu, Mar 15, 2018 at 09:04:24AM +0100, Ondrej Zary wrote:
> > > On Thursday 15 March 2018, Christoph Hellwig wrote:
> > > > The paride drivers are some of the cruftiest, grottiest block drivers
> > > > (besides drivers/ide and floppy.c) and have seen one single targeted
> > > > commit since the dawn of git in 2007.  Drop them to make block layer
> > > > improvements easier.
> > >
> > > This will make my parallel port ZIP and LS-120 drives useless :(
> >
> > So you are still using them and the code actually works properly?
>
> I don't use them daily, only occasionally. Last time they worked.
> Checked now and it seems to work:

Also found an old CD-ROM drive mounted in a HP C4381A box instead of the long-dead CD
Writer 7200. Not as good as the pf driver :)

# modprobe epat
[   50.446246] paride: epat registered as protocol 0
# modprobe pcd drive0=0x378,0
[   56.694140] pcd: pcd version 1.07, major 46, nice 0
[   56.803399] pcd0: Sharing parport0 at 0x378
[   56.804336] pcd0: epat 1.02, Shuttle EPAT chip c6 at 0x378,
[   56.804339] mode 5 (EPP-32), delay 1
[   56.837419] pcd0: Master: 8X CD-ROM   V1.0
[   56.839420] pcd0: mode sense capabilities completion: alt=0x51 stat=0x51 err=0x60 loop=0 phase=3
[   56.842259] pcd0: mode sense capabilities: Sense key: 6, ASC: 29, ASQ: 0
[   56.843149] cdrom: Uniform CD-ROM driver Revision: 3.20
[   56.843757] BUG: unable to handle kernel paging request at f0b6a334
[   56.844371] IP: register_cdrom+0x85/0x185 [cdrom]
[   56.844971] *pde = 2f564067 *pte = 2c343161
[   56.845692] Oops: 0003 [#1] SMP
[   56.846564] Modules linked in: pcd(+) cdrom epat paride i2c_dev nouveau sg parport_pc 8139cp wmi hwmon ttm parport intel_agp
[   56.847467] CPU: 0 PID: 1790 Comm: modprobe Not tainted 4.16.0-rc4+ #217
[   56.848340] Hardware name:  /848P-ICH5, BIOS 6.00 PG 02/03/2005
[   56.849275] EIP: register_cdrom+0x85/0x185 [cdrom]
[   56.850190] EFLAGS: 00010246 CPU: 0
[   56.851104] EAX: f0b61155 EBX: f0b6a300 ECX: ef992164 EDX: ef98c9cc
[   56.852029] ESI: f0b6bb80 EDI: ec351dfc EBP: ec351de4 ESP: ec351dd8
[   56.852961]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[   56.853895] CR0: 80050033 CR2: f0b6a334 CR3: 2c22d000 CR4: 00000690
[   56.854832] Call Trace:
[   56.855764]  pcd_init+0x37e/0x1000 [pcd]
[   56.856692]  ? _raw_spin_trylock_bh+0x1d/0x3a
[   56.857615]  ? __switch_to_asm+0x26/0x40
[   56.858541]  ? __switch_to_asm+0x1a/0x40
[   56.859442]  ? __switch_to_asm+0x26/0x40
[   56.860334]  ? 0xf0b6e000
[   56.861172]  do_one_initcall+0x84/0x111
[   56.862074]  ? __schedule+0x38f/0x3dd
[   56.862990]  ? virt_to_head_page+0x19/0x1b
[   56.863883]  ? virt_to_head_page+0x19/0x1b
[   56.864768]  ? _cond_resched+0x1e/0x22
[   56.865626]  ? kmem_cache_alloc+0x86/0xa9
[   56.866486]  ? do_init_module+0x17/0x1ad
[   56.867333]  do_init_module+0x46/0x1ad
[   56.868164]  load_module+0x1708/0x1b23
[   56.868997]  ? kernel_read_file+0x116/0x143
[   56.869820]  SyS_finit_module+0x62/0x67
[   56.870648]  do_int80_syscall_32+0x50/0x62
[   56.871477]  entry_INT80_32+0x2a/0x2a
[   56.872308] EIP: 0xb7fd6a02
[   56.873134] EFLAGS: 00000292 CPU: 0
[   56.873951] EAX: ffffffda EBX: 00000004 ECX: 007aff18 EDX: 00000000
[   56.874749] ESI: 007b0278 EDI: 007aff90 EBP: 00000000 ESP: bffbbac8
[   56.875590]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   56.876431] Code: 0c 00 75 0d 83 7b 10 00 75 07 c7 43 34 6f ff ff ff 83 7b 14 00 75 04 83 63 34 fc 83 7b 18 00 75 04 83 63 34 fb 83 7b 1c 00 75 04 <83> 63 34 f7 83 7b 24 00 75 04 83 63 34 df 83 7b 28 00 75 04 83
[   56.878264] EIP: register_cdrom+0x85/0x185 [cdrom] SS:ESP: 0068:ec351dd8
[   56.879220] CR2: 00000000f0b6a334
[   56.880193] ---[ end trace 596e4157e238f0e3 ]---


-- 
Ondrej Zary
