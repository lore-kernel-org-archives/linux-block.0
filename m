Return-Path: <martin.petersen@oracle.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com, agk@redhat.com, shli@kernel.org,
        philipp.reisner@linbit.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH 22/23] drbd: implement REQ_OP_WRITE_ZEROES
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-23-hch@lst.de>
	<20170330100641.GI5939@soda.linbit> <20170330114408.GA15777@lst.de>
	<20170330134957.GA508@redhat.com>
Date: Thu, 30 Mar 2017 11:20:09 -0400
In-Reply-To: <20170330134957.GA508@redhat.com> (Mike Snitzer's message of
	"Thu, 30 Mar 2017 09:49:57 -0400")
Message-ID: <yq1pogy3i6u.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Mike Snitzer <snitzer@redhat.com> writes:

> I can work on this now.  Only question I have is: should DM thinp take
> care to zero any misaligned head and tail?  (I assume so but with all
> the back and forth between Bart, Paolo and Martin I figured I'd ask
> explicitly).

Yep, let's make sure our semantics match the hardware ditto.

 - So write zeroes should behave deterministically and explicitly handle
   any blocks that can't be cleared via deprovisioning.

 - And discard can work at the discard granularity in a
   non-deterministic fashion.

-- 
Martin K. Petersen	Oracle Linux Engineering
