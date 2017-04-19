Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20170415123825.32716-1-ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Omar Sandoval <osandov@fb.com>,
 Jozef Mikovic <jmikovic@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
Date: Wed, 19 Apr 2017 14:17:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170415123825.32716-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/15/2017 06:38 AM, Ming Lei wrote:
> The 1st patch enhances BLK_MQ_F_NO_SCHED so that we can't change/
> show available io schedulers on devices which don't support io
> scheduler.
> 
> The 2nd patch passes BLK_MQ_F_NO_SCHED for avoiding one regression
> on mtip32xx, which is introduced by blk-mq io scheduler.

I've added 1-2 for 4.11 for now, and then let's plan on getting
a real fix done for 4.12.

-- 
Jens Axboe
