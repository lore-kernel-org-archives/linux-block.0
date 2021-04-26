Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B7EC433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8D2600D1
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 17:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhDZRkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbhDZRkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 13:40:52 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D2C061574
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 10:40:09 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id u21-20020a0568301195b02902a2119f7613so5955152otq.10
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XW66VMgYUjmmyM5tWjO/chrTso30tW7lctDhWTKas4=;
        b=JsFLAE239nzAJt8i0qo40W31Oesl3uZ76taSTcn+Ryt41AZolWe9C5BSc/kEzv0yLb
         nFZA7gRcz8NiRP6117IJC5Ia6zEn/azgEqgCu31/ysAP1hbKkeXMaQeQKwB+cvwpOBYu
         GC+ZfWn5G07O+uTX6ASZsdD3R0R/r9/oTidtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XW66VMgYUjmmyM5tWjO/chrTso30tW7lctDhWTKas4=;
        b=TM9JraEo3YsL85uqLKLtsyk+Z2/P85e01U5rGgtKeeVNaE6K9samhEUjK8Hqkva0Hg
         TnG5822ArhyTO0qPBKrNIjAYWT7HCgbOEIaG7HHalkSaA+9P9gNcBaHxMhj8bsDJL2Rx
         h7C3oRe3lcy8aFU5/i279bohgWnvIflCmqVLp/0KSd7dmNSgmV372MHwvKv4w8ml2/jF
         JIbUemNIgO1DRhPzWL7ujGwzxrI75d2mIHN6yas8hFDilCEQOeXeTUvkr/OBmLcj4idU
         w/SRGC9gFB9oILKm5Vh1KwrDIzdLXuBqDHvPZfvbQKFY0efnbRDORD/rBYoBXPt345u+
         c20g==
X-Gm-Message-State: AOAM533VY0CXFUA2d4Cg4zNDmbGqPDKGSrCTXbNLOseLJ/IDQm7+HHK/
        lNmNIEZOXy6ClAe5rQbzWYZEvbLTxt98aj2aoQDiFlS/rWhq+Q==
X-Google-Smtp-Source: ABdhPJzHGEvPWZLZcokhsPK2M5HSy/aKfUBIbChJrdWuuA/Xbhes//gv/T3yj3rRVz8Z0+CC4ibsTPiFN1BWSljpO8U=
X-Received: by 2002:a05:6830:11d6:: with SMTP id v22mr1642299otq.249.1619458808821;
 Mon, 26 Apr 2021 10:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-5-kbusch@kernel.org>
 <CA+AMecF+n+xVk8HcQn12oiO=YMJM08aC0AG3iM_3h8SgNxURow@mail.gmail.com> <20210426171525.GA13018@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210426171525.GA13018@redsun51.ssa.fujisawa.hgst.com>
From:   Yuanyuan Zhong <yzhong@purestorage.com>
Date:   Mon, 26 Apr 2021 10:39:58 -0700
Message-ID: <CA+AMecE32_L=gqymR6tkFPcytOrBSng4jbq85TBnNoSKdwyvFg@mail.gmail.com>
Subject: Re: [PATCHv2 4/5] nvme: use return value from blk_execute_rq()
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Casey Chen <cachen@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 26, 2021 at 10:15 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 10:10:09AM -0700, Yuanyuan Zhong wrote:
> > On Fri, Apr 23, 2021 at 3:06 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > We don't have an nvme status to report if the driver's .queue_rq()
> > > returns an error without dispatching the requested nvme command. Use the
> > > return value from blk_execute_rq() for all passthrough commands so the
> > > caller may know their command was not successful.
> > >
> > > If the command is from the target passthrough interface and fails to
> > > dispatch, synthesize the response back to the host as a internal target
> > > error.
> > >
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > >  drivers/nvme/host/core.c       | 16 ++++++++++++----
> > >  drivers/nvme/host/ioctl.c      |  6 +-----
> > >  drivers/nvme/host/nvme.h       |  2 +-
> > >  drivers/nvme/target/passthru.c |  8 ++++----
> > >  4 files changed, 18 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 10bb8406e067..62af5fe7a0ce 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -972,12 +972,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> > >                         goto out;
> > >         }
> > >
> > > -       blk_execute_rq(NULL, req, at_head);
> > > +       ret = blk_execute_rq(NULL, req, at_head);
> > >         if (result)
> > >                 *result = nvme_req(req)->result;
> > >         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> > >                 ret = -EINTR;
> > > -       else
> > > +       else if (nvme_req(req)->status)
> >
> > Since nvme_req(req)->status is uninitialized for a command failed to dispatch,
> > it's valid only if ret from blk_execute_rq() is 0.
>
> That's not quite right. If queue_rq() succeeds, but the SSD returns an
> error, blk_execute_rq() returns a non-zero value with a valid nvme_req
> status.

Agreed. But after that, freeing the req let nvme_req(req)->status from SSD stay.
If the same req get re-allocated and get dispatching failure,
shouldn't the dispatching
error take precedence over the stale nvme_req(req)->status?
