Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1540503738.66186.63.camel@acm.org>
Subject: Re: [PATCH 23/28] block: kill lld busy
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Date: Thu, 25 Oct 2018 14:42:18 -0700
In-Reply-To: <20181025211039.11559-24-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
	 <20181025211039.11559-24-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
+AD4 Nobody sets the helper, so we always return 0. Kill it.

How about changing the description of this patch into something
like +ACI-Now that the blk+AF8-lld+AF8-busy() and blk+AF8-queue+AF8-lld+AF8-busy() callers
have been removed, also remove the implementations of these functions.+ACI?

Thanks,

Bart.
