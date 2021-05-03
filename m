Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DC9C433B4
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 02:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C714361260
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 02:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhECCrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 May 2021 22:47:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:49722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhECCrS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 May 2021 22:47:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A58EAC86;
        Mon,  3 May 2021 02:46:25 +0000 (UTC)
Date:   Sun, 2 May 2021 23:46:22 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     linux-leds@vger.kernel.org, linux-block@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, Jens Axboe <axboe@kernel.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] leds: trigger: implement block trigger
Message-ID: <20210503024622.i55sne3dzqcnnezv@hyori>
References: <20210430183216.27458-1-ematsumiya@suse.de>
 <20210430183216.27458-3-ematsumiya@suse.de>
 <20210430221121.46461c81@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210430221121.46461c81@thinkpad>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/30, Marek Behun wrote:
>On Fri, 30 Apr 2021 15:32:11 -0300
>Enzo Matsumiya <ematsumiya@suse.de> wrote:
>
>> Activity is then represented in an accumulated manner (part_read_stat_accum()),
>> with a fixed blinking interval of 50ms.
>
>part_stat_read_accum, not part_read_stat_accum

Good catch, will fix in v2. Thanks.

>Why only accum? With the netdev trigger, you can choose whether rx, tx,
>or both are blinking the LED.

The original patch from Akinobu Mita could distinct between READ,
WRITE, and DISCARD. My reasoning to not follow that was I've seen
NICs with a TX and RX LED (i.e. netdev follows that), but I've never
seen any disk activity indicator with separated LEDs for read and write,
for example. So accum made sense to me.

If this is really desired, I can come up with this, but I'd like to hear
from others.

>Also I think the trigger should be called "blockdev" instead of
>"block". This is consistent with "netdev", and avoids misinterpretation
>with the verb "to block".

Thanks. I'll change this in v2.

>
>Marek

Cheers,

Enzo

