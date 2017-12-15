Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171215111050.GA30737@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171214082452.GA16698@wolff.to> <20171214100927.GA26167@localhost.didichuxing.com>
 <20171214154136.GA12936@wolff.to> <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
 <20171215014417.GA17757@wolff.to> <CAA70yB6spi5c38kFVidRsJVaYc3W9tvpZz6wy+28rK7oeefQfw@mail.gmail.com>
 <20171215111050.GA30737@wolff.to>
From: weiping zhang <zwp10758@gmail.com>
Date: Fri, 15 Dec 2017 22:02:20 +0800
Message-ID: <CAA70yB66ekUGAvusQbqo7BLV+uBJtNz72cr+tZitsfjuVRWuXA@mail.gmail.com>
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for bdi_debug_register")
To: Bruno Wolff III <bruno@wolff.to>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	regressions@leemhuis.info, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2017-12-15 19:10 GMT+08:00 Bruno Wolff III <bruno@wolff.to>:
> On Fri, Dec 15, 2017 at 10:04:32 +0800,
>  weiping zhang <zwp10758@gmail.com> wrote:
>>
>> I just want to know WARN_ON WHAT in device_add_disk,
>> if bdi_register_owner return error code, it may fail at any step of
>> following:
>
>
> Was that output in the original boot log? I didn't see anything there that
> had the string WARN_ON. The first log was from a Fedora kernel. The second
Sorry to let you confuse, WARN_ON means we catch log as following:
WARNING: CPU: 3 PID: 3486 at block/genhd.c:680 device_add_disk+0x3d9/0x460

> from a kernel I built. I used a Fedora config though. The config was
> probably from one of their nodebug kernels, I could build another one using
> a config from a debug kernel. Would that likely provide what you are looking
> for?

Yes, please help reproduce this issue include my debug patch. Reproduce means
we can see WARN_ON in device_add_disk caused by failure of bdi_register_owner.
