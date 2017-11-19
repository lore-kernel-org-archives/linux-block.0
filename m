Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH -next] blktrace.c: Use blk_trace_bio_get_cgid inside
 blk_add_trace_bio
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171119184817.15754-1-marcos.souza.org@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <91108fb4-7b90-3458-c3b3-21e2c3930d46@kernel.dk>
Date: Sun, 19 Nov 2017 12:38:04 -0700
MIME-Version: 1.0
In-Reply-To: <20171119184817.15754-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/19/2017 11:48 AM, Marcos Paulo de Souza wrote:
> instead of passing cgid as a parameter.

Patch looks fine to me, but I rewrote your changelog. Don't make
it a continuation of the patch title.

-- 
Jens Axboe
