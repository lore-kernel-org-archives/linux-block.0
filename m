Return-Path: <jack@suse.cz>
Date: Wed, 12 Apr 2017 09:32:18 +0200
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/25 v2] fs: Convert all embedded bdis into separate ones
Message-ID: <20170412073218.GA29113@quack2.suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170329105623.18241-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Jens, Christoph, ping? Any opinion on this?

								Honza
On Wed 29-03-17 12:55:58, Jan Kara wrote:
> Hello,
> 
> this is the second revision of the patch series which converts all embedded
> occurences of struct backing_dev_info to use standalone dynamically allocated
> structures. This makes bdi handling unified across all bdi users and generally
> removes some boilerplate code from filesystems setting up their own bdi. It
> also allows us to remove some code from generic bdi implementation.
> 
> The patches were only compile-tested for most filesystems (I've tested
> mounting only for NFS & btrfs) so fs maintainers please have a look whether
> the changes look sound to you.
> 
> This series is based on top of bdi fixes that were merged into linux-block
> git tree into for-next branch. I have pushed out the result as a branch to
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdi
> 
> Changes since v1:
> * Added some acks
> * Added further FUSE cleanup patch
> * Added removal of unused argument to bdi_register()
> * Fixed up some compilation failures spotted by 0-day testing
> 
> 								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
