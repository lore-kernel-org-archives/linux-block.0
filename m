Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADB5C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE762177B
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohAz1Bdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBHTPI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:15:08 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46759 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfBHTPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 14:15:08 -0500
Received: by mail-qt1-f195.google.com with SMTP id y20so5150574qtm.13
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fdpoOPb9ENqIcz/X+y2qTT+jSea5Q0oQxc/UVPo0jA=;
        b=ohAz1BdnhKuTe99Sbqgtks+G1gIw6Ipv/O0zFqON82POpySofg3BGtPMl94dcW6vk8
         hEe33s4FhYfM9wjnQreyH5kUWC5cswFhDK5wIzHDy+rLw5HgzolxrDgKx/1aijL4BSdy
         L1njAW42KKnloNro3Rc8yj/LUjlUE3BrphCzJQaK/NBWTYEUrH2pKqVPQNL2cYFD1KkI
         DYfKmAqogbsCOkUdDGG2q2sZ+5NgupZEis9ib2rlZ5LECfS5RiyZb67YZM2MszC98/CA
         dh5VdMsmcWNN8DZloECqTnK23e6/NDjJln3oLHDFQRuqqabkh7vB+TxKUYvEFwzXPXGn
         /VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fdpoOPb9ENqIcz/X+y2qTT+jSea5Q0oQxc/UVPo0jA=;
        b=ir9CL9eGqNGtct7exXU8fhVQ1oRMdqcg+KvtHzCg582kIcWpt9qixWwgmZ84fAjjVm
         c9IM4F3XTboFXafoP+/gExpHi1SZhSxaDzuv6tJnJx3gyZ27UC+I8/ByEvdOa/Me4WTn
         tkPTuryJCGri1EeydNWIVz6kz/lXmjqjLhhmQcFrzfNe+ggmlxIqti/i2yhwI6LY1IPC
         eZXvFCGKV2M9zQV42zn/ezQ8DJRMbEoKbQ0UEANFuQSLOUaizVp0w/BisKGmQjRWOUt7
         QN4ovTFbWB51NBaVVk3p+lZjhoXRs04yun59YK9RuIasZMh/7moXSwlcUkdaltegrru0
         UdGg==
X-Gm-Message-State: AHQUAubgIOfz/qT9og7ZCJ9fkoc5LNJjMLIbtH7bp2+BgaBtvA9JDM4W
        psnPrcuxgyd/QnwdAUa5IpDaG8hG/NnmTHFxSwyIRMBg
X-Google-Smtp-Source: AHgI3IaLsd0HqU27ZbmzlO4jbZRnoRA22Ls7VMM2owqcIL8i84xHJTtNhDgHv6Tuvq7vjOIX/o1S5pnRpWRrwKxffZI=
X-Received: by 2002:ac8:7250:: with SMTP id l16mr17326682qtp.348.1549653307436;
 Fri, 08 Feb 2019 11:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20190125001249.72688-1-bo.liu@linux.alibaba.com>
In-Reply-To: <20190125001249.72688-1-bo.liu@linux.alibaba.com>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Fri, 8 Feb 2019 11:14:56 -0800
Message-ID: <CANQeFDDVhXdAkKYbiiShH5dCGAmOQKQDT_d+-_dPWDXOqYZHvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iolatency bug fix
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping?

thanks,
liubo

On Thu, Jan 24, 2019 at 4:14 PM Liu Bo <bo.liu@linux.alibaba.com> wrote:
>
> This set is to fix a hang case if blk-iolatency is in use.
>
> The 1st patch explains the hang problem with more details and provides
> a fix.
> The 2nd patch adds a warning for unexpected inflight counter.
> The 3rd patch is a cleanup of blk_mq_freeze_queue.
>
> v2: reorder the actual fix to the first patch.
>
> Liu Bo (3):
>   blk-iolatency: fix IO hang due to negative inflight counter
>   Blk-iolatency: warn on negative inflight IO counter
>   blk-mq: remove duplicated definition of blk_mq_freeze_queue
>
>  block/blk-iolatency.c | 56 ++++++++++++++++++++++++++++++++++++-------
>  block/blk-mq.h        |  1 -
>  2 files changed, 48 insertions(+), 9 deletions(-)
>
> --
> 2.20.1.2.gb21ebb6
>
