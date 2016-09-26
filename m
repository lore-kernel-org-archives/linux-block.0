Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750754AbcIZSdK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2016 14:33:10 -0400
Date: Mon, 26 Sep 2016 14:33:08 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/9] Introduce blk_quiesce_queue() and blk_resume_queue()
Message-ID: <20160926183308.GA13309@redhat.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 26 2016 at  2:25pm -0400,
Bart Van Assche <bart.vanassche@sandisk.com> wrote:

> Hello Jens,
> 
> Multiple block drivers need the functionality to stop a request
> queue and to wait until all ongoing request_fn() / queue_rq() calls
> have finished without waiting until all outstanding requests have
> finished. Hence this patch series that introduces the
> blk_quiesce_queue() and blk_resume_queue() functions. The dm-mq, SRP
> and nvme patches in this patch series are three examples of where
> these functions are useful. These patches apply on top of the
> September 21 version of your for-4.9/block branch. The individual
> patches in this series are:
> 
> 0001-blk-mq-Introduce-blk_mq_queue_stopped.patch
> 0002-dm-Fix-a-race-condition-related-to-stopping-and-star.patch
> 0003-RFC-nvme-Use-BLK_MQ_S_STOPPED-instead-of-QUEUE_FLAG_.patch
> 0004-block-Move-blk_freeze_queue-and-blk_unfreeze_queue-c.patch
> 0005-block-Extend-blk_freeze_queue_start-to-the-non-blk-m.patch
> 0006-block-Rename-mq_freeze_wq-and-mq_freeze_depth.patch
> 0007-blk-mq-Introduce-blk_quiesce_queue-and-blk_resume_qu.patch
> 0008-SRP-transport-Port-srp_wait_for_queuecommand-to-scsi.patch
> 0009-RFC-nvme-Fix-a-race-condition.patch

Hi Bart,

How much testing has this series seen?  Did you run it against the
mptest testsuite? https://github.com/snitm/mptest

I did notice patch 2 should come after patch 7 (not sure if other
patches are out of order).

Mike
