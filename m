Return-Path: <SRS0=LIaE=AV=goodmis.org=rostedt@kernel.org>
Date: Wed, 20 Sep 2017 15:27:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nilfs@vger.kernel.org,
 cluster-devel@redhat.com, Bart Van Assche <Bart.VanAssche@wdc.com>,
 Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Message-ID: <20170920152733.0e8290e1@gandalf.local.home>
In-Reply-To: <eb3069f4-7803-32a0-0503-4258d47bb54d@kernel.dk>
References: <1505928371-27829-1-git-send-email-longman@redhat.com>
	<20170920133238.6d48fb93@gandalf.local.home>
	<eb3069f4-7803-32a0-0503-4258d47bb54d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 20 Sep 2017 13:09:31 -0600
Jens Axboe <axboe@kernel.dk> wrote:
> 
> I'll take it through my tree, and I'll prune some of that comment
> as well (which should be a commit message thing, not a code comment).
> 

Agreed, and thanks.

-- Steve
