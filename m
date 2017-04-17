Return-Path: <prvs=528058ede1=axboe@fb.com>
Subject: Re: [PATCH] nbd: set the max segment size to UINT_MAX
To: Josef Bacik <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <nbd-general@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
References: <1492436677-11209-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <cd50c670-3f2c-b075-1328-a670d810e175@fb.com>
Date: Mon, 17 Apr 2017 09:55:59 -0600
MIME-Version: 1.0
In-Reply-To: <1492436677-11209-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 04/17/2017 07:44 AM, Josef Bacik wrote:
> NBD doesn't care about limiting the segment size, let the user push the
> largest bio's they want.  This allows us to control the request size
> solely through max_sectors_kb.

Doesn't apply to the 4.12 branch.

-- 
Jens Axboe
