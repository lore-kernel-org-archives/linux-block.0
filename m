Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:58987 "EHLO
        mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbcJKQ3N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2016 12:29:13 -0400
Date: Tue, 11 Oct 2016 12:27:09 -0400 (EDT)
From: Laurence Oberman <loberman@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
Message-ID: <2065305791.1268439.1476203229110.JavaMail.zimbra@redhat.com>
In-Reply-To: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
Subject: Re: [PATCH 0/9] Introduce blk_quiesce_queue() and
 blk_resume_queue()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



----- Original Message -----
> From: "Bart Van Assche" <bart.vanassche@sandisk.com>
> To: "Jens Axboe" <axboe@fb.com>
> Cc: "Christoph Hellwig" <hch@lst.de>, "James Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen"
> <martin.petersen@oracle.com>, "Mike Snitzer" <snitzer@redhat.com>, "Doug Ledford" <dledford@redhat.com>, "Keith
> Busch" <keith.busch@intel.com>, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
> linux-nvme@lists.infradead.org
> Sent: Monday, September 26, 2016 2:25:54 PM
> Subject: [PATCH 0/9] Introduce blk_quiesce_queue() and blk_resume_queue()
> 
> Hello Jens,
> 
> Multiple block drivers need the functionality to stop a request queue
> and to wait until all ongoing request_fn() / queue_rq() calls have
> finished without waiting until all outstanding requests have finished.
> Hence this patch series that introduces the blk_quiesce_queue() and
> blk_resume_queue() functions. The dm-mq, SRP and nvme patches in this
> patch series are three examples of where these functions are useful.
> These patches apply on top of the September 21 version of your
> for-4.9/block branch. The individual patches in this series are:
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
> 
> Thanks,
> 
> Bart.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
Hello

I took Bart's latest patches from his tree and tested all the SRP/RDMA and as many of the nvme tests.

Everything is passing my tests, including SRP port resets etc.
The nvme tests were all on a small intel nvme card.

Tested-by: Laurence Oberman <loberman@redhat.com>
