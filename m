Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9DC46460
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 16:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F34821734
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 16:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gpiccoli-net.20150623.gappssmtp.com header.i=@gpiccoli-net.20150623.gappssmtp.com header.b="c1Geez7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfEQQRw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 May 2019 12:17:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38446 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbfEQQRw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 12:17:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so8637458qth.5
        for <linux-block@vger.kernel.org>; Fri, 17 May 2019 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4FffnAnwdRE+1PgwVKRrOC66n7RnysXVy2HJUpNb2M=;
        b=c1Geez7bVZbVWrY4f+4RoXhbwUhzklz/7bC0OK5tQLJ7Bqwo2i4ZRZN+WyhS7YjMRX
         OigAhZQafsBif5DZx+nzKNAnFTPJPtDJNIIsGXVv+hYf7GdpoRBCcIq3Sm3eJEWn0uOm
         KE06l+A/nU5cszw5p9lZqZFu8BgXlk7C98t0NwBl6Q1pPQvfcyvPmqO4P0pyc0nNb8Pe
         hvea1fmleiuAgn5jdS2KgdJIAi9JZavLtc8mgHBB2aBCl7B0Syf7/MXuCwq4Gx5Xy9jX
         4LYkN1Z1r1DAQIlJNLZ2dJkpH0TgyvTd4FWN+XzmAa29nCx9kjF8BWUM0k/0psETkJrQ
         OO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4FffnAnwdRE+1PgwVKRrOC66n7RnysXVy2HJUpNb2M=;
        b=GyVqDYVLvKfF140jwAGj5s4gtDmX1cwejc6zoMDp5VjDJ+lifUKi2zJeuzC5+tKJHj
         z57Ngp/3bzC4B2ZpZIQ4bRiInooGU7DOix5ZZV3XMeOQ35ZkBBtJQa0c357iiPdQMfD0
         Zy08X2SRYXDWscEJkWfSwrqs0mocC9ToJ8IQnzioLsbXj8p9+fTsj/6vwkZ0q9F02fIG
         6Cr9x5Ve2xkbdIUOBWPCMX3UXDFvFy6aMUwL3qpD19OVNJskvSzkq+5SKNQtZ15+e5kk
         p8EEaJmay+lZ4MuU4S0DiuyZlmbF5+RraZtnjWL6yv6SN8ftPDT4fdCLNu79UO/Cq5Q+
         7RbA==
X-Gm-Message-State: APjAAAVN/jGPkb6CMPwa2TX0a1FlO4M7oqHE5jNIUYW4TpJmvyj6qCa/
        wf3cE9dw/HG3VfrkjC5Cd1sT2Dqr5/0tkeHNBdGKtQ==
X-Google-Smtp-Source: APXvYqzbeRUmj6xRCLSv9g2lWjKr1SwKV3qpXEK7UfptQnDMaaQvvApWUcRABpavgtAEHwcAbEJT7QLHUWF8CTer57s=
X-Received: by 2002:ac8:2ac5:: with SMTP id c5mr44962908qta.332.1558109871467;
 Fri, 17 May 2019 09:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190430223722.20845-1-gpiccoli@canonical.com> <CAKM4Aez=eC96uyqJa+=Aom2M2eQnknQW_uY4v9NMVpROSiuKSg@mail.gmail.com>
In-Reply-To: <CAKM4Aez=eC96uyqJa+=Aom2M2eQnknQW_uY4v9NMVpROSiuKSg@mail.gmail.com>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Date:   Fri, 17 May 2019 13:17:15 -0300
Message-ID: <CALJn8nME9NQGsSqLXHQPEizFfKUzxozfYy-2510MHyMPHRzhfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: Fix a NULL pointer dereference in generic_make_request()
To:     Eric Ren <renzhengeek@gmail.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        axboe@kernel.dk, Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Bart Van Assche <bvanassche@acm.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 17, 2019 at 12:33 AM Eric Ren <renzhengeek@gmail.com> wrote:
>
> Hello,
> [...]
> Thanks for the bugfix. I also had a panic having very similar
> calltrace below as this one,
> when using devicemapper in container scenario and deleting many thin
> snapshots by dmsetup
> remove_all -f, meanwhile executing lvm command like vgs.
>
> After applied this one, my testing doesn't crash kernel any more for
> one week.  Could the block
> developers please give more feedback/priority on this one?
>

Thanks Eric, for the testing! I think you could send your Tested-by[0]
tag, which could be added
in the patch before merge. It's good to know the patch helped somebody
and your testing improves
confidence in the change.

Cheers,


Guilherme

[0] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
