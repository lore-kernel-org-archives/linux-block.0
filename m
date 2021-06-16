Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084D9C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 17:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2D561055
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 17:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFPRiw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 13:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPRiv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 13:38:51 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9159BC061574
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 10:36:44 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so3335131ott.1
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 10:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WF2UEjVKOhuXNDjWMiYeFCQnPAAsctBC2eC+oTid+aY=;
        b=rhmTfw2fLsGLrlAFs/zO+R8OIYb1+Tio9MkfOH5Z3MOuIn3/ijZYkYAzd0YD8Cnuna
         QKvA9A7+J88jbNV/yHvOv9CyYVtu8e97wRn2ZSg2IVwfiqIFNkZti/Y1ORNJ0nkV0nUW
         /+zjbwDoUqRsVJLTCnRXnc8g6p5Lrf4CA7k77dlnz29HK4yCegZSvWhkVe67XLryAoH2
         elrJshr/CqhD71Pij3tgg1ykVk8vAZ4JQjYRNEcIU6KCPd/5yB7MgHStfeP5M2qp+CFV
         j9ujLRzSC8a/sSozqH71Vy+zQlKY7sFVE1ADNhEbmO1tCtSabdkeuc60yzRzcEP5gkAT
         Hh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WF2UEjVKOhuXNDjWMiYeFCQnPAAsctBC2eC+oTid+aY=;
        b=Om0tBwgAvuUnyAlhPoIpiP+kfR5U5qnUqnIKhIYPhNz/W3rRU56uRgpFUlguV5P1gh
         sv6o4MZ+x9052LgUSza4awLtqa9U1EcZKHPcjAD2j9UDQ8iivTTOGxvL9hFHE+aqQqth
         p1THctuo+WSN69qsDh98z57QOF6sNQqOeC0t2vxd1Lsv2pJaxe8Pwb1tFzMztjyRumJl
         bvFVx4mlwhh4bbQWSuIMnE4fBXC+arCIlim7ApPDKx3yl5TTRU3VJoI7nfuL9868LCl+
         TYYyMWZup1nsesiefoL/eDVzVolgz1f+ZEqu7BW2R5gN/UWHiirWnfdxNegipNcHScjP
         rjxQ==
X-Gm-Message-State: AOAM533LO5nRK/xLpkyheduFGHW2hVaBo6jvxPEbwUeTpIYQV9dBXPzG
        Xsd6gM39YZrMM1mCRsLR9Vp3x7IPPAgvrJmnieQjc7/Kiz0=
X-Google-Smtp-Source: ABdhPJz9Yys5cMMWHNQNmV/uQqZEoUISylrc8NRpD72j8aUj+PD/eKnfvWhP0sqT9SS1v+Vx4MYu18OFxMaS7C4zAvw=
X-Received: by 2002:a05:6830:1f0a:: with SMTP id u10mr878018otg.181.1623865003470;
 Wed, 16 Jun 2021 10:36:43 -0700 (PDT)
MIME-Version: 1.0
From:   Omar Kilani <omar.kilani@gmail.com>
Date:   Wed, 16 Jun 2021 10:36:32 -0700
Message-ID: <CA+8F9hh3vqc=jdTi4xfV40AgbJ2GRdmastv=smyuDCYVFRVV5g@mail.gmail.com>
Subject: blk-wbt / wbt_rqw_done logic?
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

While looking into a deadlock that Jan has fixed:

https://lore.kernel.org/linux-block/CA+8F9hggf7jOcGRxvBoa8FYxQs8ZV+XueVAd9BodpQQP_+8Pdw@mail.gmail.com/T/

I noticed this line of code in blk-wbt.c (L164):

-               if (!inflight || diff >= rwb->wb_background / 2)

And based on the preceding logic calculating `limit` and the comment
in the "no wakeup" check above which references "normal limit" and
decides based on `limit`, it's not clear why `rwb->wb_background` is
used here as there's no comment.

Should this be:

+               if (!inflight || diff >= limit / 2)

I traced the history of the line back to 4.20rc but it hasn't changed
since being added.

Thanks!

Regards,
Omar
