Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:5922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750733AbeEDHHn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 May 2018 03:07:43 -0400
From: Caizhiyong <caizhiyong@hisilicon.com>
To: Wang YanQing <udknight@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiangheng <jiangheng@hisilicon.com>
Subject: RE: [PATCH] block: add verifier for cmdline partition
Date: Fri, 4 May 2018 07:07:30 +0000
Message-ID: <C3050A4DBA34F345975765E43127F10F8B77159A@dggemm511-mbs.china.huawei.com>
References: <20180503111748.GA904@udknight>
In-Reply-To: <20180503111748.GA904@udknight>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> -----Original Message-----
> From: Wang YanQing [mailto:udknight@gmail.com]
> Sent: Thursday, May 03, 2018 7:18 PM
> To: axboe@kernel.dk
> Cc: gregkh@linuxfoundation.org; pombredanne@nexb.com;
> tglx@linutronix.de; Caizhiyong <caizhiyong@hisilicon.com>; linux-
> block@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] block: add verifier for cmdline partition
> 
> I meet strange filesystem corruption issue recently, the reason
> is there are overlaps partitions in cmdline partition argument.
> 
> This patch add verifier for cmdline partition, then if there are
> overlaps partitions, cmdline_partition will return error and log
> a error message.
> 

Partition overlap was intentionally designed in this cmdline partition.
some time, the cmdline partition save raw data(not filesystem), the overlap makes data  access very convenient.

reference  http://lists.infradead.org/pipermail/linux-mtd/2013-August/048092.html

> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  block/partitions/cmdline.c | 63
> +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
> 
