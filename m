Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <14f04d43-728a-953f-e07c-e7f9d5e3392d@kernel.dk>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171221130057.GA26743@wolff.to> <CAA70yB6Z=r+zO7E+ZP74jXNk_XM2CggYthAD=TKOdBVsHLLV-w@mail.gmail.com>
 <20171221151843.GA453@wolff.to> <CAA70yB496Nuy2FM5idxLZthBwOVbhtsZ4VtXNJ_9mj2cvNC4kA@mail.gmail.com>
 <20171221153631.GA2300@wolff.to> <CAA70yB6nD7CiDZUpVPy7cGhi7ooQ5SPkrcXPDKqSYD2ezLrGHA@mail.gmail.com>
 <20171221164221.GA23680@wolff.to> <14f04d43-728a-953f-e07c-e7f9d5e3392d@kernel.dk>
From: weiping zhang <zwp10758@gmail.com>
Date: Fri, 22 Dec 2017 01:46:00 +0800
Message-ID: <CAA70yB7mCzRmULHQ44EDr2x2YzFBJaSfhcGhSHWfDPrPuevg4w@mail.gmail.com>
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for bdi_debug_register")
To: Jens Axboe <axboe@kernel.dk>
Cc: Bruno Wolff III <bruno@wolff.to>, Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	regressions@leemhuis.info, weiping zhang <zhangweiping@didichuxing.com>,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2017-12-22 1:02 GMT+08:00 Jens Axboe <axboe@kernel.dk>:
> On 12/21/17 9:42 AM, Bruno Wolff III wrote:
>> On Thu, Dec 21, 2017 at 23:48:19 +0800,
>>   weiping zhang <zwp10758@gmail.com> wrote:
>>>> output you want. I never saw it for any kernels I compiled myself. Only when
>>>> I test kernels built by Fedora do I see it.
>>> see it every boot ?
>>
>> I don't look every boot. The warning gets scrolled of the screen. Once I see
>> the CPU hang warnings I know the boot is failing. I don't always look
>> at journalctl later to see what's there.
>
> I'm going to revert a0747a859ef6 for now, since we're now 8 days into this
> and no progress has been made on fixing it.
>
OK, you can revert it first.
it seems MD produce a duplicated major:minor pair, which lead to create
debugfs dir failed, but it's under debugging...
>
