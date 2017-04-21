Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: set the max segments to USHRT_MAX
To: Josef Bacik <josef@toxicpanda.com>, nbd-general@lists.sourceforge.net,
 linux-block@vger.kernel.org, kernel-team@fb.com
References: <1492717621-9042-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3abe6211-2ed8-a88f-23e4-e5064c0fe2c5@kernel.dk>
Date: Thu, 20 Apr 2017 19:54:11 -0600
MIME-Version: 1.0
In-Reply-To: <1492717621-9042-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 01:47 PM, Josef Bacik wrote:
> I lack the basic understanding of what segments mean, so we were being
> limited to 512kib requests even with higher max_sectors sizes set.
> Setting the maximum number of segments to unlimited allows us to
> actually have arbitrarily large IO's go through NBD.

Applied for 4.12, thanks Josef.

-- 
Jens Axboe
