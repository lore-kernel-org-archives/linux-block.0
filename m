Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:48064 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbeFEOe7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jun 2018 10:34:59 -0400
Date: Tue, 5 Jun 2018 08:37:40 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 13/14] nvme: use the changed namespaces list log to clear
 ns data changed AENs
Message-ID: <20180605143740.GA10501@localhost.localdomain>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-14-hch@lst.de>
 <20180604195908.GC8205@localhost.localdomain>
 <20180605044733.GA29448@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180605044733.GA29448@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 05, 2018 at 06:47:33AM +0200, Christoph Hellwig wrote:
> But let's assume we don't want to use the list due to this concern:
> we'd still have to read the log page, as per the NVMe spec the only
> think clearing a pending AEN is reading the associated log page.
> We'd then need to still do the full scan using identify.  Is this what
> we want?  If you think this is important for reliability we could
> just ignore the log page.

That sounds good. Let's have the driver read the log page to re-arm
the event as you've done, but don't rely on the contents for namespace
enumeration.

The rest of your series looks good to me.
