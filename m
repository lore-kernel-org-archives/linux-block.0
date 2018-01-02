Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753436AbeABDCF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jan 2018 22:02:05 -0500
Date: Tue, 2 Jan 2018 11:01:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH V2 2/6] blk-mq: support concurrent blk_mq_quiesce_queue()
Message-ID: <20180102030146.GA20428@ming.t460p>
References: <20171214023103.18272-1-ming.lei@redhat.com>
 <20171214023103.18272-3-ming.lei@redhat.com>
 <20171229095833.GB24507@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229095833.GB24507@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 29, 2017 at 10:58:33AM +0100, Christoph Hellwig wrote:
> The quiesce count looks good to me.  But I'm really worried about
> the force unquiesce in nvme.  I'd feel much better if we could find

This patch doesn't change the behaviour wrt. force unquiesce in NVMe,
which has been done since commit 443bd90f2cca(nvme: host: unquiesce queue
in nvme_kill_queues()).

The reason is that NVMe's usage of blk_mq_quiesce_queue() is a bit complicated,
for example:

- nvme_dev_disable(false) may be called two times in reset_work()
- queue may never be started in nvme_fw_act_work()
...

But blk_cleanup_queue() can be triggered anytime.

> a way to move this into the core.

We can't move the force unquiesce into blk_set_queue_dying() or other
places in core before calling blk_cleanup_queue(), because that may
break SCSI which uses quiesce to implement device block.

thanks,
Ming
