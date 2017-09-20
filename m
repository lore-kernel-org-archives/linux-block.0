Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v7] blktrace: Fix potentail deadlock between delete &
 sysfs ops
To: Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
 Bart Van Assche <Bart.VanAssche@wdc.com>,
 Christoph Hellwig <hch@infradead.org>
References: <1505928371-27829-1-git-send-email-longman@redhat.com>
 <20170920133238.6d48fb93@gandalf.local.home>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eb3069f4-7803-32a0-0503-4258d47bb54d@kernel.dk>
Date: Wed, 20 Sep 2017 13:09:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170920133238.6d48fb93@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/20/2017 11:32 AM, Steven Rostedt wrote:
> 
> Christoph,
> 
> Can you give an acked-by for this patch?
> 
> Jens,
> 
> You want to take this through your tree, or do you want me to?
> 
> If you want it, here's my:
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I'll take it through my tree, and I'll prune some of that comment
as well (which should be a commit message thing, not a code comment).

-- 
Jens Axboe
