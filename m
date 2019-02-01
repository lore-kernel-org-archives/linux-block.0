Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C87C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50DD21726
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 18:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXW2N2I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfBASTi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:19:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39136 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfBASTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 13:19:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so6615074ljh.6
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxoZ/1WiBGphfKlHWPhrh6yIdh2dd00BOlVryXm17Z0=;
        b=BXW2N2I23Q1VjIj1TShGnzYNVsfHGQBGYtfYKqTZoBxdxJc8w3aqMbnNhBfvu9e5M0
         8cjNpYr8lg9RQVuzJJ9Nk5+7AJ8ekZJL2tUPdTkOwUL68FoIhngq5Rt8MZdA/muxp8Ti
         aAzoEo6K7WNpvZkL39RKimPd8q9kJYPY1i+Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxoZ/1WiBGphfKlHWPhrh6yIdh2dd00BOlVryXm17Z0=;
        b=FS6M3yamAxU4iBQG2i64vWRCQko1DhmfbmeFLVND5fPlHXLzTXWdbxzLFrUt/kqmaI
         BmuHpgaoBk92eXuulRAin8ZD2x0zfU3DWtpw45uND53nLy/6ekhgA/4JTiZAiLmChM3/
         sARyZCLWUc2TV2WUyWI9B5AoalvS+dJ7lOnbGX+GcdDxo0V8pv2+XvSVmVfQg8AVakoB
         xMhvR9YLdurihVk5y/w3Zl/TazRsZ+4VUExusHxn03ErOJfqzVG/JGQrQwF85L825Ne8
         U2VobpaSFMeR4qqb0yonj8fT1htQ/h0w2c3sTVffbLuT9MvtX0hQiWLxdl+AKxXtDdbz
         480A==
X-Gm-Message-State: AHQUAuaerpkku0ZrTCMq2goKnvKkx/MTOGWqCJNCG2JINW2PPz0rTdLJ
        9GvQDYmhkXH/Fvat8O/yhZjSPTZaZok=
X-Google-Smtp-Source: AHgI3IaFV54sataAMIx9z7JofYA5dkrahCp6e+OB3ADCHb9fzW1R7iB1Dj6Je0+ESAv/ouFzkpg/eQ==
X-Received: by 2002:a2e:87c3:: with SMTP id v3-v6mr2396505ljj.13.1549045175329;
        Fri, 01 Feb 2019 10:19:35 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 185-v6sm1362985ljj.49.2019.02.01.10.19.34
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 10:19:34 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id v1-v6so6643914ljd.0
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 10:19:34 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr2936483lji.60.1549045173573;
 Fri, 01 Feb 2019 10:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20190131221328.85343-1-evgreen@chromium.org> <20190131221328.85343-2-evgreen@chromium.org>
 <1548977479.213038.20.camel@acm.org>
In-Reply-To: <1548977479.213038.20.camel@acm.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 1 Feb 2019 10:18:57 -0800
X-Gmail-Original-Message-ID: <CAE=gft5Ug9eV3Gk4VW_pgrc0BVuXUZndtO-Zhocw+wWMCONQjQ@mail.gmail.com>
Message-ID: <CAE=gft5Ug9eV3Gk4VW_pgrc0BVuXUZndtO-Zhocw+wWMCONQjQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] loop: Report EOPNOTSUPP properly
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Gwendal Grignou <gwendal@chromium.org>,
        Martin K Peterson <martin.peterson@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 3:31 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2019-01-31 at 14:13 -0800, Evan Green wrote:
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index cf5538942834..a1ba555e3b92 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -458,8 +458,13 @@ static void lo_complete_rq(struct request *rq)
> >
> >       if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
> >           req_op(rq) != REQ_OP_READ) {
> > -             if (cmd->ret < 0)
> > -                     ret = BLK_STS_IOERR;
> > +             if (cmd->ret < 0) {
> > +                     if (cmd->ret == -EOPNOTSUPP)
> > +                             ret = BLK_STS_NOTSUPP;
> > +                     else
> > +                             ret = BLK_STS_IOERR;
> > +             }
>
> Please do not nest if-conditions if that is not necessary. I think the
> above code can be written more clearly as follows:
>
> if (cmd->ret == -ENOTSUPP)
>         ret = BLK_STS_NOTSUPP;
> else if (cmd->ret < 0)
>         ret = BLK_STS_IOERR;
>

Thanks for taking a look Bart. Will fix.
-Evan
