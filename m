Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:39884 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725724AbeHJFDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 01:03:01 -0400
From: Felipe Franciosi <felipe@nutanix.com>
To: Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Omar Sandoval <osandov@fb.com>,
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
Subject: Fix for 84676c1f (b5b6e8c8) missing in 4.14.y
Date: Fri, 10 Aug 2018 02:09:01 +0000
Message-ID: <53EA26B1-86F8-40BF-A128-33137217A3F9@nutanix.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming (and all),

Your series "scsi: virtio_scsi: fix IO hang caused by irq vector automatic =
affinity" which forces virtio-scsi to use blk-mq fixes an issue introduced =
by 84676c1f. We noticed that this bug also exists in 4.14.y (as ef86f3a72ad=
b), but your series was not backported to that stable branch.

Are there any plans to do that? At least CoreOS is using 4.14 and showing i=
ssues on AHV (which provides an mq virtio-scsi controller).

Thanks,
Felipe=
