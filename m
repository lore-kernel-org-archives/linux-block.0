Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1540943443.196084.131.camel@acm.org>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
From: Bart Van Assche <bvanassche@acm.org>
To: Evan Green <evgreen@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: Gwendal Grignou <gwendal@chromium.org>, Alexis Savery
 <asavery@chromium.org>,  linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 30 Oct 2018 16:50:43 -0700
In-Reply-To: <20181030230624.61834-1-evgreen@chromium.org>
References: <20181030230624.61834-1-evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
+AD4 This series addresses some errors seen when using the loop
+AD4 device directly backed by a block device. The first change plumbs
+AD4 out the correct error message, and the second change prevents the
+AD4 error from occurring in many cases.

Hi Evan,

Can you provide some information about the use case? Why do you think that
it would be useful to support backing a loop device by a block device? Why
to use the loop driver instead of dm-linear for this use case?

Thanks,

Bart.
