Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Make write_hints[] big enough
To: Avri Altman <avri.altman@wdc.com>, linux-block@vger.kernel.org
Cc: Avi Shchislowski <avi.shchislowski@wdc.com>,
 Alex Lemberg <alex.lemberg@wdc.com>
References: <1539795081-2394-1-git-send-email-avri.altman@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <28ec8613-09c2-b82d-48da-7750e8ff144c@kernel.dk>
Date: Thu, 18 Oct 2018 08:37:48 -0600
MIME-Version: 1.0
In-Reply-To: <1539795081-2394-1-git-send-email-avri.altman@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/17/18 10:51 AM, Avri Altman wrote:
> Just stumbled over this.
> Looks like the write hints array in the request queue is not allotted
> with the required space to accommodate all the write hint types.
> 
> fixes: f793dfd3f39a (blk-mq: expose write hints through debugfs)

Your commit message doesn't really explain what you think the issue
is. We have 4 write hint types, with a fifth being "none". Where
are we exceeding these 5 hints?

-- 
Jens Axboe
