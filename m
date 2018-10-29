Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1540831588.196084.54.camel@acm.org>
Subject: Re: [PATCH 01/14] blk-mq: kill q->mq_map
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Oct 2018 09:46:28 -0700
In-Reply-To: <20181029163738.10172-2-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
	 <20181029163738.10172-2-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 It's just a pointer to set-+AD4-mq+AF8-map, use that instead.

Please clarify in the patch description that the q-+AD4-tag+AF8-set assignment
has been moved because this patch makes it necessary to have that pointer
available earlier such that it is clear that that move is intentional.
Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
