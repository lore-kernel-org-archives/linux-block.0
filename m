Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C055C48BE5
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7FD6101D
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUHwy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUHwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 03:52:54 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B306AC061574;
        Mon, 21 Jun 2021 00:50:40 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso16824684otj.4;
        Mon, 21 Jun 2021 00:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sXc451mgmL8ffnO6nUq628WK0zM1QnYqUBEcldksr4=;
        b=IJFByWgCsQSIjoNm43q/sJ2VUJxkNkW4fx3mLENTeM5U9kykrIgL0XUcV4zW+wzCCV
         F0NH74YHJ+4tDKkgI+gkus19gFmO8akvrpeZBwAmtgHzOliBzWPxwWquXgQV9OXJVHon
         KFbsM4HB9+YBC3g2WvBkp+ch04jaS9rMyEUhjqC+9hmjYt3cgww0y2cgF1GPFXznmcCu
         DcxigGxhqeCHKyndV66a+dATQDMcwO0FVI7Rty87M/BMBzTIb5b9F7vX5L+FqlRLCPH3
         be80nP5L+4lTQGGJxE5FDNXiCz83vfnNpG2CFzyYg3Qk+KE3KsTx+Ap8uEAjG2ysZp11
         4WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sXc451mgmL8ffnO6nUq628WK0zM1QnYqUBEcldksr4=;
        b=WCjSRKkQGss/dyeDTmNOrqdnjz0XWfgNy6K9AxSigs6lOYmWmRsj3f1ytqheWmyfun
         vqFZf7G87QwlywjhaMtzLEzCuOiEH3gsKEt8R6qOetFSvCX6mYRXiQ7tOeWi7kweXzdD
         j7pCtzyfxBBTA5dwovHJNZluYZQ3nQFhaYlRGafQ7OR8f/vSQSFD35TPs7B+Ik5GCvRg
         9NBSoon5Slv/VGgGVOFww8AM9BZsYbGJVl6qC86G9KRPGem81yKeJjYylFWndWZQlyVE
         OLqD+kA9nsdYaE5J8uk/ODSrYOoeLbiuAx2L1QAOanOnsSv+/GicAKqEOv6T50vcd0OY
         cVEQ==
X-Gm-Message-State: AOAM533tnGKcCYVDsr0auPVwe9wGoYDvIPdrHiS0DNMPgL8/axXFKS2D
        J3tLP/FDnZWJq0q7G7DZxLZCPlSYQZ+/hXAXsg==
X-Google-Smtp-Source: ABdhPJwZjsmiQoNIy0955HOTcsbC7nK+5GN3Nd/ts9nxc5bFtJeKT2fe9VrBtbwvY9Pl16TsK2KnhMiDEEZOo0mulbc=
X-Received: by 2002:a9d:4a8a:: with SMTP id i10mr19620639otf.282.1624261840165;
 Mon, 21 Jun 2021 00:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <1624191557-5385-1-git-send-email-zheyuma97@gmail.com> <YNAupxssJ/6zNyln@infradead.org>
In-Reply-To: <YNAupxssJ/6zNyln@infradead.org>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 21 Jun 2021 15:50:28 +0800
Message-ID: <CAMhUBj=OH8TOtVrJSfStWT=YWr3=Od=D+-BCtGhX1nN76wOYDA@mail.gmail.com>
Subject: Re: [PATCH] block: mtip32xx: set the pointer of queue to null after cleaning
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, liushixin2@huawei.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        guoqing.jiang@cloud.ionos.com, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 2:16 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Jun 20, 2021 at 12:19:17PM +0000, Zheyu Ma wrote:
> > When 'mtip_block_initialize' fails at 'mtip_hw_get_identify', a series
> > of cleanup operations will be performed. But when the execution reaches
> > 'put_disk', it will cause refcount underflow. The reason for this error
> > is that after cleaning 'dd->queue', 'dd->disk->queue' was not set to
> > null at the same time, which caused repeated cleanup work.
> >
> > Fix this by set 'dd->disk->queue' to null after cleaning
>
> This should all be fixed by the switch to blk_cleanup_disk and the
> preparation for it in linux-next.

Thanks for your reply, I have switched to the linux-next branch.

Best regards,
Zheyu Ma
