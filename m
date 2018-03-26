Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:8544 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbeCZTa6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Mar 2018 15:30:58 -0400
Date: Mon, 26 Mar 2018 13:33:21 -0600
From: Keith Busch <keith.busch@intel.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
Message-ID: <20180326193320.GA30867@localhost.localdomain>
References: <20180323221923.24545-1-keith.busch@intel.com>
 <d818f023-01a5-0728-2cc9-7a0649b5df3c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d818f023-01a5-0728-2cc9-7a0649b5df3c@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Mar 24, 2018 at 09:55:49PM +0800, jianchao.wang wrote:
> Maybe we could provide a callback parameter for __blk_mq_pci_map_queues which
> give the mapping from hctx queue num to device-relative interrupt vector index.

If a driver's mapping is so complicated as to require a special per-hctx
callback, it'd be just as easy to implement the mapping in that driver's
blk_mq_ops' 'map_queues' directly.
