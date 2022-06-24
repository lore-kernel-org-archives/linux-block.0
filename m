Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A3DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 03:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiFXDnl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 23:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFXDnk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 23:43:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D4E344D6
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 20:43:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j21so2335628lfe.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 20:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vvl+Ej4egX9Y0kXaH+N4dKRZjXPAl1N4vxBxngi7JNQ=;
        b=JMaAzmof1C+CvJudhMEqYxszMooW+CXXCAWyr/OKFaIaHYkQjAPJt36nZKoWYDzOE8
         OKaAakrmK9Y1pDNfO6N75niNlP7EGOb/xvhfXwfc9EWSbdXP21xJ2HcfiAoTpejQv7hl
         eMYNRcphhZycn+NK7RaoRxjHRNVc4TgLZL9bgv22oyGhLXOt4L+XdqpA7Yl6EUAPFARr
         1c3fAFmbZFGQ/cSE1o4c0DE1xSGBLJJp5xci25qZHI0DLJcYG+FCqMeYgk4kBc13wJKJ
         hdk86fvEzsJnIAiVpWz69oVLY569WMMCt4mrMRvfQffb3Ml3/JOOEyauODOloeBqGnI9
         eUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vvl+Ej4egX9Y0kXaH+N4dKRZjXPAl1N4vxBxngi7JNQ=;
        b=CeXsnuJHZZPYdvZGkh1Qfz49+d1X90npEH9LzssUHaHxWCE3VOyYHymEsZnRa/GtYn
         +2ex+vL1yWDc+wO84ZvL06Vp99vDYXWpg9OTIMnqGRvGiyhDwdNveTi7xxdXKyNNya8b
         JCvLNaUD3zKpx8cFkf0ClSb1AcBj6iEJ1gRbRlt6UE1xRQa0z+5Fk7Lz43wL6Ok3Nkyg
         dyz8D7SuanCw7ff2fsES+17NKWxgMyTkBQjSzURSyty7hbgexKsIYwtKIC54oEQQfLvz
         mpD2gs74TuorZEgksPDs0wl2Mgg8dcJZnLcOGBNTQb20KtTc99yNIVksFgPeh13OsXrv
         AnxA==
X-Gm-Message-State: AJIora8KiF71iGWFeTVoge7MGqQlvOJCALR5FOMJ/pU9aWYcxNDELYCQ
        1oxb/sQPBrFNqH6OdQn7nw4MWf2HEDDTQszAsE6zBeFo8/E=
X-Google-Smtp-Source: AGRyM1vFxkuSomPrYobpi8zlwGXWi/PWHDe6o9ncfMPW22RiohIBbNAaUHxn8hmC+oEPJRllDkIVwRmPYzdo2NlYJTU=
X-Received: by 2002:a05:6512:314e:b0:47f:8341:2099 with SMTP id
 s14-20020a056512314e00b0047f83412099mr7304716lfi.367.1656042217718; Thu, 23
 Jun 2022 20:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220623180528.3595304-1-bvanassche@acm.org> <20220623180528.3595304-47-bvanassche@acm.org>
In-Reply-To: <20220623180528.3595304-47-bvanassche@acm.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 24 Jun 2022 12:43:20 +0900
Message-ID: <CAKFNMonCrSpx0RMdPfMXfAvfe3ZQeVae=QYbgi1iO3pTRUnD-w@mail.gmail.com>
Subject: Re: [PATCH 46/51] fs/nilfs: Use the enum req_op and blk_opf_t types
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 24, 2022 at 3:06 AM Bart Van Assche wrote:
>
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags.
>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/nilfs2/btnode.c            | 4 ++--
>  fs/nilfs2/btnode.h            | 5 +++--
>  fs/nilfs2/mdt.c               | 3 ++-
>  include/trace/events/nilfs2.h | 4 ++--
>  4 files changed, 9 insertions(+), 7 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

I've checked this patch, picking up some of the block layer patches needed
to understand this conversion from the list of linux-block.

Ryusuke Konishi
