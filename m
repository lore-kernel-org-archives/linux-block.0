Return-Path: <axboe@kernel.dk>
Subject: Re: nvme updates for 4.19
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180804084354.GA26103@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <df1c976e-8ea7-ba14-d1d2-caf8511de527@kernel.dk>
Date: Sat, 4 Aug 2018 12:39:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180804084354.GA26103@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/4/18 2:43 AM, Christoph Hellwig wrote:
This one:

> Christoph Hellwig (9):
>       nvme: add ANA support

Has a stupid conflict with:

commit fa441b71aa27d06fa79d5e7f7c329981dccd94d1
Author: Weiping Zhang <zhangweiping@didichuxing.com>
Date:   Tue Jul 3 00:34:38 2018 +0800

    nvme: don't enable AEN if not supported

from mainline. Please keep changes like that in mind, that change should
never have been in the "nvme: add ANA support" patch.

-- 
Jens Axboe
