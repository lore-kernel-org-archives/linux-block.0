Return-Path: <BATV+d2af373be13e0fb4228a+5141+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 20 Sep 2017 10:35:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Message-ID: <20170920173552.GA14611@infradead.org>
References: <1505928371-27829-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505928371-27829-1-git-send-email-longman@redhat.com>
List-ID: <linux-block@vger.kernel.org>

> +/*
> + * When reading or writing the blktrace sysfs files, the references to the
> + * opened sysfs or device files should prevent the underlying block device
> + * from being removed. So no further delete protection is really needed.
> + *
> + * Protection from multiple readers and writers accessing blktrace data
> + * concurrently is still required. The bd_mutex was used for this purpose.
> + * That could lead to deadlock with concurrent block device deletion and
> + * sysfs access. As a result, a new blk_trace_mutex is now added to be
> + * used solely by the blktrace code.
> + */

Comments about previous locking schemes really don't have a business
in the code - those are remarks for the commit logs.  And in general
please explain the locking scheme near the data that they proctect
it, as locks should always protected data, not code and the comments
should follow that.
