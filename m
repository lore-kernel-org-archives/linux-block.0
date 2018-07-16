Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blk-iolatency: don't change the latency window
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <20180716161223.21486-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5822cf6b-075e-3140-415e-74ea86734b81@kernel.dk>
Date: Mon, 16 Jul 2018 10:16:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180716161223.21486-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/16/18 10:12 AM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Early versions of these patches had us waiting for seconds at a time
> during submission, so we had to adjust the timing window we monitored
> for latency.  Now we don't do things like that so this is unnecessary
> code.

Applied 1-2 for 4.19.

-- 
Jens Axboe
