Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20523 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdIUEnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 00:43:11 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: Ilya Dryomov <idryomov@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: cope with WRITE SAME failing in blkdev_issue_zeroout()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1504719490-7523-1-git-send-email-idryomov@gmail.com>
        <20170919203258.GB7347@lst.de>
Date: Thu, 21 Sep 2017 00:42:58 -0400
In-Reply-To: <20170919203258.GB7347@lst.de> (Christoph Hellwig's message of
        "Tue, 19 Sep 2017 22:32:58 +0200")
Message-ID: <yq1vakck6gd.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Christoph,

> I'm really not sure we should check for -EREMOTEIO specifically, but
> Martin who is more familiar with the SCSI code might be able to
> correct me, I'd feel safer about checking for any error which is
> what the old code did.
>
> Except for that the patch looks fine to me.

We explicitly return -EREMOTEIO when the device reports ILLEGAL
REQUEST. But I agree that we should fall back to manually zeroing for
any error.

-- 
Martin K. Petersen	Oracle Linux Engineering
