Return-Path: <sergey.senozhatsky.work@gmail.com>
Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Sat, 8 Oct 2016 03:08:47 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/3] zram: support page-based parallel write
Message-ID: <20161007180847.GA486@swordfish>
References: <1474526565-6676-1-git-send-email-minchan@kernel.org>
 <1474526565-6676-2-git-send-email-minchan@kernel.org>
 <20160929031831.GA1175@swordfish>
 <20160930055221.GA16293@bbox>
 <20161004044314.GA835@swordfish>
 <20161005020153.GA2988@bbox>
 <20161006082915.GA946@swordfish>
 <20161007063322.GA24554@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161007063322.GA24554@bbox>
List-ID: <linux-block@vger.kernel.org>

Hello Minchan,

On (10/07/16 15:33), Minchan Kim wrote:
[..]
> > as soon as wb flush kworker can't keep up anymore things are going off
> > the rails. most of the time, fio-template-static-buffer are in D state,
> > while the biggest bdi flush kworker is doing the job (a lot of job):
> > 
> >   PID USER      PR  NI    VIRT    RES  %CPU %MEM     TIME+ S COMMAND
> >  6274 root      20   0    0.0m   0.0m 100.0  0.0   1:15.60 R [kworker/u8:1]
> > 11169 root      20   0  718.1m   1.6m  16.6  0.0   0:01.88 D fio ././conf/fio-template-static-buffer
> > 11171 root      20   0  718.1m   1.6m   3.3  0.0   0:01.15 D fio ././conf/fio-template-static-buffer
> > 11170 root      20   0  718.1m   3.3m   2.6  0.1   0:00.98 D fio ././conf/fio-template-static-buffer
> > 
> > 
> > and still working...
> > 
> >  6274 root      20   0    0.0m   0.0m 100.0  0.0   3:05.49 R [kworker/u8:1]
> > 12048 root      20   0  718.1m   1.6m  16.7  0.0   0:01.80 R fio ././conf/fio-template-static-buffer
> > 12047 root      20   0  718.1m   1.6m   3.3  0.0   0:01.12 D fio ././conf/fio-template-static-buffer
> > 12049 root      20   0  718.1m   1.6m   3.3  0.0   0:01.12 D fio ././conf/fio-template-static-buffer
> > 12050 root      20   0  718.1m   1.6m   2.0  0.0   0:00.98 D fio ././conf/fio-template-static-buffer
> > 
> > and working...
[..]
> Isn't it blk-mq you mentioned? With blk-mq, I have some concerns.
> 
> 1. read speed degradation
> 2. no work with rw_page
> 3. more memory footprint by bio/request queue allocation

yes, I did. and I've seen your concerns in another email - I
just don't have enough knowledge at the moment to say something
not entirely stupid. gotta look more at the whole thing.

> Having said, it's worth to look into it in detail more.
> I will have time to see that approach to know what I can do
> with that.

thanks a lot!
will keep looking as well.

	-ss
