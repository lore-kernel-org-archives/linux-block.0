Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171221130057.GA26743@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com> <20171221130057.GA26743@wolff.to>
From: weiping zhang <zwp10758@gmail.com>
Date: Thu, 21 Dec 2017 22:01:33 +0800
Message-ID: <CAA70yB6Z=r+zO7E+ZP74jXNk_XM2CggYthAD=TKOdBVsHLLV-w@mail.gmail.com>
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for bdi_debug_register")
To: Bruno Wolff III <bruno@wolff.to>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	regressions@leemhuis.info, weiping zhang <zhangweiping@didichuxing.com>,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2017-12-21 21:00 GMT+08:00 Bruno Wolff III <bruno@wolff.to>:
> After today, I won't have physical access to the problem machine until
> January 2nd. So if you guys have any testing suggestions I need them soon if
> they are to get done before my vacation.
> I do plan to try booting to level 1 to see if I can get a login prompt that
> might facilitate testing. The lockups do happen fairly late in the boot
> process. I never get to X, but maybe it will get far enough for a console
> login.
>
Hi,
how do you do bisect ?build all kernel commit one by one ?
as you did before:
https://bugzilla.redhat.com/show_bug.cgi?id=1520982

what kernel source code do you use that occur warning at device_add_disk?
from fedora or any official release ? if so ,could you provide web link?

if you use same kernel source code and same .config, why your own build
Cann't trigger that warning ?
