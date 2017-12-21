Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171221151843.GA453@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171221130057.GA26743@wolff.to> <CAA70yB6Z=r+zO7E+ZP74jXNk_XM2CggYthAD=TKOdBVsHLLV-w@mail.gmail.com>
 <20171221151843.GA453@wolff.to>
From: weiping zhang <zwp10758@gmail.com>
Date: Thu, 21 Dec 2017 23:31:40 +0800
Message-ID: <CAA70yB496Nuy2FM5idxLZthBwOVbhtsZ4VtXNJ_9mj2cvNC4kA@mail.gmail.com>
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for bdi_debug_register")
To: Bruno Wolff III <bruno@wolff.to>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	regressions@leemhuis.info, weiping zhang <zhangweiping@didichuxing.com>,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2017-12-21 23:18 GMT+08:00 Bruno Wolff III <bruno@wolff.to>:
> On Thu, Dec 21, 2017 at 22:01:33 +0800,
>  weiping zhang <zwp10758@gmail.com> wrote:
>>
>> Hi,
>> how do you do bisect ?build all kernel commit one by one ?
>> as you did before:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1520982
>
>
> I just did the one bisect using Linus' tree. After each build, I would do a
> test boot and see if the boot was normal or if I got errors and an eventual
> hang before boot.
>
> Since then I have used git revert to revert just the problem commit from
> later kernels (such as v4.15-rc4) and when I do the system boots normally.
> And when I don't do the revert or just use stock Fedora kernels the problem
> occurs every time.
does every time boot fail can trigger WANRING in device_add_disk ?
