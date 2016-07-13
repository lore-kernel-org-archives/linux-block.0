Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: atari: Return early for unsupported sector size
To: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
References: <1467736712-11825-1-git-send-email-krisman@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57866D0B.2020608@kernel.dk>
Date: Wed, 13 Jul 2016 09:32:11 -0700
MIME-Version: 1.0
In-Reply-To: <1467736712-11825-1-git-send-email-krisman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/05/2016 09:38 AM, Gabriel Krisman Bertazi wrote:
> For 4K LBA or very large disks, atari_partition can easily get tricked
> into thinking it has found an Atari partition table.  Depending on the
> data in the disk, it ends up creating partitions with awkward lengths.
>
> We saw logs like this while playing with fio.
>
> [5.625867] nvme2n1: AHDI p2
> [5.625872] nvme2n1: p2 size 2910030523 extends beyond EOD, truncated
>
> People has had issues with misinterpreted AHDI partition tables for a long
> time, see this BSD thread from 1995, for example.
>
> https://mail-index.netbsd.org/port-atari/1995/11/19/0001.html
>
> Since the atari partition, according to the spec, doesn't even support
> sector sizes with more than 512, a quick sanity check is reasonable to
> just bail out early, before even attempting to read sector 0.

Added for 4.8, thanks.

-- 
Jens Axboe
