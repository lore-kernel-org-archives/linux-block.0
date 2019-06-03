Return-Path: <SRS0=uYlv=UC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F865C04AB5
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 21:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C1F25E44
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 21:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxTvQ5J6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFCVnq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:43:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37716 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFCVnq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jun 2019 17:43:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23so11368376pff.4;
        Mon, 03 Jun 2019 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YQ9KOEQkrUrE3BH10zdSnyauWIlgxvI2MCvsKO92OqM=;
        b=QxTvQ5J6FQS96wGuPSX0j5luE25HmxVJsQtcbv4b2I8gAMurDCfy3uGgLVxe+iLNwO
         48Z4uXHPz+TdTDxjdUPuxDIkPSB1sC0Aux/g5/ARDUx13CrswG31y+Drwik4csFLuQCf
         KYtNjxR/13Sm9u2QRbVUl09oC5iryUJQMXew7KGAVDVbgXEQ2wayqky88Z2YvMfUDDlE
         M04F0B92b5mEjrg5cwLqzVE5zIKSHy+cQI/7ZjcAj0a0G8yA93ego6yM3P/Z8/Jp8g/S
         PqIeLesmFCbCfNoLShgO7pksrOB+9JrLlXGAKxuYj39c7a6Ozsv4wjiJmdsP2T9rsq+3
         He+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YQ9KOEQkrUrE3BH10zdSnyauWIlgxvI2MCvsKO92OqM=;
        b=rXl14edp87/Dq2cVxnHJbThVvHmOQgMlPoquuGeifgU8H8b6yk391LReN86O6chMkd
         9mcrqCx0RtKzpF9FQD6YXXZAFXmcDY48GF3gjQliI7zY+8o0tlBih+MFzAumvwd5BSod
         KmoVijNLuNJOAe+grFGejtje8sOSt0oH6m58ifbSfDIj/s8LSN7HhnzDb9VJ24YlOGo1
         32ZuxeHFVmpX3uZ8HVQ1WsuJ71T6Yte4tUZ3tuSm9pp5qa/OOQUfsb6ToHYxzHRHLXOK
         N0Bzd5UzQxeKWyP9M3PoiGmhgE0j4cYTqyO03HZ0mr7FjGwogbbGTd7sRE+RQcL9mRy8
         cnlg==
X-Gm-Message-State: APjAAAUzmtgyL7Wu4FOz4GMHJpZpNoHvU2eZhQkIUF/UA5zOo1PsEIhh
        nkF/VUleAjxk3+fNEME5EOtnPJUc
X-Google-Smtp-Source: APXvYqyJ9A9knaCRAQg0tTXkPDokVjBHleDqoD0QQ8nkArGFOrUrEd3i93/pb7zdr6VuPwNBWQt2NQ==
X-Received: by 2002:a63:591d:: with SMTP id n29mr30397960pgb.75.1559594665229;
        Mon, 03 Jun 2019 13:44:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z18sm15738390pfa.101.2019.06.03.13.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:44:23 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:44:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V4 3/3] scsi: core: avoid to pre-allocate big chunk for
 sg list
Message-ID: <20190603204422.GA7240@roeck-us.net>
References: <20190428073932.9898-1-ming.lei@redhat.com>
 <20190428073932.9898-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428073932.9898-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 28, 2019 at 03:39:32PM +0800, Ming Lei wrote:
> Now scsi_mq_setup_tags() pre-allocates a big buffer for IO sg list,
> and the buffer size is scsi_mq_sgl_size() which depends on smaller
> value between shost->sg_tablesize and SG_CHUNK_SIZE.
> 
> Modern HBA's DMA is often capable of deadling with very big segment
> number, so scsi_mq_sgl_size() is often big. Suppose the max sg number
> of SG_CHUNK_SIZE is taken, scsi_mq_sgl_size() will be 4KB.
> 
> Then if one HBA has lots of queues, and each hw queue's depth is
> high, pre-allocation for sg list can consume huge memory.
> For example of lpfc, nr_hw_queues can be 70, each queue's depth
> can be 3781, so the pre-allocation for data sg list is 70*3781*2k
> =517MB for single HBA.
> 
> There is Red Hat internal report that scsi_debug based tests can't
> be run any more since legacy io path is killed because too big
> pre-allocation.
> 
> So switch to runtime allocation for sg list, meantime pre-allocate 2
> inline sg entries. This way has been applied to NVMe PCI for a while,
> so it should be fine for SCSI too. Also runtime sg entries allocation
> has verified and run always in the original legacy io path.
> 
> Not see performance effect in my big BS test on scsi_debug.
> 

