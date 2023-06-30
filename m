Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBDEB64DD
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 08:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjF3If3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjF3IfY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 04:35:24 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A753D1FC1;
        Fri, 30 Jun 2023 01:35:20 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 85B3972727C;
        Fri, 30 Jun 2023 10:35:17 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Darren Stevens <darren@stevens-zone.net>
Subject: Re: [FSL P50x0] [PASEMI] The Access to partitions on disks with an Amiga
 partition table doesn't work anymore after the block updates 2023-06-23
Date:   Fri, 30 Jun 2023 10:35:16 +0200
Message-ID: <5866778.MhkbZ0Pkbq@lichtvoll.de>
In-Reply-To: <a113cb83-9f82-fd39-f132-41ba4c259265@gmail.com>
References: <024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de>
 <a113cb83-9f82-fd39-f132-41ba4c259265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael, hi Christian.

Michael Schmitz - 29.06.23, 22:27:59 CEST:
[…]
> On 29/06/23 16:59, Christian Zigotzky wrote:
> > Hello,
> > 
> > The access  to partitions on disks with an Amiga partition table
> > (via the Rigid Disk Block RDB) doesn't work anymore on my Cyrus+ 
> > board with a FSL P50x0 PowerPC SoC [1] and on my P.A. Semi Nemo 
> > board [2] after the block updates 2023-06-23 [3].
> > 
> > parted -l
[…]
> > dmesg | grep -i sda
> > 
> > [    4.208905] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks:
> > (2.00 TB/1.82 TiB)

That is roughly the size of the disk that triggered my bug report from 
2012.

Jun 19 21:19:09 merkaba kernel: [ 7891.821315] ata8.00: 3907029168 
sectors, multi 0: LBA48 NCQ (depth 31/32)

Bug 43511 - Partitions: Amiga RDB partition on 2 TB disk way too big, 
while OK in AmigaOS 4.1

https://bugzilla.kernel.org/show_bug.cgi?id=43511

> > [    4.963387] sda: partition table beyond EOD,
> 
> Haven't see this one in any of my tests. I wonder whether your
> partitioning software used that value of 4294967295 (32 bit unsigned
> int max.) as marker for the end of the partition list, instead of
> NULL? It's clearly beyond the end of your disk, so cannot be a
> legitimate partition block address. (The parted dump above (showing
> only four partitions) appears to support that notion.)

I don't know about "-1" for end of partition list. However, on reviewing 
my bug report I think I used Media Toolbox myself to create the 
partition table. However I am not completely sure about that. It has 
been a long time. I used Media Toolbox on AmigaOS 4.1 to extract the 
binary copy of the RDB, but I do not recall what I used to partition it. 
I bet it was Media Toolbox as well, likely on some development version 
of AmigaOS 4. I was member of the AmigaOS 4 team back then. The disk is 
repartitioned as GPT and I do not even know at the moment where it is. 
So that is all I can say.

I could ask someone from the AmigaOS 4 team, however I am not a member 
of it anymore. And in any case, whether Media Toolbox or another tool 
writes a "-1" to end partition list or not, I'd not treat a signed value 
"-1" as valid partition size. We could also ask Joanne again, however 
she was not involved in AmigaOS 4 development and does not know about 
Media Toolbox. She created the "hdwrench.library" for AmigaOS 3.5/3.9 
HDToolBox. So maybe it is just good to assume "-1" as end of partition 
table, at least after confirming from the binary of the affected RDB that 
the "-1" is indeed at the end of the partition block list. Maybe also in 
the RDB from my bug report there is this "-1" again… however, the disk 
worked okay in Linux after testing with Joanne's initial patch from

https://bugzilla.kernel.org/show_bug.cgi?id=43511#c7

Subject: Re: Partitions: Amiga RDB partition on 2 TB disk way too big, 
while OK in AmigaOS 4.1

https://lore.kernel.org/linux-m68k/
201206192146.09327.Martin@lichtvoll.de/


This comment from an AmigaOS developer is only about the maximum sizes 
and does not detail a "-1" as partition size – however I did not ask 
about it back then:

https://lore.kernel.org/linux-m68k/
201206182239.26647.Martin@lichtvoll.de/

> > [ 5.014769] sd 0:0:0:0: [sda] Attached SCSI disk
> > 
> > I created a patch for reverting the commit. [4]
> > 
> > The access works again with this patch:
[…]
> > bytes [    4.519477]  sda: RDSK (512) sda1 (DOS^G)(res 2 spb 2)
> > sda2 (SFS^B)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 2) sda4 ((res 2
> > spb 1) [    4.720896] sda: p4 size 18446744071956107760 extends
> > beyond EOD,
>
> That's the 32 bit overflow that the patch series was meant to correct.
> Parsing the partition table ends before looking at the next partition
> block in the list, so we never hit the bug you've seen above.
> 
> By reverting my patch, you just reintroduce the old bug, which could
> result in mis-parsing the partition table in a way that is not
> detected by inane values of partition sizes as above, and as far as I
> recall this bug was reported because it did cause data corruption. Do
> I have that correct, Martin? Do you still have a copy of the
> problematic RDB from the old bug report around?

It is in the first attachment of the bug report I mentioned above. The 
bug the patch fixed.

In the bug report I wrote:

"I had a BTRFS filesystem that had some checksum errors. Maybe thats 
somehow related to this issue and AmigaOS and/or Linux overwrote 
something it shouldn´t have touched."

(Meanwhile I bet it is safe to assume that in case the checksum error 
was from overwriting something it was not AmigaOS 4.)

This is no proof, but as I re-read my bug report: It is clearly an 
overflow issue worsened by Linux back then truncating the too high 
partition sizes larger than the disk to the disk size instead of bailing 
out. So the partition I created for the Linux LVM in front of the Amiga 
partitions overflowed into the Amiga partitions. Had I used that place 
inside the PV for any LV and written to it… I bet it would have been 
goodbye to the Amiga data.

> > Could you please check your commit?
> 
> The patch series has undergone the usual thirteen versions in review,
> but the reviewers as well as myself may well have missed this point of
> detail...

I think the patch series has been very well reviewed, but I would not 
have spotted such an issue as I am not really an RDB expert and even 
then, with all the big endian conversions and what not inside of there… 
In my understanding the RDB format is not really as Rigid as the name 
implies. It is quite flexible, especially when compared to what had been 
used on PC back then and sometimes even now. So there is a chance for a 
RDB partitioning that triggers an oversight in the patch series.

> Could you please check this (whitespace-damaged) patch?
> 
>      block/partitions - Amiga partition overflow fix bugfix
> 
>      Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
>      fails the 'blk>0' test in the partition block loop if a
>      value of (signed int) -1 is used to mark the end of the
>      partition block list.
> 
>      Explicitly cast 'blk' to signed int to catch this.
> 
>      Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> 
> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
> index ed222b9c901b..506921095412 100644
> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -90,7 +90,7 @@ int amiga_partition(struct parsed_partitions *state)
> }
>          blk = be32_to_cpu(rdb->rdb_PartitionList);
>          put_dev_sector(sect);
> -       for (part = 1; blk>0 && part<=16; part++, 
> put_dev_sector(sect)) { 
> +       for (part = 1; (s32) blk>0 && part<=16; part++,
> put_dev_sector(sect)) {

Makes sense to me.

Best,
-- 
Martin


