Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020FCC433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 20:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiFAUoj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiFAUnt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 16:43:49 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2A1E174E
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 13:28:09 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd7616.dip0.t-ipconnect.de [93.221.118.22])
        by mail.itouring.de (Postfix) with ESMTPSA id 546A3125BCA
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 22:19:41 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 06CF5F01600
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 22:19:41 +0200 (CEST)
To:     linux-block <linux-block@vger.kernel.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Q: fsync on a blockdev fd worked in 5.15, but no longer does. Should
 it?
Organization: Applied Asynchrony, Inc.
Message-ID: <cca51ad8-052c-769d-62cc-99a3e3efe4f0@applied-asynchrony.com>
Date:   Wed, 1 Jun 2022 22:19:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi,

Weird story time!

I recently moved from 5.15 to 5.18 and noticed that noflushd -
a daemon that suspends rotational drives after a while - would now cause
dirty writeback buffers to accumulate endlessly for all unstopped devices
(like SSDs). Manually calling sync or exceeding the dirty threshold
would still work as expected and flush dirty data, just not the periodic
writeback. This surprised me since it has been working perfectly fine
for the last 12 years or so, incl. 5.15.

After some source spelunking I found that noflushd (basically) disables
writeback and manually performs periodic fsync on fds of the *un*stopped
devices and partitions - as in fsync(<fd of /dev/sda1>). This surprised me,
since I never would have expected this to work in the first place, yet it did
all these ears. Maybe by accident, maybe intentionally.

Since 5.16 the block layer had many cleanups, starting around ~October 2021.
Instead of trying to figure out which commit broke the daemon's back, for now
I'm more curious about whether this *should* have worked all those years?
Is it a bug that it no longer does, or just an accidental behaviour change?

Obviously if anybody (Jens, Christoph..?) has an idea what changed this
behaviour and thinks it's a bug I'm more than happy to test a fix,
however for now I'd be happy to understand what's going on.

Oh, and no, I cannot (fully) use hdparm-induced suspend since my HD's firmware
is buggy and suspend timer values >11 don't work right. grmbl.

Thanks!
Holger
