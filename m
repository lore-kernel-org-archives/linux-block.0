Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:14357 "EHLO
        BJEXCAS003.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S932074AbdGLRNj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 13:13:39 -0400
Date: Thu, 13 Jul 2017 01:13:31 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq-debugfs: add mapping show for hw queue to cpu
Message-ID: <20170712171331.GA13374@localhost.didichuxing.com>
References: <20170712165400.GA9696@localhost.didichuxing.com>
 <d9e4984e-07f1-c1bd-07be-4e0a4b2a71df@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <d9e4984e-07f1-c1bd-07be-4e0a4b2a71df@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jul 12, 2017 at 10:57:37AM -0600, Jens Axboe wrote:
> On 07/12/2017 10:54 AM, weiping zhang wrote:
> > A mapping show as following:
> > 
> > hctx		cpus
> > hctx0		  0   1
> > hctx1		  2
> > hctx2		  3
> > hctx3		  4   5
> 
> We already have that information in the /sys/block/<dev>/mq/X/cpu_list
> 
> where X is the hardware queue number. Why do we need it in debugfs as
> well, presented differently?

this arribute give a more obviously showing, only by 1 "cat" command.
/sys/bloc/<dev>/mq/X/cpu_list not easy get mapping for all hctx by 1
command.
also /sys/kernel/debug/block/xxx/hctxN/cpuX can export that info, but
these two methods both not obviously.
