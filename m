Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] block: Use per-cpu partition in_flight counters.
To: Michael Callahan <michaelcallahan@fb.com>, linux-block@vger.kernel.org
References: <tc260ulmupc.fsf@vmbox.dyndns.org>
Cc: axboe@fb.com, coder.callahan@gmail.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57325E37.6090309@kernel.dk>
Date: Tue, 10 May 2016 16:18:31 -0600
MIME-Version: 1.0
In-Reply-To: <tc260ulmupc.fsf@vmbox.dyndns.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/10/2016 04:09 PM, Michael Callahan wrote:
> Move the partition in_flight counters from hd_struct to disk_stats so
> that they become tracked on a per-cpu basis.
>
> Sign-off-by: Michael Callahan <michaelcallahan@fb.com>

^^ Signed-off-by

> ---
>
> This patch is incomplete as it just comments out use of in_flight in dm.c as
> that code tracks io statistics in it's own special way.  Any thoughts on
> how to fix dm.c are welcome.

This has been done and rejected before. The problem is that you are now 
having to do a full per cpu loop in part_in_flight(), which is a 
non-starter. Unless you can make that part more clever, than it's not 
going to be a great idea.

Generally, doing patches like this, you should include test results 
showing why this is a good idea. A good commit message is a "why" for 
the patch.

-- 
Jens Axboe
