Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 0/6] Fix races between blkcg code and request queue
 initialization and cleanup
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180228181533.29402-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5fe43ee3-2982-6d6d-2461-519fa02d00cd@kernel.dk>
Date: Wed, 28 Feb 2018 11:19:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180228181533.29402-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/28/18 11:15 AM, Bart Van Assche wrote:
> Hello Jens,
> 
> Recently Joseph Qi identified races between the block cgroup code and request
> queue initialization and cleanup. This patch series address these races.
> 
> This patch series is structured as follows:
> - Patches 3..6 fix the aforementioned races.
> - Patches 1..3 ensure that all maintained block drivers delete the gendisk
>   before cleaning up the request queue because patches 3..6 are only safe
>   if block driver shutdown uses this order. The gdrom driver (Sega Dreamcast
>   GD-ROM driver) has not been modified because from what I saw in the changelog
>   of this driver it seems to me like that driver is no longer in use. According
>   to what I found on the web production of Sega Dreamcast was stopped in 2001
>   (https://www.theguardian.com/business/2001/feb/01/4).
> 
> Please consider these patches for kernel v4.17.

Didn't Ming ack the first three?

-- 
Jens Axboe
