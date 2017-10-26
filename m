Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58082 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932234AbdJZN4A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2017 09:56:00 -0400
Subject: Re: [PATCH V12 0/5] mmc: Add Command Queue support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
References: <1508834428-4360-1-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZQEkvLB_-6H12Uo4xizLEV93KrLReONUq=Fq=cryKz8A@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <c40aa526-3ea5-205a-ba7c-c1f4ae004f4b@intel.com>
Date: Thu, 26 Oct 2017 16:49:03 +0300
MIME-Version: 1.0
In-Reply-To: <CACRpkdZQEkvLB_-6H12Uo4xizLEV93KrLReONUq=Fq=cryKz8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 26/10/17 16:32, Linus Walleij wrote:
> On Tue, Oct 24, 2017 at 10:40 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Here is V12 of the hardware command queue patches without the software
>> command queue patches, now using blk-mq and now with blk-mq support for
>> non-CQE I/O.
> 
> Since I had my test setup going I gave this a spin with the same set
> of tests that I used before/after my MQ patches.
> 
> It is using the same setup and same eMMC, but I hade to rebase onto
> Ulf's very latest next branch to apply your patches.
> 
> I default-enabled multiqueue.
> 
> Results:
> 
> sync
> echo 3 > /proc/sys/vm/drop_caches
> sync
> time dd if=/dev/mmcblk3 of=/dev/null bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.0GB) copied, 24.251922 seconds, 42.2MB/s
> real    0m 24.25s
> user    0m 0.03s
> sys     0m 3.80s
> 
> mount /dev/mmcblk3p1 /mnt/
> cd /mnt/
> sync
> echo 3 > /proc/sys/vm/drop_caches
> sync
> time find . > /dev/null
> real    0m 3.24s
> user    0m 0.22s
> sys     0m 1.23s
> 
> sync
> echo 3 > /proc/sys/vm/drop_caches
> sync
> iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
> 
>                                                    random    random
>    kB  reclen    write  rewrite    read    reread    read     write
> 20480       4     1615     1571     6612     6714     6494      531
> 20480       8     2143     2295    11559    11563    11499     1164
> 20480      16     3894     4202    17826    17823    17755     1369
> 20480      32     5816     7489    23741    23759    23709     3016
> 20480      64     7393     9167    27532    27526    27502     3591
> 20480     128     7328     8097    29184    29161    29159     5592
> 20480     256     7194     8752    29424    29434    29424     6700
> 20480     512     8984     9930    29903    29911    29909     7420
> 20480    1024     7072     7446    27684    27685    27681     7444
> 20480    2048     6840     8199    27398    27420    27418     6766
> 20480    4096     8137     6805    28091    28089    28093     8209
> 20480    8192     7255     7485    28386    28384    28383     7479
> 20480   16384     7078     7448    28584    28585    28585     7447
> 
> In short: no performance regressions.

You really need to test cards that are fast.  A decent UHS-I SD card can do
over 80 MB/s for reads and of course HS400 eMMC can do over 300 MB/s.

> 
> Performance-wise this is on par with my own patch set for MQ.
> 
> As you know my pet peeve is "enable MQ by default" and I see no
> reason from a performance perspective not to enable MQ by default
> on this patch set or mine for that matter.

That is a side-issue.  A single small patch can change that.

> 
>> While we should look at changing blk-mq to give better workqueue performance,
>> a bigger gain is likely to be made by adding a new host API to enable the
>> next already-prepared request to be issued directly from within ->done()
>> callback of the current request.
> 
> My patch series switches the stack around to make it possible
> to do this. But it doesn't go the whole way to complete the requests
> from interrupt context.
> 
> Since we have to send commands for retune etc request finalization
> cannot easily be done from interrupt context.

Re-tuning and background operations are rare and slow, so there is no reason
to try to start them from interrupt context.

> 
> But I am thinking about testing to hack it
> using some ugly approaches ... like assuming we don't need any
> retune etc and just say all is fine and optimistically complete the
> request directly in the interrupt handler if all was OK and wait
> for errors to happen before retuning.

It already works that way.  Re-tuning happens before you start a request.
We prevent re-tuning in between dependent requests, like between starting a
transfer and CMD13 polling for completion.
