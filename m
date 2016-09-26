Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com ([104.47.38.52]:43072
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161228AbcIZSrA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2016 14:47:00 -0400
Subject: Re: [PATCH 0/9] Introduce blk_quiesce_queue() and blk_resume_queue()
To: Mike Snitzer <snitzer@redhat.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <20160926183308.GA13309@redhat.com>
CC: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <9cffd6ee-2940-b2b7-cbfc-47dd6307593a@sandisk.com>
Date: Mon, 26 Sep 2016 11:46:44 -0700
MIME-Version: 1.0
In-Reply-To: <20160926183308.GA13309@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/26/2016 11:33 AM, Mike Snitzer wrote:
> On Mon, Sep 26 2016 at  2:25pm -0400,
> Bart Van Assche <bart.vanassche@sandisk.com> wrote:
>
>> Hello Jens,
>>
>> Multiple block drivers need the functionality to stop a request
>> queue and to wait until all ongoing request_fn() / queue_rq() calls
>> have finished without waiting until all outstanding requests have
>> finished. Hence this patch series that introduces the
>> blk_quiesce_queue() and blk_resume_queue() functions. The dm-mq, SRP
>> and nvme patches in this patch series are three examples of where
>> these functions are useful. These patches apply on top of the
>> September 21 version of your for-4.9/block branch. The individual
>> patches in this series are:
>>
>> 0001-blk-mq-Introduce-blk_mq_queue_stopped.patch
>> 0002-dm-Fix-a-race-condition-related-to-stopping-and-star.patch
>> 0003-RFC-nvme-Use-BLK_MQ_S_STOPPED-instead-of-QUEUE_FLAG_.patch
>> 0004-block-Move-blk_freeze_queue-and-blk_unfreeze_queue-c.patch
>> 0005-block-Extend-blk_freeze_queue_start-to-the-non-blk-m.patch
>> 0006-block-Rename-mq_freeze_wq-and-mq_freeze_depth.patch
>> 0007-blk-mq-Introduce-blk_quiesce_queue-and-blk_resume_qu.patch
>> 0008-SRP-transport-Port-srp_wait_for_queuecommand-to-scsi.patch
>> 0009-RFC-nvme-Fix-a-race-condition.patch
>
> Hi Bart,
>
> How much testing has this series seen?  Did you run it against the
> mptest testsuite? https://github.com/snitm/mptest
>
> I did notice patch 2 should come after patch 7 (not sure if other
> patches are out of order).

Hello Mike,

Regarding testing: I have primarily used my srp-test regression test 
suite to test this patch series because that test suite uncovered a 
dm-mq race that was not discovered by mptest. I'm currently running 
xfstests (to verify an ib_srp change that is not in this patch series) 
and will run mptest next.

You are right that patch 2 should come after patch 7. The order of the 
other patches in this series should be fine.

Bart.
