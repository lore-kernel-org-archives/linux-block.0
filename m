Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:40280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeCODgE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 23:36:04 -0400
To: Ming Lei <ming.lei@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V5 0/5] SCSI: fix selection of reply(hw) queue
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180313094243.8710-1-ming.lei@redhat.com>
Date: Wed, 14 Mar 2018 23:35:41 -0400
In-Reply-To: <20180313094243.8710-1-ming.lei@redhat.com> (Ming Lei's message
        of "Tue, 13 Mar 2018 17:42:38 +0800")
Message-ID: <yq1sh929fjm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Ming,

> The patches fixes reply queue(virt-queue on virtio-scsi) selection on
> hpsa, megaraid_sa and virtio-scsi, and IO hang can be caused easily by
> this issue.

I clarified all the commit descriptions. There were also a bunch of
duplicate review tags and other warnings. Please run checkpatch next
time!

Applied to 4.16/scsi-fixes. Thank you.

-- 
Martin K. Petersen	Oracle Linux Engineering
