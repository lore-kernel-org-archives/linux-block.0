Return-Path: <axboe@kernel.dk>
Subject: Re: block: hung task writing to device
To: "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20170708190730.avwa2urwjuvohpgg@sasha-lappy>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <92fb7af1-d128-ffe0-bc5c-b7a5ead77b1e@kernel.dk>
Date: Mon, 10 Jul 2017 10:05:15 -0600
MIME-Version: 1.0
In-Reply-To: <20170708190730.avwa2urwjuvohpgg@sasha-lappy>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/08/2017 01:06 PM, Levin, Alexander (Sasha Levin) wrote:
> Hi all,
> 
> syzkaller seems to be hitting a lockup with the reproducer below:
> 
> INFO: task syzkaller490361:8788 blocked for more than 120 seconds.
>      Not tainted 4.12.0-next-20170706+ #186
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syzkaller490361 D18312  8788   5843 0x00080004
> Call Trace:

I've run this for about an hour now, with mq-deadline and a regular SATA
drive, and it's still chugging along. I need to know more about your
setup.

-- 
Jens Axboe
