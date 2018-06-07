Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42147 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753153AbeFGLRR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Jun 2018 07:17:17 -0400
Date: Thu, 7 Jun 2018 13:24:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCHv2] block: always set partition number to '0' in
        blk_partition_remap()
Message-ID: <20180607112440.GA10915@lst.de>
References: <20180607082944.41676-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180607082944.41676-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 07, 2018 at 10:29:44AM +0200, Hannes Reinecke wrote:
> blk_partition_remap() will only clear bi_partno if an actual remapping
> has happened. But flush request et al don't have an actual size, so
> the remapping doesn't happen and bi_partno is never cleared.
> So for stacked devices blk_partition_remap() will be called on each level.
> If (as is the case for native nvme multipathing) one of the lower-level
> devices do _not_support partitioning a spurious I/O error is generated.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
