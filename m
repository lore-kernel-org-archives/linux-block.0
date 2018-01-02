Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:42992 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeABIMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jan 2018 03:12:14 -0500
Received: by mail-qt0-f182.google.com with SMTP id g9so61866259qth.9
        for <linux-block@vger.kernel.org>; Tue, 02 Jan 2018 00:12:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1514874831-10255-1-git-send-email-tang.junhui@zte.com.cn>
References: <1514874831-10255-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Date: Tue, 2 Jan 2018 00:12:13 -0800
Message-ID: <CAJ+L6qcbp92KkfzBWkpwZRX9fc6sFkXSs306YP7qcoJsVuybLg@mail.gmail.com>
Subject: Re: [for-416 PATCH] bcache: fix writeback target calc on large devices
To: Junhui Tang <tang.junhui@zte.com.cn>
Cc: linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tang Junhui--

Thank you for the feedback.

On Mon, Jan 1, 2018 at 10:33 PM,  <tang.junhui@zte.com.cn> wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
>
> This patch is useful for preventing the overflow of the expression
> (cache_dirty_target * bdev_sectors(dc->bdev)), but it also
> lead into a calc error, for example, when there is a 1G and
> 100*164G cached device, it would cause the "target" value to
> be aways zero of the 1G device, which would cause write-back
> threshold losing efficacy.
>
> Maybe at first we can judge if it overflows or not of the expression
> (cache_dirty_target * bdev_sectors(dc->bdev)), if it overflows,
> We can calc the value of target as the patch, otherwise,
> we calc it as old way.

Maybe it'd be preferable just to ensure that share always >=1.  It
seems like a pretty narrow set of cases where the current math works
and the new math doesn't work, though, as I expect that it's
relatively rare to have such a variation in sizes, and even so 16.4TB
uses up 35 bits of the 64 bit quantity.

I don't really like special cases or trying two different ways to do
the math, because then it's very difficult to test.

What do you think?

Mike
