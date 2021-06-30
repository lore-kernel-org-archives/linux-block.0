Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369DDC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 19:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB41613ED
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 19:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhF3Tbx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhF3Tbx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 15:31:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EA5C061756
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 12:29:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q16so7197935lfr.4
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHOYWwypwXp+hBoJ4WdpqFf1XvPwU9Z9GWyYv94wB3c=;
        b=a4b/IwmRzfQ97e/WTzIahKMexHi9S3J45sWjXze91438TWTAOoByUKJSWZVw2ylV0V
         Ix0YkQ+gJx/VFzmc0TNVeop3kJqiDD+lmALTDQuUzqJXc/Z9anGvNkNTYzPKydsCc8I0
         ZJOnp6QfyDEPNY031zr1QEDw/JM0PnI8wElJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHOYWwypwXp+hBoJ4WdpqFf1XvPwU9Z9GWyYv94wB3c=;
        b=KVHZeglxn5xV90UuIoeCl9czdVtN8QfoHqr89WA6CoxBPsrWTxT8enkWWvf15PhYdL
         YbZqL/C2uyX/M/nYJmXzHFUTJTupDVJlseIp6TxxxNs7vHJmhG+z6oDO1IWTAPt1pMlk
         XJmqXXxVxJsus1eN+4LPvfafw4mf0bP7vwb4TUKlhhOyM71Y0QkDOvnqUBY8ml6hSggP
         ZXad05o6lrjSbQqSvANfQDJFcJEnupbei/VhMzTLnjLoBChYtRJ1u6mVOXPSW6EwJYWq
         Lc6+YDQBhNV99KvUr87PeMDx2356UBOJyp6IrthV9MT2QMn6Pol9bWcZMFve0k3LNybF
         +Q6Q==
X-Gm-Message-State: AOAM533FTflxRTAu+pY8NjRSnf4FSd5zBm5DemWHqHkWydmGPqv06PEo
        oc3FKCdKFRKywAKBBfb1TkpCKFFf37WvZzLylIM=
X-Google-Smtp-Source: ABdhPJyFxlzK1U5wdhzBdB06NoEatuhLjWkJVcZSIFFGlQEfrNKVBQG//mhUEwnGn3JtDtrvpEBoIw==
X-Received: by 2002:a19:ca52:: with SMTP id h18mr21318380lfj.180.1625081361002;
        Wed, 30 Jun 2021 12:29:21 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e8sm1328384lji.59.2021.06.30.12.29.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 12:29:20 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id d16so7185522lfn.3
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 12:29:20 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr27614811lfc.201.1625081360266;
 Wed, 30 Jun 2021 12:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <ee6c32c8-e643-f817-bf45-1280e7f254ea@kernel.dk>
In-Reply-To: <ee6c32c8-e643-f817-bf45-1280e7f254ea@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Jun 2021 12:29:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6axLJQuFQBNa+nMHkEdx4X75LF7_P=eC=rzKj0x2h2A@mail.gmail.com>
Message-ID: <CAHk-=wg6axLJQuFQBNa+nMHkEdx4X75LF7_P=eC=rzKj0x2h2A@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver updates for 5.14-rc1
To:     Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 29, 2021 at 12:55 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Note that this will throw a trivial merge conflict in
> drivers/nvme/host/fabrics.c due to the NVME_SC_HOST_PATH_ERROR addition.

Grr.

I don't mind the conflict. It's trivial, as you say.

I *do* mind what the conflict unearthed: commit 63d20f54a3d0
("nvme-fabrics: remove extra new lines in the switch").

That commit claims to remove new-lines. In fact, the full commit
message explicitly says "No functionality change in this patch".

Except what it does is not just non-functional whitespace cleanup. No,
it adds that

        case NVME_SC_HOST_PATH_ERROR:

thing that was added in mainline too by commit 4d9442bf263a
("nvme-fabrics: decode host pathing error for connect").

THAT is not ok. Commit messages that explicitly say one thing, and
then do something completely different are very bad.

                 Linus
