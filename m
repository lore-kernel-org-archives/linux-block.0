Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAE3C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 14:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0698F208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 14:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnqqO5Br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0698F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeLFOSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:18:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45794 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeLFOSp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 09:18:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id b14so618071wru.12
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 06:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SzGFxhxdHn2cxLIS1Z3pWi2U7R22N3MY+J4WQG7Tzkk=;
        b=rnqqO5BrQbguwFzuGg9D4evS4kL+j5Toem3/8XSQHNrvRWoKMHf2fD1vpTbY+j1e96
         7orypQxfiSnCLOCRXb3ielfxyp+wwzV5SDQ86gFWOnkfxmIu1FXLaQaJsosoitLBcGmC
         q1PHyffIId2zHbbpqvqWOGXnBoI2ZCzDXi885LoxGb1US/wR0Tg6YUiRNnVRWMGp1nc6
         s0sVuL7qaKeWkZkJa1xO7x0Z4LvqZLvcwRbirLBxnyIzUV9lbb18Z/N1HzGVt1CKJGqb
         7QokrPnQqQctn7zY4BexBa7gygOA9PQxTknfUlmimu6z4Twf6ODe1x76eO+KzHHXZCo6
         xAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SzGFxhxdHn2cxLIS1Z3pWi2U7R22N3MY+J4WQG7Tzkk=;
        b=YxtEkCjKDejUSKS293y+qOm/nMHjOOCoTyK96SVN18EKAC5hp+eR480X8pbIUwn0UV
         9IqNWZ1EwGng0Rusy9BazGP2NUAnwMpocIG5CtJnnJ7HBXK7EO6LgpTWZdBpN3gNwm9T
         fY9s4oxp7DByewUw04+1EIoAgNi/6XbyDm8KuuD+rB7XuuRG421209rtVeD0+/L+55vJ
         k7BUbbsq9nVsSW8PZKsVST9hJ2iU2PiFyXfk1te0yjeGeih3SSJpEu1Ns8qgm/tT5XGX
         V+aaqAQdNLy8L1LMMswsTdnyvFUINbxYeK1BIlmQEiREdL3d3ZYJXDw40i1BpU1Zcwxy
         psUw==
X-Gm-Message-State: AA+aEWbR/GHGwBh74C32Z89DDawcpJNiyU5adbKvWft95nxSuwk9TRCi
        mrawkS53s64eLYJZdjzK4/OdaDZSPdyLXObLefPGJnm7lns=
X-Google-Smtp-Source: AFSGD/XizrXlK8NB2osNmWEMBnjJZPyyw+4HbSdrEulL0Kph1pc5EqR51cGSw2gIFM+B469dpmsHqk0HMoMWc4vV25U=
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr24998317wrs.281.1544105923138;
 Thu, 06 Dec 2018 06:18:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544023832.git.zhangweiping@didiglobal.com>
 <997df532a176a435c3581ce180f318a298084393.1544023832.git.zhangweiping@didiglobal.com>
 <1544025539.185366.224.camel@acm.org>
In-Reply-To: <1544025539.185366.224.camel@acm.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Thu, 6 Dec 2018 22:18:31 +0800
Message-ID: <CAA70yB5HbEqSRO9KzqCkV=ZPgsRqVLmGZh0XrBAYwPaPbmDaYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: get rid of BLK_MAX_TIMEOUT
To:     bvanassche@acm.org
Cc:     zhangweiping@didiglobal.com, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 2018-12-05 at 23:37 +0800, Weiping Zhang wrote:
> > @@ -130,7 +119,7 @@ void blk_add_timer(struct request *req)
> >        * than an existing one, modify the timer. Round up to next neare=
st
> >        * second.
> >        */
> > -     expiry =3D blk_rq_timeout(round_jiffies_up(expiry));
> > +     expiry =3D round_jiffies_up(expiry);
>
> If you would have read the comment above this code, you would have known
> that this patch does not do what you think it does and additionally that
> it introduces a regression.
>
Let's paste full comments here:
        /*
         * If the timer isn't already pending or this timeout is earlier
         * than an existing one, modify the timer. Round up to next nearest
         * second.
         */
Before this patch, even we set io_timeout to 30*HZ(default), but
blk_rq_timeout always return jiffies +5*HZ,
  [1]. if there no pending request in timeout list, the timer callback
blk_rq_timed_out_timer will be called after 5*HZ, and then
blk_mq_check_expired will check is there exist some request
was delayed by compare jiffies and request->deadline, obvious
request is not timeout because we set request's timeouts is 30*HZ.
So for this case timer callback should be called at jiffies + 30 instead
of jiffies + 5*HZ.

  [2]. if there are pending request in timeout list, we compare request's
expiry and queue's expiry. If time_after(request->expire, queue->expire) mo=
dify
queue->timeout.expire to request->expire, otherwise do nothing.

So I think this patch just solve problem in [1], no other regression, or wh=
at's
I missing here ?

Thanks
Weiping
> Bart.
