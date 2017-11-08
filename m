Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20609 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbdKHXyC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 18:54:02 -0500
Subject: Re: [PATCH V7 6/8] scsi: sd_zbc: Initialize device request queue
 zoned data
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
References: <20171108081118.7632-1-damien.lemoal@wdc.com>
 <20171108081118.7632-7-damien.lemoal@wdc.com> <yq160akxrsb.fsf@oracle.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <c7d023a9-68bd-d78b-a2c0-702d35b6f0ed@wdc.com>
Date: Thu, 9 Nov 2017 08:54:00 +0900
MIME-Version: 1.0
In-Reply-To: <yq160akxrsb.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Martin,

On 11/9/17 08:41, Martin K. Petersen wrote:
> 
> Damien,
> 
>> wait for the disk capacity and number of zones to stabilize on the
>> second revalidation pass to allocate and initialize the bitmaps.
> 
> Stabilize how?

If RC_BASIS is 0, the capacity changes after the first report zones...
In any case, as you suggested, patch 8 should be merged with this one.
I will fix that and post a v8.
Thank you for the review.

-- 
Damien Le Moal,
Western Digital
