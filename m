Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB231C433B4
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A543A6161E
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 20:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhD3UMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Apr 2021 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbhD3UMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Apr 2021 16:12:14 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE38C06138C;
        Fri, 30 Apr 2021 13:11:25 -0700 (PDT)
Received: from thinkpad (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id BB7591409BE;
        Fri, 30 Apr 2021 22:11:22 +0200 (CEST)
Date:   Fri, 30 Apr 2021 22:11:21 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-leds@vger.kernel.org, linux-block@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, Jens Axboe <axboe@kernel.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] leds: trigger: implement block trigger
Message-ID: <20210430221121.46461c81@thinkpad>
In-Reply-To: <20210430183216.27458-3-ematsumiya@suse.de>
References: <20210430183216.27458-1-ematsumiya@suse.de>
        <20210430183216.27458-3-ematsumiya@suse.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 30 Apr 2021 15:32:11 -0300
Enzo Matsumiya <ematsumiya@suse.de> wrote:

> Activity is then represented in an accumulated manner (part_read_stat_accum()),
> with a fixed blinking interval of 50ms.

part_stat_read_accum, not part_read_stat_accum

Why only accum? With the netdev trigger, you can choose whether rx, tx,
or both are blinking the LED.

Also I think the trigger should be called "blockdev" instead of
"block". This is consistent with "netdev", and avoids misinterpretation
with the verb "to block".

Marek
