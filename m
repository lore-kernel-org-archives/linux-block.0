Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] cfq: Disable writeback throttling by default
To: Jan Kara <jack@suse.cz>
References: <20170404123130.23151-1-jack@suse.cz>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bd122646-b001-dd53-9aa6-6a732d345624@kernel.dk>
Date: Wed, 5 Apr 2017 08:16:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170404123130.23151-1-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/04/2017 06:31 AM, Jan Kara wrote:
> Writeback throttling does not play well with CFQ since that also tries
> to throttle async writes. As a result async writeback can get starved in
> presence of readers. As an example take a benchmark simulating
> postgreSQL database running over a standard rotating SATA drive. There
> are 16 processes doing random reads from a huge file (2*machine memory),
> 1 process doing random writes to the huge file and calling fsync once
> per 50000 writes and 1 process doing sequential 8k writes to a
> relatively small file wrapping around at the end of the file and calling
> fsync every 5 writes. Under this load read latency easily exceeds the
> target latency of 75 ms (just because there are so many reads happening
> against a relatively slow disk) and thus writeback is throttled to a
> point where only 1 write request is allowed at a time.

Thanks Jan, it's probably really hard to ever combine anything with
CFQ, since it does its own thing. I have applied the patch.

-- 
Jens Axboe
