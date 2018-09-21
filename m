Return-Path: <hare@suse.de>
Subject: Re: REQ_OP_WRITE_ZEROES clash with REQ_FAILFAST_TRANSPORT ?
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b67451d2-3c01-9fdc-20b3-04d7165db36d@suse.de>
Message-ID: <65542a8c-d6fe-a589-cabe-742b06a8237e@suse.de>
Date: Fri, 21 Sep 2018 12:11:00 +0200
MIME-Version: 1.0
In-Reply-To: <b67451d2-3c01-9fdc-20b3-04d7165db36d@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 9/21/18 11:15 AM, Hannes Reinecke wrote:
> Hi all,
> 
> there's one thing which decidedly puzzles me:
> 
[ .. ]

Ah. Screw that.
REQ_OP_XXX is a number, and the others are a bitmask.

Sorry for the noise.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
