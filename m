Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RESEND] loop: clear wb_err in bd_inode when detaching
 backing file
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 willy@infradead.org, darrick.wong@oracle.com, tytso@mit.edu,
 bfoster@redhat.com
References: <20180521183503.6029-1-jlayton@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <af70acb0-b636-b6a8-feca-a575c8e7c317@kernel.dk>
Date: Mon, 21 May 2018 12:36:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180521183503.6029-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/21/18 12:35 PM, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> When a loop block device encounters a writeback error, that error will
> get propagated to the bd_inode's wb_err field. If we then detach the
> backing file from it, attach another and fsync it, we'll get back the
> writeback error that we had from the previous backing file.
> 
> This is a bit of a grey area as POSIX doesn't cover loop devices, but it
> is somewhat counterintuitive.
> 
> If we detach a backing file from the loopdev while there are still
> unreported errors, take it as a sign that we're no longer interested in
> the previous file, and clear out the wb_err in the loop blockdev.

Applied, thanks Jeff.

-- 
Jens Axboe
