Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750860AbdAXNYN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:24:13 -0500
Subject: Re: [PATCH 01/10] blk-mq: create debugfs directory tree
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1485197480.git.osandov@fb.com>
 <047e034aa00fe3e642ba38e1988361867b69fc07.1485197480.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <02a1cca3-e9ce-8772-834f-da803be458ff@suse.de>
Date: Tue, 24 Jan 2017 14:24:10 +0100
MIME-Version: 1.0
In-Reply-To: <047e034aa00fe3e642ba38e1988361867b69fc07.1485197480.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 07:59 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In preparation for putting blk-mq debugging information in debugfs,
> create a directory tree mirroring the one in sysfs:
> 
>     # tree -d /sys/kernel/debug/block
>     /sys/kernel/debug/block
>     |-- nvme0n1
>     |   `-- mq
>     |       |-- 0
>     |       |   `-- cpu0
>     |       |-- 1
>     |       |   `-- cpu1
>     |       |-- 2
>     |       |   `-- cpu2
>     |       `-- 3
>     |           `-- cpu3
>     `-- vda
>         `-- mq
>             `-- 0
>                 |-- cpu0
>                 |-- cpu1
>                 |-- cpu2
>                 `-- cpu3
> 
> Also add the scaffolding for the actual files that will go in here,
> either under the hardware queue or software queue directories.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/Makefile         |   1 +
>  block/blk-mq-debugfs.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-mq-sysfs.c   |   8 +++
>  block/blk-mq.c         |   2 +
>  block/blk-mq.h         |  33 +++++++++++
>  include/linux/blkdev.h |   5 ++
>  6 files changed, 201 insertions(+)
>  create mode 100644 block/blk-mq-debugfs.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
