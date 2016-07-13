Return-Path: <krisman@linux.vnet.ibm.com>
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] block: atari: Return early for unsupported sector size
References: <1467736712-11825-1-git-send-email-krisman@linux.vnet.ibm.com>
Date: Tue, 12 Jul 2016 22:42:30 -0300
In-Reply-To: <1467736712-11825-1-git-send-email-krisman@linux.vnet.ibm.com>
	(Gabriel Krisman Bertazi's message of "Tue, 5 Jul 2016 13:38:32
	-0300")
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87inwa9uux.fsf@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com> writes:

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
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
> ---

Hi Jens,

Any thoughts on this?  Do you think we can get it queued for 4.8?
-- 
Gabriel Krisman Bertazi
