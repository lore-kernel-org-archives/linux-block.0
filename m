Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Tue, 5 Jun 2018 10:30:06 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: kvigor@gmail.com, linux-block@vger.kernel.org, josef@toxicpanda.com,
	Kevin Vigor <kvigor@fb.com>
Subject: Re: [PATCH] nbd: Consistently use request pointer in debug messages.
Message-ID: <20180605143005.m3bkudt4zydhllu7@destiny>
References: <1528130412-4541-1-git-send-email-kvigor@gmail.com>
 <10d1cb78-5d68-0301-ae5c-3d35ce68383a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10d1cb78-5d68-0301-ae5c-3d35ce68383a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 05, 2018 at 08:23:06AM -0600, Jens Axboe wrote:
> On 6/4/18 10:40 AM, kvigor@gmail.com wrote:
> > From: Kevin Vigor <kvigor@fb.com>
> > 
> > Existing dev_dbg messages sometimes identify request using request
> > pointer, sometimes using nbd_cmd pointer. This makes it hard to
> > follow request flow. Consistently use request pointer instead.
> 
> You're missing the Signed-off-by.
> 

Blah sorry, still a little foggy,

Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
