Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0087.outbound.protection.outlook.com ([104.47.41.87]:14336
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162640AbcIZS0G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2016 14:26:06 -0400
To: Jens Axboe <axboe@fb.com>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 0/9] Introduce blk_quiesce_queue() and blk_resume_queue()
Message-ID: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
Date: Mon, 26 Sep 2016 11:25:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens,

Multiple block drivers need the functionality to stop a request queue 
and to wait until all ongoing request_fn() / queue_rq() calls have 
finished without waiting until all outstanding requests have finished. 
Hence this patch series that introduces the blk_quiesce_queue() and 
blk_resume_queue() functions. The dm-mq, SRP and nvme patches in this 
patch series are three examples of where these functions are useful. 
These patches apply on top of the September 21 version of your 
for-4.9/block branch. The individual patches in this series are:

0001-blk-mq-Introduce-blk_mq_queue_stopped.patch
0002-dm-Fix-a-race-condition-related-to-stopping-and-star.patch
0003-RFC-nvme-Use-BLK_MQ_S_STOPPED-instead-of-QUEUE_FLAG_.patch
0004-block-Move-blk_freeze_queue-and-blk_unfreeze_queue-c.patch
0005-block-Extend-blk_freeze_queue_start-to-the-non-blk-m.patch
0006-block-Rename-mq_freeze_wq-and-mq_freeze_depth.patch
0007-blk-mq-Introduce-blk_quiesce_queue-and-blk_resume_qu.patch
0008-SRP-transport-Port-srp_wait_for_queuecommand-to-scsi.patch
0009-RFC-nvme-Fix-a-race-condition.patch

Thanks,

Bart.
