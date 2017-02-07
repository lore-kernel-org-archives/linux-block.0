Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 7 Feb 2017 12:21:01 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4 v2] BDI lifetime fix
Message-ID: <20170207172101.GC6164@htj.duckdns.org>
References: <20170131125429.14303-1-jack@suse.cz>
 <2851869.q2N89k4IqL@morokweng>
 <1790906.I1Z25HtRf4@morokweng>
 <20170207123331.GD13524@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170207123331.GD13524@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Feb 07, 2017 at 01:33:31PM +0100, Jan Kara wrote:
> > We can see above that inode->i_wb is in r31, and the machine crashed at 
> > 0xc0000000003799a0 so it was trying to dereference wb and crashed.
> > r31 is NULL in the crash information.
> 
> Thanks for report and the analysis. After some looking into the code I see
> where the problem is. Writeback code assumes inode->i_wb can never become
> invalid once it is set however we still call inode_detach_wb() from
> __blkdev_put(). So in a way this is a different problem but closely
> related.

Heh, it feels like we're chasing our own tails.

> It seems to me that instead of calling inode_detach_wb() in __blkdev_put()
> we may just switch blkdev inode to bdi->wb (it is now guaranteed to stay
> around). That way bdi_unregister() can complete (destroying all writeback
> structures except for bdi->wb) while block device inode can still live with
> a valid i_wb structure.

So, the problem there would be synchronizing get_wb against the
transition.  We can do that and inode_switch_wbs_work_fn() already
does it but it is a bit nasty.

I'm getting a bit confused here, so the reason we added
inode_detach_wb() in __blkdev_put() was because the root wb might go
away because it's embedded in the bdi which is embedded in the
request_queue which is put and may be released by put_disk().

Are you saying that we changed the behavior so that bdi->wb stays
around?  If so, we can just remove the inode_detach_wb() call, no?

Thanks.

-- 
tejun