This patch causes a variety of boot failures in -next. Typical failure
pattern is scsi hangs or failure to find a root file system. For example,
on alpha, trying to boot from usb:

scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
sd 0:0:0:0: Power-on or device reset occurred
sd 0:0:0:0: [sda] 20480 512-byte logical blocks: (10.5 MB/10.0 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] Attached SCSI disk
usb 1-1: reset full-speed USB device number 2 using ohci-pci
sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x07 driverbyte=0x00
sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 00 58 00 00 42 00
print_req_error: I/O error, dev sda, sector 88 flags 80000
EXT4-fs error (device sda): __ext4_get_inode_loc:4703: inode #2: block 44: comm
swapper: unable to read itable block
EXT4-fs (sda): get root inode failed
EXT4-fs (sda): mount failed
VFS: Cannot open root device "sda" or unknown-block(8,0): error -5

Similar problems are seen with other architectures.
Reverting the patch fixes the problem. Bisect log attached.

Guenter

---
# bad: [ae3cad8f39ccf8d31775d9737488bccf0e44d370] Add linux-next specific files for 20190603
# good: [f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a] Linux 5.2-rc3
git bisect start 'HEAD' 'v5.2-rc3'
# good: [8ff6f4c6e067a9d3f3bbacf02c4ea5eb81fe2c6a] Merge remote-tracking branch 'crypto/master'
git bisect good 8ff6f4c6e067a9d3f3bbacf02c4ea5eb81fe2c6a
# good: [6c93755861ce6a6dd904df9cdae9f08671132dbe] Merge remote-tracking branch 'iommu/next'
git bisect good 6c93755861ce6a6dd904df9cdae9f08671132dbe
# good: [1a567956cb3be5754d94ce9380a2151e57e204a7] Merge remote-tracking branch 'cgroup/for-next'
git bisect good 1a567956cb3be5754d94ce9380a2151e57e204a7
# bad: [a6878ca73cf30b83efbdfb1ecc443d7cfb2d8193] Merge remote-tracking branch 'rtc/rtc-next'
git bisect bad a6878ca73cf30b83efbdfb1ecc443d7cfb2d8193
# bad: [25e7f57cf9f86076704b543628a0f02d3d733726] Merge remote-tracking branch 'gpio/for-next'
git bisect bad 25e7f57cf9f86076704b543628a0f02d3d733726
# bad: [28e85db94534c92fa00d787264e3ea1843d1dc42] scsi: lpfc: Fix nvmet handling of received ABTS for unmapped frames
git bisect bad 28e85db94534c92fa00d787264e3ea1843d1dc42
# bad: [cf9eddf616bb03387e597629142b0be34111e8d0] scsi: hpsa: check for tag collision
git bisect bad cf9eddf616bb03387e597629142b0be34111e8d0
# good: [4e74166c52a836f05d4bd8270835703908b34d3e] scsi: libsas: switch sas_ata.[ch] to SPDX tags
git bisect good 4e74166c52a836f05d4bd8270835703908b34d3e
# good: [f186090846c29fd9760917fb3d01f095c39262e0] scsi: lib/sg_pool.c: improve APIs for allocating sg pool
git bisect good f186090846c29fd9760917fb3d01f095c39262e0
# bad: [12b6b55806928690359bb21de3a19199412289fd] scsi: sd: Inline sd_probe_part2()
git bisect bad 12b6b55806928690359bb21de3a19199412289fd
# bad: [c3288dd8c2328a74cb2157dff18d13f6a75cedd2] scsi: core: avoid pre-allocating big SGL for data
git bisect bad c3288dd8c2328a74cb2157dff18d13f6a75cedd2
# good: [0f0e744eae6c8af361d227d3a2286973351e5a2a] scsi: core: avoid pre-allocating big SGL for protection information
git bisect good 0f0e744eae6c8af361d227d3a2286973351e5a2a
# first bad commit: [c3288dd8c2328a74cb2157dff18d13f6a75cedd2] scsi: core: avoid pre-allocating big SGL for data
