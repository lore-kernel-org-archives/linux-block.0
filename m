Return-Path: <longman@redhat.com>
Subject: Re: [PATCH v6 2/2] block_dev: Rename bd_fsfreeze_mutex
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
 Bart Van Assche <Bart.VanAssche@wdc.com>
References: <1505760831-7747-1-git-send-email-longman@redhat.com>
 <1505760831-7747-3-git-send-email-longman@redhat.com>
 <20170918234745.GA8600@infradead.org>
From: Waiman Long <longman@redhat.com>
Message-ID: <9c144de1-72bc-50b8-b828-afe7a5d371aa@redhat.com>
Date: Tue, 19 Sep 2017 08:43:54 -0400
MIME-Version: 1.0
In-Reply-To: <20170918234745.GA8600@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/18/2017 07:47 PM, Christoph Hellwig wrote:
> Don't rename it to a way to long name.  Either add a separate mutex
> for your purpose (unless there is interaction between freezing and
> blktrace, which I doubt), or properly comment the usage.

I would agree with you if the long name causes the expressions hard to
read. In this particular case, it is just the single parameter to the
mutex_lock() and mutex_unlock() functions. There is no confusion and
overly long lines. So I think it is OK. In fact, I got the opposite
advices in the past that some people prefer long descriptive names than
short and cryptic names.

Cheers,
Longman
