Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 7/9] xfs: add support for passing in write hints for
 buffered writes
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com, linux-nvme@lists.infradead.org
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-8-git-send-email-axboe@kernel.dk>
 <20170626095617.GF14057@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ec322a30-849d-65c7-76a8-f1aa282407b7@kernel.dk>
Date: Mon, 26 Jun 2017 08:16:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170626095617.GF14057@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/26/2017 03:56 AM, Christoph Hellwig wrote:
>> +	ioend->io_bio->bi_opf |= write_hint_to_opf(inode_write_hint(ioend->io_inode));
> 
> Too long line again.
> 
> I think simply adding an inode_hint_to_opf() flag would make the various
> opencoded versions of the above call a little easier to read.

Sure, I'll do that.

-- 
Jens Axboe
