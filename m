Return-Path: <bruno@wolff.to>
Date: Fri, 15 Dec 2017 13:51:22 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: weiping zhang <zwp10758@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
  Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171215195122.GA27126@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171214082452.GA16698@wolff.to>
 <20171214100927.GA26167@localhost.didichuxing.com>
 <20171214154136.GA12936@wolff.to>
 <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
 <20171215014417.GA17757@wolff.to>
 <CAA70yB6spi5c38kFVidRsJVaYc3W9tvpZz6wy+28rK7oeefQfw@mail.gmail.com>
 <20171215111050.GA30737@wolff.to>
 <CAA70yB66ekUGAvusQbqo7BLV+uBJtNz72cr+tZitsfjuVRWuXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <CAA70yB66ekUGAvusQbqo7BLV+uBJtNz72cr+tZitsfjuVRWuXA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 15, 2017 at 22:02:20 +0800,
  weiping zhang <zwp10758@gmail.com> wrote:
>Sorry to let you confuse, WARN_ON means we catch log as following:
>WARNING: CPU: 3 PID: 3486 at block/genhd.c:680 device_add_disk+0x3d9/0x460

I do not get this warning for any of the kernels I build, whether from 
Linus' tree or Josh Boyer's Fedora tree. It shows up when I test kernels built 
by Fedora, but those don't have your debug patch.

I do not know what is different. Do you have any ideas? Most likely I won't 
be able to test any more kernels until Monday (unless I can use most of my 
most recent build over again very soon).
