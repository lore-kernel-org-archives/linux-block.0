Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Apr 2016 14:13:21 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
Message-ID: <20160422181321.GV7822@mtj.duckdns.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
 <20160211222824.GD3741@mtj.duckdns.org>
 <57174CA7.5000706@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57174CA7.5000706@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Paolo.

On Wed, Apr 20, 2016 at 11:32:23AM +0200, Paolo wrote:
> This malfunction seems related to a blkcg behavior that I did not
> expect: the sequential writer changes group continuously. It moves
> from the root group to its correct group, and back. Here is the
> output of
> 
> egrep 'insert_request|changed cgroup' trace
> 
> over a trace taken with the original version of cfq (seq_write is of
> course the group of the writer):
...
> For reasons that I don't yet know, group changes are much more
> frequent with bfq, which ultimately causes bfq to fail to isolate the
> writer from the reader.
> 
> While I go on trying to understand why, could you please tell me
> whether this fluctuation is normal, and/or point me to documentation from
> which I can better understand this behavior, without bothering you
> further?

So, a kworker would jump through different workqueues and issue IOs
for different writeback domains and the context can't be tied to the
issuing task.  The cgroup membership should be determined directly
from the bio.  cfq uses per-cgroup async queue.  I'm not sure how this
would map to bfq tho.

Thanks.

-- 
tejun
