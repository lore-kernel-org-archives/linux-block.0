Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40525C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B19B2078B
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 18:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgIAShk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIAShk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 14:37:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A4DC061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 11:37:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D463929A095
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH] block: Fix inflight statistic for MQ submission with !elevator
Organization: Collabora
References: <20200831153127.3561733-1-krisman@collabora.com>
        <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
Date:   Tue, 01 Sep 2020 14:37:34 -0400
In-Reply-To: <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
        (Ming Lei's message of "Tue, 1 Sep 2020 09:18:08 +0800")
Message-ID: <87wo1dpclt.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <tom.leiming@gmail.com> writes:

> On Mon, Aug 31, 2020 at 11:37 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:

>> -       if (rq->part == mi->part)
>> +       if (rq->part == mi->part && rq->state == MQ_RQ_IN_FLIGHT)
>>                 mi->inflight[rq_data_dir(rq)]++;
>
> The fix looks fine. However, we have helper of
> blk_mq_request_started() for this purpose.

Thanks for the review.

I was aware of blk_mq_request_started, but it forces a READ_ONCE which
on Alpha includes a mb() for every tagged request, which doesn't seem
necessary or desired here.  I might be wrong though, memory barriers
are hard. :)

let's see what Jens says about the other points, so I don't spin this
unnecessarily.

-- 
Gabriel Krisman Bertazi
