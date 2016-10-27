Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0062.outbound.protection.outlook.com ([104.47.42.62]:20835
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933914AbcJ0P5B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 11:57:01 -0400
Subject: Re: [PATCH 05/12] blk-mq: Introduce blk_mq_quiesce_queue()
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@fb.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <5143c240-39af-9fe2-d3e6-ed69f9c20531@sandisk.com>
 <f1661bd2-12ca-20d1-ece2-5c7fe5987035@suse.de>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <5227b122-8c10-5f63-4448-499fc645cfbd@sandisk.com>
Date: Thu, 27 Oct 2016 08:56:50 -0700
MIME-Version: 1.0
In-Reply-To: <f1661bd2-12ca-20d1-ece2-5c7fe5987035@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/26/2016 10:52 PM, Hannes Reinecke wrote:
> Hmm. Can't say I like having to have two RCU structure for the same
> purpose, but I guess that can't be helped.

Hello Hannes,

There are two RCU structures because of BLK_MQ_F_BLOCKING. Today only 
the nbd driver sets that flag. If the nbd driver would be modified such 
that it doesn't set that flag then the BLK_MQ_F_BLOCKING flag and also 
queue_rq_srcu could be eliminated from the blk-mq core.

Bart.
