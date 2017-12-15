Return-Path: <bruno@wolff.to>
Date: Fri, 15 Dec 2017 05:10:50 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: weiping zhang <zwp10758@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
  Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171215111050.GA30737@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171214082452.GA16698@wolff.to>
 <20171214100927.GA26167@localhost.didichuxing.com>
 <20171214154136.GA12936@wolff.to>
 <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
 <20171215014417.GA17757@wolff.to>
 <CAA70yB6spi5c38kFVidRsJVaYc3W9tvpZz6wy+28rK7oeefQfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <CAA70yB6spi5c38kFVidRsJVaYc3W9tvpZz6wy+28rK7oeefQfw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 15, 2017 at 10:04:32 +0800,
  weiping zhang <zwp10758@gmail.com> wrote:
>I just want to know WARN_ON WHAT in device_add_disk,
>if bdi_register_owner return error code, it may fail at any step of following:

Was that output in the original boot log? I didn't see anything there 
that had the string WARN_ON. The first log was from a Fedora kernel. The 
second from a kernel I built. I used a Fedora config though. The config 
was probably from one of their nodebug kernels, I could build another 
one using a config from a debug kernel. Would that likely provide what 
you are looking for?
