Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Add missed break in generic_make_request_checks
To: Mike Krinkin <krinkin.m.u@gmail.com>
References: <1480972700-3873-1-git-send-email-krinkin.m.u@gmail.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com,
 hare@suse.de, shaun@tancheff.com, damien.lemoal@hgst.com,
 shaun.tancheff@seagate.com, chaitanya.kulkarni@hgst.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <862569c0-4d0e-d73e-1d25-4177b66748a9@kernel.dk>
Date: Mon, 5 Dec 2016 14:21:30 -0700
MIME-Version: 1.0
In-Reply-To: <1480972700-3873-1-git-send-email-krinkin.m.u@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/05/2016 02:18 PM, Mike Krinkin wrote:
> With recent linux-next i started to get this error:
> 
> [   19.746764] EXT4-fs (sda6): Delayed block allocation failed for inode 4999023 at logical offset 0 with max blocks 6 with error 95
> [   19.746767] EXT4-fs (sda6): This should not happen!! Data will be lost
> 
> Bisect points at the commit e73c23ff736e ("block: add async variant of
> blkdev_issue_zeroout") but i think that the real problem is a missed
> break in the commit 2d253440b5af ("block: Define zoned block device
> operations").

Fix was already committed for this:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.10/block&id=58886785db318588f95c8036abb2a47016c1f14c

-- 
Jens Axboe
