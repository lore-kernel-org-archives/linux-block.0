Return-Path: <jack@suse.cz>
Date: Mon, 26 Feb 2018 17:43:58 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
	Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 0/6 v2] block: Fix races in bdev - gendisk handling
Message-ID: <20180226164358.opwo7auv4neqvt6t@quack2.suse.cz>
References: <20180226120142.25786-1-jack@suse.cz>
 <ea8d5867-75e4-47eb-db51-1d905db208cc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea8d5867-75e4-47eb-db51-1d905db208cc@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon 26-02-18 09:04:40, Jens Axboe wrote:
> On 2/26/18 5:01 AM, Jan Kara wrote:
> > Hello,
> > 
> > these patches fix races happening when devices are frequently destroyed and
> > recreated in association of block device inode with corresponding gendisk.
> > Generally when such race happen it results in use-after-free issues, block
> > device page cache inconsistencies, or other problems. I have verified these
> > patches fix use-after-free issues that could be reproduced by frequent creation
> > and destruction of loop device. Hou Tao has verified that races reported by
> > him in [1] related to gendisk-blkdev association were also fixed. Jens, can
> > you please merge these patches? Thanks!
> 
> What are you thinking in terms of target? I'd like to get it into 4.16,
> but I'd need to know if you are comfortable with that.

Yeah, 4.16 should be OK. The patches are quite conservative.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
