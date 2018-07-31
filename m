Return-Path: <ming.lei@redhat.com>
Date: Tue, 31 Jul 2018 12:58:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Message-ID: <20180731045805.GE15701@ming.t460p>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 31, 2018 at 12:02:15PM +0800, Jianchao Wang wrote:
> Currently, we will always set SCHED_RESTART whenever there are
> requests in hctx->dispatch, then when request is completed and
> freed the hctx queues will be restarted to avoid IO hang. This
> is unnecessary most of time. Especially when there are lots of
> LUNs attached to one host, the RR restart loop could be very
> expensive.

The big RR restart loop has been killed in the following commit:

commit 97889f9ac24f8d2fc8e703ea7f80c162bab10d4d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Mon Jun 25 19:31:48 2018 +0800

    blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()


Thanks,
Ming
