Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C54C43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E9020936
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 22:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgIOWYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgIOQXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 12:23:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB4C061A2A
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 09:12:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1FAA8295F45
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v2] block: Consider only dispatched requests for inflight statistic
Organization: Collabora
References: <20200831153127.3561733-1-krisman@collabora.com>
        <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
        <87wo1dpclt.fsf@collabora.com>
        <d3dd1d80-ea30-f9df-9812-05b846a76f21@kernel.dk>
        <87r1rkorsf.fsf_-_@collabora.com>
Date:   Tue, 15 Sep 2020 12:11:12 -0400
In-Reply-To: <87r1rkorsf.fsf_-_@collabora.com> (Gabriel Krisman Bertazi's
        message of "Wed, 02 Sep 2020 16:19:28 -0400")
Message-ID: <87wo0vj9zz.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> Jens Axboe <axboe@kernel.dk> writes:
>
>> We just need to decide if this makes sense or not. I think we should
>> apply this for 5.10, with Ming's suggestion of using
>> blk_mq_request_started(). Then I guess we'll see what happens...
>
> Hello,
>
> Here is the second version, then.  But, instead of
> blk_mq_request_started as suggested on the review, this uses
> blk_mq_rq_state to access the state attribute, since we don't want to
> include MQ_RQ_COMPLETE.
>
> Also, improved the commit message a bit.
>

Hi Jens,

Sorry for the ping.  Have you made a decision here?

Thanks,

-- 
Gabriel Krisman Bertazi
