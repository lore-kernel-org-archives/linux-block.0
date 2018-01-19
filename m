Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] lib/scatterlist: Fix chaining support in
 sgl_alloc_order()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "Nicholas A . Bellinger" <nab@linux-iscsi.org>,
 Laurence Oberman <loberman@redhat.com>
References: <20180119190054.10789-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b2309bd1-acfd-1853-bde0-c59d1a4d11a1@kernel.dk>
Date: Fri, 19 Jan 2018 12:31:36 -0700
MIME-Version: 1.0
In-Reply-To: <20180119190054.10789-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/19/18 12:00 PM, Bart Van Assche wrote:
> This patch avoids that workloads with large block sizes (megabytes)
> can trigger the following call stack with the ib_srpt driver (that
> driver is the only driver that chains scatterlists allocated by
> sgl_alloc_order()):
> 
> BUG: Bad page state in process kworker/0:1H  pfn:2423a78
> page:fffffb03d08e9e00 count:-3 mapcount:0 mapping:          (null) index:0x0
> flags: 0x57ffffc0000000()
> raw: 0057ffffc0000000 0000000000000000 0000000000000000 fffffffdffffffff
> raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
> page dumped because: nonzero _count
> CPU: 0 PID: 733 Comm: kworker/0:1H Tainted: G          I      4.15.0-rc7.bart+ #1
> Hardware name: HP ProLiant DL380 G7, BIOS P67 08/16/2015
> Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> Call Trace:
>  dump_stack+0x5c/0x83
>  bad_page+0xf5/0x10f
>  get_page_from_freelist+0xa46/0x11b0
>  __alloc_pages_nodemask+0x103/0x290
>  sgl_alloc_order+0x101/0x180
>  target_alloc_sgl+0x2c/0x40 [target_core_mod]
>  srpt_alloc_rw_ctxs+0x173/0x2d0 [ib_srpt]
>  srpt_handle_new_iu+0x61e/0x7f0 [ib_srpt]
>  __ib_process_cq+0x55/0xa0 [ib_core]
>  ib_cq_poll_work+0x1b/0x60 [ib_core]
>  process_one_work+0x141/0x340
>  worker_thread+0x47/0x3e0
>  kthread+0xf5/0x130
>  ret_from_fork+0x1f/0x30

Applied, thanks.

-- 
Jens Axboe
