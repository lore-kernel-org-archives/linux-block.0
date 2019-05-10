Return-Path: <SRS0=2qaK=TK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F62C04A6B
	for <linux-block@archiver.kernel.org>; Fri, 10 May 2019 23:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF08120881
	for <linux-block@archiver.kernel.org>; Fri, 10 May 2019 23:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfEJXRY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 May 2019 19:17:24 -0400
Received: from mx.ewheeler.net ([66.155.3.69]:58630 "EHLO mx.ewheeler.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfEJXRY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 May 2019 19:17:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id CC6C0A0692;
        Fri, 10 May 2019 23:17:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id yfMugx9mXySL; Fri, 10 May 2019 23:17:23 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id 170AEA067D;
        Fri, 10 May 2019 23:17:23 +0000 (UTC)
Date:   Fri, 10 May 2019 23:17:20 +0000 (UTC)
From:   Eric Wheeler <stable@lists.ewheeler.net>
X-X-Sender: lists@mx.ewheeler.net
To:     Sasha Levin <sashal@kernel.org>
cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BFQ I/O SCHEDULER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eric Wheeler <bfq@linux.ewheeler.net>, stable@vger.kernel.org
Subject: Re: [PATCH] bfq: backport: update internal depth state when queue
 depth changes
In-Reply-To: <20190510201855.GB14410@sasha-vm>
Message-ID: <alpine.LRH.2.11.1905102312220.4789@mx.ewheeler.net>
References: <1557510992-18506-1-git-send-email-stable@lists.ewheeler.net> <20190510201855.GB14410@sasha-vm>
User-Agent: Alpine 2.11 (LRH 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 10 May 2019, Sasha Levin wrote:

> On Fri, May 10, 2019 at 10:56:32AM -0700, Eric Wheeler wrote:
> >From: Jens Axboe <axboe@kernel.dk>
> >
> >commit 77f1e0a52d26242b6c2dba019f6ebebfb9ff701e upstream
> >
> >A previous commit moved the shallow depth and BFQ depth map calculations
> >to be done at init time, moving it outside of the hotter IO path. This
> >potentially causes hangs if the users changes the depth of the scheduler
> >map, by writing to the 'nr_requests' sysfs file for that device.
> >
> >Add a blk-mq-sched hook that allows blk-mq to inform the scheduler if
> >the depth changes, so that the scheduler can update its internal state.
> >
> >Signed-off-by: Eric Wheeler <bfq@linux.ewheeler.net>
> >Tested-by: Kai Krakow <kai@kaishome.de>
> >Reported-by: Paolo Valente <paolo.valente@linaro.org>
> >Fixes: f0635b8a416e ("bfq: calculate shallow depths at init time")
> >Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >Cc: stable@vger.kernel.org
> 
> I wasn't clear on what was backported here, so I've queued the upstream
> version on 4.19 and 4.14, it doesn't seem to be relevant to older
> branches.


Thanks Sasha.  We needed it for 4.19, I wasn't sure how far it would patch 
back so I left the version off.  BFQ was merged in 4.12 iirc, so if it 
patched against 4.14, then 4.19 and 4.14 are the only ones that need it.

--
Eric Wheeler


> 
> --
> Thanks,
> Sasha
> 
