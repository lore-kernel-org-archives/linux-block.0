Return-Path: <rsalvaterra@gmail.com>
MIME-Version: 1.0
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Thu, 25 Oct 2018 17:09:32 +0100
Message-ID: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
Subject: Bug: swap discard issue with zram caused by "block: don't deal with
 discard limit in blkdev_issue_discard()"
To: ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi,

After commit 744889b7cbb56a64f957e65ade7cb65fe3f35714, I started
getting this (-EIO, it seems) on my dmesg:

swapon: discard_swap(00000000c275f02d): -5

This is an 8 GB zram swap device. It's configured like this:

modprobe zram
echo zstd > /sys/block/zram0/comp_algorithm
echo 8297508864 > /sys/block/zram0/disksize
mkswap /dev/zram0
swapon -d -p 100 /dev/zram0

I should note that if I use --discard=pages instead of -d (both
policies) at swapon, I don't get this error.
Reverting the commit from v4.19 final fixes the error for me, but
surely breaks something else. :)
Let me know if you need any additional information.

Thanks,

Rui
