Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv2 1/2] blk-mq: export setting request completion state
To: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Jianchao Wang <jianchao.w.wang@oracle.com>,
 Bart Van Assche <bart.vanassche@wdc.com>
References: <20180723143751.10843-1-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <90649cd7-6e8a-c87c-4773-eb6881e85d72@kernel.dk>
Date: Tue, 24 Jul 2018 13:42:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180723143751.10843-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/23/18 7:37 AM, Keith Busch wrote:
> This is preparing for drivers that want to directly alter the state of
> their requests. No functional change here.

Added this (and 2/2) for 4.18...

-- 
Jens Axboe
