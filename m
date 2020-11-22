Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BBAC5519F
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 09:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8027720795
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 09:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI4KdVpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgKVJk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 04:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgKVJk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 04:40:26 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75547C0613CF;
        Sun, 22 Nov 2020 01:40:26 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so11426395pgg.12;
        Sun, 22 Nov 2020 01:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8E2Nlp+Ctf60nM81/7FfdYzhBZP3JLnLEDBD2M4sIsk=;
        b=dI4KdVppj/D7oc3RwSzIbUqAUIvld1t4wZcJhrZs9kCi19D2uer+bPlvP7zxQxhzZe
         XSTFUhzdHPzc89SFEzdukwI4YeRHosmx4hvmF9eKGu6CxdTXOdacilwTYOC6WE8XddyI
         3P3/+86L42Vt/upbWtGqQcL8UC0U1iK5KeLYN+QDXpKvOgpyn9h4YY7N/vxxgISwabFo
         QOHLrUoovlK596p6InZV6ng9xZ03E2Acbz2L9QXp1LYsy4YeMRru1h26TcnKm1hQr2nk
         ZC/2KOalhsM0JdSj1z8Nfj6TZENZI26Q57QLe4yNkueEBdq9BjEXsZs1UfdHJCdLYbJg
         09vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8E2Nlp+Ctf60nM81/7FfdYzhBZP3JLnLEDBD2M4sIsk=;
        b=IKAeLRcfa1TjgSI2xLSGLVoRTpo/PKMyigcIX9O9zZQ87K1vDjr3HDRG5uW7qlz6yE
         sXOKCN7TOpdarubz5LQ0Fz5If2r4StzvRZsV4mq3+1w0Zv2bWK28Ig5egFiAYTXaWxC0
         SLesiCqIQ4BhdHnqyuPj3SYrUwO4r59kxPkliB+EssJTDAYceT2lVEe5BCoJfhs2ehdy
         A2GCVBuXCSUQV9WsEKq/+eBlxEFfwF3ziYy2YTmbqJY+VVOxvHEQqRP7evIukPesnXZ2
         IeuAXcOe6imoxeGr6svgJJWbwu6wMifGXO+34hw6gh0wquSbm+xk13VUnNIOeQjp/ZDd
         bM0A==
X-Gm-Message-State: AOAM533Yc2Umfn5ogMg0uwKbbRv5cdxmySYvPp9u1VsxM94Hnik1p5FZ
        qdGMSk18Qv6nQmlRhSyb+wnfpR45Zxr6SXC2iQ==
X-Google-Smtp-Source: ABdhPJwUXAL8UTLtiteP/awxdRud2NlOzelqRy4rOZ3PjxzIIYAW8YRA45l1wTmrCHLmrxpentpIC+Q3EGp2a8O6MaQ=
X-Received: by 2002:a17:90a:fd0d:: with SMTP id cv13mr19884875pjb.124.1606038025792;
 Sun, 22 Nov 2020 01:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20201115101514.954-1-rsalvaterra@gmail.com> <20201119222610.GD3113267@google.com>
 <CALjTZvbK6_UqDQFhMxdEQAR-FbsZKrztkEFronvoFpLUWsi_gw@mail.gmail.com>
 <20201120214013.GD3377168@google.com> <CALjTZvafTn4Mv5cp=QpGnmSkn=p++Chy+VeBKCOWuM5rUTXFJQ@mail.gmail.com>
In-Reply-To: <CALjTZvafTn4Mv5cp=QpGnmSkn=p++Chy+VeBKCOWuM5rUTXFJQ@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Sun, 22 Nov 2020 09:40:14 +0000
Message-ID: <CALjTZvbRfFRWzN7Umsi7Yd3PZVK_rc1CtRL-g8wL3C+cS4kWoQ@mail.gmail.com>
Subject: Re: [PATCH v5] zram: break the strict dependency from lzo
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Minchan,

On Sat, 21 Nov 2020 at 00:44, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Well, it's quite possible I mis{read,applied} your patch.

And I obviously did. Your kconfig suggestion does basically the same,
in a more simplified way. I guess a v6 is in order.

Thanks,
Rui
