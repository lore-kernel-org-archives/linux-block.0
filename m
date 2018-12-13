Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52370C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 11:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA5420870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 11:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA5420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeLMLgB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:36:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33411 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeLMLgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 06:36:01 -0500
Received: from 201-68-129-100.dsl.telesp.net.br ([201.68.129.100] helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gXPHY-0002UX-9r; Thu, 13 Dec 2018 11:35:56 +0000
Date:   Thu, 13 Dec 2018 09:35:50 -0200
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/4] nvme multipath: expose slaves/holders
Message-ID: <20181213113549.GA7543@calabresa>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <bd4405c7-560c-f138-78f0-023807f96367@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd4405c7-560c-f138-78f0-023807f96367@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 10:33:13AM +0100, Johannes Thumshirn wrote:
> On 06/12/2018 17:48, Thadeu Lima de Souza Cascardo wrote:
> > Exposing slaves/holders is necessary in order to find out the real PCI device
> > and its driver for the root filesystem when generating an initramfs with
> > initramfs-tools. That fails right now for nvme multipath devices, which this
> > patchset fixes.
> > 
> > However, because the slave devices are hidden, lsblk fails without some extra
> > patches, as it can't find the device numbers for the slave devices, and exits.
> 
> Sorry for chiming in so late, can someone give me an explanation what
> actually is broken?
> 
> I know this is technically a user visible regression, but isn't lsblk
> (and others) already fixed? I believe it's [1] in util-linux.
> 
> And to find out the PCI device, why do you need slaves/holders here?
> Have a look at blktest's _get_pci_dev_from_blkdev() function [2].
> 
> [1] d51f05bfecb2 ("lsblk: try device/dev to read devno")
> [2] https://github.com/osandov/blktests/blob/master/common/rc#L185

Those two work fine for the block device associated to a controller. Now, when
multipath is used, there is now a virtual block device that balances IO to the
real paths.

# readlink -f /sys/block/nvme0n1/device
/sys/devices/virtual/nvme-subsystem/nvme-subsys0
#

And we can't just give it a parent because it may have multiple parents as it
might have multiple slaves, which is something we can represent, and has been
in use for a long time.

Now, the issue with lsblk is that the hidden block devices won't have a dev.
And now that I think of it, when you are reading device/dev instead of dev for
the nvme block device, you are, in fact, looking at the dev for the character
device, which seems wrong.

You are looking at nvme0, which is the character device that works as a
controlling interface. So, there is no reason lsblk should use that as the dev
number for the block device.

Cascardo.

> 
> Byte,
> 	Johannes
> -- 
> Johannes Thumshirn                            SUSE Labs Filesystems
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
> Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
