Return-Path: <bruno@wolff.to>
Date: Fri, 15 Dec 2017 11:40:13 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: Laura Abbott <labbott@redhat.com>
Cc: weiping zhang <zwp10758@gmail.com>, Jan Kara <jack@suse.cz>,
  Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171215174013.GA20381@wolff.to>
References: <20171214082452.GA16698@wolff.to>
 <20171214100927.GA26167@localhost.didichuxing.com>
 <20171214154136.GA12936@wolff.to>
 <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
 <20171215014417.GA17757@wolff.to>
 <CAA70yB6spi5c38kFVidRsJVaYc3W9tvpZz6wy+28rK7oeefQfw@mail.gmail.com>
 <20171215111050.GA30737@wolff.to>
 <CAA70yB66ekUGAvusQbqo7BLV+uBJtNz72cr+tZitsfjuVRWuXA@mail.gmail.com>
 <20171215163048.GA15928@wolff.to>
 <533198ad-b756-3e0a-c3bd-9aae0a42d170@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <533198ad-b756-3e0a-c3bd-9aae0a42d170@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 15, 2017 at 09:18:56 -0800,
  Laura Abbott <labbott@redhat.com> wrote:
>
>You can see the trees Fedora produces at https://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/fedora.git
>which includes the configs (you want to look at the ones withtout - debug)

Thanks. I found it a little while ago and am already doing a test build 
without weiping's test patch to see if that kernel provides what he(?) 
needs. Doing a rebuild with the test patch will go pretty quickly. So 
if I get the message with device_add_disk from these kernels, I should 
be able to get the information this afternoon. If there is some other 
reason I don't get that when I do the builds, I'm probably not going to be 
able to figure it out and get a build done before I leave. I don't live 
close enough to the office that I'm going to want to drive in just to 
be able to do a reboot test. (And my hardware at home does exhibit the 
problem.)

If you have some other idea about why I might not be seeing the 
device_add_disk message, I'd be interested in hearing it.
