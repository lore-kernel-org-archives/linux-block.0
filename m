Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: update comments to reflect REQ_FLUSH ->
 REQ_PREFLUSH rename
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
References: <4c5c12f867eaf4da2230e11cfb27676e29c152e1.1503598124.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <541d40d7-4a26-9e15-13d8-34ac48382b9d@kernel.dk>
Date: Fri, 25 Aug 2017 10:38:20 -0600
MIME-Version: 1.0
In-Reply-To: <4c5c12f867eaf4da2230e11cfb27676e29c152e1.1503598124.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/24/2017 12:09 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Normally I wouldn't bother with this, but in my opinion the comments are
> the most important part of this whole file since without them no one
> would have any clue how this insanity works.

What are you talking about, that code is clear as day. But, uhm, applied
for 4.14.

-- 
Jens Axboe
