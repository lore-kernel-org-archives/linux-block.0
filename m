Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB1C4332F
	for <linux-block@archiver.kernel.org>; Sat, 24 Dec 2022 16:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiLXQ4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Dec 2022 11:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiLXQ4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Dec 2022 11:56:44 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFE3D11A
        for <linux-block@vger.kernel.org>; Sat, 24 Dec 2022 08:56:42 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g7so5897337qts.1
        for <linux-block@vger.kernel.org>; Sat, 24 Dec 2022 08:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JpcHNwpuE5O5lhju52DhjRWOVFDf/6KjMwJeJDv0qOk=;
        b=eHv1mgQ5AP7oglntmJxZbKwRJLD99vZvrbBfFnrC1Jz7Ia5B1JDL0ZVdTe1ypPUTRQ
         5WCHLYSZyzzKFMghdQRAE1HIgHcXJ19GaLrYGrmqNcv/IylzDZaqSNbaWFNgXXY8isCb
         xvyY1lejoB6EYNIgNic+EwyGt+zj1OR7/0hzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpcHNwpuE5O5lhju52DhjRWOVFDf/6KjMwJeJDv0qOk=;
        b=hZv8lMPnpL+ubsSGehuE2zvrJpHosO4iSMWrrmyezJPmrkBpeIdfUsN6/c2NRoDpyT
         M0B/czpgLJJA8ofXQ9F/DXTCtBv508j+n09EJgNy9LALYR0ImFicwEAlZco+Q4mvV4ff
         q52LIujWIJAFDCC+ohRsnzcLkgb5/HH9ywhyjsAeVWDuLIJrBs0cRzLzQQmpTMCH8GvL
         V/20OGZs+xqBgg8x+nCkqU3Xy6IGkW7CduU0uIGq4r5RIn63VwaOGnXDT93AocqQe43q
         e0crS9NyoMEOFQQfyTNkeMoWe4wphzWObDec21LCF2N5RhO8p3BUG6ha3XvxSvG4QsN0
         Lg4A==
X-Gm-Message-State: AFqh2kpiWRretJyFU6hQexLWjP0BdV0k9Ng38kUQAk3gMydN87TWDTkd
        ppj5rE439xsWH1pMUTFJQ1/LItYfuJY8s5q7
X-Google-Smtp-Source: AMrXdXuTxt9ild/bzA/yL5/Mg8LoxTXAImYT3HbkB4z3NpG9fQ/88tDb58531/9wojUFrIAJ7Xg/lQ==
X-Received: by 2002:a05:622a:4d8a:b0:39c:da20:5f8 with SMTP id ff10-20020a05622a4d8a00b0039cda2005f8mr28122057qtb.2.1671901000954;
        Sat, 24 Dec 2022 08:56:40 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id m14-20020ac866ce000000b003a7ee9613a6sm3731754qtp.25.2022.12.24.08.56.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 08:56:39 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id v14so3100509qtq.3
        for <linux-block@vger.kernel.org>; Sat, 24 Dec 2022 08:56:39 -0800 (PST)
X-Received: by 2002:ac8:4e26:0:b0:3a7:648d:23d4 with SMTP id
 d6-20020ac84e26000000b003a7648d23d4mr705942qtw.180.1671900999023; Sat, 24 Dec
 2022 08:56:39 -0800 (PST)
MIME-Version: 1.0
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com> <Y6amzxU7choHAXWi@infradead.org>
 <c67eba0-fc5a-4ad0-971-cf80bc1c6e5a@google.com>
In-Reply-To: <c67eba0-fc5a-4ad0-971-cf80bc1c6e5a@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Dec 2022 08:56:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjVw9=Hio5pRfGW45+yL-geWfNGyPeSFess3FAZQwVJrg@mail.gmail.com>
Message-ID: <CAHk-=wjVw9=Hio5pRfGW45+yL-geWfNGyPeSFess3FAZQwVJrg@mail.gmail.com>
Subject: Re: 6.2 nvme-pci: something wrong
To:     Hugh Dickins <hughd@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 24, 2022 at 2:19 AM Hugh Dickins <hughd@google.com> wrote:
>
> Regarding the awful 0's based queue depth: yes, it just looked to me
> as if the way that got handled in pci.c before differed from the way
> it gets handled in pci.c and core.c now, one too many "+ 1"s or "- 1"s
> somewhere.

The commit in question seems to replace nvme_pci_alloc_tag_set() calls
with nvme_alloc_io_tag_set(), and that has a big difference in how
queue_depth is set.

It used to do (in nnvme_pci_alloc_tag_set()):

        set->queue_depth = min_t(unsigned, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;

but now it does (in nvme_alloc_io_tag_set())

        set->queue_depth = ctrl->sqsize + 1;

instead.

So that "set->queue_depth" _seems_ to have historically had that "-1"
(that "zero means one" that apparently sqsize also has), but the new
code basically undoes it.

I don't know the code at all, but this does all seem to be a change
(and *very* confusing).

The fact that Hugh gets it to work by doint that

        set->queue_depth = ctrl->sqsize;

does seem to match the whole "it used to subtract one" behavior it
had. Which is why I assume Hugh tried that patch in the first place.

             Linus
