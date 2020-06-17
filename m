Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8CC433DF
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 10:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530AF208B3
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 10:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1Rqzc/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgFQKax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQKaw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 06:30:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41236C061573;
        Wed, 17 Jun 2020 03:30:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so1781559wro.1;
        Wed, 17 Jun 2020 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6cV4DHswB2EyeE07H4W7XCwzmJOtlP+W1W6yT4bg52g=;
        b=C1Rqzc/japPum67ZTnuAVaiq2NPpCxTUZk2OOs7u92om/UHf8Ai1fJSa95yb+EikCj
         FBZ1VOx2o/jL0/ss9n2sPgAJHTd3graTtuDv9BYwoKAb93VfJjObyyHcoutjcoGT8EOC
         9hPIZjJSMZUyWOzmqJYxnHFdApHcEoxQYfIJd6h3fmQqZNcRqTmQ+WqPLNWgbLW0Q86p
         TG4UxOrr2COtSPwxiPlsjpDusl8PVaBkUjxdYp+H9OkjEmKCu7Lq1Y+6hFmqe+Epn+Ht
         wYEVI9ippMMUZlfY+0xSNPJ4TMZ0Cvy7Ac3jJJYc2Hs7T2I8mQ1tafjsm7vtC6fpfdal
         t0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6cV4DHswB2EyeE07H4W7XCwzmJOtlP+W1W6yT4bg52g=;
        b=XrmTVsgOpuLl1sxOPDvj6VkVWK4erBCWejzLLpcAbfj5UTmxjG0HFlLtN6r3jtareE
         qVTyrkrccj3H9Eym+ogjaDvLsT4VYwyU0bwuMZX6Pafi+fVJ4Q8Uo1CquvVUzdpwf8vu
         aFjejUMaqT/2amn67u5gor/3HE5bkRNatXssO7nyr20ngJqE9LopjQggX2R48CR8hGVi
         Y8mB77tfuTiaJFiaeMi69YImPVIZb3T6ypc1er19NZwc4ETs+Hwiir2YcZtoJvSapUo/
         gM0GdDpVqmeGv+V0sSo6qeekUCNxsrKwc2UCUTphKaMXn+B6K4s5Ntpwh2LMjWzNG3rj
         Tz2Q==
X-Gm-Message-State: AOAM530LtSkN8Iw3JvayCp0EXao6kmNKV2oFewer6GLvrPUSwLNOb1Eu
        F97S0VaDKR2yU2R6BiA57FMofIrt5VW09//6Hxw=
X-Google-Smtp-Source: ABdhPJyeQZRqJRgjSeusf9v5yBFBGvFjqIYCsu8BTeFkhrJ4QbR0F92kIGENOe/0gNpO5f5goNfGZYn7RWQvl6s5vns=
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr4518383wro.317.1592389850778;
 Wed, 17 Jun 2020 03:30:50 -0700 (PDT)
MIME-Version: 1.0
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 17 Jun 2020 18:30:39 +0800
Message-ID: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
Subject: krobe: __blkdev_put probe is missed
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

I found probe on __blkdev_put is missed, which can be observed
via bcc/perf reliably:

1) start trace
- perf probe __blkdev_put
- perf trace -a  -e probe:__blkdev_put

or

/usr/share/bcc/tools/stackcount __blkdev_put

2) run the following command:
blockdev --getbsz /dev/sda1

3) 'perf trace'  or stackcount just  dumps one trace event, and it
should have been two
__blkdev_put() traces, since one __blkdev_put() is called for
partition(/dev/sda1),
and another is for disk(/dev/sda). If trace_printk() is added in __blkdev_put(),
two events will be captured from ftrace.

The only special thing about __blkdev_put() is that the function will call into
itself. However, no such issue on __blkdev_get() which calls itself too.


Thanks,
Ming Lei
