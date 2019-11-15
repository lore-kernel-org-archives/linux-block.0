Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018CCC432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF5B20730
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 18:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKOScy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:32:54 -0500
Received: from mail.itouring.de ([188.40.134.68]:43298 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfKOScx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 13:32:53 -0500
Received: from tux.wizards.de (p5B07EF98.dip0.t-ipconnect.de [91.7.239.152])
        by mail.itouring.de (Postfix) with ESMTPSA id 52D3B4160141;
        Fri, 15 Nov 2019 19:32:51 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id D47175F04C2;
        Fri, 15 Nov 2019 19:32:50 +0100 (CET)
Subject: Re: [PATCH BUGFIX V2 1/1] block, bfq: deschedule empty bfq_queues not
 referred by any process
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        tschubert@bafh.org, patdung100@gmail.com, cevich@redhat.com
References: <20191114093311.47877-1-paolo.valente@linaro.org>
 <20191114093311.47877-2-paolo.valente@linaro.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <89dde326-fc76-10cc-5ec9-ec5fd4dae4ac@applied-asynchrony.com>
Date:   Fri, 15 Nov 2019 19:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191114093311.47877-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/19 10:33 AM, Paolo Valente wrote:
> Since commit 3726112ec731 ("block, bfq: re-schedule empty queues if
> they deserve I/O plugging"), to prevent the service guarantees of a
> bfq_queue from being violated, the bfq_queue may be left busy, i.e.,
> scheduled for service, even if empty (see comments in
> __bfq_bfqq_expire() for details). But, if no process will send
> requests to the bfq_queue any longer, then there is no point in
> keeping the bfq_queue scheduled for service.
> 
> In addition, keeping the bfq_queue scheduled for service, but with no
> process reference any longer, may cause the bfq_queue to be freed when
> descheduled from service. But this is assumed to never happen, and
> causes a UAF if it happens. This, in turn, caused crashes [1, 2].
> 
> This commit fixes this issue by descheduling an empty bfq_queue when
> it remains with not process reference.
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=205447
> 
> Fixes: 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve I/O plugging")
> Reported-by: Chris Evich <cevich@redhat.com>
> Reported-by: Patrick Dung <patdung100@gmail.com>
> Reported-by: Thorsten Schubert <tschubert@bafh.org>
> Tested-by: Thorsten Schubert <tschubert@bafh.org>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>

Jens,

can you please also tag this for stable-5.3 before the next push?
The original problem was found on 5.3 after all, and hoping for the
stable-bot to pick it up automagically is a bit unreliable.

Thanks,
Holger
