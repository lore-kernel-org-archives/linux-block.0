Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Signed-off-by: Kitone Elvis Peter <elviskitone@gmail.com>
To: Kitone Elvis Peter <elviskitone@gmail.com>
Cc: linux-block@vger.kernel.org
References: <20180608090737.GA5653@kitone-HP-ProBook-4530s>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6d0a5808-2c4b-e4f2-3426-476b38887db5@kernel.dk>
Date: Fri, 8 Jun 2018 07:12:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180608090737.GA5653@kitone-HP-ProBook-4530s>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/8/18 3:07 AM, Kitone Elvis Peter wrote:
> Subject: REMOVE DELETION ERROR
> 
> Corrected the modified variable in  previous commit

That's not how it works - you send out a v2 of the patch instead. Read:

Documentation/process/submitting-patches.rst

and don't send anything out before you have. And never send out patches
that you haven't even compiled.

-- 
Jens Axboe
