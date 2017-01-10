Return-Path: <minchan@kernel.org>
Date: Wed, 11 Jan 2017 07:54:27 +0900
From: Minchan Kim <minchan@kernel.org>
To: Jerome Marchand <jmarchan@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Hyeoncheol Lee <cheol.lee@lge.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [RFC] blk: increase logical_block_size to unsigned int
Message-ID: <20170110225427.GB31163@bbox>
References: <1483938267-8858-1-git-send-email-minchan@kernel.org>
 <20170109143344.GA753@tigerII.localdomain>
 <978119764.6177321.1483974560473.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <978119764.6177321.1483974560473.JavaMail.zimbra@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jerome, Sergey

On Mon, Jan 09, 2017 at 10:09:20AM -0500, Jerome Marchand wrote:
> 
> 
> ----- Original Message -----
> > From: "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>
> > To: "Minchan Kim" <minchan@kernel.org>
> > Cc: "Jens Axboe" <axboe@kernel.dk>, "Hyeoncheol Lee" <cheol.lee@lge.com>, linux-block@vger.kernel.org,
> > linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>, "Sergey Senozhatsky"
> > <sergey.senozhatsky@gmail.com>, "Jerome Marchand" <jmarchan@redhat.com>
> > Sent: Monday, January 9, 2017 3:33:44 PM
> > Subject: Re: [RFC] blk: increase logical_block_size to unsigned int

Remove Robert's mail. It didn't work and don't know his update mail

> > 
> > On (01/09/17 14:04), Minchan Kim wrote:
> > > Mostly, zram is used as swap system on embedded world so it want to do IO
> > > as PAGE_SIZE aligned/size IO unit. For that, one of the problem was
> > > blk_queue_logical_block_size(zram->disk->queue, PAGE_SIZE) made overflow
> > > in *64K page system* so [1] changed it to constant 4096.
> > > Since that, partial IO can happen so zram should handle it which makes zram
> > > complicated[2].
> > > 
> > 
> > I thought that zram partial IO support is there because some file
> > systems cannot cope with large logical_block_size. like FAT, for
> > example. am I wrong?
> 
> Yes indeed. When we discussed the patch adding the partial I/O, increasing the
> size of logical_block was considered. The reason we didn't go the easy path was
> that not all block users could handle 64k blocks. FAT is one of them.


I thought it might make some FSes which doesn't support 64K block but
I didn't know what FSes exactly. I thought most popular FSes in linux
may work well(e.g., ext, btrfs, xfs). Thanks for the pointer.
I guess there might be more as well as FAT so let's keep it.

Thanks, Sergey and Jerome!
