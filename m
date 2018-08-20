Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbeHTO5l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 10:57:41 -0400
Date: Mon, 20 Aug 2018 19:42:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: blk-mq 5-8 times slower for bmap-tools
Message-ID: <20180820114209.GA19999@ming.t460p>
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <CACVXFVNguNEJ_R7XXvC8dG_yu5tghQk+Hdg6Hp6KKr4Ys4EV_A@mail.gmail.com>
 <CAPybu_2ke4usj9Qwr9iSKTymAk1510pzZnZAgLemRB+cK4Se1A@mail.gmail.com>
 <20180820083032.GA24522@ming.t460p>
 <CAPybu_3QT_qTojTUXFhJFQKVsbhnWUmvyQ0zb5MwDJ5hsECf=A@mail.gmail.com>
 <20180820095514.GA25981@ming.t460p>
 <CAPybu_3Pd_jSP-mPv6FeHU9ksjoEibneZHY=AxMExo+L7L-SXQ@mail.gmail.com>
 <20180820101510.GB25981@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180820101510.GB25981@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 20, 2018 at 06:15:10PM +0800, Ming Lei wrote:
> On Mon, Aug 20, 2018 at 11:56:26AM +0200, Ricardo Ribalda Delgado wrote:
> > Hi
> > On Mon, Aug 20, 2018 at 11:55 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Mon, Aug 20, 2018 at 11:04:08AM +0200, Ricardo Ribalda Delgado wrote:
> > > > Hello Ming
> > > > On Mon, Aug 20, 2018 at 10:30 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > >
> > > > > On Mon, Aug 20, 2018 at 09:39:45AM +0200, Ricardo Ribalda Delgado wrote:
> > > > > > Some measurements:
> > > > > >
> > > > > > Please note that even when iostat shows 0.0 the LED on the device was
> > > > > > blinking as if there was some activity going on.
> > > > > >
> > > > > > Thanks!
> > > > > >
> > > > > > KERNEL:
> > > > > > Linux neopili 4.17.0-1-amd64 #1 SMP Debian 4.17.8-1 (2018-07-20)
> > > > > > x86_64 GNU/Linux
> > > > > >
> > > > > > DISK:
> > > > > > [247530.712686] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
> > > > > > [247530.738906] usb 2-2: New USB device found, idVendor=174c,
> > > > > > idProduct=5136, bcdDevice= 1.00
> > > > > > [247530.738913] usb 2-2: New USB device strings: Mfr=2, Product=3,
> > > > > > SerialNumber=1
> > > > > > [247530.738918] usb 2-2: Product: 91686
> > > > > > [247530.738921] usb 2-2: Manufacturer: Delock
> > > > > > [247530.738925] usb 2-2: SerialNumber: 300000003B45
> > > > > > [247530.750709] scsi host6: uas
> > > > > > [247530.751377] scsi 6:0:0:0: Direct-Access     ASMT     2105
> > > > > >    0    PQ: 0 ANSI: 6
> > > > > > [247530.752174] sd 6:0:0:0: Attached scsi generic sg2 type 0
> > > > > > [247530.752616] sd 6:0:0:0: [sdb] 31277232 512-byte logical blocks:
> > > > > > (16.0 GB/14.9 GiB)
> > > > > > [247530.752740] sd 6:0:0:0: [sdb] Write Protect is off
> > > > > > [247530.752742] sd 6:0:0:0: [sdb] Mode Sense: 43 00 00 00
> > > > > > [247530.752905] sd 6:0:0:0: [sdb] Write cache: enabled, read cache:
> > > > > > enabled, doesn't support DPO or FUA
> > > > > > [247530.755912]  sdb: sdb1 sdb2
> > > > > > [247530.756832] sd 6:0:0:0: [sdb] Attached SCSI disk
> > > > > >
> > > > > >
> > > > > > TL/DR:
> > > > > > CFQ: 21.7
> > > > > > NOOP: 21.7
> > > > > > DEADLINE: 21.7
> > > > > > MQ-DEADLINE: 175.2
> > > > > > NONE: 236.4
> > > > > > KYBER: 174.9
> > > > >
> > > > > Thanks for your test!
> > > > >
> > > > > One problem found from your iostat log is that looks there is ~30sec
> > > > > idle period between IO activities when blk-mq is enabled.
> > > >
> > > > During all the test the LED on the device was blinking.
> > > >
> > > > But a closer look to dmesg reveals a lot of this messages:
> > > >
> > > > [  196.929811] sd 6:0:0:0: [sdb] tag#3 data cmplt err -71 uas-tag 1
> > > > inflight: CMD
> > >
> > > -71 is -EPROTO, which is returned from xhci driver, usually it means
> > > there is error from the USB device side.
> > >
> > > > [  196.929822] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > > > 68 00 04 00 00
> > > > [  227.764379] sd 6:0:0:0: [sdb] tag#4 uas_eh_abort_handler 0 uas-tag
> > > > 2 inflight: CMD OUT
> > > > [  227.764389] sd 6:0:0:0: [sdb] tag#4 CDB: Write(10) 2a 00 00 04 04
> > > > 68 00 04 00 00
> > > > [  227.766555] sd 6:0:0:0: [sdb] tag#3 uas_eh_abort_handler 0 uas-tag
> > > > 1 inflight: CMD
> > > > [  227.766562] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > > > 68 00 04 00 00
> > > > [  227.784312] scsi host6: uas_eh_device_reset_handler start
> > > > [  227.913672] usb 2-2: reset SuperSpeed USB device number 3 using xhci_hcd
> > > > [  227.944842] scsi host6: uas_eh_device_reset_handler success
> > > > [  231.416133] sd 6:0:0:0: [sdb] tag#1 data cmplt err -71 uas-tag 10
> > > > inflight: CMD
> > > > [  231.416147] sd 6:0:0:0: [sdb] tag#1 CDB: Write(10) 2a 00 00 06 d5
> > > > e8 00 04 00 00
> > > >
> > > > And they take around 30 secons (227-196)
> > > >
> > > >
> > > > Maybe this is a hw issue? I will bring the reader home tonight and see
> > > > if I can replicate the bug with my notebook
> > >
> > > It might be.
> > >
> > > Is there such message in case of non-blk-mq?
> > 
> > No, only with blk-mq
> 
> OK, seems something doesn't work as expected in either scsi_mq or uas
> driver.

