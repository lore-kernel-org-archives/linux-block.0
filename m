Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD67EC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 20:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798DF21B1A
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 20:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miNHtWej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440060AbfBNUqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:46:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46050 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440056AbfBNUqU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 15:46:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so6431435ljd.12
        for <linux-block@vger.kernel.org>; Thu, 14 Feb 2019 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gl6I2b7fxkRiwKicMaJHRX0YMriswtzvuilI6IduaU0=;
        b=miNHtWej1ev6gufg8ZGzqKodvnBr7o4HnVKfZt84L29zL3xZE6+/GmdCXaEMUO8Pa1
         lFsiFZ6Wd+WsNtqniDFKwOe8hDmJgdCdG0GvlI6d+uH66VrGhsXKL5J7LC0zFOtFOziY
         pwdo67UM8NrsTkJ+kUadbN18hDr6VMdW9Gkf81Wyx/MEGNZuwqd5sZzOJQlM58gb73qj
         D2+apfOy+a2vqpMY4j0R1OAiAyH3x/o8NkUasHt7jnojt1kJkUgM++S9OVsTjrf55eNG
         4PNUY/ELH953uB7bhvbP7F9gt4/z1JQg7/NGxslYG84wVCvW70fwozXegEbj6Io79thq
         065g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gl6I2b7fxkRiwKicMaJHRX0YMriswtzvuilI6IduaU0=;
        b=tX4re4mepJ0zKJGn+0hw5MRlEwVLFsNo8F0qA7+amIpEmw3t0kF6f5nXHrNhRCzwOf
         Qi6ZFkbySfXDYfg5N3CiHNVOmfZ964ptavTeRiJbKno2i5kQFxrKRalYvujanKWbSdXy
         3PJzf3EDYBa3S268mucxNgykiy5mfMEtmlXOnpuJcRvVARNvqO31Y5+H/lVRINQOW/Ks
         cCTW/8PbBbEwtEqrcOidibn1yG3TZM6FNK0zoVFtP4Mdj+KZV9WmIrcklmOa+MhADWVZ
         jc7hqlG4GKTTFhCkqcAwKNdh2voZR9zEZ4s5KZ8lBVPJ3b97ObUbbd4Bc602tjH0Bn3Q
         0b/w==
X-Gm-Message-State: AHQUAuY/GVtKpM87qfhmfrjepKiQg47NBRNSJTCtzQKjHP7dyJyC8wPi
        jrprdH3PAwxIr0H+aC71JMRgwI2WDg4c7yYJBCApBA==
X-Google-Smtp-Source: AHgI3IZvInj9x4eP9ZLqWUlqSugOKcrx1mCUQSKdbPJz3GYLxCQqz1aXKcIagvGylbfNZhC/Xj3YaMDveoYfPieQxnU=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr3559557ljb.126.1550177178324;
 Thu, 14 Feb 2019 12:46:18 -0800 (PST)
MIME-Version: 1.0
References: <CAE=gft4_WiL87FtZnVmZok+oXPjK=GUb5tDUPGQFijddrB0Pbg@mail.gmail.com>
 <1550172827.93548.5.camel@acm.org>
In-Reply-To: <1550172827.93548.5.camel@acm.org>
From:   Evan Green <evgreen@google.com>
Date:   Thu, 14 Feb 2019 12:45:41 -0800
Message-ID: <CAE=gft5GR1xEM1gNQjMyo_wfhs_JUAc2AUHHk5qr36EjaWv1hg@mail.gmail.com>
Subject: Re: KASAN warning in bt_for_each
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 11:33 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2019-02-14 at 10:04 -0800, Evan Green wrote:
> > Greetings, block experts!
> >
> > I'm trying to track down a KASAN warning I'm seeing in our downstream
> > 4.19 kernel, and I could use a little help. The warning looks like
> > this:
> >
> > [  224.564894] BUG: KASAN: use-after-free in bt_for_each+0x1ac/0x28c
> > [  224.571195] Read of size 8 at addr ffffffc17c621340 by task fio/3851
> > [  224.577745]
> > [  224.579320] CPU: 2 PID: 3851 Comm: fio Tainted: G W 4.19.16 #398
>
> Please have a look at this e-mail thread:
> https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/

Oh, yep, that's totally it. Did that patch make it in anywhere?
-Evan
