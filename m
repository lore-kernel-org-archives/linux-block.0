Return-Path: <jmarchan@redhat.com>
Date: Mon, 9 Jan 2017 10:09:20 -0500 (EST)
From: Jerome Marchand <jmarchan@redhat.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Hyeoncheol Lee <cheol.lee@lge.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Jennings <rcj@linux.vnet.ibm.com>
Message-ID: <978119764.6177321.1483974560473.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170109143344.GA753@tigerII.localdomain>
References: <1483938267-8858-1-git-send-email-minchan@kernel.org> <20170109143344.GA753@tigerII.localdomain>
Subject: Re: [RFC] blk: increase logical_block_size to unsigned int
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



----- Original Message -----
> From: "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>
> To: "Minchan Kim" <minchan@kernel.org>
> Cc: "Jens Axboe" <axboe@kernel.dk>, "Hyeoncheol Lee" <cheol.lee@lge.com>, linux-block@vger.kernel.org,
> linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>, "Sergey Senozhatsky"
> <sergey.senozhatsky@gmail.com>, "Robert Jennings" <rcj@linux.vnet.ibm.com>, "Jerome Marchand" <jmarchan@redhat.com>
> Sent: Monday, January 9, 2017 3:33:44 PM
> Subject: Re: [RFC] blk: increase logical_block_size to unsigned int
> 
> On (01/09/17 14:04), Minchan Kim wrote:
> > Mostly, zram is used as swap system on embedded world so it want to do IO
> > as PAGE_SIZE aligned/size IO unit. For that, one of the problem was
> > blk_queue_logical_block_size(zram->disk->queue, PAGE_SIZE) made overflow
> > in *64K page system* so [1] changed it to constant 4096.
> > Since that, partial IO can happen so zram should handle it which makes zram
> > complicated[2].
> > 
> 
> I thought that zram partial IO support is there because some file
> systems cannot cope with large logical_block_size. like FAT, for
> example. am I wrong?

Yes indeed. When we discussed the patch adding the partial I/O, increasing the
size of logical_block was considered. The reason we didn't go the easy path was
that not all block users could handle 64k blocks. FAT is one of them.

Jerome

> 
> 	-ss
> 
