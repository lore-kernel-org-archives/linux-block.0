Return-Path: <bruno@wolff.to>
Date: Thu, 21 Dec 2017 09:36:31 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: weiping zhang <zwp10758@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
  Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, weiping zhang <zhangweiping@didichuxing.com>,
  linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171221153631.GA2300@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171221130057.GA26743@wolff.to>
 <CAA70yB6Z=r+zO7E+ZP74jXNk_XM2CggYthAD=TKOdBVsHLLV-w@mail.gmail.com>
 <20171221151843.GA453@wolff.to>
 <CAA70yB496Nuy2FM5idxLZthBwOVbhtsZ4VtXNJ_9mj2cvNC4kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <CAA70yB496Nuy2FM5idxLZthBwOVbhtsZ4VtXNJ_9mj2cvNC4kA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 21, 2017 at 23:31:40 +0800,
  weiping zhang <zwp10758@gmail.com> wrote:
>does every time boot fail can trigger WANRING in device_add_disk ?

Not that I see. But the message could scroll off the screen. The boot gets 
far enough that systemd copies over dmesg output to permanent storage that 
I can see on my next successful boot. That's where I looked for the warning 
output you want. I never saw it for any kernels I compiled myself. Only 
when I test kernels built by Fedora do I see it.

I just tried booting to single user and the boot still hangs.

When I build the kernels, the compiler options are probably a bit different 
than when Fedora does. That might affect what happens during boot.
