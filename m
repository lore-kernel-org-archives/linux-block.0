Return-Path: <bruno@wolff.to>
Date: Sat, 16 Dec 2017 10:32:26 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: weiping zhang <zwp10758@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
  Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171216163226.GA1796@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171214082452.GA16698@wolff.to>
 <20171214100927.GA26167@localhost.didichuxing.com>
 <20171214154136.GA12936@wolff.to>
 <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
 <20171215014417.GA17757@wolff.to>
 <CAA70yB6spi5c38kFVidRsJVaYc3W9tvpZz6wy+28rK7oeefQfw@mail.gmail.com>
 <20171215111050.GA30737@wolff.to>
 <CAA70yB66ekUGAvusQbqo7BLV+uBJtNz72cr+tZitsfjuVRWuXA@mail.gmail.com>
 <20171215195122.GA27126@wolff.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20171215195122.GA27126@wolff.to>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 15, 2017 at 13:51:22 -0600,
  Bruno Wolff III <bruno@wolff.to> wrote:
>
>I do not know what is different. Do you have any ideas? Most likely I 
>won't be able to test any more kernels until Monday (unless I can use 
>most of my most recent build over again very soon).

The .config looks like it should be OK. I'll test setting loglevel on 
boot in case the default is different than what the config file says. 
I can't do that until Monday morning.

I think it is more likely the the WARN_ON macro code isn't being 
compiled in for some reason. I haven't confirmed that, nor have I found 
anything that would leave that code out when I do a make, but include 
it during Fedora builds.
