Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, target-devel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        drbd-dev@lists.linbit.com, dm-devel@redhat.com
Subject: Re: remove REQ_OP_WRITE_SAME
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170412084809.8245-1-hch@lst.de>
Date: Thu, 13 Apr 2017 22:23:10 -0400
In-Reply-To: <20170412084809.8245-1-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 12 Apr 2017 10:48:01 +0200")
Message-ID: <yq1mvbjwwvl.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
> kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
> have two callers left, and both just export optional protocol features
> to remote systems: DRBD and the target code.

While I'm not particularly married to WRITE SAME, I do think it's a
shame that the RAID5/6 code never started using it. It does make a
difference when initializing RAID sets.

The other thing that keeps me a bit on the fence is that a bunch of the
plumbing to handle a bio with a payload different from bi_size is needed
for the copy offload token. I'm hoping to have those patches ready for
4.13. Right now there are a bunch of places where handling of
REQ_OP_COPY_IN and REQ_OP_COPY_OUT share conditionals with WRITE SAME.

So I suggest postponing the decision about whether to rip out WRITE SAME
until I finish the token stuff.

-- 
Martin K. Petersen	Oracle Linux Engineering
