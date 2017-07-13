Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:22425 "EHLO
        BJEXCAS003.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751204AbdGMQah (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2017 12:30:37 -0400
Date: Fri, 14 Jul 2017 00:30:27 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: only alloc hctx point as many as nr_hw_queues
Message-ID: <20170713163015.GA10602@bogon.didichuxing.com>
References: <20170713161020.GA10325@bogon.didichuxing.com>
 <e03b2bfa-15d3-3d27-15cf-07e65882fc25@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <e03b2bfa-15d3-3d27-15cf-07e65882fc25@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 13, 2017 at 10:14:31AM -0600, Jens Axboe wrote:
> On 07/13/2017 10:10 AM, weiping zhang wrote:
> > one hw queue only has one hctx, reduce it's number same as nr_hw_queues.
> 
> What happens if a device registers with eg 4 hw queues, then later
> calls blk_mq_update_nr_hw_queues()?
> 

your means, 10 cpu, and  device has 10 hw queues, but  only register 4,
and then update it to 10, no place store new hctx. Am i understanding
right ? if yes, could you tell me why driver do that ? thanks.

--
weiping
