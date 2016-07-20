Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: add flag for single-threaded submission
To: Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>
References: <1468936978-9124-1-git-send-email-hare@suse.de>
 <1468936978-9124-2-git-send-email-hare@suse.de>
CC: <dm-devel-redhat.com@suse.de>, <linux-scsi@vger.kernel.org>,
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
From: Damien Le Moal <damien.lemoal@hgst.com>
Message-ID: <df86ecc5-92d0-776c-3438-22b1089ae258@hgst.com>
Date: Wed, 20 Jul 2016 10:13:25 +0900
MIME-Version: 1.0
In-Reply-To: <1468936978-9124-2-git-send-email-hare@suse.de>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


On 7/19/16 23:02, Hannes Reinecke wrote:
> Some devices (most notably SMR drives) support only
> one I/O stream eg for ensuring ordered I/O submission.
> This patch adds a new block queue flag
> 'BLK_QUEUE_SINGLE' to support these devices.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  block/blk-core.c       | 2 ++
>  include/linux/blkdev.h | 2 ++
>  2 files changed, 4 insertions(+)

Reviewed-by: Damien Le Moal <damien.lemoal@hgst.com>
Tested-by: Damien Le Moal <damien.lemoal@hgst.com>

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Group, HGST Research,
HGST, a Western Digital brand
Damien.LeMoal@hgst.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

