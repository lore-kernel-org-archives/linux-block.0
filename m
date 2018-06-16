Return-Path: <axboe@kernel.dk>
Subject: Re: list_add double add in blk_mq_check_expired()
To: Borislav Petkov <bp@alien8.de>, linux-block@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20180616103605.GA28657@zn.tnic>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78f4ff73-3b5a-1e1b-2996-b2b16437247c@kernel.dk>
Date: Sat, 16 Jun 2018 08:46:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180616103605.GA28657@zn.tnic>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/16/18 4:36 AM, Borislav Petkov wrote:
> Hi,
> 
> just triggered the below in a qemu guest, kernel is Linus' master from
> yesterday + tip/master. It doesn't fire reliably so it could be some
> transient thing of the merge window:

Should be fixed in my for-linus branch, it'll go out today.

-- 
Jens Axboe
