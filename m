Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: set discard granularity properly
To: Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <20180523173559.6336-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2eb5f5ba-298c-da7b-c0bd-05e51c18bc14@kernel.dk>
Date: Wed, 23 May 2018 15:27:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180523173559.6336-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/23/18 11:35 AM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> For some reason we had discard granularity set to 512 always even when
> discards were disabled.  Fix this by having the default be 0, and then
> if we turn it on set the discard granularity to the blocksize.

Applied, thanks.

-- 
Jens Axboe
