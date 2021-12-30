Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D50C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Dec 2021 04:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhL3EBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 23:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhL3EBf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 23:01:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA54C061574
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 20:01:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y22so93379828edq.2
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 20:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5onrs9lSEaHmvYpP7Y+ZzwiLXT0++XAWXsdC8ftsfM=;
        b=eW8aWt+e/Eht2JXn+QcRsIlGQtn13L3SfDZa2aeBH8mDWXtdnt2EgOaMcRpNeTwfGM
         yCUCa+G1GvDUVT4PVoj1pGmKAVJoo5l90f6aXco45+KpucB0PH+REvGR2xN1Sv8/Ea3R
         qQ09TbK7wJZlfB1OZiVe3hgujFPHps6dHCuK1JGj6lwffiLoUmk76/jC8cpWrRyq5Xdq
         wsju7O1itCrafDBBgLymyovaQhoHmuIja931eeS0Mz9431kFwhXpUefcP37ekmp5rIRy
         7q2+7/BRfLJCseYWogIM9zKab3izoKfvSUlFTPKo4xXgdZWboqOR56J+zabEc51fXwuO
         +YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5onrs9lSEaHmvYpP7Y+ZzwiLXT0++XAWXsdC8ftsfM=;
        b=q02rfsJe43xtukCZ9ye8xmNEdVw6iABZan2Mlfwvmf13DxHAg/+0c++0fQRl7bYrgw
         vBn0kljIk5Sr0j2yUi7W0LqbSqzWonQtlOl7DMmRZ0EFh6y+pS7MkI7FeuIYaq5EvCXk
         7sdbAlI5R1xW1wotR/nni6zKbUOqvkNNhfbXOJ40VNbn0tsBCK0ibCummveoYtddrPYA
         0HIxNS5WX05jYW0CHUNwoxFgnBvfDljMvgZw+6xgW/dFAF5MxJOwNgp7vD9+D/c+W7LQ
         8VhbmMW9kD12t0Gme4H3CQaVWUowbRpnxwz3mV85IeSfyQ4LNmxhONcqK1/iS6x32VrK
         wZfA==
X-Gm-Message-State: AOAM532MPjLuio5ljQTK9a+IlqRiemH9p6Pxct2VttZuHd6bPaDBfT9U
        4JggPCoD3Glg39um3kTCzNtT+hmsHNmW3SWkLHoa
X-Google-Smtp-Source: ABdhPJwwN4Iso2fFaoeNHAASddkpjxDEcW4ydhjnGSeZ7ramQSBfNRtaYA2Ye43/a6HNM5+6L9P2K7DemHTdE1iYWZo=
X-Received: by 2002:a17:907:1c9c:: with SMTP id nb28mr25007879ejc.452.1640836893881;
 Wed, 29 Dec 2021 20:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <Ycycda8w/zHWGw9c@infradead.org>
In-Reply-To: <Ycycda8w/zHWGw9c@infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 30 Dec 2021 12:01:23 +0800
Message-ID: <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 30, 2021 at 1:35 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > The rescuer thread might take over the works queued on
> > the workqueue when the worker thread creation timed out.
> > If this happens, we have no chance to create multiple
> > recv threads which causes I/O hung on this nbd device.
>
> If a workqueue is used there aren't really 'receive threads'.
> What is the deadlock here?

We might have multiple recv works, and those recv works won't quit
unless the socket is closed. If the rescuer thread takes over those
works, only the first recv work can run. The I/O needed to be handled
in other recv works would be hung since no thread can handle them.

In that case, we can see below stacks in rescuer thread:

__schedule
  schedule
    scheule_timeout
      unix_stream_read_generic
        unix_stream_recvmsg
          sock_xmit
            nbd_read_stat
              recv_work
                process_one_work
                  rescuer_thread
                    kthread
                      ret_from_fork

Thanks,
Yongji
