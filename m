Return-Path: <BATV+de86e71b538cb4077339+5140+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 18 Sep 2017 17:01:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v6 1/2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Message-ID: <20170919000155.GA30806@infradead.org>
References: <1505760831-7747-1-git-send-email-longman@redhat.com>
 <1505760831-7747-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505760831-7747-2-git-send-email-longman@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Taking a look at this it seems like using a lock in struct block_device
isn't the right thing to do anyway - all the action is on fields in
struct blk_trace, so having a lock inside that would make a lot more
sense.

It would also help to document what exactly we're actually protecting.
