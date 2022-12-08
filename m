Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C3DC4332F
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 16:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiLHQUP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiLHQUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 11:20:14 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594698972
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 08:20:10 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id s11so2255665ybe.2
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 08:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdgYJLzTPBcOfDF3BbqPa6dcRUmgHzjyuCZ+9Opiczk=;
        b=Xp6jfHF/D4+VCOaKah3TxBeGZ0VlzdZ3SHIGn21BmHQYhd3DKvLIfzn0lnbbigRk3b
         qw9CRKQSRXdmNBsXFL8b3zqNW9uRtwlikTHnpAxveZav0jk/IZvWecw8fYrHLSJRjidr
         s/xUnaDE26FHlZI/KwhcD2HHICVf5XmTlwACY64Vj/8iV0KjD9W1I3cm9k24Hoe1O0eO
         aC82TbEJUrt40EyCyNx/OJZcCHyAX1a8wra49tiI/PaSHORaJd2GH/+HhwYd3uCppoqH
         T96AT9xTEkZ60CJ+ehpXr7SoAm/W7ZOtdj+nW6l3DKzip2I6GFGhExLLogFffFQiFlmD
         frAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdgYJLzTPBcOfDF3BbqPa6dcRUmgHzjyuCZ+9Opiczk=;
        b=oqNW2kmaZ+DGEwLNezGRgRvahGERRaA3tdpStC7ouwhC+Z/+niPxt6GFEQ4jNyVZTP
         d0mwZxPNc+FCqQgGD8WuuqvQUlih6/bMBRfyEEUkv1+OSLTTLiajNH7ZW0b8/hQgcQ0E
         w5thigGZoUa5mXvPVcSYD+mE67AGcsDIfcFfjmp82aVtxEWoMU9JUvdKSvzPTJXbpCg5
         a3ys5kwtKsDw5H6Zn4mLB6oTLhJTHTC1IrWtkifiOetl8ROs2jZmqZPvWq3WVYqZdrk5
         8ha7JwHS+JQC7nq4030oRXDL9zNaf57UFlAyZAkIzEa92keOkZt+sZWviOdlVE1/1skI
         /HTQ==
X-Gm-Message-State: ANoB5pkHM905V1DtUu9J3fq2NyNPmmkcFt/9K0Bf20c7p/cGRY/1nhuA
        fC0Rv0cI9KeShWCd9JzRoVzUAm5swqk3fZAXhI4NY+tq
X-Google-Smtp-Source: AA0mqf7zpXIG/amLEkmAVnAMDoOM/Em2JmaL5lu6BSEXIskDRf9KuwHmI9BPlpSqreqv1YwbZR/mviM/B7VPdUsgL7I=
X-Received: by 2002:a25:2087:0:b0:6f0:7c15:8e2b with SMTP id
 g129-20020a252087000000b006f07c158e2bmr61076500ybg.547.1670516409742; Thu, 08
 Dec 2022 08:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
 <20221206092913.4625-1-luca.boccassi@gmail.com> <ffce679f-0062-f514-1504-c92c63d74850@kernel.dk>
In-Reply-To: <ffce679f-0062-f514-1504-c92c63d74850@kernel.dk>
From:   Luca Boccassi <luca.boccassi@gmail.com>
Date:   Thu, 8 Dec 2022 16:19:58 +0000
Message-ID: <CAMw=ZnTupKivYy1z42DadhSyJngNQJXR_spN+qRQ9Jmr0jiAWQ@mail.gmail.com>
Subject: Re: [PATCH v4] sed-opal: allow using IOC_OPAL_SAVE for locking too
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, jonathan.derrick@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 8 Dec 2022 at 16:18, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/6/22 2:29=E2=80=AFAM, luca.boccassi@gmail.com wrote:
> > v4: add reviewed-by tags, no other changes
>
> Never resend just for that, normal patch tooling picks that up
> automatically hence it's just pointless noise.

Sorry, didn't know about that.

Kind Regards,
Luca Boccassi
