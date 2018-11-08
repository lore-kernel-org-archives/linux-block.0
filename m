Return-Path: <msnitzer@redhat.com>
Date: Thu, 8 Nov 2018 10:49:01 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: provide a helper to check if a queue is busy
Message-ID: <20181108154901.GB28795@redhat.com>
References: <20181108154216.23853-1-axboe@kernel.dk>
 <20181108154216.23853-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181108154216.23853-3-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 08 2018 at 10:42am -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> Returns true if the queue currently has requests pending,
> false if not.
> 
> DM can use this to replace the atomic_inc/dec they do per device
> to see if a device is busy.
> 
> Cc: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>
