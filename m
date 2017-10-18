Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26855 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdJRWsn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 18:48:43 -0400
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/2] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1508162350-21978-1-git-send-email-idryomov@gmail.com>
        <1508162350-21978-3-git-send-email-idryomov@gmail.com>
Date: Wed, 18 Oct 2017 18:48:08 -0400
In-Reply-To: <1508162350-21978-3-git-send-email-idryomov@gmail.com> (Ilya
        Dryomov's message of "Mon, 16 Oct 2017 15:59:10 +0200")
Message-ID: <yq1po9kqdhz.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Ilya,

> sd_config_write_same() ignores ->max_ws_blocks == 0 and resets it to

I'm not so keen on that description.

sd is the entity that owns max_ws_blocks so it certainly doesn't ignore
it. The default is for max_ws_blocks to be set because we have no
generic, non-destructive way of finding out whether a WRITE SAME command
is going to work or not. If a WRITE SAME subsequently fails, we'll
disable the feature by clearing max_write_same_sectors in the queue
limits.

> permit trying WRITE SAME on older SCSI devices, unless ->no_write_same
> is set.  Because REQ_OP_WRITE_ZEROES is implemented in terms of WRITE
> SAME, blkdev_issue_zeroout() may fail with -EREMOTEIO:

Other than that patch looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