Maybe it is just an uas issue, since I can reproduce the following issue
with either scsi_mq or not on v4.18, and the uas is emulated via qemu.

[  116.988843] sd 3:0:0:0: [sde] tag#10 uas_eh_abort_handler 0 uas-tag 9 inflight: CMD OUT
[  116.988859] sd 3:0:0:0: [sde] tag#10 CDB: Write(10) 2a 00 0d d9 ec 08 00 00 08 00
[  116.991121] sd 3:0:0:0: [sde] tag#12 uas_eh_abort_handler 0 uas-tag 1 inflight:
[  116.991129] sd 3:0:0:0: [sde] tag#12 CDB: Write(10) 2a 00 0d d9 35 b0 00 00 08 00
[  116.991136] sd 3:0:0:0: [sde] tag#2 uas_eh_abort_handler 0 uas-tag 8 inflight:
[  116.991140] sd 3:0:0:0: [sde] tag#2 CDB: Write(10) 2a 00 0d 9c 7f b8 00 00 08 00
[  116.991146] sd 3:0:0:0: [sde] tag#5 uas_eh_abort_handler 0 uas-tag 7 inflight:
[  116.991149] sd 3:0:0:0: [sde] tag#5 CDB: Write(10) 2a 00 0d 87 0d c8 00 00 08 00
[  116.991155] sd 3:0:0:0: [sde] tag#9 uas_eh_abort_handler 0 uas-tag 14 inflight:
[  116.991158] sd 3:0:0:0: [sde] tag#9 CDB: Write(10) 2a 00 0d 84 fa b0 00 00 08 00
[  116.991163] sd 3:0:0:0: [sde] tag#6 uas_eh_abort_handler 0 uas-tag 6 inflight:
[  116.991167] sd 3:0:0:0: [sde] tag#6 CDB: Write(10) 2a 00 0d 5b f2 e0 00 00 08 00
[  116.991173] sd 3:0:0:0: [sde] tag#13 uas_eh_abort_handler 0 uas-tag 5 inflight:
[  116.991176] sd 3:0:0:0: [sde] tag#13 CDB: Write(10) 2a 00 0d 27 dd a0 00 00 08 00
[  116.991181] sd 3:0:0:0: [sde] tag#8 uas_eh_abort_handler 0 uas-tag 13 inflight:
[  116.991185] sd 3:0:0:0: [sde] tag#8 CDB: Write(10) 2a 00 0d 14 03 08 00 00 08 00
[  116.991190] sd 3:0:0:0: [sde] tag#11 uas_eh_abort_handler 0 uas-tag 2 inflight:
[  116.991194] sd 3:0:0:0: [sde] tag#11 CDB: Write(10) 2a 00 0c f8 10 d0 00 00 08 00
[  116.991199] sd 3:0:0:0: [sde] tag#0 uas_eh_abort_handler 0 uas-tag 12 inflight:
[  116.991203] sd 3:0:0:0: [sde] tag#0 CDB: Write(10) 2a 00 0c f7 5f 00 00 00 08 00
[  116.991208] sd 3:0:0:0: [sde] tag#7 uas_eh_abort_handler 0 uas-tag 4 inflight:
[  116.991211] sd 3:0:0:0: [sde] tag#7 CDB: Write(10) 2a 00 0c c1 7d 98 00 00 08 00
[  116.996641] scsi host3: uas_eh_device_reset_handler start
[  117.112534] usb 3-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[  117.128255] scsi host3: uas_eh_device_reset_handler success
[ming@VM]$
[ming@VM]$
[ming@VM]$cat /proc/cmdline
ftrace_dump_on_oops root=UUID=a2850628-61dd-42ee-8081-5f482a65314a ro console=tty1 console=ttyS0,115200n8 earlyprintk rootfstype=ext4 rw loglevel=9 virtio_blk.queue_depth=128 scsi_mod.use_blk_mq=0 no_console_suspend dm_mod.use_blk_mq=1 ip=dhcp iommu=force intel_iommu=on hugepages=0 debug kmemleak=off scsi_transport_iscsi.debug_session=1 scsi_transport_iscsi.debug_conn=1


thanks,
Ming
