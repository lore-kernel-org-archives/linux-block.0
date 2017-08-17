Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: allow device creation at a specific index
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <1502735133-15841-1-git-send-email-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <641a9030-ade5-855b-ffcf-f276a39b5fae@kernel.dk>
Date: Thu, 17 Aug 2017 11:03:50 -0600
MIME-Version: 1.0
In-Reply-To: <1502735133-15841-1-git-send-email-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/14/2017 12:25 PM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> If users really want to use a particular index for their nbd device and it
> doesn't already exist there's no reason we can't just create it for them.  Do
> this instead of erroring out.

Added for 4.14, thanks.

-- 
Jens Axboe
