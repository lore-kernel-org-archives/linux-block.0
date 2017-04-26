Return-Path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] ide-pm: always pass 0 error to ide_complete_rq in
 ide_do_devset
Date: Wed, 26 Apr 2017 12:33:20 +0200
Message-id: <6500755.RihOe6T0DR@amdc3058>
In-reply-to: <20170426073422.14511-4-hch@lst.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170426073422.14511-1-hch@lst.de>
 <20170426073422.14511-4-hch@lst.de>
 <CGME20170426103322epcas5p390d45ef01f24b5bfb457761f9c71a530@epcas5p3.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Wednesday, April 26, 2017 09:34:22 AM Christoph Hellwig wrote:
> The caller only looks at the scsi_request result field anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
