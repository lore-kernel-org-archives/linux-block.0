Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blktrace_api.h: fix comment for struct
 blk_user_trace_setup
To: Eric Biggers <ebiggers3@gmail.com>, linux-block@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
References: <20180127005806.105338-1-ebiggers3@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <03a9043c-1926-e35f-340d-1c77467c7dd9@kernel.dk>
Date: Mon, 26 Feb 2018 12:26:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180127005806.105338-1-ebiggers3@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/26/18 5:58 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> 'struct blk_user_trace_setup' is passed to BLKTRACESETUP, not
> BLKTRACESTART.

Applied, thanks.

-- 
Jens Axboe
