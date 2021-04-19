Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6FDC433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 17:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABE96101E
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 17:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhDSR2X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbhDSR2X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 13:28:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F8C061761
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 10:27:52 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o13-20020a9d404d0000b029028e0a0ae6b4so14261645oti.10
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zer3si/7X5ySMXgF2gktWrTQrlEkz2gg/oEe2rOReg0=;
        b=l4pz55jQz9YaxS1S8/DqS234Mxoc385oRRYH9jS9t4dWeEmIs6GhYqqNZUUUFyzIZi
         bD5qOuX8cwbjRpYSiZcBnWQDTt9fQq2DVgU9vpB9qNAMDR0jjWW4zLUaKjRJzZ7LMnhq
         b+1hp1aOgq4Ab80yzLmZcTEbqLvUBqO9XygjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zer3si/7X5ySMXgF2gktWrTQrlEkz2gg/oEe2rOReg0=;
        b=aSDOuAsY3kyfsEURWQUqbmuFwW/G6ZTqepAaFe0kYfjKhX0uKDPXxlBWvoqAPKHkrB
         F2RWLAa86KH1Lcdb+iBfoio4jPzKPIe170irlsNMfeLECxfLzRV/sCXCGB4TGpARVC+J
         IN+33/CGynM0Nnav0FDHZqigeiDcbfQ7wQPTR1QGXkbv2YeO5FLU+wziiImDhTK0aVia
         Dor8f9hLzkKjLI2kJiB8AifpkTxhCsY9prEaUcFXnC5nhseCtfxSt63sHWuA/VjJsZFs
         OMPlpC5VVy5sGk+uifDDpvUSBe2RvdIfRVkLxefBE6ee5wbABlsUwBsTPjat9qG1y921
         +1Dg==
X-Gm-Message-State: AOAM530T2sgByBEYuK0HRH+cRaJGxka3PvafcF+P/7EhYndXJ+snAjGC
        e8fbEeyGEyo/aTNPqqdcbtYC9y0VC0Mw/nEvycwJIg==
X-Google-Smtp-Source: ABdhPJy9FXaOlhwVd2jzTlK3ocPguHbumX5GXOLbiE7p6yLCR8BGfYE18OuCrvCFQTNDYcKqvT1lMJl0ahTWEh7HzN4=
X-Received: by 2002:a9d:7a53:: with SMTP id z19mr15086585otm.40.1618853272128;
 Mon, 19 Apr 2021 10:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210416165353.3088547-1-kbusch@kernel.org> <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
 <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com> <20210419071605.GA19658@lst.de>
 <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com>
From:   Yuanyuan Zhong <yzhong@purestorage.com>
Date:   Mon, 19 Apr 2021 10:27:42 -0700
Message-ID: <CA+AMecFXLCm3zsrfGdjT5hW4fvvgDxJxGEZvxOEA0bJT3X11wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 19, 2021 at 8:14 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Apr 19, 2021 at 09:16:05AM +0200, Christoph Hellwig wrote:
> > On Sat, Apr 17, 2021 at 02:17:35AM +0900, Keith Busch wrote:
> > > On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > > > >         if (poll)
> > > > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > > > You may need to audit other completion handlers for blk_execute_rq_nowait().
> > >
> > > Why? Those callers already provide their own callback that directly get
> > > the error.

See below clarification. I was wondering whether the way you were going to
propose for nvme_end_sync_rq() would establish new convention for other
blk_execute_rq_nowait() completion handlers implementation.

> > >
> > > > How to get error ret from polled rq?
> > >
> > > Please see nvme_end_sync_rq() for that driver's polled handler callback.
> > > It already has the error.
> >
> > But it never looks at it..
>
> The question was how to get ret. I didn't mean to imply the example was
> actually using it. :)

The question was how to let nvme_end_sync_rq() propagate the blk_status_t
error to the ret for __nvme_submit_sync_cmd(). That's part of the problem
here: __nvme_submit_sync_cmd() may return success for a command that
failed submission.

-- 
Regards,
Yuanyuan Zhong
