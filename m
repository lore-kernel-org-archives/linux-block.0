Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Tue, 5 Jun 2018 09:13:44 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: kvigor@gmail.com
Cc: linux-block@vger.kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	Kevin Vigor <kvigor@fb.com>
Subject: Re: [PATCH] nbd: Consistently use request pointer in debug messages.
Message-ID: <20180605131343.lsyazgsi4ksdnwpt@destiny>
References: <1528130412-4541-1-git-send-email-kvigor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528130412-4541-1-git-send-email-kvigor@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 04, 2018 at 10:40:12AM -0600, kvigor@gmail.com wrote:
> From: Kevin Vigor <kvigor@fb.com>
> 
> Existing dev_dbg messages sometimes identify request using request
> pointer, sometimes using nbd_cmd pointer. This makes it hard to
> follow request flow. Consistently use request pointer instead.

Reviewed-by: Josef Bacik <jbacik@toxicpanda.com>

Thanks,

Josef
