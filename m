Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EFBC43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 18:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A306820851
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 18:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCGSiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:38:03 -0500
Received: from mail02.iobjects.de ([188.40.134.68]:53672 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGSiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 13:38:03 -0500
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2019 13:38:02 EST
Received: from tux.wizards.de (pD9EBF050.dip0.t-ipconnect.de [217.235.240.80])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 2B4074160E37;
        Thu,  7 Mar 2019 19:29:17 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 934BAF01611;
        Thu,  7 Mar 2019 19:29:16 +0100 (CET)
Subject: Re: [PATCH BUGFIX IMPROVEMENT 0/8] block, bfq: fix bugs, reduce exec
 time and boost performance
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com
References: <20190307162554.77205-1-paolo.valente@linaro.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <469708ba-e483-b98c-118d-abc26ab8871a@applied-asynchrony.com>
Date:   Thu, 7 Mar 2019 19:29:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190307162554.77205-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/19 5:25 PM, Paolo Valente wrote:
> Hi,
> since I didn't make it to submit these ones for 5.1, let me be
> early for 5.2 :)
> 
> These patches fix some bug affecting performance, reduce execution
> time a little bit, and boost throughput and responsiveness.
> 
> They are meant to be applied on top of the last series I submitted:
> https://lkml.org/lkml/2019/1/29/368

I have the earlier series applied & working well. This one applies cleanly
on top, but something's wrong with the bfq_log_bfqq() macro:

   CC [M]  block/bfq-iosched.o
In file included from block/bfq-iosched.c:140:
block/bfq-iosched.c: In function 'bfq_check_fifo':
block/bfq-iosched.h:1058:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
   char pid_str[MAX_PID_STR_LENGTH]; \
   ^~~~
block/bfq-iosched.c:890:2: note: in expansion of macro 'bfq_log_bfqq'
   bfq_log_bfqq(bfqq->bfqd, bfqq, "check_fifo: returned %p", rq);
   ^~~~~~~~~~~~
block/bfq-iosched.c: In function 'bfq_updated_next_req':
block/bfq-iosched.h:1058:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]

This is with gcc 8.3.0 on top of 5.0++.

thanks,
Holger
