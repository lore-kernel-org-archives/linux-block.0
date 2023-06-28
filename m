Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC353EB64DC
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 08:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjF1I7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234639AbjF1IRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 04:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687940178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOlL3RSz6r/FHa/kJAy/uiAgUQG7pSYnjQgfd6RA4Bg=;
        b=d2WA5dkkLiEl13IgOJqZ8doRfSRuUMIXx/qxmlPvvHIl+sg7gWUd0lWxRemmTT3X2OGnKz
        lTR84IUFD/BDiyRJAg0HK0ed+eoIxQV9/2Sa3N0yAM7j2QfNYsc7YB2XSAnWG4ZIwhGp7x
        SUkUzWwDGi/bC+ngxeLZtwZsLwmYcGI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-38d-dcYzO1uUemG6mEuVCA-1; Wed, 28 Jun 2023 03:15:54 -0400
X-MC-Unique: 38d-dcYzO1uUemG6mEuVCA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-39ca3e1728fso4954988b6e.2
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 00:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687936554; x=1690528554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOlL3RSz6r/FHa/kJAy/uiAgUQG7pSYnjQgfd6RA4Bg=;
        b=BDAYdJJC1y2nGr54T42Hou+7nJL/yKVmO38hoZ/KFQade+04MfkMnZkAhEyi2u6Ai4
         aAiyjsbhVuyxIrz16o/G4KaDcrPL9A0391/UyzNoitWVS8p/6I+z8nctGD/TaKKn4fnS
         iP7OZXlUYoYPSvPZualcnHGFB2k6E5kOD5gDUpnLm/OCpHER9VN3HhtFJ4JZB9tYzsy1
         jZ/pGP6tUFfkzc+tttJFrlSPpq6/5h87nIA/lPYeYSoJMUx7oydRG4Hg0ScCkVxJM0Am
         HrNOwcN8GQGRLO3cpUU8C5s5rtS8nW2KPwvJJKbQJLpzPit06mLoMjzUZARjzsMTPuLB
         t+2Q==
X-Gm-Message-State: AC+VfDxkP3HiYo0e+v83gkbZHhdPytX83vsFlg2RCA3alkpr5gmDXG8Z
        B5oTihHgM8hWdE3/G/VTNRtBr0vP9jCeL7m5QhwQMUlGRsqzUGHSQeGiqJkZuaJ/Bqu82jvOUI3
        p2F5QvfATeIsfYUQkAc8bGj5+LcyOsshwJ/ao7io=
X-Received: by 2002:a05:6808:178b:b0:3a1:efe6:13c5 with SMTP id bg11-20020a056808178b00b003a1efe613c5mr6372687oib.44.1687936554185;
        Wed, 28 Jun 2023 00:15:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5b1JKXXZr/fxyH6D05v9L+c5/fBm1hVIv8gr4cANfz7s7CdBBTWYKitE4TTX3WfkZ9rc5AiDdkfY6U8UjM1e0=
X-Received: by 2002:a05:6808:178b:b0:3a1:efe6:13c5 with SMTP id
 bg11-20020a056808178b00b003a1efe613c5mr6372679oib.44.1687936553951; Wed, 28
 Jun 2023 00:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me> <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com> <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com> <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
In-Reply-To: <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 28 Jun 2023 15:15:41 +0800
Message-ID: <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux tree
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 28, 2023 at 2:47=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> Yi,
>
> Do you have hostnqn and hostid files in your /etc/nvme directory?
>

No, only one discovery.conf there.

# ls /etc/nvme/
discovery.conf

--=20
Best Regards,
  Yi Zhang

