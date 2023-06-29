Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA4EB64DC
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 10:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjF2KSK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 06:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjF2KSC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 06:18:02 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F119B6;
        Thu, 29 Jun 2023 03:18:00 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qEoiq-000SNC-7D; Thu, 29 Jun 2023 12:17:56 +0200
Received: from p57bd9486.dip0.t-ipconnect.de ([87.189.148.134] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qEoip-001qhD-Vp; Thu, 29 Jun 2023 12:17:56 +0200
Message-ID: <f1a0f2252cc38721e222530dc4026ed3834e3eb8.camel@physik.fu-berlin.de>
Subject: Re: [FSL P50x0] [PASEMI] The Access to partitions on disks with an
 Amiga partition table doesn't work anymore after the block updates
 2023-06-23
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>, schmitzmic@gmail.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Darren Stevens <darren@stevens-zone.net>
Date:   Thu, 29 Jun 2023 12:17:55 +0200
In-Reply-To: <024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de>
References: <024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.134
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Christian!

On Thu, 2023-06-29 at 06:59 +0200, Christian Zigotzky wrote:
> The access  to partitions on disks with an Amiga partition table (via 
> the Rigid Disk Block RDB) doesn't work anymore on my Cyrus+ board with a 
> FSL P50x0 PowerPC SoC [1] and on my P.A. Semi Nemo board [2] after the 
> block updates 2023-06-23 [3].
> 
> parted -l
> 
> Model: ATA ST2000DM001-9YN1 (scsi)
> Disk /dev/sda: 2000GB
> Sector size (logical/physical): 512B/4096B
> Partition Table: amiga
> Disk Flags:
> 
> Number  Start   End     Size    File system  Name  Flags
>   1      1057kB  123MB   122MB   affs7        BDH0  hidden
>   2      123MB   2274MB  2150MB               DH0   boot
>   3      2274MB  691GB   689GB                DH2
>   4      691GB   1992GB  1301GB  ext4         dhx   boot

What version of AmigaOS is that?

> dmesg | grep -i sda
> 
> [    4.208905] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: 
> (2.00 TB/1.82 TiB)
> [    4.253995] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [    4.254826] sd 0:0:0:0: [sda] Write Protect is off
> [    4.300069] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    4.486476] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [    4.580507] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
> [    4.712624] Dev sda: unable to read partition block 4294967295
> [    4.761532]  sda: RDSK (512) sda1 (DOS^G)(res 2 spb 2) sda2 
> (SFS^B)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 2) sda4 ((res 2 spb 1) 
> unable to read partition table
> [    4.761892] sda: partition table beyond EOD,
> [    4.861681] Dev sda: unable to read partition block 4294967295
> [    4.912094]  sda: RDSK (512) sda1 (DOS^G)(res 2 spb 2) sda2 
> (SFS^B)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 2) sda4 ((res 2 spb 1) 
> unable to read partition table
> [    4.963387] sda: partition table beyond EOD,
> [    5.014769] sd 0:0:0:0: [sda] Attached SCSI disk

Maybe the RDB is corrupted? Did you try on a freshly created RDB?

> I created a patch for reverting the commit. [4]

That can be done with just "git revert <commit hash>".

> The access works again with this patch:
> 
> [    0.000000] Kernel command line: root=/dev/sda4
> [    3.987717] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: 
> (2.00 TB/1.82 TiB)
> [    4.031349] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [    4.123773] sd 0:0:0:0: [sda] Write Protect is off
> [    4.168682] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    4.279304] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [    4.463508] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
> [    4.519477]  sda: RDSK (512) sda1 (DOS^G)(res 2 spb 2) sda2 
> (SFS^B)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 2) sda4 ((res 2 spb 1)
> [    4.720896] sda: p4 size 18446744071956107760 extends beyond EOD,
> [    4.922550]  sda: RDSK (512) sda1 (DOS^G)(res 2 spb 2) sda2 
> (SFS^B)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 2) sda4 ((res 2 spb 1)
> [    4.948655] sda: p4 size 18446744071956107760 extends beyond EOD, 
> truncated

Looks like the old code is complaining about your partition table as well.

> Could you please check your commit?

Please also make sure that your RDB is not corrupted.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
