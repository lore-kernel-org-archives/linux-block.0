Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:22640 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbdAZDVl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 22:21:41 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 11/18] scsi: remove gfp_flags member in scsi_host_cmd_pool
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
        <1485365126-23210-12-git-send-email-hch@lst.de>
Date: Wed, 25 Jan 2017 22:21:29 -0500
In-Reply-To: <1485365126-23210-12-git-send-email-hch@lst.de> (Christoph
        Hellwig's message of "Wed, 25 Jan 2017 18:25:19 +0100")
Message-ID: <yq1o9yu8q12.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> When using the slab allocator we already decide at cache
Christoph> creation time if an allocation comes from a GFP_DMA pool
Christoph> using the SLAB_CACHE_DMA flag, and there is no point passing
Christoph> the kmalloc-family only GFP_DMA flag to kmem_cache_alloc.
Christoph> Drop all the infrastructure for doing so.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
