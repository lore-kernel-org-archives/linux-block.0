Return-Path: <prvs=52824aec4b=axboe@fb.com>
Subject: Re: [PATCH] nbd: set the max segment size to UINT_MAX
To: Josef Bacik <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <nbd-general@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
References: <1492546971-2682-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <e6c114e2-aa3f-829a-fb40-dd901d77d406@fb.com>
Date: Wed, 19 Apr 2017 08:16:22 -0600
MIME-Version: 1.0
In-Reply-To: <1492546971-2682-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

On 04/18/2017 02:22 PM, Josef Bacik wrote:
> NBD doesn't care about limiting the segment size, let the user push the
> largest bio's they want.  This allows us to control the request size
> solely through max_sectors_kb.

Thanks Josef, applied for 4.12.

-- 
Jens Axboe
