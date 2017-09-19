Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36551 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbdISUdA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 16:33:00 -0400
Date: Tue, 19 Sep 2017 22:32:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: cope with WRITE SAME failing in
        blkdev_issue_zeroout()
Message-ID: <20170919203258.GB7347@lst.de>
References: <1504719490-7523-1-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504719490-7523-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 06, 2017 at 07:38:10PM +0200, Ilya Dryomov wrote:
> sd_config_write_same() ignores ->max_ws_blocks == 0 and resets it to
> permit trying WRITE SAME on older SCSI devices, unless ->no_write_same
> is set.  This means blkdev_issue_zeroout() must cope with WRITE SAME
> failing with BLK_STS_TARGET/-EREMOTEIO and explicitly write zeroes,
> unless BLKDEV_ZERO_NOFALLBACK is specified.
> 
> Commit 71027e97d796 ("block: stop using discards for zeroing") added
> the following to __blkdev_issue_zeroout() comment:
> 
>   "Note that this function may fail with -EOPNOTSUPP if the driver signals
>   zeroing offload support, but the device fails to process the command (for
>   some devices there is no non-destructive way to verify whether this
>   operation is actually supported).  In this case the caller should call
>   retry the call to blkdev_issue_zeroout() and the fallback path will be used."
> 
> But __blkdev_issue_zeroout() doesn't fail in this case: if WRITE SAME
> support is indicated, a REQ_OP_WRITE_ZEROES bio is built and returned
> to blkdev_issue_zeroout().  -EREMOTEIO is then propagated up:
> 
>   $ fallocate -zn -l 1k /dev/sdg
>   fallocate: fallocate failed: Remote I/O error
>   $ fallocate -zn -l 1k /dev/sdg  # OK
> 
> (The second fallocate(1) succeeds because sd_done() sets ->no_write_same
> in response to a sense that would become BLK_STS_TARGET.)
> 
> Retry __blkdev_issue_zeroout() if the I/O fails with -EREMOTEIO.  This
> is roughly what we did until 4.12, sans BLKDEV_ZERO_NOFALLBACK knob.

I'm really not sure we should check for -EREMOTEIO specifically, but
Martin who is more familiar with the SCSI code might be able to
correct me, I'd feel safer about checking for any error which is
what the old code did.

Except for that the patch looks fine to me.
