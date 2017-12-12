Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59621 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbdLLOOA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 09:14:00 -0500
Date: Tue, 12 Dec 2017 15:13:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 6/6] nvme: remove .init_request callback
Message-ID: <20171212141358.GB7849@lst.de>
References: <20171212110232.12495-1-ming.lei@redhat.com> <20171212110232.12495-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212110232.12495-7-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 12, 2017 at 07:02:32PM +0800, Ming Lei wrote:
> It may cause race by setting 'nvmeq' in nvme_init_request()
> because .init_request is called inside switching io scheduler, which
> may happen when the NVMe device is being resetted and its nvme queues
> are being freed and created. We don't have any sync between the two
> pathes.
> 
> This patch removes the .init_request callback and sets the nvmeq runtime,
> and fixes the following bug:

If ->init_request doesn't work for NVMe it won't work for any other
driver either, so we need to remove it entirely if we can't fix it.

I'd much rather try to fix it first, though.
