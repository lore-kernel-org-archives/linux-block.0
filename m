Return-Path: <axboe@kernel.dk>
Subject: Re: bug in tag handling in blk-mq?
To: Mike Galbraith <efault@gmx.de>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block
 <linux-block@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Oleksandr Natalenko <oleksandr@natalenko.name>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
 <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
 <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
Date: Tue, 8 May 2018 08:55:43 -0600
MIME-Version: 1.0
In-Reply-To: <1525768632.5208.4.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-block@vger.kernel.org>

On 5/8/18 2:37 AM, Mike Galbraith wrote:
> On Tue, 2018-05-08 at 06:51 +0200, Mike Galbraith wrote:
>>
>> I'm deadlined ATM, but will get to it.
> 
> (Bah, even a zombie can type ccache -C; make -j8 and stare...)
> 
> kbuild again hung on the first go (yay), and post hang data written to
> sdd1 survived (kernel source lives in sdb3).  Full ftrace buffer (echo
> 1 > events/block/enable) available off list if desired.  dmesg.txt.xz
> is dmesg from post hang crashdump, attached because it contains the
> tail of trace buffer, so _might_ be useful.
> 
> homer:~ # df|grep sd
> /dev/sdb3 �����959074776 785342824 172741072 �82% /
> /dev/sdc3 �����959074776 455464912 502618984 �48% /backup
> /dev/sdb1 ��������159564 �����7980 ���151584 ��6% /boot/efi
> /dev/sdd1 �����961301832 393334868 519112540 �44% /abuild
> 
> Kernel is virgin�modulo these...
> 
> patches/remove_irritating_plus.diff
> patches/add-scm-version-to-EXTRAVERSION.patch
> patches/block-bfq:-postpone-rq-preparation-to-insert-or-merge.patch
> patches/block-bfq:-test.patch  (hang provocation hack from Paolo)

All the block debug files are empty...

-- 
Jens Axboe
