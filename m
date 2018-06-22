Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754291AbeFVVni (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 17:43:38 -0400
Date: Sat, 23 Jun 2018 05:43:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
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
Subject: Re: [PATCH 0/3] scsi: scsi-mq: don't hold host_busy in IO path
Message-ID: <20180622214316.GC2949@ming.t460p>
References: <20180420065742.8043-1-ming.lei@redhat.com>
 <994729bc-7ca4-6671-d454-d4612ce59b25@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <994729bc-7ca4-6671-d454-d4612ce59b25@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 22, 2018 at 08:29:20AM -0700, Bart Van Assche wrote:
> On 04/20/18 00:00, Ming Lei wrote:
> > This patches removes the expensive atomic opeation on host-wide counter
> > of .host_busy for scsi-mq, and it is observed that IOPS can be increased by
> > 15% with this change in IO test over scsi_debug.
> 
> Hello Ming,
> 
> Do you want to resend these patches to Martin or do you perhaps that I do
> that myself?

Hi Bart,

I will resend it later.

thanks,
Ming
