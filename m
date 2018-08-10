Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725724AbeHJE7b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 00:59:31 -0400
Date: Fri, 10 Aug 2018 10:31:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Greg A. Smith" <gasmith@nutanix.com>,
        Peter Turschmid <peter.turschm@nutanix.com>
Subject: Re: Fix for 84676c1f (b5b6e8c8) missing in 4.14.y
Message-ID: <20180810023128.GB2816@ming.t460p>
References: <53EA26B1-86F8-40BF-A128-33137217A3F9@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53EA26B1-86F8-40BF-A128-33137217A3F9@nutanix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 10, 2018 at 02:09:01AM +0000, Felipe Franciosi wrote:
> Hi Ming (and all),
> 
> Your series "scsi: virtio_scsi: fix IO hang caused by irq vector automatic affinity" which forces virtio-scsi to use blk-mq fixes an issue introduced by 84676c1f. We noticed that this bug also exists in 4.14.y (as ef86f3a72adb), but your series was not backported to that stable branch.
> 
> Are there any plans to do that? At least CoreOS is using 4.14 and showing issues on AHV (which provides an mq virtio-scsi controller).
> 

Hi Felipe,

Looks the following 4 patches should have been marked as stable, sorry
for missing that.

b5b6e8c8d3b4 scsi: virtio_scsi: fix IO hang caused by automatic irq vector affinity
2f31115e940c scsi: core: introduce force_blk_mq
adbe552349f2 scsi: megaraid_sas: fix selection of reply queue
8b834bff1b73 scsi: hpsa: fix selection of reply queue

Usually this backporting is done by our stable guys, so I will CC stable
and leave them handle it, but I am happy to provide any help for
addressing conflicts or sort of thing.


Thanks,
Ming
