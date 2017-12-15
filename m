Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171214154136.GA12936@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171214082452.GA16698@wolff.to> <20171214100927.GA26167@localhost.didichuxing.com>
 <20171214154136.GA12936@wolff.to>
From: weiping zhang <zwp10758@gmail.com>
Date: Fri, 15 Dec 2017 09:22:21 +0800
Message-ID: <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for bdi_debug_register")
To: Bruno Wolff III <bruno@wolff.to>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	regressions@leemhuis.info, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2017-12-14 23:41 GMT+08:00 Bruno Wolff III <bruno@wolff.to>:
> On Thu, Dec 14, 2017 at 18:09:27 +0800,
>  weiping zhang <zhangweiping@didichuxing.com> wrote:
>>
>>
>> It seems something wrong with bdi debugfs register, could you help
>> test the forllowing debug patch, I add some debug log, no function
>> change, thanks.
>
>
> I applied your patch to d39a01eff9af1045f6e30ff9db40310517c4b45f and there
> were some new debug messages in the dmesg output. Hopefully this helps. I
> also added the patch and output to the Fedora bug for people following
> there.

Hi Bruno,

Thanks your testing, but I cann't find WARN_ON in device_add_disk from
this boot1.log, could you help reproduce that issue? And does this issue can be
triggered at every bootup ?

--
Thanks
weiping
