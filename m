Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:17883 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbdAZDYa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 22:24:30 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 13/18] scsi: remove scsi_cmd_dma_pool
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
        <1485365126-23210-14-git-send-email-hch@lst.de>
Date: Wed, 25 Jan 2017 22:24:18 -0500
In-Reply-To: <1485365126-23210-14-git-send-email-hch@lst.de> (Christoph
        Hellwig's message of "Wed, 25 Jan 2017 18:25:21 +0100")
Message-ID: <yq1fuk68pwd.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> There is no need for GFP_DMA allocations of the scsi_cmnd
Christoph> structures themselves, all that might be DMAed to or from is
Christoph> the actual payload, or the sense buffers.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
