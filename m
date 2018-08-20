Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbeHTLpa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 07:45:30 -0400
Date: Mon, 20 Aug 2018 16:30:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: tom.leiming@gmail.com, linux-block@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: blk-mq 5-8 times slower for bmap-tools
Message-ID: <20180820083032.GA24522@ming.t460p>
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <CACVXFVNguNEJ_R7XXvC8dG_yu5tghQk+Hdg6Hp6KKr4Ys4EV_A@mail.gmail.com>
 <CAPybu_2ke4usj9Qwr9iSKTymAk1510pzZnZAgLemRB+cK4Se1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPybu_2ke4usj9Qwr9iSKTymAk1510pzZnZAgLemRB+cK4Se1A@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 20, 2018 at 09:39:45AM +0200, Ricardo Ribalda Delgado wrote:
> Some measurements:
> 
> Please note that even when iostat shows 0.0 the LED on the device was
> blinking as if there was some activity going on.
> 
> Thanks!
> 
> KERNEL:
> Linux neopili 4.17.0-1-amd64 #1 SMP Debian 4.17.8-1 (2018-07-20)
> x86_64 GNU/Linux
> 
> DISK:
> [247530.712686] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
> [247530.738906] usb 2-2: New USB device found, idVendor=174c,
> idProduct=5136, bcdDevice= 1.00
> [247530.738913] usb 2-2: New USB device strings: Mfr=2, Product=3,
> SerialNumber=1
> [247530.738918] usb 2-2: Product: 91686
> [247530.738921] usb 2-2: Manufacturer: Delock
> [247530.738925] usb 2-2: SerialNumber: 300000003B45
> [247530.750709] scsi host6: uas
> [247530.751377] scsi 6:0:0:0: Direct-Access     ASMT     2105
>    0    PQ: 0 ANSI: 6
> [247530.752174] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [247530.752616] sd 6:0:0:0: [sdb] 31277232 512-byte logical blocks:
> (16.0 GB/14.9 GiB)
> [247530.752740] sd 6:0:0:0: [sdb] Write Protect is off
> [247530.752742] sd 6:0:0:0: [sdb] Mode Sense: 43 00 00 00
> [247530.752905] sd 6:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [247530.755912]  sdb: sdb1 sdb2
> [247530.756832] sd 6:0:0:0: [sdb] Attached SCSI disk
> 
> 
> TL/DR:
> CFQ: 21.7
> NOOP: 21.7
> DEADLINE: 21.7
> MQ-DEADLINE: 175.2
> NONE: 236.4
> KYBER: 174.9

Thanks for your test!

One problem found from your iostat log is that looks there is ~30sec
idle period between IO activities when blk-mq is enabled.

Maybe it is related with timeout, given we had big change in v4.17 timeout code,
and we also fixed one scsi_mq timeout related issue recently, and the patch[1] has
been merged to v4.18 release already.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d5ba0e2de24ec87636244a01d4e78d095cc1b20

So could you test v4.18 and see if there is such issue?

BTW, I have run the same test on usb-storage, and can't reproduce it.
However you are using UAS, and I don't have it at hand, so can't
reproduce it completely.

Thanks,
Ming
