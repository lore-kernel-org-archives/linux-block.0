Return-Path: <minchan.kim@gmail.com>
Return-Path: <minchan.kim@gmail.com>
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Sun, 21 May 2017 16:15:36 +0900
From: Minchan Kim <minchan@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	kernel-team <kernel-team@lge.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, viro@zeniv.linux.org.uk,
	axboe@kernel.dk, jlayton@redhat.com, tytso@mit.edu
Subject: Re: [PATCH 2/2] zram: do not count duplicated pages as compressed
Message-ID: <20170521071536.GA9377@bgram>
References: <20170516073616.GB767@jagdpanzerIV.localdomain>
 <20170517083212.GA25750@bbox>
 <20170521070427.GB10453@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170521070427.GB10453@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Sun, May 21, 2017 at 12:04:27AM -0700, Christoph Hellwig wrote:
> On Wed, May 17, 2017 at 05:32:12PM +0900, Minchan Kim wrote:
> > Is block device(esp, zram which is compressed ram block device) okay to
> > return garbage when ongoing overwrite IO fails?
> > 
> > O_DIRECT write 4 block "aaa.." -> success
> > read  4 block "aaa.." -> success
> > O_DIRECT write 4 block "bbb.." -> fail
> > read  4 block "000..' -> it is okay?
> > 
> > Hope to get an answer form experts. :)
> 
> It's "okay" as it's what existing real block devices do (at least on a
> sector boundary).  It's not "nice" though, so if you can avoid it,
> please do.

That was my understanding so I wanted to avoid it for just simple
code refactoring. Your comment helps to confirm the thhought.

Thanks, Christoph!
