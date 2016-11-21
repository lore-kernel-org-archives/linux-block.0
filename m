Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] Apply blk_partition_remap to REQ_OP_ZONE_RESET
To: Shaun Tancheff <shaun@tancheff.com>
References: <f32c3115-dabb-d04b-2b77-2b2169e2229a@kernel.dk>
 <20161121215223.31658-1-shaun@tancheff.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>,
 Michael T Lombardi <michael.t.lombardi@seagate.com>,
 Shaun Tancheff <shaun.tancheff@seagate.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6e67e6ce-9756-c6bf-1c2e-c4b5f0dd57e3@kernel.dk>
Date: Mon, 21 Nov 2016 15:07:58 -0700
MIME-Version: 1.0
In-Reply-To: <20161121215223.31658-1-shaun@tancheff.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/21/2016 02:52 PM, Shaun Tancheff wrote:
> If a ZBC device is partitioned and operations are performed on the partition
> the zone information is rebased to the partition, however the zone reset
> is not mapped from the partition to device as are other operations.
>
> This causes the API (report zones / reset zone) to be unbalanced in this
> regard. Checking for the zone reset op code explicitly will balance the
> API.

Much better, thanks. Applied for 4.10.

-- 
Jens Axboe
