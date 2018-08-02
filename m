Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>, mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1533217674-9514-1-git-send-email-javier@cnexlabs.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2436f855-7a87-9ecd-be3a-358939c9c750@kernel.dk>
Date: Thu, 2 Aug 2018 09:57:40 -0600
MIME-Version: 1.0
In-Reply-To: <1533217674-9514-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/2/18 7:47 AM, Javier González wrote:
> Take the write semaphore on metadata I/Os too.

I'm going to nit pick a little bit here, but this isn't a good
changelog at all. A good changelog tells you _why_ a change is
made, not how it's made. Your commit message doesn't really tell
me anything that I can't easily glean from looking at the patch.

A good commit message would tell me _why_ we are now also
grabbing the write sem for metadata.

-- 
Jens Axboe
