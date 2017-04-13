Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 13 Apr 2017 16:08:10 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 3/6] blk-mq: Make blk_flags_show() callers append a
 newline character
Message-ID: <20170413230810.GD1550@vader.DHCP.thefacebook.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
 <20170411205842.28137-4-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170411205842.28137-4-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 11, 2017 at 01:58:39PM -0700, Bart Van Assche wrote:
> This patch does not change any functionality but makes it possible
> to produce a single line of output with multiple flag-to-name
> translations.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>

Reviewed-by: Omar Sandoval <osandov@fb.com>
