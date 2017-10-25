Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] lightnvm: Convert timers to use timer_setup()
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
 Kees Cook <keescook@chromium.org>
Cc: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171024153004.GA112705@beast>
 <05041A94-19A4-42DC-9DA7-5CB0730F4B01@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e0955c0b-2599-b028-99bb-726e7f03569f@kernel.dk>
Date: Wed, 25 Oct 2017 11:24:24 -0700
MIME-Version: 1.0
In-Reply-To: <05041A94-19A4-42DC-9DA7-5CB0730F4B01@lightnvm.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/2017 01:53 AM, Javier González wrote:
> One thing though: The patch does not apply on top of Jen's for-15/block.
> It is trivial, but here you have a version that applies.

Jens's...

It won't work against that tree, as it doesn't have the necessary prep
patch. We can do this after the merge window opens.

-- 
Jens Axboe
