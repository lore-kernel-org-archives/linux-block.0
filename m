Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbeHTPBZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 11:01:25 -0400
Date: Mon, 20 Aug 2018 19:45:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: blk-mq 5-8 times slower for bmap-tools
Message-ID: <20180820114555.GB19999@ming.t460p>
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <CACVXFVNguNEJ_R7XXvC8dG_yu5tghQk+Hdg6Hp6KKr4Ys4EV_A@mail.gmail.com>
 <CAPybu_2ke4usj9Qwr9iSKTymAk1510pzZnZAgLemRB+cK4Se1A@mail.gmail.com>
 <20180820083032.GA24522@ming.t460p>
 <CAPybu_3QT_qTojTUXFhJFQKVsbhnWUmvyQ0zb5MwDJ5hsECf=A@mail.gmail.com>
 <20180820095514.GA25981@ming.t460p>
 <CAPybu_3Pd_jSP-mPv6FeHU9ksjoEibneZHY=AxMExo+L7L-SXQ@mail.gmail.com>
 <20180820101510.GB25981@ming.t460p>
 <20180820114209.GA19999@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180820114209.GA19999@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 20, 2018 at 07:42:09PM +0800, Ming Lei wrote:
> On Mon, Aug 20, 2018 at 06:15:10PM +0800, Ming Lei wrote:
> > On Mon, Aug 20, 2018 at 11:56:26AM +0200, Ricardo Ribalda Delgado wrote:
> > > Hi
> > > On Mon, Aug 20, 2018 at 11:55 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Mon, Aug 20, 2018 at 11:04:08AM +0200, Ricardo Ribalda Delgado wrote:
> > > > > Hello Ming
> > > > > On Mon, Aug 20, 2018 at 10:30 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 20, 2018 at 09:39:45AM +0200, Ricardo Ribalda Delgado wrote:
> > > > > > > Some measurements:
> > > > > > >
> > > > > > > Please note that even when iostat shows 0.0 the LED on the device was
> > > > > > > blinking as if there was some activity going on.
> > > > > > >
> > > > > > > Thanks!
> > > > > > >
> > > > > > > KERNEL:
> > > > > > > Linux neopili 4.17.0-1-amd64 #1 SMP Debian 4.17.8-1 (2018-07-20)
> > > > > > > x86_64 GNU/Linux
> > > > > > >
> > > > > > > DISK:
> > > > > > > [247530.712686] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
> > > > > > > [247530.738906] usb 2-2: New USB device found, idVendor=174c,
> > > > > > > idProduct=5136, bcdDevice= 1.00
> > > > > > > [247530.738913] usb 2-2: New USB device strings: Mfr=2, Product=3,
> > > > > > > SerialNumber=1
> > > > > > > [247530.738918] usb 2-2: Product: 91686
> > > > > > > [247530.738921] usb 2-2: Manufacturer: Delock
> > > > > > > [247530.738925] usb 2-2: SerialNumber: 300000003B45
> > > > > > > [247530.750709] scsi host6: uas
> > > > > > > [247530.751377] scsi 6:0:0:0: Direct-Access     ASMT     2105
> > > > > > >    0    PQ: 0 ANSI: 6
> > > > > > > [247530.752174] sd 6:0:0:0: Attached scsi generic sg2 type 0
> > > > > > > [247530.752616] sd 6:0:0:0: [sdb] 31277232 512-byte logical blocks:
> > > > > > > (16.0 GB/14.9 GiB)
> > > > > > > [247530.752740] sd 6:0:0:0: [sdb] Write Protect is off
> > > > > > > [247530.752742] sd 6:0:0:0: [sdb] Mode Sense: 43 00 00 00
> > > > > > > [247530.752905] sd 6:0:0:0: [sdb] Write cache: enabled, read cache:
> > > > > > > enabled, doesn't support DPO or FUA
> > > > > > > [247530.755912]  sdb: sdb1 sdb2
> > > > > > > [247530.756832] sd 6:0:0:0: [sdb] Attached SCSI disk
> > > > > > >
> > > > > > >
> > > > > > > TL/DR:
> > > > > > > CFQ: 21.7
> > > > > > > NOOP: 21.7
> > > > > > > DEADLINE: 21.7
> > > > > > > MQ-DEADLINE: 175.2
> > > > > > > NONE: 236.4
> > > > > > > KYBER: 174.9
> > > > > >
> > > > > > Thanks for your test!
> > > > > >
> > > > > > One problem found from your iostat log is that looks there is ~30sec
> > > > > > idle period between IO activities when blk-mq is enabled.
> > > > >
> > > > > During all the test the LED on the device was blinking.
> > > > >
> > > > > But a closer look to dmesg reveals a lot of this messages:
> > > > >
> > > > > [  196.929811] sd 6:0:0:0: [sdb] tag#3 data cmplt err -71 uas-tag 1
> > > > > inflight: CMD
> > > >
> > > > -71 is -EPROTO, which is returned from xhci driver, usually it means
> > > > there is error from the USB device side.
> > > >
> > > > > [  196.929822] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > > > > 68 00 04 00 00
> > > > > [  227.764379] sd 6:0:0:0: [sdb] tag#4 uas_eh_abort_handler 0 uas-tag
> > > > > 2 inflight: CMD OUT
> > > > > [  227.764389] sd 6:0:0:0: [sdb] tag#4 CDB: Write(10) 2a 00 00 04 04
> > > > > 68 00 04 00 00
> > > > > [  227.766555] sd 6:0:0:0: [sdb] tag#3 uas_eh_abort_handler 0 uas-tag
> > > > > 1 inflight: CMD
> > > > > [  227.766562] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > > > > 68 00 04 00 00
> > > > > [  227.784312] scsi host6: uas_eh_device_reset_handler start
> > > > > [  227.913672] usb 2-2: reset SuperSpeed USB device number 3 using xhci_hcd
> > > > > [  227.944842] scsi host6: uas_eh_device_reset_handler success
> > > > > [  231.416133] sd 6:0:0:0: [sdb] tag#1 data cmplt err -71 uas-tag 10
> > > > > inflight: CMD
> > > > > [  231.416147] sd 6:0:0:0: [sdb] tag#1 CDB: Write(10) 2a 00 00 06 d5
> > > > > e8 00 04 00 00
> > > > >
> > > > > And they take around 30 secons (227-196)
> > > > >
> > > > >
> > > > > Maybe this is a hw issue? I will bring the reader home tonight and see
> > > > > if I can replicate the bug with my notebook
> > > >
> > > > It might be.
> > > >
> > > > Is there such message in case of non-blk-mq?
> > > 
> > > No, only with blk-mq
> > 
> > OK, seems something doesn't work as expected in either scsi_mq or uas
> > driver.
> 
> Maybe it is just an uas issue, since I can reproduce the following issue
> with either scsi_mq or not on v4.18, and the uas is emulated via qemu.

Forget to mention, no need to run bmap-tool, just by the following fio
command:

fio --direct=1 -size=128G --bsrange=4k-4k --runtime=20 --numjobs=32 --ioengine=libaio --iodepth=64 --group_reporting=1 --filename=/dev/sde --name=/dev/sde-test-randwrite --rw=randwrite


Thanks,
Ming
