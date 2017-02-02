Subject: Re: [PATCH] blk-mq-sched: bypass the scheduler for flushes entirely
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <0d437b20c5eafb38997dbb4695c6387cbe18991a.1486078616.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <54e0a7c4-5cf2-13a6-a059-32964fa37b2b@fb.com>
Date: Thu, 2 Feb 2017 16:57:30 -0700
MIME-Version: 1.0
In-Reply-To: <0d437b20c5eafb38997dbb4695c6387cbe18991a.1486078616.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/02/2017 04:42 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> There's a weird inconsistency that flushes are mostly hidden from the
> scheduler, but it needs to be aware of them in ->insert_requests().
> Instead of having every scheduler call blk_mq_sched_bypass_insert(),
> let's do it in the common framework.

Thanks Omar, looks good to me. After a cycle or two, we can kill
the debug loop in blk_mq_sched_insert_requests().

-- 
Jens Axboe
