Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] blktrace: delete garbage for message trace
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, axboe@fb.com, Kernel-team@fb.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5731F438.8060400@kernel.dk>
Date: Tue, 10 May 2016 08:46:16 -0600
MIME-Version: 1.0
In-Reply-To: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/09/2016 06:22 PM, Shaohua Li wrote:
> commit f4a1d08ce65 introduces a regression. Originally for
> BLK_TN_MESSAGE, we add message in trace and return. The commit ignores
> the early return and add garbage info.

Applied this, and 2+3/3. Thanks Shaohua.

-- 
Jens Axboe
