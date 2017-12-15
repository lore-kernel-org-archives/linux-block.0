Return-Path: <bruno@wolff.to>
Date: Thu, 14 Dec 2017 19:44:17 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: weiping zhang <zwp10758@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
  Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171215014417.GA17757@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171214082452.GA16698@wolff.to>
 <20171214100927.GA26167@localhost.didichuxing.com>
 <20171214154136.GA12936@wolff.to>
 <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 15, 2017 at 09:22:21 +0800,
  weiping zhang <zwp10758@gmail.com> wrote:
>
>Thanks your testing, but I cann't find WARN_ON in device_add_disk from
>this boot1.log, could you help reproduce that issue? And does this issue can be
>triggered at every bootup ?

I don't know what you need for the first question. When I am physically at 
the machine I can do test reboots. If you have something specific you want 
me to try I should be able to.

Every time I boot with the problem commit, the boot never completes. However 
it does seem to get pretty far. I get multiple register dumps every time. 
After a while (a few minutes) I reboot to a wrking kernel.

The output I included is from: journalctl -k -b -1
If you think it would be better to see more than dmesg output let me know.
