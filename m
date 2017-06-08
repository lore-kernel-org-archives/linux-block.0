Subject: Re: [PATCH blktests] loop/002: Regression testing for loop device
 flush
To: James Wang <jnwang@suse.com>, osandov@fb.com, hch@infradead.org
Cc: hare@suse.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 mgorman@suse.com
References: <20170608122812.24225-1-jnwang@suse.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f7910153-2c5e-f6e6-9947-768774956fa7@fb.com>
Date: Thu, 8 Jun 2017 09:17:12 -0600
MIME-Version: 1.0
In-Reply-To: <20170608122812.24225-1-jnwang@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/08/2017 06:28 AM, James Wang wrote:
> Add a regression testing for loop device. when an unbound device
> be close that take too long time. kernel will consume serveral orders
> of magnitude more wall time than it does for a mounted device.

Thanks a lot for taking the time to turn this into a blktests regression
test!

-- 
Jens Axboe
