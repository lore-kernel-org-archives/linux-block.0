Return-Path: <bruno@wolff.to>
Date: Thu, 21 Dec 2017 09:18:43 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: weiping zhang <zwp10758@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
  Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, weiping zhang <zhangweiping@didichuxing.com>,
  linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171221151843.GA453@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171221130057.GA26743@wolff.to>
 <CAA70yB6Z=r+zO7E+ZP74jXNk_XM2CggYthAD=TKOdBVsHLLV-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <CAA70yB6Z=r+zO7E+ZP74jXNk_XM2CggYthAD=TKOdBVsHLLV-w@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 21, 2017 at 22:01:33 +0800,
  weiping zhang <zwp10758@gmail.com> wrote:
>Hi,
>how do you do bisect ?build all kernel commit one by one ?
>as you did before:
>https://bugzilla.redhat.com/show_bug.cgi?id=1520982

I just did the one bisect using Linus' tree. After each build, I would do 
a test boot and see if the boot was normal or if I got errors and an 
eventual hang before boot.

Since then I have used git revert to revert just the problem commit from 
later kernels (such as v4.15-rc4) and when I do the system boots normally. 
And when I don't do the revert or just use stock Fedora kernels the problem 
occurs every time.

I also did a couple of tests with Josh Boyer's Fedora kernel tree that 
has Fedora patches on top of the development kernel.

>what kernel source code do you use that occur warning at device_add_disk?
>from fedora or any official release ? if so ,could you provide web link?

That was from an offical Fedora kernel. I believe I got it from the 
nodebug repo, but that kernel should be the same as the one that was 
normally used for rawhide. It is at 
https://koji.fedoraproject.org/koji/buildinfo?buildID=1007500 
but I don't know how much longer the binaries will stay available in koji. 

>if you use same kernel source code and same .config, why your own build
>Cann't trigger that warning ?

I don't know. The install script may build the initramfs differently. As 
far as I can tell, if the WARN_ON was triggered, I should have gotten 
output. 
