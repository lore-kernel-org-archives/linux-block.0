Return-Path: <axboe@kernel.dk>
Subject: Re: block: hung task writing to device
To: "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20170708190730.avwa2urwjuvohpgg@sasha-lappy>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <720248fc-22fa-1fd3-08a4-e582adb38037@kernel.dk>
Date: Sat, 8 Jul 2017 19:29:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170708190730.avwa2urwjuvohpgg@sasha-lappy>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/08/2017 01:06 PM, Levin, Alexander (Sasha Levin) wrote:
> Hi all,
> 
> syzkaller seems to be hitting a lockup with the reproducer below:

Thanks for the reproducer, but this is missing a lot of detail that we
need to debug this issue. Is this a regression since 4.12? What storage
device is this? Is the device using an IO scheduler?

dmesg after boot and .config would be helpful, too.

-- 
Jens Axboe
