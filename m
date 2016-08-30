Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13986 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbcH3XRu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2016 19:17:50 -0400
Date: Tue, 30 Aug 2016 19:28:24 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: blk-mq: allow passing in an external queue mapping V2
Message-ID: <20160830232824.GA2807@localhost.localdomain>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472468013-29936-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 29, 2016 at 12:53:26PM +0200, Christoph Hellwig wrote:
> This series is one third of the earlier "automatic interrupt affinity for
> MSI/MSI-X capable devices" series, and make uses of the new irq-level
> interrupt / queue mapping code in blk-mq, as well as allowing the driver
> to pass in such a mask obtained from the (PCI) interrupt code.  To fully
> support this feature in drivers the final third in the PCI layer will
> be needed as well.
> 
> Note that these patches are on top of Linux 4.8-rc4 and will need several
> patches not yet in the block for-4.9 branch.
> 
> A git tree is available at:
> 
>    git://git.infradead.org/users/hch/block.git block-queue-mapping
> 
> Gitweb:
> 
>    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-queue-mapping
> 
> Changes since V1:
>  - rebased on top of Linux 4.8-rc4
> 
> Changes since automatic interrupt affinity for MSI/MSI-X capable devices V3:
>  - a trivial cleanup in blk_mq_create_mq_map pointed out by Alexander
> 

I really like how this is looking, but the pairing isn't coming out
right when I applied this on one of my test machines. I have 32 CPUs
and 31 MSI-x vectors, and this is the resulting blk-mq cpu list:

  # cat /sys/block/nvme0n1/mq/*/cpu_list
  0
  10
  11
  12
  13
  14
  15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
  1
  2
  3
  4
  5
  6
  7
  8
  9

Before, each mq hardware queue would have 2 CPUs, now it's terribly
unbalanced.

I'll look again tomorrow to make sure I didn't mess something up when
merging your tree, but just wanted to let you know now.
