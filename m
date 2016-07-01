Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix use-after-free in sys_ioprio_get()
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>
References: <fa9c9a3ee7355f932d4f40322602aae5fb293f97.1467358615.git.osandov@fb.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com, stable@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <577680B8.4020003@kernel.dk>
Date: Fri, 1 Jul 2016 08:39:52 -0600
MIME-Version: 1.0
In-Reply-To: <fa9c9a3ee7355f932d4f40322602aae5fb293f97.1467358615.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/01/2016 01:39 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> get_task_ioprio() accesses the task->io_context without holding the task
> lock and thus can race with exit_io_context(), leading to a
> use-after-free. The reproducer below hits this within a few seconds on
> my 4-core QEMU VM:

Thanks Omar, applied for this series.

-- 
Jens Axboe
