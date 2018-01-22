Return-Path: <axboe@kernel.dk>
Subject: Re: Hard LOCKUP on 4.15-rc9 + 'blkmq/for-next' branch
To: David Zarzycki <dave@znu.io>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <95E75EBE-D01A-4236-8762-FF3522D6DBAD@znu.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78e10971-611e-8dd7-104e-8266c3ba3b5c@kernel.dk>
Date: Mon, 22 Jan 2018 16:34:16 -0700
MIME-Version: 1.0
In-Reply-To: <95E75EBE-D01A-4236-8762-FF3522D6DBAD@znu.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/22/18 4:31 PM, David Zarzycki wrote:
> Hello,
> 
> I previously reported a hang when building LLVM+clang on a block multi-queue device (NVMe _or_ loopback onto tmpfs with the ’none’ scheduler).
> 
> I’ve since updated the kernel to 4.15-rc9, merged the ‘blkmq/for-next’ branch, disabled nohz_full parameter (used for testing), and tried again. Both NVMe and loopback now lock up hard (ext4 if it matters). Here are the backtraces:
> 
> NVMe:      http://znu.io/IMG_0366.jpg
> Loopback:  http://znu.io/IMG_0367.jpg

I tried to reproduce this today using the exact recipe that you provide,
but it ran fine for hours. Similar setup, nvme on a dual socket box
with 48 threads.

> What should I try next to help debug this?

This one looks different than the other one. Are you sure your hw
is sane? I'd probably try and enable lockdep debugging etc and
see if you catch anything.

-- 
Jens Axboe
