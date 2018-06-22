Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51907 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933304AbeFVP3W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 11:29:22 -0400
Subject: Re: [PATCH 0/3] scsi: scsi-mq: don't hold host_busy in IO path
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>
References: <20180420065742.8043-1-ming.lei@redhat.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <994729bc-7ca4-6671-d454-d4612ce59b25@wdc.com>
Date: Fri, 22 Jun 2018 08:29:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180420065742.8043-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/20/18 00:00, Ming Lei wrote:
> This patches removes the expensive atomic opeation on host-wide counter
> of .host_busy for scsi-mq, and it is observed that IOPS can be increased by
> 15% with this change in IO test over scsi_debug.

Hello Ming,

Do you want to resend these patches to Martin or do you perhaps that I 
do that myself?

Thanks,

Bart.
