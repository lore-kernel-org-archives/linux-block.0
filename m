Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Change 'unsigned' to 'unsigned int' throughout
 block layer
To: John Pittman <jpittman@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8c4f1f22-223e-6bc1-6261-dceb0caf5219@kernel.dk>
Date: Wed, 14 Feb 2018 19:03:44 -0700
MIME-Version: 1.0
In-Reply-To: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/14/18 6:37 PM, John Pittman wrote:
> In quite a few files throughout the block layer, the bare 'unsigned' is
> used rather than the preferred 'unsigned int'.  The issue was
> exposed by checkpatch.pl.  Warnings encountered were:
> 
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>     WARNING: Prefer 'unsigned int *' to bare use of 'unsigned *'
> 
> Fixed 64 total warnings.

I'm not going to take this, unless there's a specific bug related
to it.

-- 
Jens Axboe
