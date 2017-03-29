Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752431AbdC2O5h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2017 10:57:37 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: RFC: always use REQ_OP_WRITE_ZEROES for zeroing offload
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alasdair G Kergon <agk@redhat.com>,
        "shli@kernel.org" <shli@kernel.org>,
        "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        dm <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
References: <20170323143341.31549-1-hch@lst.de>
 <20170323155410.GD1138@soda.linbit> <20170323170221.GA20854@redhat.com>
 <20170323225256.GK1138@soda.linbit>
Message-ID: <0d2950ea-a1ab-7939-3c8e-d14038839761@redhat.com>
Date: Wed, 29 Mar 2017 16:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170323225256.GK1138@soda.linbit>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 23/03/2017 23:53, Lars Ellenberg wrote:
> Thin does not claim to zero data on discard.  which is ok, and correct,
> because it only punches holes on full chunks (or whatever you call
> them), and leaves the rest in the mapping tree as is.
> 
> And that behaviour would prevent DRBD from exposing discards if
> configured on top of thin. (see above)
> 
> But thin *could* easily guarantee zeroing, by simply punching holes
> where it can, and zeroing out the not fully-aligned partial start and
> end of the range.

That's the difference between REQ_OP_DISCARD (only punches holes on full
chunks) and REQ_OP_WRITE_ZEROES with the REQ_UNMAP flag (punches holes +
zeroes incomplete chunks).

dm-thinp's REQ_OP_DISCARD should not do anything for unaligned parts.
Instead, layers above should use REQ_OP_WRITE_ZEROES (with or without
REQ_UNMAP, as required) if they need zeroes.  dm-thinp would have to
split off the partial chunks, and zero them in the lower-level device
with REQ_OP_WRITE_ZEROES.

Paolo
