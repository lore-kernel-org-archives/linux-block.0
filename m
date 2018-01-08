Return-Path: <hare@suse.com>
Subject: Re: [PATCH 5/5] dm mpath: Use blk_retryable
To: Keith Busch <keith.busch@intel.com>,
 Linux Block <linux-block@vger.kernel.org>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Device Mapper <dm-devel@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Bart VanAssche <bart.vanassche@wdc.com>,
 James Smart <james.smart@broadcom.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-6-keith.busch@intel.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <cc35a658-5a88-05e9-8c0b-a173037390a9@suse.com>
Date: Mon, 8 Jan 2018 09:59:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180104224623.8944-6-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/04/2018 11:46 PM, Keith Busch wrote:
> Uses common code for determining if an error should be retried on
> alternate path.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/md/dm-mpath.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
