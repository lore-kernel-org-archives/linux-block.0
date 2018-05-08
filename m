Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 8 May 2018 13:48:12 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	dchinner@redhat.com, hch@lst.de
Subject: Re: [PATCH 4/4] blk-wbt: throttle discards like background writes
Message-ID: <20180508204812.GE27324@vader>
References: <1525709615-14395-1-git-send-email-axboe@kernel.dk>
 <1525709615-14395-5-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525709615-14395-5-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 07, 2018 at 10:13:35AM -0600, Jens Axboe wrote:
> Throttle discards like we would any background write. Discards should
> be background activity, so if they are impacting foreground IO, then
> we will throttle them down.

Seems reasonable.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-stat.h |  6 +++---
>  block/blk-wbt.c  | 43 ++++++++++++++++++++++++++-----------------
>  block/blk-wbt.h  |  4 +++-
>  3 files changed, 32 insertions(+), 21 deletions(-)
