Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3BAC43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 10:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E854020657
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 10:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCKKQb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:16:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbfCKKQb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 06:16:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C4B130821F9;
        Mon, 11 Mar 2019 10:16:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EE9D5D706;
        Mon, 11 Mar 2019 10:16:24 +0000 (UTC)
Date:   Mon, 11 Mar 2019 18:16:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: NVMe: Regression: write zeros corrupts ext4 file system
Message-ID: <20190311101618.GA26229@ming.t460p>
References: <20190311022441.GA16849@ming.t460p>
 <08f3d0f9-c10c-ef72-72f5-62670388763b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f3d0f9-c10c-ef72-72f5-62670388763b@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 11 Mar 2019 10:16:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 03:54:16PM +0800, Dongli Zhang wrote:
> 
> 
> On 3/11/19 10:24 AM, Ming Lei wrote:
> > Hi,
> > 
> > It is observed that ext4 is corrupted easily by running some workloads
> > on QEMU NVMe, such as:
> 
> I cannot reproduce with most recent up-to-date mainline kernel on below qemu
> versions:
> 
> - qemu-2.10.2
> - qemu-3.0.0

The qemu in my test is from Fedora 27, and it isn't built by me, and
'qemu-system-x86_64 -version' shows that:

	QEMU emulator version 2.10.2(qemu-2.10.2-1.fc27)

My test VM is actually cloned from the official Fedora 27 Cloud image[1],
then run 'dnf update' before starting the test.

[1] https://download.fedoraproject.org/pub/fedora/linux/releases/27/CloudImages/x86_64/images/Fedora-Cloud-Base-27-1.6.x86_64.qcow2

> 
> > 
> > 1) mkfs.ext4 /dev/nvme0n1
> > 
> > 2) mount /dev/nvme0n1 /mnt
> > 
> > 3) cd /mnt; git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > 
> > 4) then the following error message may show up:
> > 
> > [ 1642.271816] EXT4-fs error (device nvme0n1): ext4_mb_generate_buddy:747: group 0, block bitmap and bg descriptor inconsistent: 32768 vs 23513 free clusters
> > 
> > Or fsck.ext4 will complain after running 'umount /mnt'
> > 
> > The issue disappears by reverting 6e02318eaea53eaafe6 ("nvme: add support for the
> > Write Zeroes command").
> 
> As above commit is for Write Zeros command, I instrument and add printf at the
> beginning of nvme_write_zeros() for qemu-2.10.2.
> 
> nvme_write_zeros() are only called for 47 times during "mount /dev/nvme0n1 /mnt".
> 
> 
> During "git clone" from torvalds' linux.git, there is no call of nvme_write_zeros().
> 
> Perhaps there is some special configuration required to trigger the
> nvme_write_zeros() on purpose during "git clone" to involve the
> nvme_cmd_write_zeroes on kernel side?

It can be triggered by random write workloads after mkfs & mount on the
nvme.

> 
> My test nvme image is only about 5GB.

Mine is 8GB.


Thanks,
Ming
