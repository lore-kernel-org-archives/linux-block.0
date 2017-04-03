Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: allow us to change max_segments on the fly
To: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
 linux-block@vger.kernel.org
References: <1491246798-1774-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9a782a78-7842-db93-2065-22081d16ab1d@kernel.dk>
Date: Mon, 3 Apr 2017 13:15:36 -0600
MIME-Version: 1.0
In-Reply-To: <1491246798-1774-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/03/2017 01:13 PM, Josef Bacik wrote:
> For things like NBD we want to be able to experiment with different
> sized requests going over the wire.  Half of our limit is controled by
> max_sectors_kb, but the other half is how many bvec's we can cram into a
> request, which is controlled by max_segments.  Changing this sysfs knob
> to be writeable allows us to be able to control our io limits more
> precisely.

This is a hw setting for most drivers, we can't make it user settable.
If you want it user settable, you'd have to split it in a hw and user
setting.

-- 
Jens Axboe
