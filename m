Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:9820 "EHLO
        BJEXCAS007.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752122AbdHGMgS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Aug 2017 08:36:18 -0400
Date: Mon, 7 Aug 2017 20:36:07 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/2] null_blk: make sure submit_queues > 0
Message-ID: <20170807123600.GA5988@bogon.didichuxing.com>
References: <20170802162555.GA30489@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170802162555.GA30489@bogon.didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 03, 2017 at 12:26:00AM +0800, weiping zhang wrote:
> Hi,
> 
> two misc patch for null_blk,
> 
> null_blk: simplify logic for use_per_node_hctx
> simplify code logic, if use_per_node_hctx set submit_queues same as
> nr_online_nodes.
> 
> null_blk: make sure submit_queues > 0
> set submit_queues to 1 by default, and add a handle for it's value < 0,
> no matter what user want, otherwise kmalloc has a negtive parameters.
> 
> weiping zhang (2):
>   null_blk: simplify logic for use_per_node_hctx
>   null_blk: make sure submit_queues > 0
> 
>  drivers/block/null_blk.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Hi Jens,

Have you had a chance to look these two misc changes at your
convinience.

thanks
