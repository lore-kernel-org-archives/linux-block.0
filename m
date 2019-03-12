Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1889CC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83632084F
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfCLBc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:32:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfCLBc5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 21:32:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24D9181F25;
        Tue, 12 Mar 2019 01:32:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A492C19C71;
        Tue, 12 Mar 2019 01:32:51 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:32:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: NVMe: Regression: write zeros corrupts ext4 file system
Message-ID: <20190312013245.GD28841@ming.t460p>
References: <20190311022441.GA16849@ming.t460p>
 <20190311145457.GA10411@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311145457.GA10411@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 12 Mar 2019 01:32:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 08:54:59AM -0600, Keith Busch wrote:
> On Mon, Mar 11, 2019 at 10:24:42AM +0800, Ming Lei wrote:
> > Hi,
> > 
> > It is observed that ext4 is corrupted easily by running some workloads
> > on QEMU NVMe, such as:
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
> > 
> > QEMU version:
> > 
> > QEMU emulator version 2.10.2(qemu-2.10.2-1.fc27)
> > Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
> 
> In QEMU, blk_aio_pwrite_zeroes() takes bytes, but the nvme controller
> thought it was blocks. Oops, that went by unnoticed till now!
> 
> We should fix QEMU (patch below). Question is, should we quirk driver 
> for older versions too?

I think so, users may never upgrade their QEMU.

Thanks,
Ming
