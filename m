Return-Path: <axboe@kernel.dk>
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
To: Josef Bacik <jbacik@fb.com>, Wouter Verhelst <w@uter.be>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <3536bb1d-623d-8533-1584-0040207a6c3d@fb.com>
 <20160909205535.xfl3py76z6zedejt@grep.be>
 <cc4d274c-184d-02de-cd98-ad30f8cce74f@fb.com>
Cc: linux-block@vger.kernel.org, mpa@pengutronix.de, kernel-team@fb.com,
 nbd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <14127c86-f6c5-22e6-ae14-c2b9a6395372@kernel.dk>
Date: Fri, 9 Sep 2016 17:37:21 -0600
MIME-Version: 1.0
In-Reply-To: <cc4d274c-184d-02de-cd98-ad30f8cce74f@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/09/2016 05:00 PM, Josef Bacik wrote:
>> Right. Alternatively, you could perhaps make it so that the lost
>> connection is removed, unack'd requests on that connection are resent,
>> and the session moves on with one less connection (unless the lost
>> connection is the last one, in which case we die as before). That might
>> be too much work and not worth it though.
>
> Yeah I wasn't sure if we could just randomly remove hw queue's in blk mq
> while the device is still up.  If that is in fact easy to do then I'm in
> favor of trucking along with less connections than we originally had,
> otherwise I think it'll be too big of a pain.  Also some users (Facebook
> in this case) would rather the whole thing fail so we can figure out
> what went wrong rather than suddenly going at a degraded performance.

We can do that online. We do that for CPU hotplug/unplug events, and we
also expose that functionality to drivers through
blk_mq_update_nr_hw_queues(). So yes, should be trivial to support from
nbd.

-- 
Jens Axboe
