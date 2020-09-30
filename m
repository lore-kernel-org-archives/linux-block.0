Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FFBC4727E
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 13:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBC82075F
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ehfWBFfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgI3NaQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Sep 2020 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgI3NaQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 09:30:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADFDC0613D0
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2020 06:30:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q13so2814794ejo.9
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2020 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1LDkQQNXAVKEqr0+tqeGQXJ1mdD4On0ZbGgfQW9Bm0=;
        b=ehfWBFfOpeiXSM8K3ALecLLOYUcExD0bVjWpUSLJD+wC2rIkpXAlPehwx2dUEcr+E9
         jTjAtSSvApyOBbOpQ4PpEJp+KXQa/Uisja0tY8sp0ke4jUI1GEZvhgejqo/I0kHqtbpQ
         Zb3/DxG2Hmwuod4+XjdmzCrX+RUKW1gPmSEujGpcsjz6sTBwXPk9O+vRtjxqtbfGzer4
         8TLucGiGTJOoUyDllYv8wJU1EJFrxGAku7SNSdTs01ett8+66yMgsdCtQkG6nI28O1MY
         0APTctfFS7UMfUVLwFTZxbKRsAqWqetzK+DDxEvZ/gvmaEbqclc5JwjTIaLPoRDKt3vV
         CPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1LDkQQNXAVKEqr0+tqeGQXJ1mdD4On0ZbGgfQW9Bm0=;
        b=A+CluB9UDVwXvNkbKAr3uuDYcCmbTwfFzB6PgoCLQr/Z6+4W3AYGEsjAtp8gHYKJby
         vW3XvDOJOp5ePpOBjFY6n+3ae18IfhEaXVensKDXOqqHX6EKZuifbZvylWFfCYMYYvxW
         /l6yOeRuumQnsj7r5AhBuk7SbHmO9HUF6tmWF4yn6LiKfxCWgRXOHiDkjaQNzcYBtdpN
         agIi1BPT9ENVs4b2inEfPnbHyaw6u72jbxhHM+ZyyjHbn3TUU3UQ1oOd5BXJpE7PqZ4P
         PaWAJIrSx3is1iO1z3wOkmWvcQYlKZlPIPZ96I3MlQvOp96RW29mD9WbB7eaj04CQGzF
         Zwrw==
X-Gm-Message-State: AOAM531iUk++M1QXiQiLO1M+FTxQ6GH3Tz9uiy8Hz5oKrVwuXgv3OkIG
        sZXI5iTjYogpOBL7z0y6FyIS7OvQDmWoi5gdD/nOPA==
X-Google-Smtp-Source: ABdhPJxexbd6G3TxMmQMKWcWvmbIx5AeUioE+moumV4nV8b1xn7KvTl+m9m58v9dQcMxkHLF1Cd3vFsJOAHoqsFR/lA=
X-Received: by 2002:a17:906:b24c:: with SMTP id ce12mr2896421ejb.353.1601472614378;
 Wed, 30 Sep 2020 06:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200918072356.10331-1-gi-oh.kim@clous.ionos.com> <CAMGffEn79RE=JbTPR0AzW+3EZO0MwemwTLwkc-LTnK8f06dKWA@mail.gmail.com>
In-Reply-To: <CAMGffEn79RE=JbTPR0AzW+3EZO0MwemwTLwkc-LTnK8f06dKWA@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 30 Sep 2020 15:30:03 +0200
Message-ID: <CAMGffEkzEv7hEyVAw-tGLJ53cRv-tq+JrVD0oDWvqXtmYsrJLA@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: send_msg_close if any error occurs after send_msg_open
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 18, 2020 at 10:18 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> On Fri, Sep 18, 2020 at 9:24 AM Gioh Kim <gi-oh.kim@cloud.ionos.com> wrote:
> >
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > After send_msg_open is done, send_msg_close should be done
> > if any error occurs and it is necessary to recover
> > what has been done.
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> Looks good to me!
> Thanks!
> Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
ping Jens, could you queue this up?
