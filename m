Return-Path: <ming.lei@redhat.com>
Date: Fri, 15 Sep 2017 10:20:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/6] blk-mq: don't allocate driver tag beforehand for
 flush rq
Message-ID: <20170915022052.GC19340@ming.t460p>
References: <20170914164213.17859-1-ming.lei@redhat.com>
 <77beace7-6243-dbda-0c8e-245fe1a9bed9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <77beace7-6243-dbda-0c8e-245fe1a9bed9@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 14, 2017 at 12:51:24PM -0600, Jens Axboe wrote:
> On 09/14/2017 10:42 AM, Ming Lei wrote:
> > Hi,
> > 
> > This patchset avoids to allocate driver tag beforehand for flush rq
> > in case of I/O scheduler, then flush rq isn't treated specially
> > wrt. get/put driver tag, code gets cleanup much, such as,
> > reorder_tags_to_front() is removed, and we needn't to worry
> > about request order in dispatch list for avoiding I/O deadlock.
> > 
> > 'dbench -t 30 -s -F 64' has been run on different devices(shared tag,
> > multi-queue, singele queue, ...), and no issues are observed,
> > even very low queue depth(1) test are run, debench still works
> > well.
> 
> Gave this a quick spin on the test box, and I get tons of spewage
> on booting up:
> 
> [    9.131290] WARNING: CPU: 2 PID: 337 at block/blk-mq-sched.c:274 blk_mq_sched_insert_request+0x15d/0x170

Sorry, my fault.

The WARN_ON() was inside 'if (has_sched)' actually, and could you
please remove the WARN_ON() in blk_mq_sched_bypass_insert() and
see if it works?


Thanks,
Ming
