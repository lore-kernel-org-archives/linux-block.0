Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36199 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbcJERul (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2016 13:50:41 -0400
Subject: Re: [PATCH v2 1/7] blk-mq: Introduce blk_mq_queue_stopped()
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <26c7db22-bac8-6d8c-ba6e-3cbf0cec3368@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c5a9fd34-a8fa-d50f-20c2-a48f1f807e04@grimberg.me>
Date: Wed, 5 Oct 2016 20:50:26 +0300
MIME-Version: 1.0
In-Reply-To: <26c7db22-bac8-6d8c-ba6e-3cbf0cec3368@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
