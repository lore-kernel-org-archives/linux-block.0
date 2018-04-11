Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 10:07:33 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Israel Rukshin <israelr@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180411170733.GM793541@devbig577.frc2.facebook.com>
References: <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
 <20180410152553.GC22340@ming.t460p>
 <20180410153031.GO3126663@devbig577.frc2.facebook.com>
 <20180410153812.GA3219@ming.t460p>
 <20180410154043.GP3126663@devbig577.frc2.facebook.com>
 <20180410213323.GC793541@devbig577.frc2.facebook.com>
 <d88becef654cde4b5382c1ebddb0aeba963c0578.camel@wdc.com>
 <20180410215456.GD793541@devbig577.frc2.facebook.com>
 <7a586854-33a5-fe3b-6d94-24d305696126@grimberg.me>
 <0da96ded-7bfc-e6a8-428c-1ce1e3db0378@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <0da96ded-7bfc-e6a8-428c-1ce1e3db0378@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Israel.

On Wed, Apr 11, 2018 at 07:16:14PM +0300, Israel Rukshin wrote:
> >Just noticed this one, this looks interesting to me as well. Israel,
> >can you run your test with this patch?
> 
> Yes, I just did and it looks good.

Awesome.

> >>+++ b/include/linux/blkdev.h
> >>@@ -227,6 +227,8 @@ struct request {
> >>� ����� unsigned int extra_len;��� /* length of alignment and padding */
> >>� +��� bool missed_completion;
> >>+
> >
> >Would be nicer if we can flag this somewhere instead of adding a hole to
> >struct request...

I missed it before.  It's actually being put in an existing hole, so
the struct size stays the same before and after.  It's a bit of
cheating cuz this is one of the two holes which can be removed by
swapping two fields.

Re. making it a flag, regardless of whether this is a flag or a
separate field, we need to add a new field because there currently is
no field which can be modified by the party who doesn't own the
request, so if we make it a flag, we need to add sth like unsigned
long atom_flags.

Thanks.

-- 
tejun
