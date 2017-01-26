Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51836 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbdAZDQH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 22:16:07 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 05/18] block: allow specifying size for extra command data
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
        <1485365126-23210-6-git-send-email-hch@lst.de>
Date: Wed, 25 Jan 2017 22:15:55 -0500
In-Reply-To: <1485365126-23210-6-git-send-email-hch@lst.de> (Christoph
        Hellwig's message of "Wed, 25 Jan 2017 18:25:13 +0100")
Message-ID: <yq160l2a4us.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph,

Christoph> This mirrors the blk-mq capabilities to allocate extra
Christoph> drivers-specific data behind struct request by setting a
Christoph> cmd_size field, as well as having a constructor / destructor
Christoph> for it.

Nice!

A couple of minor nits:

+static void *alloc_request_size(gfp_t gfp_mask, void *data)

I like alloc_request_simple() but alloc_request_size() seems a bit
contrived. _reserve? _extra? _special? Don't have any good suggestions,
I'm afraid.

Also a bit heavy on the else brackets a couple of places. But no biggie.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
