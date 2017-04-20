Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49401 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754947AbdDTCFh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 22:05:37 -0400
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, ceph-devel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] block: get rid of blk_integrity_revalidate()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1492533800-30627-1-git-send-email-idryomov@gmail.com>
Date: Wed, 19 Apr 2017 22:04:59 -0400
In-Reply-To: <1492533800-30627-1-git-send-email-idryomov@gmail.com> (Ilya
        Dryomov's message of "Tue, 18 Apr 2017 18:43:20 +0200")
Message-ID: <yq1shl3rfzo.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ilya Dryomov <idryomov@gmail.com> writes:

Ilya,

> Commit 25520d55cdb6 ("block: Inline blk_integrity in struct gendisk")
> introduced blk_integrity_revalidate(), which seems to assume ownership
> of the stable pages flag and unilaterally clears it if no blk_integrity
> profile is registered:
>
>     if (bi->profile)
>             disk->queue->backing_dev_info->capabilities |=
>                     BDI_CAP_STABLE_WRITES;
>     else
>             disk->queue->backing_dev_info->capabilities &=
>                     ~BDI_CAP_STABLE_WRITES;
>
> It's called from revalidate_disk() and rescan_partitions(), making it
> impossible to enable stable pages for drivers that support partitions
> and don't use blk_integrity: while the call in revalidate_disk() can be
> trivially worked around (see zram, which doesn't support partitions and
> hence gets away with zram_revalidate_disk()), rescan_partitions() can
> be triggered from userspace at any time.  This breaks rbd, where the
> ceph messenger is responsible for generating/verifying CRCs.
>
> Since blk_integrity_{un,}register() "must" be used for (un)registering
> the integrity profile with the block layer, move BDI_CAP_STABLE_WRITES
> setting there.  This way drivers that call blk_integrity_register() and
> use integrity infrastructure won't interfere with drivers that don't
> but still want stable pages.

I seem to recall that the reason for the revalidate hook was that either
NVMe or nvdimm had to register an integrity profile prior to the actual
format being known.

So while I am OK with the change from a SCSI perspective, I think we
need Keith and Dan to ack it.

-- 
Martin K. Petersen	Oracle Linux Engineering
