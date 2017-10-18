Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22792 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdJRWl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 18:41:29 -0400
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/2] block: factor out __blkdev_issue_zero_pages()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1508162350-21978-1-git-send-email-idryomov@gmail.com>
        <1508162350-21978-2-git-send-email-idryomov@gmail.com>
Date: Wed, 18 Oct 2017 18:40:08 -0400
In-Reply-To: <1508162350-21978-2-git-send-email-idryomov@gmail.com> (Ilya
        Dryomov's message of "Mon, 16 Oct 2017 15:59:09 +0200")
Message-ID: <yq1tvywqdvb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Ilya,

> blkdev_issue_zeroout() will use this in !BLKDEV_ZERO_NOFALLBACK case.

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
