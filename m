Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:17756 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbdAZDXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 22:23:48 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 12/18] scsi: respect unchecked_isa_dma for blk-mq
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
        <1485365126-23210-13-git-send-email-hch@lst.de>
Date: Wed, 25 Jan 2017 22:23:34 -0500
In-Reply-To: <1485365126-23210-13-git-send-email-hch@lst.de> (Christoph
        Hellwig's message of "Wed, 25 Jan 2017 18:25:20 +0100")
Message-ID: <yq1k29i8pxl.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> Currently blk-mq always allocates the sense buffer using
Christoph> normal GFP_KERNEL allocation.  Refactor the cmd pool code to
Christoph> split the cmd and sense allocation and share the code to
Christoph> allocate the sense buffers as well as the sense buffer slab
Christoph> caches between the legacy and blk-mq path.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
