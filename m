Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:35698 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbeFZQyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 12:54:16 -0400
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH V2 0/2] scsi: scsi-mq: don't hold host_busy in IO path
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180624140327.28146-1-ming.lei@redhat.com>
Date: Tue, 26 Jun 2018 12:53:44 -0400
In-Reply-To: <20180624140327.28146-1-ming.lei@redhat.com> (Ming Lei's message
        of "Sun, 24 Jun 2018 22:03:25 +0800")
Message-ID: <yq1o9fx32w7.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Ming,

> This patches removes the expensive atomic opeation on host-wide
> counter of .host_busy for scsi-mq, and it is observed that IOPS can be
> increased by 15% with this change in IO test over scsi_debug.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
