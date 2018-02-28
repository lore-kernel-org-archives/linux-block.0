Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/6] Fix races between blkcg code and request queue
 initialization and cleanup
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
 <1519774665.23791.23.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <72406d05-acc3-8636-e577-74548fb3022a@kernel.dk>
Date: Wed, 28 Feb 2018 08:33:24 -0700
MIME-Version: 1.0
In-Reply-To: <1519774665.23791.23.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/27/18 4:37 PM, Bart Van Assche wrote:
> On Thu, 2018-02-22 at 17:08 -0800, Bart Van Assche wrote:
>> Recently Joseph Qi identified races between the block cgroup code and request
>> queue initialization and cleanup. This patch series address these races. Please
>> consider these patches for kernel v4.17.
> 
> Hello Jens,
> 
> Can you have a look at this series?

Looks fine to me. Can you repost with the suggested change from Johannes,
and collect the acks while your at it? Then we can queue it up for 4.17.

-- 
Jens Axboe
