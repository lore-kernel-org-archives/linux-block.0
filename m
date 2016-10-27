Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ant-001.se.1eurohost.be ([5.134.1.73]:59197 "EHLO
        ant-001.se.1eurohost.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752855AbcJ0DR3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2016 23:17:29 -0400
Subject: Re: [PATCH 05/12] blk-mq: Introduce blk_mq_quiesce_queue()
To: Ming Lei <tom.leiming@gmail.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
        <5143c240-39af-9fe2-d3e6-ed69f9c20531@sandisk.com>
        <CACVXFVPWL=izFmUPtpi-+RLrhNX0LFfw2m6eurgMC5GvfDWsxQ@mail.gmail.com>
        <7690b469-f5b7-ab04-4b6f-fa0d679e0f18@acm.org>
        <CACVXFVNvdNXm4JXsXo2p1_pZLqDpCos0MTTR+svR98p_vw5PCA@mail.gmail.com>
        <16074653-5e31-27b0-90db-33d36a9df0bc@acm.org>
        <CACVXFVNyRnJFnsSO9TNksE5GNy7TJKL=iZnqrv38=u0XCrW7jA@mail.gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <8404f2d1-5bc3-6c84-7ca0-24e7672ff67d@acm.org>
Date: Wed, 26 Oct 2016 20:05:14 -0700
MIME-Version: 1.0
In-Reply-To: <CACVXFVNyRnJFnsSO9TNksE5GNy7TJKL=iZnqrv38=u0XCrW7jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/26/16 19:48, Ming Lei wrote:
> On Thu, Oct 27, 2016 at 10:40 AM, Bart Van Assche <bvanassche@acm.org> wrote:
>> If you have a look at the later patches in this series then you will see
>> that the dm core and the NVMe driver have been modified such that
>> blk_mq_stop_hw_queues(q) is called immediately before
>> blk_mq_quiesce_queue(q) is called.
>
> Cause any current and future users of blk_mq_quiesce_queue(q)
> have to set the flag via blk_mq_stop_hw_queues(q), why not set
> the flag explicitly in blk_mq_quiesce_queue(q)?

Hello Ming,

I'll leave it to Jens to decide whether I should repost the patch series 
with this change integrated or whether to realize this change with a 
follow-up patch.

Bart.

