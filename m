Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4DBC10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 11:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C822820724
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 11:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCsuoAgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCML3w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:29:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36895 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgCML3w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 07:29:52 -0400
Received: by mail-io1-f67.google.com with SMTP id k4so8995991ior.4
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2020 04:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoMJmL1hnneo2X5SSA9aG8mLu/s7Lqr0F3n7IPTI+3I=;
        b=TCsuoAgA16VfGLqWrxwK92fMnelLGfJ6UM+ghAKatLatdLRXx/6AF/FaRxqEW2GBey
         85J/T3jApJQAebtm85xBCudeMnizqiVmEvt0AKY3r/MZ67TYL/yrqzeWoBajXzvruDdE
         jHXMWIA7ELrY/ibXLZxIBbpSDpJiUiA2nv7yce15gbMoOR3F34c+KU+JiJfVMf0LgGnu
         pO7W+OmvqEARsGwWl8nV08DOcShvg5+431I/UaWWUiJS1botO2R1PG3gaAT6UOLO/fPL
         9/Aj+SHoda4J21X7jxEpb2xQKH8JxMVW+oJ5x8+5h/ejyp5BzzyI652jS7nrdylN0urT
         c2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoMJmL1hnneo2X5SSA9aG8mLu/s7Lqr0F3n7IPTI+3I=;
        b=Vak9bm4Le5fcmhwKes9y30SQIOT+lREAPp2hPXKCommxWWQZ8mK3ptew1YKz6W9r+k
         UOD5rkitSvVvWEWvCwJMq78QxjcPcu7PXr+MMqmdu7JINLff5XdvZxjQJZ7NeiNn7Nyl
         K6vGLBHn106/2rT7euz3w8JLGhwY++lJPYQZ0G7SI0yj2lqmzrZhJuq9Q3XScBo6KUE6
         BJgDrILIpyeTXd/Pv3zZivz6gS1SOLAMVRiGwqF8rw+queolB8ylohng4brjmtfTBL6P
         QPuL3kgkUNkRkH0Z9tyJ4jZRvZJelyM7h1wOeyzUiaouJUFsEMQv0pCVJ5s2aEF04lbT
         v/vg==
X-Gm-Message-State: ANhLgQ0542+dlBYb8VOHIb240t6Nznk8cHXl/hwFY0LYwCXz78V27dDM
        dDj4gVMw2IhKhBbJDPFPXmI5EjuVNLi/F+KYmVE=
X-Google-Smtp-Source: ADFU+vslRAaDjBcQEc5evPtf5FaenUKJEM2egGZk75hkSAx/ZXDN7M2d2HUaVgWHXua/POZ82w1bxrhz2uM0aZlZJvc=
X-Received: by 2002:a6b:784a:: with SMTP id h10mr8283286iop.64.1584098989678;
 Fri, 13 Mar 2020 04:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200228064030.16780-1-houpu@bytedance.com> <b407f0d1-f07c-4d6b-9657-bb296557ff50@kernel.dk>
In-Reply-To: <b407f0d1-f07c-4d6b-9657-bb296557ff50@kernel.dk>
From:   Hou Pu <houpu.main@gmail.com>
Date:   Fri, 13 Mar 2020 19:29:38 +0800
Message-ID: <CAKHcvQidfK_04_BxLL_kVBC7e7+eeAfSX=W=8Xyi-HNU0NQ0OQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] nbd: requeue request if only one connection is configured
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Mike Christie <mchristi@redhat.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 12, 2020 at 9:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/27/20 11:40 PM, Hou Pu wrote:
> > Hello,
> >
> > NBD server could be upgraded if we have multiple connections.
> > But if we have only one connection, after we take down NBD server,
> > all inflight IO could finally timeout and return error. These
> > patches fix this using current reconfiguration framework.
> >
> > I noticed that Mike has following patchset
> >
> > nbd: local daemon restart support
> > https://lore.kernel.org/linux-block/5DD41C49.3080209@redhat.com/
> >
> > It add another netlink interface (NBD_ATTR_SWAP_SOCKETS) and requeue
> > request immediately after recongirure/swap socket. It do not need to
> > wait for timeout to fire and requeue in timeout handler, which seems more
> > like an improvement. Let fix this in current framework first.
> >
> > Changes compared to v2:
> > Fix comments in nbd_read_stat() to be aligned with the code change
> > suggested by Mike Christie.
>
> Applied for 5.7.

Thanks.
And also thanks Josef and Mike for the review.

>
> --
> Jens Axboe
>
