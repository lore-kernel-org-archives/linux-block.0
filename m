Return-Path: <BATV+efe86d5870596b20d79e+5139+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 18 Sep 2017 16:47:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v6 2/2] block_dev: Rename bd_fsfreeze_mutex
Message-ID: <20170918234745.GA8600@infradead.org>
References: <1505760831-7747-1-git-send-email-longman@redhat.com>
 <1505760831-7747-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505760831-7747-3-git-send-email-longman@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Don't rename it to a way to long name.  Either add a separate mutex
for your purpose (unless there is interaction between freezing and
blktrace, which I doubt), or properly comment the usage.
