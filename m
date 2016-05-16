Return-Path: <jack@suse.cz>
Date: Mon, 16 May 2016 09:47:41 +0200
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dchinner@redhat.com, sedat.dilek@gmail.com
Subject: Re: [PATCHSET v5] Make background writeback great again for the
 first time
Message-ID: <20160516074741.GA12026@quack2.suse.cz>
References: <1461686131-22999-1-git-send-email-axboe@fb.com>
 <20160427180105.GA17362@quack2.suse.cz>
 <5721021E.8060006@fb.com>
 <20160427203708.GA25397@kernel.dk>
 <20160427205915.GC25397@kernel.dk>
 <20160428115401.GD17362@quack2.suse.cz>
 <57225A91.50002@kernel.dk>
 <20160503121719.GA25436@quack2.suse.cz>
 <20160511163608.GG14744@quack2.suse.cz>
 <57361CF6.3040202@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57361CF6.3040202@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri 13-05-16 12:29:10, Jens Axboe wrote:
> Thanks Jan, this is great and super useful! I'm revamping certain parts of
> it to deal with write back caching better, and I'll take a look at the
> regressions that you reported.
> 
> What kind of SSD is this? I'm assuming it's SATA (QD=32), and then it would
> probably be a safe assumption that it's flagging itself as having a volatile
> write back cache, would that be a correct assumption?

Yes, it is SATA with writeback cache.

> Are you using scsi-mq, or do you have an IO scheduler attached to it?

The disk was using IO scheduler, however at this point I'm not 100% sure
which scheduler (deadline or cfq) was the default one for the distro that
was installed. The machine is currently testing something else so I cannot
reinstall it and check. Maybe I can rerun some tests later in the week when
the machine gets freed with scsi-mq or deadline IO scheduler so that we
have 100% certain config.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
