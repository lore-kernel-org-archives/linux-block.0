Return-Path: <axboe@kernel.dk>
Date: Mon, 26 Feb 2018 09:49:03 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 0/6 v2] block: Fix races in bdev - gendisk handling
Message-ID: <20180226164901.GA10232@kernel.dk>
References: <20180226120142.25786-1-jack@suse.cz>
 <ea8d5867-75e4-47eb-db51-1d905db208cc@kernel.dk>
 <20180226164358.opwo7auv4neqvt6t@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226164358.opwo7auv4neqvt6t@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 26 2018, Jan Kara wrote:
> On Mon 26-02-18 09:04:40, Jens Axboe wrote:
> > On 2/26/18 5:01 AM, Jan Kara wrote:
> > > Hello,
> > > 
> > > these patches fix races happening when devices are frequently destroyed and
> > > recreated in association of block device inode with corresponding gendisk.
> > > Generally when such race happen it results in use-after-free issues, block
> > > device page cache inconsistencies, or other problems. I have verified these
> > > patches fix use-after-free issues that could be reproduced by frequent creation
> > > and destruction of loop device. Hou Tao has verified that races reported by
> > > him in [1] related to gendisk-blkdev association were also fixed. Jens, can
> > > you please merge these patches? Thanks!
> > 
> > What are you thinking in terms of target? I'd like to get it into 4.16,
> > but I'd need to know if you are comfortable with that.
> 
> Yeah, 4.16 should be OK. The patches are quite conservative.

OK good, let's get it queued up. Thanks Jan.

-- 
Jens Axboe
