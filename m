Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Apply blk_partition_remap to REQ_OP_ZONE_RESET
To: Shaun Tancheff <shaun@tancheff.com>
References: <20161121190011.13259-1-shaun@tancheff.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>,
 Michael T Lombardi <michael.t.lombardi@seagate.com>,
 Shaun Tancheff <shaun.tancheff@seagate.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f32c3115-dabb-d04b-2b77-2b2169e2229a@kernel.dk>
Date: Mon, 21 Nov 2016 12:11:51 -0700
MIME-Version: 1.0
In-Reply-To: <20161121190011.13259-1-shaun@tancheff.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/21/2016 12:00 PM, Shaun Tancheff wrote:
> When a Reset WP is requested from a partition offset the blk_partition_remap
> should be applied.

You need to provide a better explanation in your commit message, and
also put a comment in the code. A good commit message explans WHY
there's a need for the patch.

-- 
Jens Axboe
