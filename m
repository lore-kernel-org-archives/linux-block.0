Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0081.outbound.protection.outlook.com ([104.47.37.81]:5818
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756104AbcJRV4M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2016 17:56:12 -0400
Subject: Re: [PATCH v3 0/11] Fix race conditions related to stopping block
 layer queues
To: Jens Axboe <axboe@fb.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lin <ming.l@ssi.samsung.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <8fa81aa5-746f-c163-e26b-3a7becf7259e@sandisk.com>
Date: Tue, 18 Oct 2016 14:56:04 -0700
MIME-Version: 1.0
In-Reply-To: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/18/2016 02:48 PM, Bart Van Assche wrote:
> - blk_mq_quiesce_queue() has been reworked (thanks to Ming Lin and Sagi
>    for their feedback).

(replying to my own e-mail)

A correction: Ming Lei provided feedback on v2 of this patch series 
instead of Ming Lin.

Bart.
