Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A3BC6FD1F
	for <linux-block@archiver.kernel.org>; Sun, 12 Mar 2023 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCLIbR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Mar 2023 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCLIbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Mar 2023 04:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF74FF1F
        for <linux-block@vger.kernel.org>; Sun, 12 Mar 2023 00:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678609827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTJUAFMiKw9YXPlS9lywYBNgOfv1YiKLGXLNoVp00UQ=;
        b=Mh6Fm5lDZQUofBj/lQiRykJBl4+ANTG7lh8RPA/D55tCoN4zY2dUvDpWvJ0peoUWNaJFdp
        Q4ia/IGDLmD9fRM/xXX3zPQL1U4H1W+r90TYRGHrQqu6dw4uI/Q9goKNZXyMJHCFsaA72f
        siqO+EnT+0V1KcCEvANU2dm7bmzgbEU=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-nA7d5DTFP0O9B7yiG4QnSA-1; Sun, 12 Mar 2023 04:30:19 -0400
X-MC-Unique: nA7d5DTFP0O9B7yiG4QnSA-1
Received: by mail-ua1-f69.google.com with SMTP id b19-20020ab04813000000b0068fbb418f63so4616765uad.2
        for <linux-block@vger.kernel.org>; Sun, 12 Mar 2023 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678609818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTJUAFMiKw9YXPlS9lywYBNgOfv1YiKLGXLNoVp00UQ=;
        b=OrdTIsvdkDAl5L7Wewi4OfHSuHm47RDf8KZT+pQmXeWuB3JttCSmktCHayOLbAKOaD
         Wcu+bynJ+UiMKlE6g1pplAirSj+ZckAgtjjZNRegM9EEiGTIzS9TfXvn6+ys+56kT4HW
         +ikpukapmBY0zDENIp068nPEmzf82hfKxBZSpwTOYU6THk1uQJ7aC0EDi9EBlo+uc2Hd
         e2Y8aH8q9VMm1/nOAdRCY30GGwqHWW544hwd2t+pC7naqWkRBC6/4JkXFTh8V8T3/B7m
         rZFxTxoCZnWyLC8pwCqxxlZShfFyYgjNolO/c5sm9nZfj44pznRfKtLX/aS1OpfiYlYY
         ziow==
X-Gm-Message-State: AO0yUKWEUKq9eokMyv8AI2ZymoGuLIrHrhdw1aBHlA2mv6CayimAryhV
        OVUrXqXarUzHkoYgbN+/zW2eJd0A7uiD+L/6IDTO6b8wCJzbq86r/SPo4SmQTwv1jlda76rlr3e
        S7Kbsj1Ep1m7O8tQMM2aKsioz132VaUsTpudpLr6CDzEicjo=
X-Received: by 2002:a1f:5081:0:b0:418:4529:a308 with SMTP id e123-20020a1f5081000000b004184529a308mr18819944vkb.3.1678609818165;
        Sun, 12 Mar 2023 00:30:18 -0800 (PST)
X-Google-Smtp-Source: AK7set/XxiUHqj7uZm7+uQmpQQmAFDztF4XwTwbAWzfBXxoaAKYWNuNGHKx1WneKNKQ2hYsmxYfu0s630gn5HA+5VLg=
X-Received: by 2002:a1f:5081:0:b0:418:4529:a308 with SMTP id
 e123-20020a1f5081000000b004184529a308mr18819935vkb.3.1678609817771; Sun, 12
 Mar 2023 00:30:17 -0800 (PST)
MIME-Version: 1.0
References: <Y8lSYBU9q5fjs7jS@T590> <ZAyAdwWdw0I034IZ@pc220518.home.grep.be>
In-Reply-To: <ZAyAdwWdw0I034IZ@pc220518.home.grep.be>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Sun, 12 Mar 2023 16:30:06 +0800
Message-ID: <CAFj5m9KM1xbwPobvEYBmgotrU8s2jBQGcSQafJVJM+iQMS0pjA@mail.gmail.com>
Subject: Re: ublk-nbd: ublk-nbd is avaialbe
To:     Wouter Verhelst <w@uter.be>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 11, 2023 at 9:58=E2=80=AFPM Wouter Verhelst <w@uter.be> wrote:
>
> Hi,
>
> On Thu, Jan 19, 2023 at 10:23:28PM +0800, Ming Lei wrote:
> > The handshake implementation is borrowed from nbd project[2], so
> > basically ublk-nbd just adds new code for implementing transmission
> > phase, and it can be thought as moving linux block nbd driver into
> > userspace.
> [...]
> > Any comments are welcome!
>
> I see you copied nbd-client.c and modified it, but removed all the
> author information from it (including mine).
>
> Please don't do that. nbd-client is not public domain, it is GPLv2,
> which means you need to keep copyright statements around somewhere. You
> can move them into an AUTHORS file or some such if you prefer, but you
> can't just remove them blindly.

Thanks for finding it, and it must be one accident, and I will add the
author info
back soon.

thanks,

