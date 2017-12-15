Return-Path: <bruno@wolff.to>
Date: Fri, 15 Dec 2017 10:30:48 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: weiping zhang <zwp10758@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
  Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171215163048.GA15928@wolff.to>
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
>
>Yes, please help reproduce this issue include my debug patch. Reproduce means
>we can see WARN_ON in device_add_disk caused by failure of bdi_register_owner.

I'm not sure why yet, but I'm only getting the warning message you want 
with Fedora kernels, not the ones I am building (with or without your test 
patch). I'll attach a debug config file if you want to look there. But in 
theory that should be essentially what Fedora is using for theirs. They 
probably have some out of tree patches they are applying, but I wouldn't 
expect those to make a difference here. I think they now have a tree 
somewhere that I can try to build from that has their patches applied 
to the upstream kernel and if I can find it I will try building it just 
to test this out.

I only have about 6 hours of physical access to the machine exhibiting 
the problem, and after that I won't be able to do test boots until Monday.
