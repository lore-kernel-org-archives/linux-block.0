Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] Bcache fixes for 4.16
To: Michael Lyle <mlyle@lyle.org>, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20180227174930.15911-1-mlyle@lyle.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <97b035f5-22dd-9c37-717d-7d723cdd8a2d@kernel.dk>
Date: Tue, 27 Feb 2018 10:54:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180227174930.15911-1-mlyle@lyle.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/27/18 10:49 AM, Michael Lyle wrote:
> Hi Jens,
> 
> Please pick up these two critical fixes to bcache by Tang Junhui.
> They're both one-liners and have been reviewed and tested.
> 
> The first corrects a regression when flash-only volumes are present
> that was introduced in 4.16-RC1.  The second adjusts bio refcount
> and completion behavior to work with md RAID5 backing.

Looks fine, applied for 4.16, thanks Mike.

-- 
Jens Axboe
