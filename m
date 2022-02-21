Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F3C433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Feb 2022 13:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348903AbiBUNJo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Feb 2022 08:09:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbiBUNJn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Feb 2022 08:09:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5765C1EAFB
        for <linux-block@vger.kernel.org>; Mon, 21 Feb 2022 05:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645448958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0mufslNXt75K3JhABrZgA0bQHXouv5QJLdHcq6BX8s=;
        b=CBTopYGnbDPOZhGM9adzcFoAGSHrNsj20uXxuNs/3MZLla/4hB/KdmVI5Mboy9TGMglfjv
        2xAzo8gHC+4dE6I7cmAg9VS5cp30wT63uPdw8zZOo8ArDDWt3aXXuLzIBOFbmCkBagFSE5
        y+agDy1wT612OGZhYWj3yyAQaAsHMBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-xQWVsbQCM26PkZhaCKZEfg-1; Mon, 21 Feb 2022 08:09:17 -0500
X-MC-Unique: xQWVsbQCM26PkZhaCKZEfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 322051853026;
        Mon, 21 Feb 2022 13:09:16 +0000 (UTC)
Received: from work (unknown [10.40.194.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BC2E7D70B;
        Mon, 21 Feb 2022 13:09:15 +0000 (UTC)
Date:   Mon, 21 Feb 2022 14:09:12 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Olaf Fraczyk <olaf.fraczyk@gmail.com>
Cc:     Karel Zak <kzak@redhat.com>, linux-block@vger.kernel.org
Subject: Re: blkdiscard BLKDISCARD ioctl failed: Remote I/O error
Message-ID: <20220221130912.kboxxd2dga7edjkf@work>
References: <CAJWTG89dq0-HDb=hSJMdT5WyArH3dy+SKZNXDEr9WOWsaUsMEg@mail.gmail.com>
 <20220221090558.yvkgw2lujwjodhfi@ws.net.home>
 <CAJWTG8-yrpLevVALX9ONnQGEgFcytYuhSk4ge_-qyi0tQS0keg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJWTG8-yrpLevVALX9ONnQGEgFcytYuhSk4ge_-qyi0tQS0keg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

the problem is definitelly not in util-linux. In kernel there are checks
in place that would prevent proceeding with out of range BLKDISCARD ioctl,
but that's not what we hit here.

In the logs below you can see that the actual discard request failed,
but it appears to be well within the device range. I don't know what is
going on, maybe someone in the linux-block have a clue (adding to cc).

Meanwhile please let us know what kernel version do you have and provide
a blkparse output of the blkdiscard run. You can do this for example

blktrace -a discard -d /dev/sdb -o - | \
blkparse -o output -f "%D %2c %8s %5T.%9t %6p %2a %3d %10S + %10U (%4e) [%C]\n" -i -

then run the blkdiscard and see the content of output file.

Thanks!
-Lukas



On Mon, Feb 21, 2022 at 01:34:57PM +0100, Olaf Fraczyk wrote:
> Hello,
> 
> I had to put the disk in use, and I needed it in MBR format, so I can't
> create GPT now.
> 
> Anyway, the reported size seems to be OK.
> 
> I have created 3rd partition to go till the end of the disk, as below:
> 
> Device     Boot      Start        End    Sectors   Size Id Type
> /dev/sdb1             2048    4196351    4194304     2G fd Linux raid
> autodetect
> /dev/sdb2          4196352 1874855935 1870659584   892G fd Linux raid
> autodetect
> /dev/sdb3       1874855936 1875385007     529072 258.3M 83 Linux
> 
> I can fill it to the last sector using dd without problems:
> 
> [root@vh3 ~]# dd if=/dev/zero of=/dev/sdb3 bs=1024 count=264536
> 264536+0 records in
> 264536+0 records out
> 270884864 bytes (271 MB, 258 MiB) copied, 4.81622 s, 56.2 MB/s
> 
> When I do blkdiscard:
> 
> root@vh3 ~]# blkdiscard -l 264536K /dev/sdb3
> blkdiscard: /dev/sdb3: BLKDISCARD ioctl failed: Remote I/O error
> [root@vh3 ~]# blkdiscard -l 264535K /dev/sdb3
> [root@vh3 ~]#
> 
> In the /var/log/messages for the failed discard I get:
> Feb 21 13:19:52 vh3 kernel: sd 1:0:1:0: [sdb] tag#2227 FAILED Result:
> hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
> Feb 21 13:19:52 vh3 kernel: sd 1:0:1:0: [sdb] tag#2227 Sense Key : Illegal
> Request [current]
> Feb 21 13:19:52 vh3 kernel: sd 1:0:1:0: [sdb] tag#2227 Add. Sense: Logical
> block address out of range
> Feb 21 13:19:52 vh3 kernel: sd 1:0:1:0: [sdb] tag#2227 CDB: Unmap/Read
> sub-channel 42 00 00 00 00 00 00 00 18 00
> Feb 21 13:19:52 vh3 kernel: blk_update_request: critical target error, dev
> sdb, sector 1874855936 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0
> 
> I have the drive on a SAS controller - mpt3sas driver, LSI SAS2008
> 
> Best regards,
> 
> Olaf
> 
> 
> 
> 
> 
> pon., 21 lut 2022 o 10:06 Karel Zak <kzak@redhat.com> napisał(a):
> 
> >
> >  Hi Olaf,
> >
> >  from my point of view it seems like kernel (SSD driver) issue. The
> >  ioctl needs to accept range from 0 to device size. The another
> >  possibility is that the device itself reports incorrect size. Do you
> >  see another issue, for example when you try to create GPT partition
> >  table on the device, or so? Do you see anything in dmesg output?
> >
> >  CC: Lukas Czerner who understands kernel part :-)
> >
> >     Karel
> >
> >
> > On Thu, Feb 17, 2022 at 10:32:06PM +0100, Olaf Fraczyk wrote:
> > > Hello,
> > >
> > > Tried:
> > > util-linux-2.32.1-28.el8.x86_64 (Almalinux 8)
> > > util-linux-2.38-rc1 (compiled from sources)
> > >
> > > I have a problem with blkdiscard and Samsung  PM893 SSD 960GB drive.
> > >
> > > I tried to trim entire drive but I get the following error:
> > > [root@vh3 util-linux-2.38-rc1]# ./blkdiscard /dev/sdb
> > > lt-blkdiscard: /dev/sdb: BLKDISCARD ioctl failed: Remote I/O error
> > >
> > > I have done strace and I see:
> > > ioctl(3, BLKGETSIZE64, [960197124096])  = 0
> > > ioctl(3, BLKSSZGET, [512])              = 0
> > > ioctl(3, BLKDISCARD, [0, 960197124096]) = -1 EREMOTEIO (Remote I/O error)
> > >
> > > When I do the same giving length explicitly I get the same error.
> > >
> > > However when I specify the length 512 bytes smaller, it works without a
> > > problem:
> > >
> > > ioctl(3, BLKGETSIZE64, [960197124096])  = 0
> > > ioctl(3, BLKSSZGET, [512])              = 0
> > > ioctl(3, BLKDISCARD, [0, 960197123584]) = 0
> > >
> > > Disk size from fdisk:
> > > [root@vh3 util-linux-2.38-rc1]# fdisk -l /dev/sdb
> > > Disk /dev/sdb: 894.3 GiB, 960197124096 bytes, 1875385008 sectors
> > > Units: sectors of 1 * 512 = 512 bytes
> > > Sector size (logical/physical): 512 bytes / 4096 bytes
> > > I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> > >
> > >
> > > Is this a problem with the SSD drive or with the blkdiscard command /
> > ioctl?
> > > Could you please help me solve this issue?
> > >
> > > Best regards,
> > >
> > > Olaf Frączyk
> >
> > --
> >  Karel Zak  <kzak@redhat.com>
> >  http://karelzak.blogspot.com
> >
> >

