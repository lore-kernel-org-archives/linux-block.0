Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] mq-deadline: add 'deadline' as a name alias
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org
References: <1508954687-3204-1-git-send-email-axboe@kernel.dk>
 <1508954687-3204-4-git-send-email-axboe@kernel.dk>
 <20171025183439.GC9160@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <84073b4c-0c14-22a0-3e4b-e725d3528c02@kernel.dk>
Date: Wed, 25 Oct 2017 11:36:16 -0700
MIME-Version: 1.0
In-Reply-To: <20171025183439.GC9160@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/2017 11:34 AM, Omar Sandoval wrote:
> On Wed, Oct 25, 2017 at 12:04:47PM -0600, Jens Axboe wrote:
>> The scheduler framework now supports looking up the appropriate
>> scheduler with the {name,mq} tupple. We can register mq-deadline
>> with the alias of 'deadline', so that switching to 'deadline'
>> will do the right thing based on the type of driver attached to
>> it.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> A blktest for this would be nice.

Not really critical imho, as it's not fixing a "real" issue in
terms of an oops, hang, or similar.

-- 
Jens Axboe
